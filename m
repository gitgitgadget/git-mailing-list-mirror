From: =?iso-8859-1?q?Adri=E1n_Ribao_Mart=EDnez?= <aribao@gmail.com>
Subject: Integration-Manager Workflow
Date: Sat, 16 Jan 2010 18:49:32 +0100
Message-ID: <201001161849.32211.aribao@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed;
  boundary="nextPart1675152.SI4riVrqQT";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Jan 16 18:49:45 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NWCmO-0007RG-Fy
	for gcvg-git-2@lo.gmane.org; Sat, 16 Jan 2010 18:49:44 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753168Ab0APRti (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 16 Jan 2010 12:49:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751451Ab0APRti
	(ORCPT <rfc822;git-outgoing>); Sat, 16 Jan 2010 12:49:38 -0500
Received: from mail-ew0-f219.google.com ([209.85.219.219]:46948 "EHLO
	mail-ew0-f219.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752594Ab0APRth (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 16 Jan 2010 12:49:37 -0500
Received: by ewy19 with SMTP id 19so1899648ewy.21
        for <git@vger.kernel.org>; Sat, 16 Jan 2010 09:49:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:subject:date
         :user-agent:mime-version:content-type:content-transfer-encoding
         :message-id;
        bh=iWgbhxQ5gsi23w5k3vlm979ANvmhe0yJ7TEWupQtzrU=;
        b=IUFhWHzEnS5BzpYO0mCKH+QTGcfen4aAu8+O4pcQcxvb+jq0OQFB3c+CVBstreAxJh
         /RcFnbC01EtM+CG+7CYoBBoOkpa8+5/A2vK/C5Yo9b8CXGdlX7mlQ+dCQG41KP+SLGFr
         3cJcPpPjbRs/lsHeNe1X+bJySccZI27hYfMnA=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:subject:date:user-agent:mime-version:content-type
         :content-transfer-encoding:message-id;
        b=ps53W3vIBMllAHGMYZV8B0CkmCb+fMZsqmBFdAlLV5DyQG9Hd0fAcTrX9o04Jlv4XP
         4scOQGz3voae/ZnyOlsQInqPCTkKl6D0Yz0a6a8/wdBE7mkCm/xgjVcGJnIk2U+KWWxl
         nZPnvVQvBtRIUDhZPeJfTvFV3SAujDVebRUzs=
Received: by 10.216.85.9 with SMTP id t9mr1330985wee.79.1263664174995;
        Sat, 16 Jan 2010 09:49:34 -0800 (PST)
Received: from debian.localnet (93.160.222.87.dynamic.jazztel.es [87.222.160.93])
        by mx.google.com with ESMTPS id g11sm4421227gve.3.2010.01.16.09.49.33
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sat, 16 Jan 2010 09:49:34 -0800 (PST)
User-Agent: KMail/1.12.4 (Linux/2.6.32-trunk-amd64; KDE/4.3.4; x86_64; ; )
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/137241>

--nextPart1675152.SI4riVrqQT
Content-Type: Text/Plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit

Hello everybody, I'm learning git since I'm planning moving from Bazaar.

I've been reading the documentation and the progit book, which is excellent.

I'm a bit confused In the chapter: http://progit.org/book/ch5-1.html#integrationmanager_workflow : "Integration-Manager Workflow"

I need to manages a project with several developers. Those developers are split into teams.

I'm planning these:
 * A central repository using the http protocol. This central repository would be only writable by myself, it would have http access for the developers and ssh access for me.
 * Every team would have ssh access to their repositories. i.e. team1.myserver.net, team2.myserver.net
 * I want at least three branches: master, test, and develop. The path would be: develop(development version) -> test (beta) -> master (stable)
 * I don't want any developer to write into the develop branch, and if they do by mistake, I don't want to take it into account.

My question is about the branches in the teams repositories. I want the developers to create feature/fix branches in their checkouts and when they have finished the work, I check and merge into develop if everything is OK.

Is the following procedure correct?:
1. They send me the path of the branch I should do: git checkout --track origin/feature1 (where origin could be: ssh://user@team1.myserver.net:/home/user/git/project)
2. If everything is ok I merge into development and remove branch feature1.
3. They fetch and the branch is deleted in their local checkouts, and the feature1 is in the develop branch: git pull origin


What happens if they accidentally work in the develop branch instead of creating a new one? What should we do?
I think I should never fetch from teamx.myserver.net to avoid this problem and instead track the branch like in step 2. Is this correct?

Thank you for your help, I'm a bit confused about git.

Regards,

Adrian Ribao

--nextPart1675152.SI4riVrqQT
Content-Type: application/pgp-signature; name=signature.asc 
Content-Description: This is a digitally signed message part.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)

iEYEABECAAYFAktR/CwACgkQalnHcq94Lhlz/gCgkEryGlpN0Bzl9ZHX5jPbAGeJ
fQIAnA+6gKxgIPdo7yX0xSfCg8tTMuBQ
=fW7U
-----END PGP SIGNATURE-----

--nextPart1675152.SI4riVrqQT--
