From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v5 1/1] send-email: Add sendmail email aliases format
Date: Sat, 23 May 2015 11:07:24 -0700
Message-ID: <xmqq382ncgmb.fsf@gitster.dls.corp.google.com>
References: <49e9a95b52aa61ed4f37edf1dfa178186acb4a29.1432367540.git.allenbh@gmail.com>
	<xmqqfv6nchmf.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org, Eric Sunshine <sunshine@sunshineco.com>
To: Allen Hubbe <allenbh@gmail.com>
X-From: git-owner@vger.kernel.org Sat May 23 20:07:33 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YwDpc-0003q6-Rp
	for gcvg-git-2@plane.gmane.org; Sat, 23 May 2015 20:07:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758075AbbEWSH1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 23 May 2015 14:07:27 -0400
Received: from mail-ig0-f169.google.com ([209.85.213.169]:34507 "EHLO
	mail-ig0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754116AbbEWSH1 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 23 May 2015 14:07:27 -0400
Received: by igbhj9 with SMTP id hj9so13360735igb.1
        for <git@vger.kernel.org>; Sat, 23 May 2015 11:07:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-type;
        bh=jvQ2Quy+ioBqLN4g9a2JFITt22BfaP5bjuQG+E/JCFI=;
        b=QCj3LO4+FDdn9MbuIbjyivhjZFatmDQxtb9gQmUVWbGcrLFP4AnPCxe3+sXHqdXn9a
         kHhaNw5JGgyZ8PiBds/oKnEGCHpkN4yHVC44MQLfl2RxFxfAsY2Z45UYWyP1ACNycE9X
         WqbskBdSoLebz89v9JQHzlj2EL6Mfh63mYMOzZQQewr8wQL/SdQ8fuG2IYrQvWJV68VU
         YBljQ2Pv0XJ5TU9HJXWid1r8j0HcytByaCqYz/7OjeAH8KOQso6Y2/N4Jjj+UAK2XLiU
         EAytpWLmJU9P2VPWxSSVqQ/3uBkOMpQ92aK7FHBNRY5oQQpdBmFvQHZtJRgMzJt4EpDM
         SnXA==
X-Received: by 10.42.214.79 with SMTP id gz15mr6294939icb.86.1432404446575;
        Sat, 23 May 2015 11:07:26 -0700 (PDT)
Received: from localhost ([2620:0:10c2:1012:609e:6a22:2d9d:c8d5])
        by mx.google.com with ESMTPSA id q85sm4675402ioi.6.2015.05.23.11.07.25
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Sat, 23 May 2015 11:07:25 -0700 (PDT)
In-Reply-To: <xmqqfv6nchmf.fsf@gitster.dls.corp.google.com> (Junio C. Hamano's
	message of "Sat, 23 May 2015 10:45:44 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/269815>

Junio C Hamano <gitster@pobox.com> writes:

> A small thing I noticed in the test (and this patch is not adding a
> new "breakage"---there are a few existing instances) is the use of
> "~/"; it should be spelled "$HOME/" instead for portability (not in
> POSIX, even though bash, dash and ksh all seem to understand it).

Well, I was wrong. Tilde expansion is in POSIX.

Nevertheless, I'd prefer if we avoided it.
