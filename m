From: Michael Blume <blume.mike@gmail.com>
Subject: Re: AW: [PATCH 1/2] stash--helper: implement "git stash--helper"
Date: Mon, 1 Feb 2016 15:36:27 -0800
Message-ID: <CAO2U3QhvibfEexCUuDJyj=4P+bebnrQhMaVq3VrgNBLbiTDNaA@mail.gmail.com>
References: <BLU436-SMTP27D65F59A444FA678FFD8AA5DA0@phx.gbl>
 <0000015289f33df4-d0095101-cfc0-4c41-b1e7-6137105b93fb-000000@eu-west-1.amazonses.com>
 <xmqqr3h1l2x8.fsf@gitster.mtv.corp.google.com> <BLU436-SMTP10996033F3EBFE2E8639F96A5DB0@phx.gbl>
 <xmqqlh78ximf.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?Q?Matthias_A=C3=9Fhauer?= <mha1993@live.de>,
	Git List <git@vger.kernel.org>,
	Thomas Gummerer <t.gummerer@gmail.com>,
	Stefan Beller <sbeller@google.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Feb 02 00:36:56 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aQO1g-00074N-AA
	for gcvg-git-2@plane.gmane.org; Tue, 02 Feb 2016 00:36:56 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751441AbcBAXgt convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 1 Feb 2016 18:36:49 -0500
Received: from mail-ig0-f174.google.com ([209.85.213.174]:38393 "EHLO
	mail-ig0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751219AbcBAXgr convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 1 Feb 2016 18:36:47 -0500
Received: by mail-ig0-f174.google.com with SMTP id mw1so45203000igb.1
        for <git@vger.kernel.org>; Mon, 01 Feb 2016 15:36:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        bh=afFtnsIOgXoBq2BfdbimAi2wKl/BkMNJ8NsVH/bzBTw=;
        b=cawP1UVbBdgIthtQX8B51x7XLdUEmNsCy1EnQu29u5lWRCGeAxELZ0Fko4tOBGnkOQ
         vkKPSSUGrWEFOe7s818U4TLb7yc1AhEQ0j8MBmPqYjHu4oEVyaBWvTL6fD13flax77Bg
         2Im5K47P9K1vIInino13XJpj259d3HvDB/vZ3N/gsFo6X5ltGnbNWgRQ29fkLhlFOmQE
         7qyaR0ikX21dtHGuqR2ESGYk7f5Ki1dz+32vGNUEF0vO52UJ5RJo7vrtrtokx5mPE2Kz
         v6xA+agRddvHH723uiQO7S36FYhgDO+rray8jiN7QspFjKYdselA3KJWf3IyMHI3l6HP
         oCTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-type:content-transfer-encoding;
        bh=afFtnsIOgXoBq2BfdbimAi2wKl/BkMNJ8NsVH/bzBTw=;
        b=GzzvdaUm/dwqk2HVVOVJGrGga0l+p3Ot+/a+Drzfz1YD/4+s+2JNcrPbhzY8oGkg0B
         cUwFMJKIDs1U+GdCiPzjOtJCi7CAHSjcBkynEByiz+TlrhiHzUbyt0TOmtGRpk0tlrA5
         HmutgT/OpJWXyCnZwFV3KXjgFpN+ZwBu1QN++LFQjhXNqU8NzUUaHL9saqiGct2VjEs+
         XlpxuK8u7b/kHJWO4RhK8gUD5q8k4z2MAsrVxBsuY9aM3KRvEV2CUGg+C9lXxoYV7p1l
         Be1cqytc3aJKp3Uhkv4VqdlX/Ge31I7IVZX+dZjhiTjO6UyYTF6zbdmbxfgV3mChBuBK
         a0uA==
X-Gm-Message-State: AG10YOSXNjTbv6EZhcAqpMPjFoBxhbjNApLrBv3Xix0A97X2sHwehdhUialhH2cCuaEVqploHsrgcTX2oF1uZQ==
X-Received: by 10.50.102.40 with SMTP id fl8mr14041082igb.85.1454369806762;
 Mon, 01 Feb 2016 15:36:46 -0800 (PST)
Received: by 10.36.149.131 with HTTP; Mon, 1 Feb 2016 15:36:27 -0800 (PST)
In-Reply-To: <xmqqlh78ximf.fsf@gitster.mtv.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/285225>

On Fri, Jan 29, 2016 at 11:58 AM, Junio C Hamano <gitster@pobox.com> wr=
ote:
> Matthias A=C3=9Fhauer <mha1993@live.de> writes:
>
> [administrivia: please wrap your lines to reasonable lengths]
>
>>> Honestly, I had high hopes after seeing the "we are rewriting it
>>> in C" but I am not enthused after seeing this.  I was hoping that
>>> the rewritten version would do this all in-core, by calling these
>>> functions that we already have:
>>
>> These functions might be obvious to you, but I'm new to git's
>> source code, ...
>
> Ahh, I didn't realize I was talking with somebody unfamiliar with
> the codebase.  Apologies.
>
> Nevertheless, the list of functions I gave are a good starting
> point; they are widely used building blocks in the codebase.
>
>> I'll be working on a v2 that incorporates the feedback from you,
>> Thomas Gummerer and Stefan Beller then. Further feedback is of
>> course welcome.
>
> Thanks.
> --
> To unsubscribe from this list: send the line "unsubscribe git" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

Maybe this isn't important given that it looks like the patch is going
to be rewritten, but I have

stash.c:43:18: warning: incompatible pointer types assigning to 'const
char *const *' from 'const char *'; take the address with &
[-Wincompatible-pointer-types]
                write_tree.env =3D prefix;
