From: Sergio Callegari <scallegari@arces.unibo.it>
Subject: Problem with pack
Date: Fri, 25 Aug 2006 10:45:33 +0200
Message-ID: <44EEB8AD.5080703@arces.unibo.it>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-From: git-owner@vger.kernel.org Fri Aug 25 10:46:30 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GGXKO-00016g-Os
	for gcvg-git@gmane.org; Fri, 25 Aug 2006 10:46:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932244AbWHYIqI (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 25 Aug 2006 04:46:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932296AbWHYIqI
	(ORCPT <rfc822;git-outgoing>); Fri, 25 Aug 2006 04:46:08 -0400
Received: from arces.unibo.it ([137.204.143.6]:56537 "EHLO arces.unibo.it")
	by vger.kernel.org with ESMTP id S932249AbWHYIqF (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 25 Aug 2006 04:46:05 -0400
Received: from [192.168.1.99] (adsl-ull-29-2.41-151.net24.it [151.41.2.29])
	(authenticated bits=0)
	by arces.unibo.it (8.13.7/8.13.7) with ESMTP id k7P8wkao006753
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <git@vger.kernel.org>; Fri, 25 Aug 2006 10:58:48 +0200
User-Agent: Thunderbird 1.5.0.5 (X11/20060728)
To: git@vger.kernel.org
X-Spam-Status: No, score=-96.0 required=5.0 tests=BAYES_50,RCVD_IN_NJABL_DUL,
	RCVD_IN_SORBS_DUL,USER_IN_WHITELIST autolearn=no version=3.1.3-gr0
X-Spam-Checker-Version: SpamAssassin 3.1.3-gr0 (2006-06-01) on 
	mail.arces.unibo.it
X-Virus-Scanned: ClamAV 0.88.4/1728/Fri Aug 25 07:55:58 2006 on arces.unibo.it
X-Virus-Status: Clean
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/25992>

Hi,

I am encountering a problem after a

git repack -a -d

on an archive.

The packet that has been generated appears to be corrupted:

git verify-pack -v pack-ebcdfbbda07e5a3e4136aa1f499990b35685bab4.idx
fatal: failed to read delta-pack base object 
2849bd2bd8a76bbca37df2a4c8e8b990811d01a7

and apparently I might have lost all the history of my project.

I have a few questions:

1) I am working on both a pc and a notebook, syncing the two everytime I 
move from one to the other.
On the PC I have git 1.4.2, on the notebook git 1.4.0. I am using 
"unison" as a syncing tool.
Might the data loss have something to do with...
- the version of git I am using or the mixing of two versions?
- the syncing? I have noticed that after a sync, git is not immediately 
in a happy state... for instance if I run

git diff

git lists diff commands for every file, even if those have not changed. 
However after a

git status

everything seems fine again.

2) git unpack-objects seems to be able to extract some objects from the 
pack, but at a certain point it dies.
- does it die on the first error or does it try to extract everything 
that is possible to extract after the error?
- if it's the first, is there a way to trigger the second behaviour to 
try to save as much as possible from the pack?

Thanks,

Sergio Callegari
