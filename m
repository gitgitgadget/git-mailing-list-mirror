From: Luc Bourhis <luc_j_bourhis@mac.com>
Subject: Re: Trouble with case insensitive filesystem
Date: Thu, 16 May 2013 05:15:43 +0200
Message-ID: <075E55AB-24A4-495E-BC40-92745DE7F4AE@mac.com>
References: <F0A0C92F-6D85-463E-9CB5-B9060BDA196B@mac.com>
 <51938E51.5060900@viscovery.net>
Mime-Version: 1.0 (Apple Message framework v1283)
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: Luc Bourhis <luc_j_bourhis@mac.com>, git@vger.kernel.org
To: Johannes Sixt <j.sixt@viscovery.net>
X-From: git-owner@vger.kernel.org Thu May 16 05:16:12 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ucofr-0005QS-Gn
	for gcvg-git-2@plane.gmane.org; Thu, 16 May 2013 05:16:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753091Ab3EPDQI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 15 May 2013 23:16:08 -0400
Received: from nk11p04mm-asmtpout001.mac.com ([17.158.236.236]:63078 "EHLO
	nk11p04mm-asmtp001.mac.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752327Ab3EPDQF convert rfc822-to-8bit
	(ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 15 May 2013 23:16:05 -0400
Received: from [192.168.1.200] ([80.11.252.214]) by nk11p04mm-asmtp001.mac.com
 (Oracle Communications Messaging Server 7u4-26.01(7.0.4.26.0) 64bit (built Jul
 13 2012)) with ESMTPSA id <0MMV00H7UFQ8AQ80@nk11p04mm-asmtp001.mac.com> for
 git@vger.kernel.org; Thu, 16 May 2013 03:15:48 +0000 (GMT)
X-Proofpoint-Virus-Version: vendor=fsecure
 engine=2.50.10432:5.10.8626,1.0.431,0.0.0000
 definitions=2013-05-15_08:2013-05-15,2013-05-15,1970-01-01 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0
 ipscore=0 suspectscore=0 phishscore=0 bulkscore=0 adultscore=0 classifier=spam
 adjust=0 reason=mlx scancount=1 engine=6.0.2-1305010000
 definitions=main-1305150249
In-reply-to: <51938E51.5060900@viscovery.net>
X-Mailer: Apple Mail (2.1283)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/224465>


On 15 May 2013, at 15:32, Johannes Sixt wrote:

> Am 5/15/2013 10:40, schrieb Luc Bourhis:
>> I work on a case insensitive filesystem and I have core.ignorecase set to true. 
>> ...
>> So I thought it was a job for git filter-branch, ...
>> 
>> However because of those two blobs, I have:
>> 
>> ~> git status
>> #	modified:   .../fourCircles.py
>> 
>> and git filter-branch therefore refuses to run.
> 
> Make a commit that has neither file, run git filter-branch, then throw
> away the commit with git reset --hard HEAD~.

That did not work, i.e. fourCircles remained "unmodified". Eventually, I managed by successively removing the file with "C" and then the file with "c". Then filter-branch, and then reset --hard as you suggested. Then of course, all the sha's have changed and git cvsimport can't be used for incremental updates anymore, which I knew would happen, obviously.

Thanks,

Luc J. Bourhis
 