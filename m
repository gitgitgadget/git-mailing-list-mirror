From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: Re: [PATCH 4/4] t4300 (rebase): don't unnecessarily set GIT_TRACE
Date: Sat, 11 May 2013 17:07:14 +0530
Message-ID: <CALkWK0=rqjduiWsj2-iqCoW9tsv4G8gvpf7fCZwg5=TKuEo+bA@mail.gmail.com>
References: <1368196178-5807-1-git-send-email-artagnon@gmail.com>
 <1368196178-5807-5-git-send-email-artagnon@gmail.com> <7vmws2529j.fsf@alter.siamese.dyndns.org>
 <CALkWK0k_ArM9EpY0S7=mbgFpHsoauZCr9e=ESX_CEA5-vRHrHQ@mail.gmail.com>
 <7vr4he3kpz.fsf@alter.siamese.dyndns.org> <CALkWK0kLjf=m-_9PkXzxOpnpqfh-n004E0f7_mi-VL3SbYWFAg@mail.gmail.com>
 <7vk3n6206h.fsf@alter.siamese.dyndns.org> <CALkWK0kTvwxMFGUqH0wKNVpLg-qQQbN+vOcAxiEwmOeDe=87jA@mail.gmail.com>
 <20130510190705.GA3478@elie> <CALkWK0kZWrY5_B3mxuVV1cA-AqvkqJpjRAuSovXLi6OCA+3ybQ@mail.gmail.com>
 <20130510191639.GB3478@elie> <7vk3n6zgr3.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Jonathan Nieder <jrnieder@gmail.com>,
	Git List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat May 11 13:38:01 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ub87k-0004UD-B1
	for gcvg-git-2@plane.gmane.org; Sat, 11 May 2013 13:38:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751704Ab3EKLhz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 11 May 2013 07:37:55 -0400
Received: from mail-ie0-f171.google.com ([209.85.223.171]:36778 "EHLO
	mail-ie0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750924Ab3EKLhz (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 11 May 2013 07:37:55 -0400
Received: by mail-ie0-f171.google.com with SMTP id e11so9734794iej.30
        for <git@vger.kernel.org>; Sat, 11 May 2013 04:37:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:mime-version:in-reply-to:references:from:date:message-id
         :subject:to:cc:content-type;
        bh=h73b0USotR+e9s4z1gUEOcujgQbgVHJPPXkcfZpGvC4=;
        b=OZI98SSZ8CvplyX7aLEQWK8fI5IHhKtMRTpCC7neNftyRagTzZqGEHnUM5LRcXcT5A
         Msk/wIfVySyO4BFRcv+soJKZuOg5rJkQfQBK4HZJ8rpj0HZ5el4OrKxisAOO2kRmAiBy
         eFvVGxBHpn48O0V8bMDLmv4TeVjv6BPPZdu2O7w3Tpeyt0UailMniBdCk1852gt0LDdM
         /+CXP7RLHvfhnbg1kqzaNBjtW6GL2xLxm512I7uNK3zt4UWkU3gcGQBYRfNmRpKVLFn6
         yBW4YuSNbomacRxB38ITzN1CtueUKhXRVdakHP5ttU/6yL+Ch1KbOpnt6+ETipIek8hW
         SeXA==
X-Received: by 10.50.66.140 with SMTP id f12mr4720932igt.63.1368272274587;
 Sat, 11 May 2013 04:37:54 -0700 (PDT)
Received: by 10.64.46.1 with HTTP; Sat, 11 May 2013 04:37:14 -0700 (PDT)
In-Reply-To: <7vk3n6zgr3.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/223958>

Junio C Hamano wrote:
> But the output from passing "-v" before the test that breaks is not
> very useful for two reasons.

I sometimes checkout the Good branch in a different worktree, compare
the output/ state of the passing test with the failing one.  I've
never really found the outputs from earlier tests enlightening.  From
my experience, the failure is often due to an earlier test not
imposing tighter passing conditions: but because it's shell, the
debugging time is very small.  I always just patch-locally and run.

I'm not sure how to make the testing framework more useful.
