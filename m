From: Albert Astals Cid <aacid@kde.org>
Subject: Re: [BUG] git archive broken in 1.7.8.1
Date: Tue, 10 Jan 2012 23:05:45 +0100
Message-ID: <1431498.0yPWNQLupF@xps>
References: <5142795.2dTmMhVRTP@xps> <20120110213344.GI2714@centaur.lab.cmartin.tk>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Carlos =?ISO-8859-1?Q?Mart=EDn?= Nieto <cmn@elego.de>
X-From: git-owner@vger.kernel.org Tue Jan 10 23:05:56 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RkjpL-0004Od-Nq
	for gcvg-git-2@lo.gmane.org; Tue, 10 Jan 2012 23:05:56 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756847Ab2AJWFu convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 10 Jan 2012 17:05:50 -0500
Received: from mail-ee0-f46.google.com ([74.125.83.46]:39567 "EHLO
	mail-ee0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752303Ab2AJWFt convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 10 Jan 2012 17:05:49 -0500
Received: by eekd4 with SMTP id d4so4860eek.19
        for <git@vger.kernel.org>; Tue, 10 Jan 2012 14:05:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=sender:from:to:cc:subject:date:message-id:user-agent:in-reply-to
         :references:mime-version:content-transfer-encoding:content-type;
        bh=Y3guKYZ8mviF1YI6rQQ18xPnqWzPJxvoXLftyXaSGMQ=;
        b=Oqy5qILfBqJcVktlvWCLt42ZNneMRFFPO35rbGaKmIXfddgA4NEKP66APIzkCyNwSA
         1L1m7IpvdioLkiVNTiLa788cLXrhiqJhNPYCMSUqzeLwBuDevDLOGdiPTH95fiTd0gdI
         Toalf0sjLQ1bveIFYlpStCPiLfMZYpJ5mniIw=
Received: by 10.14.2.97 with SMTP id 73mr8184445eee.45.1326233147864;
        Tue, 10 Jan 2012 14:05:47 -0800 (PST)
Received: from xps.localnet (business-89-133-214-66.business.broadband.hu. [89.133.214.66])
        by mx.google.com with ESMTPS id a60sm309508811eeb.4.2012.01.10.14.05.45
        (version=SSLv3 cipher=OTHER);
        Tue, 10 Jan 2012 14:05:46 -0800 (PST)
User-Agent: KMail/4.7.3 (Linux/3.0.0-15-generic; KDE/4.7.3; x86_64; ; )
In-Reply-To: <20120110213344.GI2714@centaur.lab.cmartin.tk>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/188296>

El Dimarts, 10 de gener de 2012, a les 22:33:44, Carlos Mart=EDn Nieto =
va=20
escriure:
> On Tue, Jan 10, 2012 at 10:18:41PM +0100, Albert Astals Cid wrote:
> > CC me on answers since i'm not subscribed to the list
> >=20
> > Hi, one of our [KDE] anongit servers was updated to 1.7.8.1 and not=
 the
> > syntax
> >=20
> > git archive --remote=3Dgit://anongit.kde.org/repo.git HEAD:path
>=20
> This syntax is no longer allowed due to some security tightening. Use
> the alternate syntax
>=20
>     git archive --remote=3Dgit://anongit.kde.org/repo.git HEAD -- pat=
h

Unfortunately this producess a tarball with a different layout, e.g.

git archive --remote=3Dgit://anongit.kde.org/kgraphviewer.git HEAD:doc/=
en_US
  gives me a tarball with the doc/en_US files in the root

git archive --remote=3Dgit://anongit.kde.org/kgraphviewer.git HEAD -- d=
oc/en_US
  gives me a tarball with the doc/en_US folders and then the files

Is there a way to keep the old behaviour or do we need to update our sc=
ripts?

Thanks for the fast answer!

Albert

>=20
> > does not seem to return a valid tar archive anymore when it did wor=
k
> > previously. In fact the man page of my version has that syntax in o=
ne of
> > the examples.
>=20
> That sounds like a documentation bug.
>=20
>    cmn
