From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: [PATCH] t0005: skip signal death exit code test on Windows
Date: Thu, 6 Jun 2013 13:32:08 -0500
Message-ID: <CAMP44s0Qq2n5cJa9buaLgNDTp61cxA1G+XutTZasphkGmyguHg@mail.gmail.com>
References: <7vtxld30f2.fsf@alter.siamese.dyndns.org>
	<51AEE1C3.9020507@viscovery.net>
	<20130605071206.GC14427@sigill.intra.peff.net>
	<51B02D81.3000700@viscovery.net>
	<20130606063754.GA20050@sigill.intra.peff.net>
	<CAMP44s2L4EOG7aEOR8gqXeaHm7SeuPg=GQAWX3PByKKbtTHnwQ@mail.gmail.com>
	<20130606064409.GA20334@sigill.intra.peff.net>
	<7vy5anyx1w.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Jeff King <peff@peff.net>, Johannes Sixt <j.sixt@viscovery.net>,
	git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Jun 06 20:32:16 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ukeyt-0006uZ-Gg
	for gcvg-git-2@plane.gmane.org; Thu, 06 Jun 2013 20:32:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751818Ab3FFScL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 6 Jun 2013 14:32:11 -0400
Received: from mail-la0-f45.google.com ([209.85.215.45]:63850 "EHLO
	mail-la0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751129Ab3FFScK (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 6 Jun 2013 14:32:10 -0400
Received: by mail-la0-f45.google.com with SMTP id fr10so2908996lab.18
        for <git@vger.kernel.org>; Thu, 06 Jun 2013 11:32:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=fGNbMX92YPHW3vkJZ1LKmbspB+BI0lY1IWfRpmaNo9s=;
        b=Rxpbrs7QwGUVxH+QTnCDRblxVVECab/3U+X5VI16jm3Xd+0w6UORSg/PquYr8x4lDr
         yMAwa3VXMMTjVTToCztSRpOBykPgDXlXZD44jAM1OdY53PgE1AIJ8dQqenNdLTbBOyVa
         VM5ApwlgyV8dWNdz1ysgXg2ndPuMo897dv9ZobAx9j5ATEGnnLbzvynEOrF15yJdPsJy
         9OKwTL7UJ2xWkkwy5jkRRGuWbe3GXtpAvKd9PGW2O7psiO6YL3/4OyFcPIabAEbdZnQ4
         uJOjytEsZAYgoI7nXRXTsEznDERKOsyVJW1o4PHcYfuwzFwtKP0sdcPBhJCDfEXAUN9E
         +Gfw==
X-Received: by 10.152.22.73 with SMTP id b9mr5865885laf.36.1370543528072; Thu,
 06 Jun 2013 11:32:08 -0700 (PDT)
Received: by 10.114.59.202 with HTTP; Thu, 6 Jun 2013 11:32:08 -0700 (PDT)
In-Reply-To: <7vy5anyx1w.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/226525>

On Thu, Jun 6, 2013 at 12:21 PM, Junio C Hamano <gitster@pobox.com> wrote:
> Jeff King <peff@peff.net> writes:

>> If somebody wants to write a note somewhere in the git
>> documentation, that's fine with me, but I'm not clear on exactly
>> what it would even say.
>
> I agree with both points.  I can suggest to clarify the log message
> a bit with "the implementation of raise() in msvcrt (Microsoft C
> Runtime library) just calls exit(3)", but that does not address the
> end-user documentation issue.
>
> I tried to summarize the issue for end-user documentation and came
> up with this:
>
>     The Git implementation on MinGW

That's not accurate at all. MinGW is essentially a compiler for
Windows. It doesn't matter if you use MinGW, Visual C++, or any other
compiler for Windows, the result would be the same.

> But when stated this way, it feels that it belongs to Msysgit
> documentation, not ours, at least to me.

Are we saying then that Git doesn't support Windows? That wouldn't be
wise considering it's one of the most widely used reasons to argue
that Git is not a good choice of a SCM; lack of Windows support.

The truth of the matter is that exit codes are platform-dependent. Period.

-- 
Felipe Contreras
