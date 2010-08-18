From: =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Subject: Re: [PATCH 1/6] Add string comparison functions that respect the
 ignore_case variable.
Date: Wed, 18 Aug 2010 12:53:52 +0000
Message-ID: <AANLkTi=V1-vNjA36BXC5OD+ek-S_1RLVBFt==atxtJk5@mail.gmail.com>
References: <cover.1281985411.git.j6t@kdbg.org>
	<513deaf9e8915473f7fc7f32401b17e383cb7d3a.1281985411.git.j6t@kdbg.org>
	<AANLkTi=mH9WPbJMKXRrgvdcuqZfHj1kC49M0jKUhaYeS@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Joshua Jensen <jjensen@workspacewhiz.com>
To: Johannes Sixt <j6t@kdbg.org>
X-From: git-owner@vger.kernel.org Wed Aug 18 14:54:01 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Oli9Y-0000PB-PA
	for gcvg-git-2@lo.gmane.org; Wed, 18 Aug 2010 14:54:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752793Ab0HRMxy convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 18 Aug 2010 08:53:54 -0400
Received: from mail-iw0-f174.google.com ([209.85.214.174]:45381 "EHLO
	mail-iw0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751441Ab0HRMxx convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 18 Aug 2010 08:53:53 -0400
Received: by iwn7 with SMTP id 7so662678iwn.19
        for <git@vger.kernel.org>; Wed, 18 Aug 2010 05:53:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:in-reply-to
         :references:date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=v8Fm/EfH9xGhHrn3ZwqUtvNNVJGnSOOo/Vb/EYyIFL8=;
        b=nrwZNT5VxLO3+ZYw9agtxl+gykJ1SLXq+BbotcCjs+Z7u4wV5iezFzwdA1smgWKGpE
         FhTc4VndYzTmnMjCQeI3J8q3FA3xECseMiMJ8AnwZHMKW/R7wfO481fBIocIIYvrX/5G
         0tQFWoCkRFwqeH61NIl5zbnL249jWEw+TqO/k=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=mgCvldOjQ7/jUTaRu4jU/JozPKahb3P3fgpKxjBMWuQH95hDKWLnQF9RRPXjSaq/F+
         J20ggXgU+UaMWNfsq8Qstey3jgUVRufLQRAjQy2GtbafQ6b++Ia8ofY2gqadY2xZkVA6
         fnhgRTOrbN8NJoBXEkAGQW9zpfi6KnW08yY6c=
Received: by 10.231.146.134 with SMTP id h6mr9006057ibv.170.1282136032882;
 Wed, 18 Aug 2010 05:53:52 -0700 (PDT)
Received: by 10.231.186.226 with HTTP; Wed, 18 Aug 2010 05:53:52 -0700 (PDT)
In-Reply-To: <AANLkTi=mH9WPbJMKXRrgvdcuqZfHj1kC49M0jKUhaYeS@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/153835>

On Wed, Aug 18, 2010 at 12:52, =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <=
avarab@gmail.com> wrote:
> On Mon, Aug 16, 2010 at 19:38, Johannes Sixt <j6t@kdbg.org> wrote:
>
>> + =C2=A0 =C2=A0 =C2=A0 return fnmatch(pattern, string, flags | (igno=
re_case ? FNM_CASEFOLD : 0));
>
> On Solaris 10:
>
> dir.c: In function `fnmatch_icase':
> dir.c:34: error: `FNM_CASEFOLD' undeclared (first use in this functio=
n)
> dir.c:34: error: (Each undeclared identifier is reported only once
> dir.c:34: error: for each function it appears in.)

Actually, reading the fnmatch manpage it's not just Solaris, but all
non-GNU systems:

       FNM_CASEFOLD
              If this flag (a GNU extension) is set, the pattern is
matched case-insensitively.
