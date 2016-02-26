From: Jacob Keller <jacob.keller@gmail.com>
Subject: Re: [PATCH v3 2/2] git: submodule honor -c credential.* from command line
Date: Thu, 25 Feb 2016 18:19:17 -0800
Message-ID: <CA+P7+xqyTUh60BOmY03JHE6HyVqY7iidVkUf3ji95_s3uE32cg@mail.gmail.com>
References: <1456426632-23257-1-git-send-email-jacob.e.keller@intel.com>
 <1456426632-23257-2-git-send-email-jacob.e.keller@intel.com> <20160226015510.GA5347@flurp.local>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Jacob Keller <jacob.e.keller@intel.com>,
	Git mailing list <git@vger.kernel.org>,
	Jeff King <peff@peff.net>,
	Mark Strapetz <marc.strapetz@syntevo.com>,
	Stefan Beller <sbeller@google.com>,
	Junio C Hamano <gitster@pobox.com>
To: Eric Sunshine <sunshine@sunshineco.com>
X-From: git-owner@vger.kernel.org Fri Feb 26 03:19:44 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aZ80L-0007O0-NZ
	for gcvg-git-2@plane.gmane.org; Fri, 26 Feb 2016 03:19:42 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751342AbcBZCTi (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 25 Feb 2016 21:19:38 -0500
Received: from mail-ig0-f173.google.com ([209.85.213.173]:37950 "EHLO
	mail-ig0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750736AbcBZCTh (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 25 Feb 2016 21:19:37 -0500
Received: by mail-ig0-f173.google.com with SMTP id y8so26975907igp.1
        for <git@vger.kernel.org>; Thu, 25 Feb 2016 18:19:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=q8ZEO608w1q6YMwzcANbg0gVKg6ojg4z28zH8aaqVGQ=;
        b=uj7Z+23l2MpJb8WcjO5Tu6XaN58IqiX5vnnMnxB9IJbrd6xc0kiwDvHrijgchTarHX
         q71EtAZ4+b3xCtKpg7farigUCZphUn7+2MJaN97TrZro4AromBN7abHEuBymtSAZ2Ams
         fPkIQpKApJc3TPMGTY8ZhU6/HsS1B0s7sxwsm+ydl1An7ZE4vWAGdvkF/Pnudrm19DSi
         VZXPcYlkD2QCzRdxlmIzmLjYkm5lftBZ1i8LmfICiFesbWBf6vYyjWO21NjqeR/EwGrI
         o36Pfdo1Ia1AGZ8dTtK/mnJQA5L31aUYXeFJCqvM2uYDB0Q1HBNa7LwQUihm0mP5mzNb
         CoIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=q8ZEO608w1q6YMwzcANbg0gVKg6ojg4z28zH8aaqVGQ=;
        b=Z+P3iN0EJuLK2IL2+SAomCKFrtAUhZI8/YSJeDctw9/sOJmxuYecSGD/m1d8yKr4b/
         wzbllLnCT/zQ79vyYK4xTPABs7H471OVzmBaBRIocaEzvJMapVUGAV6ELibMspzmM1uL
         sSbr5doXc/LRgw0A1dOgwjMnecQwL+o9JS13HFX2KSKC/bew6827k45IarK/zb0sRtHB
         fF164glcmTV5YVe0eSBvjvRuYqgV9iyLwj8o0fpprGTopmjiMmPuCWP5ySQE0YMqxT1W
         8jOMa7gileuRxAwkqvSsdrttw/CEV5+ejF8F7zvkfo0L121MD1ZNY4QbH3LwRMxLfckG
         XR1A==
X-Gm-Message-State: AD7BkJL3v8NF1MM14vduBXwiIi0RcNdqukGY9tYUCUCN5K1Gf/NiyGM0wgHtIjoXNpiHq8fDaAc7XxZKQw/ZUA==
X-Received: by 10.50.142.103 with SMTP id rv7mr514727igb.35.1456453176390;
 Thu, 25 Feb 2016 18:19:36 -0800 (PST)
Received: by 10.107.20.76 with HTTP; Thu, 25 Feb 2016 18:19:17 -0800 (PST)
In-Reply-To: <20160226015510.GA5347@flurp.local>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/287531>

On Thu, Feb 25, 2016 at 5:55 PM, Eric Sunshine <sunshine@sunshineco.com> wrote:
> Not worth a re-roll, but these quote sequences are brain-melting.
> Easier would have been to double-quote the second argument of
> test_expect_success() and then do either:
>

They are. I fiddled with things till I got it working. I wasn't sure
if double quotes would cause a problem or not, since most other tests
seemed to avoid it.

However this re-roll forgot to check argc in submodule--helper so
maybe worth reroll to fix both things?

Thanks
Jake
