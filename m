From: Nicolas Ferre <nicolas.ferre@atmel.com>
Subject: error: packfile while git fsck
Date: Wed, 22 Oct 2008 16:06:55 +0200
Organization: atmel
Message-ID: <48FF337F.3050505@atmel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Oct 22 16:43:49 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Ksevn-00054B-66
	for gcvg-git-2@gmane.org; Wed, 22 Oct 2008 16:43:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752536AbYJVOmM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 22 Oct 2008 10:42:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753073AbYJVOmK
	(ORCPT <rfc822;git-outgoing>); Wed, 22 Oct 2008 10:42:10 -0400
Received: from mail.atmel.fr ([81.80.104.162]:56525 "EHLO atmel-es2.atmel.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752536AbYJVOmJ (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 22 Oct 2008 10:42:09 -0400
X-Greylist: delayed 2106 seconds by postgrey-1.27 at vger.kernel.org; Wed, 22 Oct 2008 10:42:09 EDT
Received: from fwat.rfo.atmel.com (gateway [192.168.1.1])
	by atmel-es2.atmel.fr (8.11.6+Sun/8.11.6) with SMTP id m9ME5mI22369
	for <git@vger.kernel.org>; Wed, 22 Oct 2008 16:05:48 +0200 (MEST)
Received: from meyreuil ([10.159.254.132]) by fwat; Wed, 22 Oct 2008 16:04:20 +0200 (MEST)
Received: from [127.0.0.1] (pc245_112.atmel.fr [10.159.245.112])
	by meyreuil.atmel.fr (8.11.7p1+Sun/8.11.7) with ESMTP id m9ME6rb07713
	for <git@vger.kernel.org>; Wed, 22 Oct 2008 16:06:53 +0200 (MEST)
User-Agent: Thunderbird 2.0.0.17 (Windows/20080914)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/98871>

Hi all,
(please cc me on response)

I am facing error during git status & git fsck on my tree.
This tree is cloned from various linux kernel trees.

Here are a sample of the error I see :

$ git fsck
error: packfile .git/objects/pack/pack-2ab31ad1f8cb69d091a56fe936634e4796606d49.pack does not match index
error: packfile .git/objects/pack/pack-2ab31ad1f8cb69d091a56fe936634e4796606d49.pack cannot be accessed
error: packfile .git/objects/pack/pack-2ab31ad1f8cb69d091a56fe936634e4796606d49.pack does not match index
error: packfile .git/objects/pack/pack-2ab31ad1f8cb69d091a56fe936634e4796606d49.pack cannot be accessed
error: packfile .git/objects/pack/pack-2ab31ad1f8cb69d091a56fe936634e4796606d49.pack does not match index
[..]
error: packfile .git/objects/pack/pack-2ab31ad1f8cb69d091a56fe936634e4796606d49.pack cannot be accessed
dangling blob fe130d58453393f15e0db82bca18f35998689a87
dangling commit 2515ddc6db8eb49a79f0fe5e67ff09ac7c81eab4
error: packfile .git/objects/pack/pack-2ab31ad1f8cb69d091a56fe936634e4796606d49.pack does not match index
error: packfile .git/objects/pack/pack-2ab31ad1f8cb69d091a56fe936634e4796606d49.pack cannot be accessed
error: packfile .git/objects/pack/pack-2ab31ad1f8cb69d091a56fe936634e4796606d49.pack does not match index
error: packfile .git/objects/pack/pack-2ab31ad1f8cb69d091a56fe936634e4796606d49.pack cannot be accessed
error: packfile .git/objects/pack/pack-2ab31ad1f8cb69d091a56fe936634e4796606d49.pack does not match index
error: packfile .git/objects/pack/pack-2ab31ad1f8cb69d091a56fe936634e4796606d49.pack cannot be accessed
dangling commit 6bb7a935489dab20802dde6c2cb7d8582f4849bf
error: packfile .git/objects/pack/pack-2ab31ad1f8cb69d091a56fe936634e4796606d49.pack does not match index
error: packfile .git/objects/pack/pack-2ab31ad1f8cb69d091a56fe936634e4796606d49.pack cannot be accessed
dangling commit 4aba41ea8bdc1b475861f5e5c1649ab20251090c
error: packfile .git/objects/pack/pack-2ab31ad1f8cb69d091a56fe936634e4796606d49.pack does not match index
error: packfile .git/objects/pack/pack-2ab31ad1f8cb69d091a56fe936634e4796606d49.pack cannot be accessed
[..]
$  git verify-pack .git/objects/pack/pack-2ab31ad1f8cb69d091a56fe936634e4796606d49.pack
pack-2ab31ad1f8cb69d091a56fe936634e4796606d49.pack
nferre@bendor:linux-2.6-arm > git verify-pack .git/objects/pack/pack-2ab31ad1f8cb69d091a56fe936634e4796606d49.pack
error: packfile .git/objects/pack/pack-2ab31ad1f8cb69d091a56fe936634e4796606d49.pack does not match index
fatal: packfile .git/objects/pack/pack-2ab31ad1f8cb69d091a56fe936634e4796606d49.pack cannot be accessed

What can I do to recover my git archive ?

Did I do something wrong (merging files while fetching) ?

Is it related to a known issue (I cannot figure out if it is 
after some googling) ?

Thanks for your help. Regards,
-- 
Nicolas Ferre
