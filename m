From: Fedor Eftimitsa <Fedor.Eftimitsa@nivalnetwork.com>
Subject: (unknown)
Date: Thu, 30 Oct 2014 12:23:56 +0000
Message-ID: <BF520C46C422AF4A8718EAD1AA903AF0743CF010@exchange1.intra.nival.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
To: "git@vger.kernel.org" <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Thu Oct 30 13:29:45 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XjorH-0005Th-FJ
	for gcvg-git-2@plane.gmane.org; Thu, 30 Oct 2014 13:29:43 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759341AbaJ3M3j (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 30 Oct 2014 08:29:39 -0400
Received: from edge1.nivalnetwork.com ([195.128.68.8]:43797 "EHLO
	edge1.nivalnetwork.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759165AbaJ3M3i convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 30 Oct 2014 08:29:38 -0400
X-Greylist: delayed 332 seconds by postgrey-1.27 at vger.kernel.org; Thu, 30 Oct 2014 08:29:37 EDT
Received: from EXCHANGE2.intra.nival.com (192.168.1.188) by
 EDGE1.nivalnetwork.com (195.128.68.8) with Microsoft SMTP Server (TLS) id
 8.3.297.1; Thu, 30 Oct 2014 15:23:39 +0300
Received: from exchange1.intra.nival.com ([fe80::fd05:2c4c:cdb1:25a]) by
 EXCHANGE2.intra.nival.com ([fe80::e960:fdac:6649:26c7%14]) with mapi id
 14.02.0387.000; Thu, 30 Oct 2014 15:23:57 +0300
Subject: 
Thread-Index: Ac/0PF8SaehmHhiFQAyFYtHm/wOVxQ==
Accept-Language: ru-RU, en-US
Content-Language: ru-RU
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.200.1.65]
city: Saint-Petersburg
X-EsetResult: clean, is OK
X-EsetId: 42359C3EF90E34301874C2
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Greetings!

I have very large git repository (>20Gb) and after repack the size of it increases by 1.3-2 times.
I try to understand why it is happened and how to solve this matter.

Details
I work in gamedev and we store under git all what we have: source code, textures and other binary data.
Now size of the main repository (.git) is about 23Gb right after cloning.
But if I run 'git gc' or 'git gc --aggressive' size of repository increases to more than 40Gb.
'git gc --auto' doesn't change existing packs and doesn't increase size so much.

For a long time we disabled 'gc auto' for all work PCs and repacked repository by script at night.
Script configures some options and runs 'git gc' without --auto and now the size of most repositories is more than 50Gb.
Here this options from script:
-- pack.threads 2
-- pack.windowMemory 16m
-- pack.depth 1
-- pack.window 10
-- gc.aggressiveWindow 10
-- pack.packSizeLimit 2g

I try to improve this script and find the way to decrease size of these repositories to initial (after clone) size. The size of repository is very important because it's located on SSD disk for comfort work.
I've tried different options for 'git gc' and 'git gc --aggressive' but can't achieve this - size of repository always about 40Gb and more.
Best result provides 'git gc --aggressive' with disabled pack.packSizeLimit, window and depth is 250 - it creates single pack about 36Gb.
In worst case repository size can be more than 60Gb.

Can you help me to understand what options I can try to repack repositories to initial size?

All work PCs have Windows 7 and git version >=1.8.1 installed.

All the best,
Fedor Eftimitsa
Senior Programmer

Nival
www.nival.com
www.zzima.com

Skype: d9fault
