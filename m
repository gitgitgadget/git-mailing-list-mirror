From: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
Subject: Re: [PATCH] fsck: print progress
Date: Sat, 5 Nov 2011 16:02:01 +0700
Message-ID: <CACsJy8CEh6x1O0AHpiErZ_+T2hGwjRZofygmsgVX8_WXV7uDTA@mail.gmail.com>
References: <20111103211819.GA17341@sigill.intra.peff.net> <1320376242-27851-1-git-send-email-pclouds@gmail.com>
 <4EB4EB70.40801@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	Jeff King <peff@peff.net>
To: Stephen Boyd <bebarino@gmail.com>
X-From: git-owner@vger.kernel.org Sat Nov 05 10:02:47 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RMc9H-0003rI-0q
	for gcvg-git-2@lo.gmane.org; Sat, 05 Nov 2011 10:02:47 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752074Ab1KEJCe convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 5 Nov 2011 05:02:34 -0400
Received: from mail-bw0-f46.google.com ([209.85.214.46]:62696 "EHLO
	mail-bw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751935Ab1KEJCd convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 5 Nov 2011 05:02:33 -0400
Received: by bke11 with SMTP id 11so2568764bke.19
        for <git@vger.kernel.org>; Sat, 05 Nov 2011 02:02:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        bh=pmY0sGVFBy/1Wmu9ikiInjEhXYTGCVMhY87gFwVpy7s=;
        b=lUlWcWr+VDoT6F50vQJIBEbfK7xd9BB8uANOWKSDtasTWoTiJ/MzJgKmlne2j3XfvH
         7eBR7t59jMajGSPpKzGlCpeSkazSolk4kuhexaP5oxrorkrMoCLz+Kis++RoCuyc2Npf
         dzoPHqFJ3Uv9OWiCU+dsdXq/8nUawTqCxphy0=
Received: by 10.204.139.8 with SMTP id c8mr13973576bku.97.1320483752128; Sat,
 05 Nov 2011 02:02:32 -0700 (PDT)
Received: by 10.204.177.79 with HTTP; Sat, 5 Nov 2011 02:02:01 -0700 (PDT)
In-Reply-To: <4EB4EB70.40801@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/184838>

2011/11/5 Stephen Boyd <bebarino@gmail.com>:
> On 11/03/2011 08:10 PM, Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy wro=
te:
>> diff --git a/Documentation/git-fsck.txt b/Documentation/git-fsck.txt
> [...]
>> +--progress::
>> +--no-progress::
>> + =C2=A0 =C2=A0 When fsck is run in a terminal, it will show the pro=
gress.
>> + =C2=A0 =C2=A0 These options can force progress to be shown or not
>> + =C2=A0 =C2=A0 regardless terminal check.
>
> Can we reuse the --progress description in fetch-options.txt (minus t=
he q)?
>
> --[no]-progress::
> =C2=A0 =C2=A0 =C2=A0 =C2=A0Progress status is reported on the standar=
d error stream
> =C2=A0 =C2=A0 =C2=A0 =C2=A0by default when it is attached to a termin=
al. This flag
> =C2=A0 =C2=A0 =C2=A0 =C2=A0forces progress status even if the standar=
d error stream
> =C2=A0 =C2=A0 =C2=A0 =C2=A0is not directed to a terminal.
>
>
>> ++
>> +Progress is not shown when --verbose is used. --progress is ignored
>> +in this case.
>
> What progress isn't shown? How about
>
> =C2=A0 =C2=A0 =C2=A0 =C2=A0If --verbose is used with --progress the p=
rogress status
> =C2=A0 =C2=A0 =C2=A0 =C2=A0will not be shown.

"-q" in fetch-options.txt can be converted to "--no-progress or
--verbose". How about this?

--progress::
--no-progress::
	Progress status is reported on the standard error stream by
	default when it is attached to a terminal, unless
	--no-progress or --verbose is specified. --progress forces
	progress status even if the standard error stream is not
	directed to a terminal.
--=20
Duy
