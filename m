From: Michael J Gruber <git@drmicha.warpmail.net>
Subject: Re: [PATCH] branch: only print upstream relationship with -v -v
Date: Wed, 17 Mar 2010 17:21:18 +0100
Message-ID: <4BA1017E.1010404@drmicha.warpmail.net>
References: <1268838344-8581-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: =?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41jIER1eQ==?= 
	<pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Wed Mar 17 17:36:50 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NrwEj-0000VJ-8h
	for gcvg-git-2@lo.gmane.org; Wed, 17 Mar 2010 17:36:49 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753737Ab0CQQgJ convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 17 Mar 2010 12:36:09 -0400
Received: from out3.smtp.messagingengine.com ([66.111.4.27]:44138 "EHLO
	out3.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753620Ab0CQQgD (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 17 Mar 2010 12:36:03 -0400
X-Greylist: delayed 721 seconds by postgrey-1.27 at vger.kernel.org; Wed, 17 Mar 2010 12:36:03 EDT
Received: from compute2.internal (compute2.internal [10.202.2.42])
	by gateway1.messagingengine.com (Postfix) with ESMTP id 59574E6259;
	Wed, 17 Mar 2010 12:24:00 -0400 (EDT)
Received: from heartbeat2.messagingengine.com ([10.202.2.161])
  by compute2.internal (MEProxy); Wed, 17 Mar 2010 12:24:00 -0400
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=messagingengine.com; h=message-id:date:from:mime-version:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding; s=smtpout; bh=6a2ex+FVAG2ze88uED3581+Iwes=; b=VNydea8eK4wN5eN9RLBrLODrUV8bhCAQF5ZW/wKa/IwlnMTRGd8aKS8YzcUwaT5G7fMF+0F5+/+F261kul3bjJ90/aorCslXB+XjT1dwzsyVgSnWunGSCKBJTiWEY578WufnSJwMyjhTN7J8BOVS6iUDhUIuUh4FemOPH/pMxb4=
X-Sasl-enc: +cPTg+v7q1EIM+u6GN3EYNWcUx2BoGCa4msu0SLGHJzr 1268843040
Received: from localhost.localdomain (whitehead.math.tu-clausthal.de [139.174.44.12])
	by mail.messagingengine.com (Postfix) with ESMTPSA id C5E09F6AE;
	Wed, 17 Mar 2010 12:23:59 -0400 (EDT)
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.9.1.10pre) Gecko/20100316 Lightning/1.0b2pre Shredder/3.0.4pre
In-Reply-To: <1268838344-8581-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/142412>

Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy venit, vidit, dixit 17.03.201=
0 16:05:
> "git branch -v" is unusable for me because it's too slow. After this
> patch:
>=20
> pclouds@do ~/w/git $ time ./git branch -v > /dev/null
> real    0m0.016s
> user    0m0.011s
> sys     0m0.004s
>=20
> pclouds@do ~/w/git $ time ./git branch -v -v > /dev/null
> real    0m8.960s
> user    0m8.854s
> sys     0m0.029s
>=20

Well, but also, after your patch the old output format of "git branch
-v" is not available any more at all! I mean, what is wrong with

git log --oneline --no-walk --branches --decorate

or

git rev-list --oneline --no-walk --branches

depending on what it is that you're really after? (Not to mention
for-each-ref.)

Michael
