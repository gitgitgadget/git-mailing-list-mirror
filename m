From: =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Subject: Re: [RFC PATCH 1/2] Allow "git log --grep foo" as synonym for "git 
	log --grep=foo".
Date: Tue, 27 Jul 2010 10:18:03 +0000
Message-ID: <AANLkTim1S_IYbPArQqX91OOPtoh2-rIWmTRon50_j2p3@mail.gmail.com>
References: <1280168078-31147-1-git-send-email-Matthieu.Moy@imag.fr>
	<1280168078-31147-2-git-send-email-Matthieu.Moy@imag.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Matthieu Moy <Matthieu.Moy@imag.fr>
X-From: git-owner@vger.kernel.org Tue Jul 27 12:18:12 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OdhEi-0003a8-Az
	for gcvg-git-2@lo.gmane.org; Tue, 27 Jul 2010 12:18:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756037Ab0G0KSH convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 27 Jul 2010 06:18:07 -0400
Received: from mail-gx0-f174.google.com ([209.85.161.174]:43177 "EHLO
	mail-gx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753703Ab0G0KSE convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 27 Jul 2010 06:18:04 -0400
Received: by gxk23 with SMTP id 23so1183430gxk.19
        for <git@vger.kernel.org>; Tue, 27 Jul 2010 03:18:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:in-reply-to
         :references:date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=tfC7fl+t0t4gEicxNwQCnhVxVFdEJNCVJXvg+bZgByo=;
        b=cNgkdDtaLp9qpJKRi5HKJCZUTuG8X3LOrmGkNQWKnbLPz6b7q+PcStAAH1jSTwrfEB
         3PfeexjP4Pjv7/zhCSmOk3nzh7WAkKle37zlGPykOI0pQYwGCUtg+pSeU0xepRsyG1yQ
         KacvIFb2psy3HPjBNOBxXb9RQLsX1SnQE/b5Q=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=pFerRdF+7/cdMYKdebtSmBAs96AEtrotFJl7pq0fVIwBO3kiw678dgyS+u5U2OolKD
         qRk5DHZPOAQ8JluFlp9zPGjjt9uEzonyLqCmJbU4RiQjaCC620syD6t06+GCT6EzvH2X
         mvC3zDnMzvGGLeoF3AaY9M4668sqNY/uBViRU=
Received: by 10.101.149.5 with SMTP id b5mr9427044ano.32.1280225883737; Tue, 
	27 Jul 2010 03:18:03 -0700 (PDT)
Received: by 10.231.166.79 with HTTP; Tue, 27 Jul 2010 03:18:03 -0700 (PDT)
In-Reply-To: <1280168078-31147-2-git-send-email-Matthieu.Moy@imag.fr>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/151925>

On Mon, Jul 26, 2010 at 18:14, Matthieu Moy <Matthieu.Moy@imag.fr> wrot=
e:

> + =C2=A0 =C2=A0 =C2=A0 } else if (!strcmp(arg, "--grep")) {
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 add_message_grep(r=
evs, optarg);
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return 2;

This looks good. I've been bitten by git-log's non-standard option
parsing. But there's still a lot of options that need the =3D, no?:

    21 matches for "=3D"" in buffer: revision.c

                     1163:    if (!prefixcmp(arg, "--max-count=3D")) {
       1166:    } else if (!prefixcmp(arg, "--skip=3D")) {
       1181:    } else if (!prefixcmp(arg, "--max-age=3D")) {
       1183:    } else if (!prefixcmp(arg, "--since=3D")) {
       1185:    } else if (!prefixcmp(arg, "--after=3D")) {
       1187:    } else if (!prefixcmp(arg, "--min-age=3D")) {
       1189:    } else if (!prefixcmp(arg, "--before=3D")) {
       1191:    } else if (!prefixcmp(arg, "--until=3D")) {
       1272:    } else if (!prefixcmp(arg, "--unpacked=3D")) {
       1297:    } else if (!prefixcmp(arg, "--pretty=3D") ||
!prefixcmp(arg, "--format=3D")) {
       1304:    } else if (!prefixcmp(arg, "--show-notes=3D")) {
       1346:    } else if (!prefixcmp(arg, "--abbrev=3D")) {
       1362:    } else if (!strncmp(arg, "--date=3D", 7)) {
       1371:    else if (!prefixcmp(arg, "--author=3D")) {
       1373:    } else if (!prefixcmp(arg, "--committer=3D")) {
       1375:    } else if (!prefixcmp(arg, "--grep=3D")) {
       1385:    } else if (!prefixcmp(arg, "--encoding=3D")) {
       1515:            if (!prefixcmp(arg, "--glob=3D")) {
       1521:            if (!prefixcmp(arg, "--branches=3D")) {
       1527:            if (!prefixcmp(arg, "--tags=3D")) {
       1533:            if (!prefixcmp(arg, "--remotes=3D")) {

I think changing the option parsing so that it handles all the long
options consistently would be very nice (along with some tests). But
just making --grep a special case is more confusing than requiring =3D
everywhere.
