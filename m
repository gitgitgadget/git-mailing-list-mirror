From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2 01/18] t1404: new tests of ref D/F conflicts within transactions
Date: Thu, 14 May 2015 10:00:06 -0700
Message-ID: <xmqqr3qj857t.fsf@gitster.dls.corp.google.com>
References: <1431357920-25090-1-git-send-email-mhagger@alum.mit.edu>
	<1431357920-25090-2-git-send-email-mhagger@alum.mit.edu>
	<xmqqlhgu3nyl.fsf@gitster.dls.corp.google.com>
	<5551BA88.3090900@alum.mit.edu>
	<CAPc5daVQEMv-QPDpyNVGzcjrjrw20QLzm8dkC0ZYAX=Y4zGaBQ@mail.gmail.com>
	<5553B1E0.9080008@alum.mit.edu>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Stefan Beller <sbeller@google.com>,
	Eric Sunshine <sunshine@sunshineco.com>,
	Jeff King <peff@peff.net>,
	Git Mailing List <git@vger.kernel.org>
To: Michael Haggerty <mhagger@alum.mit.edu>
X-From: git-owner@vger.kernel.org Thu May 14 19:00:15 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YswUY-0008PV-Tr
	for gcvg-git-2@plane.gmane.org; Thu, 14 May 2015 19:00:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932824AbbENRAK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 14 May 2015 13:00:10 -0400
Received: from mail-ig0-f171.google.com ([209.85.213.171]:38413 "EHLO
	mail-ig0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932698AbbENRAJ (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 14 May 2015 13:00:09 -0400
Received: by igbhj9 with SMTP id hj9so78276743igb.1
        for <git@vger.kernel.org>; Thu, 14 May 2015 10:00:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-type;
        bh=7KFRo5rd7yJr72bzEFQuinHXKs99GYp2zRCqBg/+1Yc=;
        b=vel8TTl7Pl33am2JSKJgdR46UG2d39ip1HOMrVfzDylHjlU+CKHpza1ryK2QFk5N4f
         gowz00NxKz6p0RpKGRpzoA3idoUA9bW6hAaOvOTkbIh5w2eYM8bYzhO9rKowtliGAxJs
         FzBsonjBT2QxIcxXPd1pMla0N4nQMru+Kx+Q8d9WgV3ORC4pOlpn6BE1a3b7WU+zyVhM
         QFXt6syzaKAypE63vIBOqLDz1mpFNQI8/EtiVDEXYbw6nAtMArn/0PJmMF7q5mJdt1lS
         pGf9jtABjywk2EwXL28B73YoOlDs6j8qcnjgndWpyOF4fibGYmnFxnDfF/VP3rVK9D01
         KxYA==
X-Received: by 10.107.138.130 with SMTP id c2mr6562896ioj.74.1431622808637;
        Thu, 14 May 2015 10:00:08 -0700 (PDT)
Received: from localhost ([2620:0:10c2:1012:74eb:19e4:cd06:a6b6])
        by mx.google.com with ESMTPSA id j20sm6216005igt.16.2015.05.14.10.00.07
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Thu, 14 May 2015 10:00:07 -0700 (PDT)
In-Reply-To: <5553B1E0.9080008@alum.mit.edu> (Michael Haggerty's message of
	"Wed, 13 May 2015 22:19:44 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/269044>

Michael Haggerty <mhagger@alum.mit.edu> writes:

>> But there is a i18n markings test, for which test-i18ngrep was invented for.
>
> Thanks for the info. I wasn't aware of that facility.
>
> So if I understand correctly, s/grep/test_i18ngrep/ will address your
> concern? That's fine with me.

Thinking about it again, should these messages ever be translated,
or are they plumbing messages that should never get translated?

If the latter, then 'grep' is the right thing to do; in fact, it
would be a bug in the test if we used test_i18ngrep.

	Side note: besides, I think gettext-poison tests have bitrot
	and are no longer very useful (if they ever were, that is).

> In any case I'll be away for a 4-day weekend so it will have to wait
> until Monday.

Enjoy your long weekend ;-)
