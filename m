From: Emanuele Aina <em@nerd.ocracy.org>
Subject: Re: Accessing the reflog remotely
Date: Wed, 04 Nov 2009 11:16:20 +0100
Message-ID: <1257329780.3329.2.camel@abelardo.lan>
References: <vpqljimpr95.fsf@bauges.imag.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: git <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Wed Nov 04 11:16:30 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1N5cuj-0005St-Kk
	for gcvg-git-2@lo.gmane.org; Wed, 04 Nov 2009 11:16:29 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754702AbZKDKQT convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 4 Nov 2009 05:16:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753842AbZKDKQS
	(ORCPT <rfc822;git-outgoing>); Wed, 4 Nov 2009 05:16:18 -0500
Received: from fg-out-1718.google.com ([72.14.220.159]:44206 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752704AbZKDKQS (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 4 Nov 2009 05:16:18 -0500
Received: by fg-out-1718.google.com with SMTP id d23so1761561fga.1
        for <git@vger.kernel.org>; Wed, 04 Nov 2009 02:16:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:sender:subject:from:to
         :in-reply-to:references:content-type:date:message-id:mime-version
         :x-mailer:content-transfer-encoding;
        bh=XvhjAhFJ8rvLElOMG3P+WVD867OMx7dfE79N9QG44XE=;
        b=fDjtvhifulcK/74xv+HrxeQs3smDrEhz4OZ2ZFEWkllaEd5SJpUSA9XoxHzdreEhFg
         M9urRNKBsxOWYxuxNCuynJTyYY2ctyOzUsyEDCyqysUNdIPYKRdVq5HuaXuokP7MmxPz
         r+WjcDoQNaZax9mFw/Kk84o+kIRKzzMhRiHWo=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=sender:subject:from:to:in-reply-to:references:content-type:date
         :message-id:mime-version:x-mailer:content-transfer-encoding;
        b=ASS9/ADji4xqz98jeoaWauDmPFv9NJQXC2N6DQLnpr1/F728vSPrRJdeqbjsneRUY4
         c9bpzkdFjO7Nhu2T+touC/UE1Gh0GSXsQqFlN37Zycad00X3f8RZOuI7QLEm+l9W5Qcm
         5lucHMJK6Yh64ctLKh/ye2tlETREEJqPSIO9s=
Received: by 10.87.40.2 with SMTP id s2mr3822086fgj.77.1257329782624;
        Wed, 04 Nov 2009 02:16:22 -0800 (PST)
Received: from ?192.168.127.15? (host178-107-static.30-87-b.business.telecomitalia.it [87.30.107.178])
        by mx.google.com with ESMTPS id 4sm8162328fge.14.2009.11.04.02.16.21
        (version=SSLv3 cipher=RC4-MD5);
        Wed, 04 Nov 2009 02:16:21 -0800 (PST)
In-Reply-To: <vpqljimpr95.fsf@bauges.imag.fr>
X-Mailer: Evolution 2.28.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/132068>

Matthieu Moy prov=C3=B2:

>   git checkout 'origin/master@{Nov 3 00:00:00}'
>=20
> But this tells me where _my_ local master was on that date (i.e. the
> last revision I had pulled).
>=20
> So, the best I can think of is:
>=20
> ssh host 'cd /repo/ ; git tag final-version "master@{Nov 3 00:00:00}"=
'
> git fetch --tags
> git checkout tags/final-version

At least you can avoid the tag:

git checkout `ssh host 'GIT_DIR=3D/repo/ git rev-parse "master@{Nov 3 0=
0:00:00}"'`

--=20
Buongiorno.
Complimenti per l'ottima scelta.
