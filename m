From: Junio C Hamano <gitster@pobox.com>
Subject: Re: tr/xdiff-fast-hash generates warnings and breaks tests
Date: Thu, 17 May 2012 09:23:40 -0700
Message-ID: <xmqqmx56rd2r.fsf@junio.mtv.corp.google.com>
References: <CAA787r=WCJXeDipiVL37oMgji=ncoPyXXVOcCyYbSC6iCcTi1g@mail.gmail.com>
	<4FB4A4B9.3080009@lsrfire.ath.cx>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?utf-8?Q?=C3=98yvind_A=2E_Holm?= <sunny@sunbase.org>,
	git@vger.kernel.org, Thomas Rast <trast@student.ethz.ch>,
	Junio C Hamano <gitster@pobox.com>
To: =?utf-8?Q?Ren=C3=A9?= Scharfe <rene.scharfe@lsrfire.ath.cx>
X-From: git-owner@vger.kernel.org Thu May 17 18:23:50 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SV3UT-0002hQ-FQ
	for gcvg-git-2@plane.gmane.org; Thu, 17 May 2012 18:23:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759562Ab2EQQXp convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 17 May 2012 12:23:45 -0400
Received: from mail-fa0-f74.google.com ([209.85.161.74]:63249 "EHLO
	mail-fa0-f74.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758472Ab2EQQXn convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 17 May 2012 12:23:43 -0400
Received: by faaa25 with SMTP id a25so106547faa.1
        for <git@vger.kernel.org>; Thu, 17 May 2012 09:23:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-type:content-transfer-encoding
         :x-gm-message-state;
        bh=t3+gORan1UisdVzsDjd1J4ZSmr/8m0gdhivLwwjVIDA=;
        b=EPi2OXQL68HunSnaizxugxvq05fCgL/xMuau1mBOUhUWVDGGGCS3ldSCZCOgxZKtPA
         u5nBDAyWTPJcpMr6c/dxKEypCrjaegty11ThGr+6VQ/qorj5r3dFnnO/9n2/16Ayugqx
         xIq5+kA/nsQU590mXcaxNavLUUNQ5XNNriO1lo0CdbiatkCdnhaYUh3PVTjn/XjuTiw0
         5UrQdSr9u/i1PpGU9p892dSj5RqdsB/sD20Pt6GNPA4A8+ri00lZqZIX/wSHTeuYLPJk
         zwjldyiIidoHpVMXfMdQVPN8n6KO3zAzCO7YFb1Sc3EXRytaPmi4ONtCd7omEEbUGYhT
         +JEQ==
Received: by 10.14.199.133 with SMTP id x5mr1620998een.7.1337271822260;
        Thu, 17 May 2012 09:23:42 -0700 (PDT)
Received: by 10.14.199.133 with SMTP id x5mr1620990een.7.1337271822203;
        Thu, 17 May 2012 09:23:42 -0700 (PDT)
Received: from hpza9.eem.corp.google.com ([74.125.121.33])
        by gmr-mx.google.com with ESMTPS id b15si5606314een.0.2012.05.17.09.23.42
        (version=TLSv1/SSLv3 cipher=AES128-SHA);
        Thu, 17 May 2012 09:23:42 -0700 (PDT)
Received: from junio.mtv.corp.google.com (junio.mtv.corp.google.com [172.27.69.24])
	by hpza9.eem.corp.google.com (Postfix) with ESMTP id 064225C006B;
	Thu, 17 May 2012 09:23:42 -0700 (PDT)
Received: by junio.mtv.corp.google.com (Postfix, from userid 110493)
	id 52B20E25F4; Thu, 17 May 2012 09:23:41 -0700 (PDT)
In-Reply-To: <4FB4A4B9.3080009@lsrfire.ath.cx> (=?utf-8?Q?=22Ren=C3=A9?=
 Scharfe"'s message of
	"Thu, 17 May 2012 09:11:53 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.1 (gnu/linux)
X-Gm-Message-State: ALoCoQljaoAvFRJvkfW/ZA8MBvTS1YXiG+dAY+7l1UQRoZkTC1Jm4wioNmVP+Q5Q3SfU8US3I2UNixQA92Bzer8cByLVTtYFlhyAn+i3tQYkJE76Lt2r4bT0ajRej1gKbf59mjWDhi7uRDLuzr0nBEYup3fKl8bV3A==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/197921>

Ren=C3=A9 Scharfe <rene.scharfe@lsrfire.ath.cx> writes:

> Am 17.05.2012 01:31, schrieb =C3=98yvind A. Holm:
>> On Debian GNU/Linux 6.0.5 (squeeze), the two commits on the
>> tr/xdiff-fast-hash branch introduces compiler warnings and breaks
>> t/t0020-crlf.sh and maybe later tests:
>
> What does the following short C program report when run (e.g. put it
> in a file named s.c, then run "gcc -o s s.c" and "./s")?
>
>   #include <stdio.h>
>   int main(int argc, const char **argv) {
>     printf("%u %u %u\n", sizeof(int), sizeof(long), sizeof(void *));
>     return 0;
>   }
>
> I suspect you run a 32-bit userland on a 64-bit kernel.
>
> On Ubuntu 12.04 x86, t0020 fails for me as well when I compile with
> XDL_FAST_HASH explicitly set (it's off by default).

OK.  So does that indicate at least breakage in the Makefile that
attempts to set XDL_FAST_HASH only on x86_64, mistakenly triggering
on =C3=98yvind's x86 32-bit userland, or did =C3=98yvind manually flipp=
ed the
feature on?

It is a separate issue that XDL_FAST_HASH code does not work on 32-bit
systems, even though it is advertised that it only needs to be on
little-endian.

> It succeeds after reverting 6f1af02, though, strangely enough.

It is strange.  I do not see anything glaringly wrong in the conversion
in that commit.  The only difference I see is that count_masked_bytes i=
n
the original used to take unsigned long on 64-bit archs but the updated
one takes signed long, but that on 32-bit archs the function takes
signed long in both versions so it cannot be it.  Stumped...

> Also, here are the measurements for master (v1.7.10.2-520-g6a4a482)
> without XDL_FAST_HASH, and with master minus 6f1af02 plus explicitly
> set XDL_FAST_HASH:
>
>   Test                                 master           reverted+FAST
>   -------------------------------------------------------------------=
--
>   4000.1: log -3000 (baseline)         0.08(0.05+0.02)  0.08(0.05+0.0=
2)
>   4000.2: log --raw -3000 (tree-only)  0.39(0.34+0.04)  0.39(0.32+0.0=
6)
>   4000.3: log -p -3000 (Myers)         1.55(1.43+0.11)  1.43(1.29+0.1=
2)
>   4000.4: log -p -3000 --histogram     1.63(1.51+0.10)  1.50(1.35+0.1=
4)
>   4000.5: log -p -3000 --patience      1.85(1.71+0.13)  1.73(1.62+0.1=
0)

So the patch does give us slight performance edge, when it works ;-)
