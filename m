From: "Liebich, Wolfgang" <wolfgang.liebich@siemens-enterprise.com>
Subject: What is the best way to synchronize two *bare* repositories with
 each other?
Date: Tue, 24 Nov 2009 22:19:27 +0100
Message-ID: <7FF082147E322048955113B6CB87A7C0081731C659@MCHP058A.global-ad.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
To: "git@vger.kernel.org" <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Tue Nov 24 22:34:45 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1ND320-00007f-Vl
	for gcvg-git-2@lo.gmane.org; Tue, 24 Nov 2009 22:34:41 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S934252AbZKXVe1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 24 Nov 2009 16:34:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S934213AbZKXVe0
	(ORCPT <rfc822;git-outgoing>); Tue, 24 Nov 2009 16:34:26 -0500
Received: from m0019.fra.mmp.de.bt.com ([62.180.227.30]:34980 "EHLO
	ms02.m0019.fra.mmp.de.bt.com" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S934008AbZKXVeY convert rfc822-to-8bit
	(ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 24 Nov 2009 16:34:24 -0500
X-Greylist: delayed 901 seconds by postgrey-1.27 at vger.kernel.org; Tue, 24 Nov 2009 16:34:24 EST
Received: from senmx11-mx ([62.134.46.9] [62.134.46.9]) by ms02.m0020.fra.mmp.de.bt.com with ESMTP id BT-MMP-113072 for git@vger.kernel.org; Tue, 24 Nov 2009 22:19:28 +0100
Received: from MCHP064A.global-ad.net (unknown [172.29.37.63])
	by senmx11-mx (Server) with ESMTP id BB3CD1EB81E8
	for <git@vger.kernel.org>; Tue, 24 Nov 2009 22:19:28 +0100 (CET)
Received: from MCHP058A.global-ad.net ([172.29.37.55]) by
 MCHP064A.global-ad.net ([172.29.37.63]) with mapi; Tue, 24 Nov 2009 22:19:28
 +0100
Thread-Topic: What is the best way to synchronize two *bare* repositories
 with each other?
Thread-Index: AQHKbUvNIFxCHKLzWUiehVhWShe3qg==
Accept-Language: de-DE, en-US
Content-Language: de-DE
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
acceptlanguage: de-DE, en-US
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/133593>

Hi,
Let's say I have two bare git repositories, bareA and bareB.
I also have a third non-bare repo, lets call it workA. Coworkers also have their working repositories, they all
synchronize back to repoA.
My work repo can only synchronize directly with repoB.
What is the best way to keep repoA and repoB synchronized to each other?

I solved that by defining (in the "config" file of repoB) a remote section for repoA,
and I "fetch" from repoA by issuing "git remote update repoA", and I push back via
"git push --all repoA".

This strange setup is necessary because of the security setup (my home development machine is not directly
connected with the company intranet).

Is this a good way to solve that problem, or are there better methods?

Ciao,
- Wolfgang