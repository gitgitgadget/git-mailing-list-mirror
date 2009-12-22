From: David Reiss <dreiss@facebook.com>
Subject: git fast-import not verifying commit author lines?
Date: Mon, 21 Dec 2009 20:22:31 -0800
Message-ID: <4B304987.7030201@facebook.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
To: <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Tue Dec 22 09:15:50 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NMzuG-0008Px-SE
	for gcvg-git-2@lo.gmane.org; Tue, 22 Dec 2009 09:15:49 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751046AbZLVIPo (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 22 Dec 2009 03:15:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750844AbZLVIPo
	(ORCPT <rfc822;git-outgoing>); Tue, 22 Dec 2009 03:15:44 -0500
Received: from mailout-snc1.facebook.com ([69.63.179.25]:40981 "EHLO
	mailout-sf2p.facebook.com" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1750711AbZLVIPn (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 22 Dec 2009 03:15:43 -0500
Received: from mail.thefacebook.com (intlb01.snat.snc1.facebook.com [10.128.203.17] (may be forged))
	by pp02.snc1.tfbnw.net (8.14.1/8.14.1) with ESMTP id nBM4MB0x022554
	(version=TLSv1/SSLv3 cipher=RC4-MD5 bits=128 verify=NOT)
	for <git@vger.kernel.org>; Mon, 21 Dec 2009 20:22:11 -0800
Received: from [192.168.1.138] (192.168.18.252) by mail.TheFacebook.com
 (192.168.18.105) with Microsoft SMTP Server (TLS) id 8.2.213.0; Mon, 21 Dec
 2009 20:22:32 -0800
User-Agent: Thunderbird 2.0.0.23 (X11/20090817)
X-Proofpoint-Virus-Version: vendor=fsecure engine=1.12.8161:2.4.5,1.2.40,4.0.166 definitions=2009-12-21_14:2009-12-12,2009-12-21,2009-12-21 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 ipscore=0 phishscore=0 bulkscore=0 adultscore=0 classifier=spam adjust=0 reason=mlx engine=5.0.0-0908210000 definitions=main-0912210278
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/135574>

mtn git_export produces this output on a simple repo:

blob
mark :1
data 8
content

commit refs/heads/com.example.badexport
mark :2
author <somename> 1261454209 +0000
committer <somename> 1261454209 +0000
data 8
acommit

M 100644 :1 "afile"
progress revision 9b0e11e4d66eba8a3cf26095fb573116b886cd37 (1/1)
#############################################################

The author and committer lines are missing the names (I've filed this as a
bug with monotone).  git commit-tree refuses to to produce a commit object
like this, so it seems like git fast-import should detect and report this
instead of silently writing the invalid commit object to the repository.

--David
