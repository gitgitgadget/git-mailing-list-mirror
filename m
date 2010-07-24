From: =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Subject: Re: [PATCH 3/6] Makefile: Split out the untested functions target
Date: Sat, 24 Jul 2010 23:29:20 +0000
Message-ID: <AANLkTikB_QV6NoaNkubfM267tZvjYN7LzMNTFkwW-eEO@mail.gmail.com>
References: <1280004663-4887-1-git-send-email-avarab@gmail.com>
	<1280004663-4887-4-git-send-email-avarab@gmail.com>
	<201007250102.20099.trast@student.ethz.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
To: Thomas Rast <trast@student.ethz.ch>
X-From: git-owner@vger.kernel.org Sun Jul 25 01:29:27 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Oco9m-0007Ur-E5
	for gcvg-git-2@lo.gmane.org; Sun, 25 Jul 2010 01:29:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754121Ab0GXX3W convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 24 Jul 2010 19:29:22 -0400
Received: from mail-iw0-f174.google.com ([209.85.214.174]:38642 "EHLO
	mail-iw0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754017Ab0GXX3V convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 24 Jul 2010 19:29:21 -0400
Received: by mail-iw0-f174.google.com with SMTP id 7so1530177iwn.19
        for <git@vger.kernel.org>; Sat, 24 Jul 2010 16:29:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:in-reply-to
         :references:date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=bNU7ccoYQBSWwigpeK/qWiHxrngYeHa85EajhH3uHn8=;
        b=f8w+ZyQmqlGmFffmpl/IXdaWBMwaTINlRhAiUMuKiqq5XNBdrGfY1m//A2SVk8ztZQ
         YLUxFmcHLBUpafbZ6+Qdc5lYtfokH2B2U5Riu6xnNdMAVjPuTEOFc+W85zrCe2A9YDKr
         fvnmK4FUN/AFueFeP2IwMwnqf2FjVMvAf2/68=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=Jqsa7kiahboJXZsT+7JvJjjJxbVhE7WaJwSCeeOBkiO3LX3R2DpMUuQyVhrBN9ImkS
         0lPJvsKKhjr8ZTe/hACm3Os2T+XNMiV6IgqO5NohTPEALSPPJmVtmKJBZ4eCT049U6mR
         NirU+J7hEYTJy98apGFAyel0jK4RqB82F3Y8g=
Received: by 10.231.33.205 with SMTP id i13mr6139664ibd.179.1280014160756; 
	Sat, 24 Jul 2010 16:29:20 -0700 (PDT)
Received: by 10.231.166.79 with HTTP; Sat, 24 Jul 2010 16:29:20 -0700 (PDT)
In-Reply-To: <201007250102.20099.trast@student.ethz.ch>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/151688>

On Sat, Jul 24, 2010 at 23:02, Thomas Rast <trast@student.ethz.ch> wrot=
e:
> =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason wrote:
>> Change the coverage-report target so that it doesn't generate the
>> coverage-untested-functions file by default. I'm adding more targets
>> for doing various things with the gcov files, and they shouldn't all
>> run by default.
>>
>> Signed-off-by: =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.=
com>
>> ---
>> =C2=A0Makefile | =C2=A0 =C2=A02 ++
>> =C2=A01 files changed, 2 insertions(+), 0 deletions(-)
>>
>> diff --git a/Makefile b/Makefile
>> index 63f3f84..5e9a6a2 100644
>> --- a/Makefile
>> +++ b/Makefile
>> @@ -2299,6 +2299,8 @@ coverage-report:
>> =C2=A0 =C2=A0 =C2=A0 gcov -b -o builtin builtin/*.c
>> =C2=A0 =C2=A0 =C2=A0 gcov -b -o xdiff xdiff/*.c
>> =C2=A0 =C2=A0 =C2=A0 gcov -b -o compat compat/*.c
>> +
>> +coverage-report-untested-functions:
>> =C2=A0 =C2=A0 =C2=A0 grep '^function.*called 0 ' *.c.gcov \
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 | sed -e 's/\([^:]*=
\)\.gcov: *function \([^ ]*\) called.*/\1: \2/' \
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 | tee coverage-unte=
sted-functions
>
> This should depend on coverage-report, and either have its name
> changed to coverage-untested-functions or be .PHONY.

Will fix, thanks.
