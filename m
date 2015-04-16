From: Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: Re: [PATCH] dir: allow a BOM at the beginning of exclude files
Date: Thu, 16 Apr 2015 17:03:05 +0200
Organization: gmx
Message-ID: <13f82e720ac12a6bc12e8b9f566dd48e@www.dscho.org>
References: <1429193112-41184-1-git-send-email-cmn@elego.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, git-owner@vger.kernel.org
To: =?UTF-8?Q?Carlos_Mart=C3=ADn_Nieto?= <cmn@elego.de>
X-From: git-owner@vger.kernel.org Thu Apr 16 17:03:15 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YilJx-00067U-Ij
	for gcvg-git-2@plane.gmane.org; Thu, 16 Apr 2015 17:03:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757084AbbDPPDJ convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 16 Apr 2015 11:03:09 -0400
Received: from mout.gmx.net ([212.227.15.15]:50930 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754543AbbDPPDI (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 16 Apr 2015 11:03:08 -0400
Received: from www.dscho.org ([87.106.4.80]) by mail.gmx.com (mrgmx001) with
 ESMTPSA (Nemesis) id 0LbMmA-1Z6IUN2pj8-00kuiR; Thu, 16 Apr 2015 17:03:05
 +0200
In-Reply-To: <1429193112-41184-1-git-send-email-cmn@elego.de>
X-Sender: johannes.schindelin@gmx.de
User-Agent: Roundcube Webmail/1.1.0
X-Provags-ID: V03:K0:ZU3+1Dhd8lSw0hlefFmEIjmGTaAyAqNZ8xTNbYVyATlr141F3ut
 qdcB1R1/iB573k8f0M6ao//pYvTOb/pgTxh59aB8M1p6zLvKHSKV9dPuchhmAJgBUqT2DKM
 DZaBEY9DaDDPRaz1rEUhyALVeBowllXcV/aUgbHCqc5CQPzoJqrvSLnIe5b9oviIQixd8/l
 zGlT950VlD9rzeNy1EbXw==
X-UI-Out-Filterresults: notjunk:1;
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/267293>

Hi Carlos,

On 2015-04-16 16:05, Carlos Mart=C3=ADn Nieto wrote:
> Some text editors like Notepad or LibreOffice write an UTF-8 BOM in
> order to indicate that the file is Unicode text rather than whatever =
the
> current locale would indicate.
>=20
> If someone uses such an editor to edit a gitignore file, we are left
> with those three bytes at the beginning of the file. If we do not ski=
p
> them, we will attempt to match a filename with the BOM as prefix, whi=
ch
> won't match the files the user is expecting.
>=20
> ---
>=20
> If you're wondering how I came up with LibreOffice, I was doing a
> workshop recently and one of the participants was not content with th=
e
> choice of vim or nano, so he opened LibreOffice to edit the gitignore
> file with confusing consequences.
>=20
> This codepath doesn't go as far as the config code in validating that
> we do not have a partial BOM which would mean there's some invalid
> content, but we don't really have invalid content any other way, as
> we're just dealing with a list of paths in the file.

Yeah, users are entertaining!

I agree that this is a good patch. *Maybe* we would need the same handl=
ing in more places, in which case it might make sense to refactor the t=
est into its own function.

In any case, though, the Git project requires a [Developer's Certificat=
e of Origin](https://github.com/git/git/blob/v2.3.5/Documentation/Submi=
ttingPatches#L234-L277); Would you mind adding that?

Thanks,
Dscho
