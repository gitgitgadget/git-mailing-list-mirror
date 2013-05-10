From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: Re: [PATCH 4/4] t4300 (rebase): don't unnecessarily set GIT_TRACE
Date: Fri, 10 May 2013 23:36:24 +0530
Message-ID: <CALkWK0kTvwxMFGUqH0wKNVpLg-qQQbN+vOcAxiEwmOeDe=87jA@mail.gmail.com>
References: <1368196178-5807-1-git-send-email-artagnon@gmail.com>
 <1368196178-5807-5-git-send-email-artagnon@gmail.com> <7vmws2529j.fsf@alter.siamese.dyndns.org>
 <CALkWK0k_ArM9EpY0S7=mbgFpHsoauZCr9e=ESX_CEA5-vRHrHQ@mail.gmail.com>
 <7vr4he3kpz.fsf@alter.siamese.dyndns.org> <CALkWK0kLjf=m-_9PkXzxOpnpqfh-n004E0f7_mi-VL3SbYWFAg@mail.gmail.com>
 <7vk3n6206h.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri May 10 20:07:16 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Uarir-0006iW-OH
	for gcvg-git-2@plane.gmane.org; Fri, 10 May 2013 20:07:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752301Ab3EJSHG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 10 May 2013 14:07:06 -0400
Received: from mail-ie0-f171.google.com ([209.85.223.171]:41555 "EHLO
	mail-ie0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751659Ab3EJSHF (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 10 May 2013 14:07:05 -0400
Received: by mail-ie0-f171.google.com with SMTP id e11so8601862iej.16
        for <git@vger.kernel.org>; Fri, 10 May 2013 11:07:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:mime-version:in-reply-to:references:from:date:message-id
         :subject:to:cc:content-type;
        bh=IEpcadiNzSnWzIeF7hhamUpo9k7FChobzYkhrXynl4s=;
        b=cV3x8jA/lvBoKTZLwBPGdtgwtJ6sF9zFQKbHwq2b+y+i22pTU+VyJIxn0Aqv/DimiB
         GphxVxe3svUrSlJPhulX71UxJHGuhCVOZ0SSlxW4W6xRSP4vYx7rnejl7jlc6tozMJRU
         GQnqBfTA7ihnB8Fblbk2tw1PMXX1AUhQp0XiTnTQgZVDpiAbVcGvcTZSaPxjwWUhgQpM
         +h9MGvjKa0jzDmxuBq7OHYJGMrfXw0TFhn20rw1/GH6jWALeOf8GdaO2kG4RZ7X5SdcM
         jUMb17YoCHtwEEMDG2pTvNJZbsLWrzPyS07cwYDiee+c4oFIohwgX0Mhwh0qV0lBRbse
         ZMKA==
X-Received: by 10.50.3.38 with SMTP id 6mr2900204igz.44.1368209224988; Fri, 10
 May 2013 11:07:04 -0700 (PDT)
Received: by 10.64.46.1 with HTTP; Fri, 10 May 2013 11:06:24 -0700 (PDT)
In-Reply-To: <7vk3n6206h.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/223887>

Junio C Hamano wrote:
> To me, most of them look like responses to valid issues, and that
> holds true even for [PATCH 1/4].  Even though your response may have
> been an incorrect one, the issue that triggered the response is
> still valid---the setting of these variables without explanation
> invites curiosities and a mistake similar to what you made in that
> patch.

I like comments, but lately I've seen nothing but reviews stripping my comments.

> If the patch were to consistently remove "GIT_TRACE=1" placed on
> "git rebase" from all test scripts that do not check the trace
> output consistently (i.e. 3400, 3402, and 7402), with a different
> justification, e.g. "whoever wants to debug a specific part of the
> test can add GIT_TRACE=1 before running the test with -v, but it
> should not be committed", the change would be very reasonable, I
> would think.

Quite frankly, I think -v is completely useless; who likes to scroll
through pages of terminal output?  If there are really users of this
thing, why haven't they got it to auto-pager yet?

I just comment out the test_expect_success and close-quote, and put a
test_done after it.  I would never advocate this GIT_TRACE thing
anywhere, because I want to put GIT_TRACE=1 (and possibly other
modifications) where I want it.  Locally.
