From: =?UTF-8?B?0JTQuNC70Y/QvSDQn9Cw0LvQsNGD0LfQvtCy?= 
	<dilyan.palauzov@aegee.org>
Subject: diff --minimal versus --diff-algorithm=minimal
Date: Wed, 25 Nov 2015 19:21:50 +0100
Message-ID: <5655FC3E.7090705@aegee.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Nov 25 19:37:14 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1a1ewL-000721-Um
	for gcvg-git-2@plane.gmane.org; Wed, 25 Nov 2015 19:37:14 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751967AbbKYShK convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 25 Nov 2015 13:37:10 -0500
Received: from scc-mailout-kit-02-aegee.scc.kit.edu ([129.13.231.100]:57631
	"EHLO scc-mailout-kit-02-aegee.scc.kit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750967AbbKYShF (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 25 Nov 2015 13:37:05 -0500
X-Greylist: delayed 976 seconds by postgrey-1.27 at vger.kernel.org; Wed, 25 Nov 2015 13:37:04 EST
Received: from aegeepc1.aegee.uni-karlsruhe.de ([129.13.131.81] helo=smtp.aegee.org)
	by scc-mailout-kit-02.scc.kit.edu with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(envelope-from <dilyan.palauzov@aegee.org>)
	id 1a1egO-0007Pl-QY
	for git@vger.kernel.org; Wed, 25 Nov 2015 19:20:46 +0100
Authentication-Results: aegeeserv.aegee.org; auth=pass (PLAIN) smtp.auth=didopalauzov
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp.aegee.org tAPIKiUP014791
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aegee.org; s=k4096;
	t=1448475645; i=dkim+MSA-tls@aegee.org;
	bh=e0x6SgnNP0woL5xaL5lK34deM2ojWcLtTsnwco/vtgA=;
	h=Date:From:To:Subject;
	b=HB4ruyhFuUKBW7OptEbBr1541OIOq8mSGxfFmo1GPu57BJsIXrnLOiv+MdO2eePLC
	 HcJAtgFCFSAB3PvVwGDuzwdFHavSAKCgP3IU3P14VZ3CHawclInpZFXp8sJGvHwUPP
	 bx1EAOUz72mv0n3YuetQJ9eKcKaFN5CPkriNCWlTosq3Yrwub1dHyzsctzBo34LIQy
	 H+VJpT04ve5dg8QpcRXIE9pXi1SZFA5/kocAuJq726byTxlRBqqA38u5ManKB9tlB6
	 bffiChfbqpMXze42KN3sWWlFZ1a3AuNaVZg1IW4+guZ5nxQSjs+D2DlbHlcFs+E5ek
	 4lBznbcQTeVJ3M+oO1u0xZMhCKTB+sqBAv+GUyF5pD2INdCKhr8fqlXKIqyyBzs7yy
	 MOCXdv8EIZUxx8LS1Z1zQICQtZaZsxnQ9QrxmQTqTfTHxL8LzNvBFfGr40q+jhEzbc
	 CTffZPN9b1KsWfb/SHw0EZGaEX2WNwYNCnMb/DWlJV+LBsi4hhj2n7NBOBvFb6Sew0
	 s6r3ekGVFjcNk/RgZgoLz6D+dsKxWDs2nw3KiNLcIAYFhRVVrCUirvxuK+5u6zpfGP
	 6qkdjmtvnyxpVzbpxTamFRvXNlvVgHJATJ/fQFhhwlPABX/RFzw30JZVBv+qWHbs4e
	 B3Om+/JUIEGehDzG 
Authentication-Results: mail.aegee.org; dkim=none
Received: from [10.128.8.54] (pd95b8b6a.dip0.t-ipconnect.de [217.91.139.106])
	(authenticated bits=0)
	by smtp.aegee.org (8.15.2/8.15.1) with ESMTPSA id tAPIKiUP014791
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NO)
	for <git@vger.kernel.org>; Wed, 25 Nov 2015 18:20:44 GMT
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:31.0) Gecko/20100101 Icedove/31.8.0
X-Virus-Scanned: clamav-milter 0.98.7 at aegeeserv
X-Virus-Status: Clean
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/281725>

Hello,

after I put in ~/.config/git "[diff] algorithm=3Dhistogram", and called=
=20
"git diff --minimal" I expect from git to use algorithm=3Dminimal.  But=
 it=20
uses histogram, unless I call "--diff-algorithm=3Dminimal".  According =
to=20
the documentation, however, --minimal and --diff-algorithm=3Dminimal sh=
all=20
be equivalent.

By the way, histogram produces more compact output than minimal (in=20
terms of number of lines and in terms of @@ ... @@ snippets), but the=20
documentation suggests, that minimal produces the most compact form tha=
t=20
can be achieved.

I use git version 2.6.3.385.g1bc8fea.

Greetings
   =D0=94=D0=B8=D0=BB=D1=8F=D0=BD
