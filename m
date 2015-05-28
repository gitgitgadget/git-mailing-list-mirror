From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 1/2] t750*: make tests for commit messages more pedantic
Date: Thu, 28 May 2015 11:55:53 -0700
Message-ID: <xmqqh9qwh6py.fsf@gitster.dls.corp.google.com>
References: <1432620908-16071-1-git-send-email-patryk.obara@gmail.com>
	<1432620908-16071-2-git-send-email-patryk.obara@gmail.com>
	<CAPig+cRHB3Qzm-e1_KROu2RQoW2rftLH=uKrWQBsnW0EYkcLPw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Patryk Obara <patryk.obara@gmail.com>,
	Git List <git@vger.kernel.org>
To: Eric Sunshine <sunshine@sunshineco.com>
X-From: git-owner@vger.kernel.org Thu May 28 20:56:29 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Yy2yc-0004dC-OI
	for gcvg-git-2@plane.gmane.org; Thu, 28 May 2015 20:56:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755144AbbE1S4N (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 28 May 2015 14:56:13 -0400
Received: from mail-ig0-f179.google.com ([209.85.213.179]:34140 "EHLO
	mail-ig0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755115AbbE1Szz (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 28 May 2015 14:55:55 -0400
Received: by igbhj9 with SMTP id hj9so177863igb.1
        for <git@vger.kernel.org>; Thu, 28 May 2015 11:55:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-type;
        bh=pyMA7E10wYjdjrjnakl+XWi75lHA4Sw9PqQRCWL89j4=;
        b=sRdyRfW7jsNr1KtK+llnjYPKoyHoB7dsTFvGR2012BJbYWmkcnE+GFDFn0W78QoAyD
         3y9SG1YsF8qDcK4scaSefHfLGiINPMJexac1M2WxYccLQeR+FokbBBX1lSFbl6Ik6JF8
         D0lrp0vQxPeJSkjewsk2jH6Qflxz9DpVHXIFL5oLi5TvPxclhrbPy6cmhavyt9KKR/Id
         1TMWK89+Q39BWSoOnUeAE5t/ZIuPOBknvi6s575PaV/nOPrk0IO7u3f9Cw/G21Vu7g3p
         NSaXbBIvDigXfE3TQYaYwt+Kg1IaEFPT88eww4WchgJRXeFbT2lwyUnPVAARSBc9TnOI
         XS4w==
X-Received: by 10.50.102.68 with SMTP id fm4mr13189361igb.25.1432839354735;
        Thu, 28 May 2015 11:55:54 -0700 (PDT)
Received: from localhost ([2620:0:10c2:1012:91c7:752b:4513:7344])
        by mx.google.com with ESMTPSA id 7sm2368617iok.43.2015.05.28.11.55.53
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Thu, 28 May 2015 11:55:54 -0700 (PDT)
In-Reply-To: <CAPig+cRHB3Qzm-e1_KROu2RQoW2rftLH=uKrWQBsnW0EYkcLPw@mail.gmail.com>
	(Eric Sunshine's message of "Thu, 28 May 2015 09:34:14 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/270179>

Eric Sunshine <sunshine@sunshineco.com> writes:

> On Tue, May 26, 2015 at 2:15 AM, Patryk Obara <patryk.obara@gmail.com> wrote:
>> Currently messages are compared with --pretty=format:%s%b which does
>> not retain raw format of commit message. In result it's not clear what
>> part of expected commit msg is subject and what part is body. Also, it's
>> impossible to test if messages with multiple lines are handled
>> correctly, which may be significant when using nondefault --cleanup.
>
> Makes sense.
> ...
>> +test_expect_success 'template without newline before eof should work with --status' '
>
> It's not clear what "should work" means. I suppose you mean that the
> end result should have exactly one newline after the template. Perhaps
> the test title could indicate the intent more clearly.

I agree that what "should work" in this title is unclear.

Because there is nothing wrong in the current system, if a follow-up
patch plans to change the established behaviour, the tests in this
"currently we do not test blank lines, so add tests for them" patch
should limit themselves to document the current behaviour.

Then a follow-up patch that modifies the behaviour can show how the
updated behaviour is different and illustrate in what way it is
better than the current behaviour.  That would be one way to justify
the change.
