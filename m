From: =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Subject: Re: [PATCH] Makefile: implement help target
Date: Tue, 28 Sep 2010 14:54:49 +0000
Message-ID: <AANLkTi=Z1HZDS=Cb4+zx7h95cgbOz7_KyTc5LGTD1jvw@mail.gmail.com>
References: <4CA1E10F.4080906@op5.se>
	<c16e8df7c8e9b562ce0e6cd6e543a83779cd2b25.1285684868.git.git@drmicha.warpmail.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	Stephen Boyd <bebarino@gmail.com>,
	Andreas Ericsson <ae@op5.se>,
	Sverre Rabbelier <srabbelier@gmail.com>
To: Michael J Gruber <git@drmicha.warpmail.net>
X-From: git-owner@vger.kernel.org Tue Sep 28 16:54:57 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1P0ba4-0007ZP-Tu
	for gcvg-git-2@lo.gmane.org; Tue, 28 Sep 2010 16:54:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756585Ab0I1Oyv convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 28 Sep 2010 10:54:51 -0400
Received: from mail-gy0-f174.google.com ([209.85.160.174]:56287 "EHLO
	mail-gy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755073Ab0I1Oyu convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 28 Sep 2010 10:54:50 -0400
Received: by gyd8 with SMTP id 8so38561gyd.19
        for <git@vger.kernel.org>; Tue, 28 Sep 2010 07:54:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:in-reply-to
         :references:date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=tPgcjL7/EX7KuHxVNBkAK+51AG+HQgo5IPljTKngamk=;
        b=FWWogkFB5lVTOhYfhCNk/BzD7UvGd2lAFMPdOdGFe6bLNe7yeDqQ2RgiV+7x1xLLbV
         1Cqvuc3v6rYdt61LcO8AwJ0G4d7CCXPcoE6kS7wp+N2i9Wch/+RMYxG9OU9mBYtcQPbK
         A1mRMzO0ZzcHjiTWcV8v9ZQJBDbZGwOlxMGiM=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=bVDaaqRG+h3xBKTVZQlTRTsaG44fLJtTmnZDl3X16O7W5KGr7CIrU+tggRBRv8BWHH
         b+j/Ntc6e9mKpk+66nH+qQj9dz+roMAAYijyjWeV+qeagEDi5OLRzFnkw/Tc81RLqmPn
         /WnSeUYh+t71v3oAUc3xN7DGKDLjCY2dFlkCc=
Received: by 10.231.10.200 with SMTP id q8mr41694ibq.83.1285685689417; Tue, 28
 Sep 2010 07:54:49 -0700 (PDT)
Received: by 10.231.48.195 with HTTP; Tue, 28 Sep 2010 07:54:49 -0700 (PDT)
In-Reply-To: <c16e8df7c8e9b562ce0e6cd6e543a83779cd2b25.1285684868.git.git@drmicha.warpmail.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/157431>

On Tue, Sep 28, 2010 at 14:44, Michael J Gruber
<git@drmicha.warpmail.net> wrote:

> +#H# Check test coverage and create HTMl report

HTML, not HTMl

> =C2=A0cover_db_html: cover_db
> =C2=A0 =C2=A0 =C2=A0 =C2=A0cover -report html -outputdir cover_db_htm=
l cover_db
> +
> +#H# Show help for main make targets

How about something less opaque, like "# Help: Show help [...]" or "#
About:". It would serve the same purpose as #H#, without the reader
wondering what that odd string means.

> +help:
> + =C2=A0 =C2=A0 =C2=A0 @sed -n =C2=A0-e '/^#H#/ {N'\
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 -e 's/^#H# \(.*\)\=
n\([a-z0-9_-]*\):.*/\2 \1/p'\
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 -e '}' <Makefile |=
 sort --key=3D2 | while read target txt;\
> + =C2=A0 =C2=A0 =C2=A0 do \
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 printf "%-20s: %s\=
n" "$$target" "$$txt"; \
> + =C2=A0 =C2=A0 =C2=A0 done

Looks good, but --key=3D2 isn't in POSIX.
