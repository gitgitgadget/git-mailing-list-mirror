From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [PATCH 10/16] grep: skip files that have not been checked out
Date: Mon, 15 Sep 2008 09:48:45 +0200
Message-ID: <200809150948.46139.jnareb@gmail.com>
References: <48cdd6cb7415e_3c273fa85e999d2827466@app01.zenbe.com.tmail>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Duy Nguyen <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Mon Sep 15 09:50:01 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Kf8qO-0006gu-27
	for gcvg-git-2@gmane.org; Mon, 15 Sep 2008 09:50:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752283AbYIOHsx convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 15 Sep 2008 03:48:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752112AbYIOHsx
	(ORCPT <rfc822;git-outgoing>); Mon, 15 Sep 2008 03:48:53 -0400
Received: from mail-gx0-f16.google.com ([209.85.217.16]:60436 "EHLO
	mail-gx0-f16.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751884AbYIOHsw (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 15 Sep 2008 03:48:52 -0400
Received: by gxk9 with SMTP id 9so24219375gxk.13
        for <git@vger.kernel.org>; Mon, 15 Sep 2008 00:48:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:subject:date
         :user-agent:cc:references:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:message-id;
        bh=XXwDEBCIIpfg7s7tdxfmq5MDryCKPu/85m3fA7elwwM=;
        b=D1wFPqLhgkYYLq1/V5xz2ZEe7Dsl0AIfeezwozlpBS/MsBcioTKwUeY0B4TqwZfdYg
         K9VFIk2CMuVvScnkj1phu/NGIUELCZOZYSmtH8E2xgAek3kkfZh+V1ZwZU4KDb/cJmM7
         ZkW2lwphtuTvvZ+hT1d1Uvhjhoyd6JCTGEoMI=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:subject:date:user-agent:cc:references:in-reply-to
         :mime-version:content-type:content-transfer-encoding
         :content-disposition:message-id;
        b=hgOzox641xlSj10N3m3UA4c0LArGz5z3zNibDrpPjJAivhqpl8Vjo04vpVQHXxiSYG
         OXbBMjraebyZhb4qUTJcvjDc5GI+dVZwJCBsjqr6/FTlfZ+GYuR7Bf9B/6+J6Luo+Xs0
         5cBuWNW0lzO6Q20VrZLqIXL5aQnl0leVe8JPg=
Received: by 10.103.18.19 with SMTP id v19mr5182177mui.123.1221464931147;
        Mon, 15 Sep 2008 00:48:51 -0700 (PDT)
Received: from ?192.168.1.11? ( [83.8.248.215])
        by mx.google.com with ESMTPS id u9sm14865083muf.9.2008.09.15.00.48.49
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Mon, 15 Sep 2008 00:48:50 -0700 (PDT)
User-Agent: KMail/1.9.3
In-Reply-To: <48cdd6cb7415e_3c273fa85e999d2827466@app01.zenbe.com.tmail>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/95890>

Duy Nguyen wrote:
> On 09/15/2008 "Jakub Narebski" <jnareb@gmail.com> wrote:
> >Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail.com> writes=
:
> >=20
> > > Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds=
@gmail.com>
> > > ---
> > >  builtin-grep.c |    7 ++++++-
> > >  1 files changed, 6 insertions(+), 1 deletions(-)
> >=20
> > No changes to Documentation/git-grep.txt?
>=20
> No, "git grep" should only grep files in working directories. In
> narrow checkout mode, some files may be missing but current "git grep=
"
> does not know about that, hence this fix. =20

Perhaps that should be stated explicitly, that git-grep searches only
[intentionally] checked-out files when searching working directory,
and only files without no-checkout bit set when searching index with
"git grep --cached".

P.S. I think it should be [--cached|<tree>...] in git-grep synopsis,
and not [--cached] ... [<tree>...], but that is unrelated thing, and
doesn't matter to you.
--=20
Jakub Narebski
Poland
