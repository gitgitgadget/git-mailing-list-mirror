From: Jarek <wodka.jaroslaw@gmail.com>
Subject: Case insensitive when file mv
Date: Mon, 4 Jun 2012 12:36:54 +0200
Message-ID: <D62ABB09-AB7B-474E-8CDE-579AD30C58AE@gmail.com>
Mime-Version: 1.0 (Apple Message framework v1257)
Content-Type: text/plain; charset=iso-8859-2
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Jun 04 12:37:10 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SbUer-0001Vt-SQ
	for gcvg-git-2@plane.gmane.org; Mon, 04 Jun 2012 12:37:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760186Ab2FDKhA convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 4 Jun 2012 06:37:00 -0400
Received: from mail-lpp01m010-f46.google.com ([209.85.215.46]:38469 "EHLO
	mail-lpp01m010-f46.google.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1760169Ab2FDKg6 convert rfc822-to-8bit
	(ORCPT <rfc822;git@vger.kernel.org>); Mon, 4 Jun 2012 06:36:58 -0400
Received: by lahd3 with SMTP id d3so2845107lah.19
        for <git@vger.kernel.org>; Mon, 04 Jun 2012 03:36:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:content-type:content-transfer-encoding:subject:date:message-id
         :to:mime-version:x-mailer;
        bh=ZoXaIr+MzEObBdAJlXtQTyCbEFuieEsprOpTJ50W9uo=;
        b=hmqZ7xPdR0pM/RSVBcnHHC6GXcDfX+kKJ7M+Kp5X2Lo0dP2rBlcliKr0Zmh6qOvoag
         fPcco7LWPkNRxnlIwoHYLikcRLnQQNB9Cp60Kr8pPOb70YHEi+t9iWHOX32vT+ZQa1oS
         H9e+Erpld0gqrClNiXXzzDDaAXBW8Sf73FZZa0w3ws7+U0nQwfajV97a6idi6szdHUyT
         1vxNpvhMz/2pqLJfumtd7YFRWg5RP+RFaXC9nB0CFiz8Twr1JBXaZ6GyvjmNgvv6/UjG
         nl7A3MsOfGQmjkLWD8hV1Cf/LOgp8r1Uo5Ia7Mz/bMzaQnCVgksomSG1Fkl+9YsmVyBH
         WIog==
Received: by 10.152.112.233 with SMTP id it9mr11878009lab.40.1338806217124;
        Mon, 04 Jun 2012 03:36:57 -0700 (PDT)
Received: from [10.1.250.190] (212-87-13-66.sds.uw.edu.pl. [212.87.13.66])
        by mx.google.com with ESMTPS id ta2sm17085253lab.15.2012.06.04.03.36.55
        (version=SSLv3 cipher=OTHER);
        Mon, 04 Jun 2012 03:36:56 -0700 (PDT)
X-Mailer: Apple Mail (2.1257)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/199125>

Hope it covers everything:

$ git mv solJW.R solRandom.r
$ git mv solRandom.r solRandom.R
fatal: destination exists, source=3DsolRandom.r, destination=3DsolRando=
m.R
$ ls
mouse_evaluator.R mouse_world.R     scenariusze.R     sol1.R           =
 sol2.R            sol3.R            solRandom.r
$ git mv solRandom.r solRandom.R
fatal: destination exists, source=3DsolRandom.r, destination=3DsolRando=
m.R
$?
-bash: 128: command not found
$ git mv solRandom.r solRandom.X
$ git mv solRandom.X solRandom.R
$ man git
$ git --version
git version 1.7.5.4
$ touch abc
$ touch Abc
$ git add abc
$ git add Abc
$=20


Didn't have time to check whether is it a known bug or already solved i=
n the latest version.

Kind regards,
Jaros=B3aw W=F3dka.