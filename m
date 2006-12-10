X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
From: Kyle Moffett <mrmacman_g4@mac.com>
Subject: Using GIT to store /etc (Or: How to make GIT store all file permission bits)
Date: Sun, 10 Dec 2006 08:40:01 -0500
Message-ID: <787BE48C-1808-4A33-A368-5E8A3F00C787@mac.com>
Mime-Version: 1.0 (Apple Message framework v752.2)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Content-Transfer-Encoding: 7bit
NNTP-Posting-Date: Sun, 10 Dec 2006 13:40:21 +0000 (UTC)
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
X-Mailer: Apple Mail (2.752.2)
X-Brightmail-Tracker: AAAAAA==
X-Brightmail-scanned: yes
X-Proofpoint-Virus-Version: vendor=fsecure engine=4.65.5446:2.3.11,1.2.37,4.0.164 definitions=2006-12-08_07:2006-12-08,2006-12-08,2006-12-08 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 ipscore=0 adultscore=0 classifier=spam adjust=0 reason=mlx engine=3.1.0-0611300000 definitions=main-0612100002
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/33887>
Received: from vger.kernel.org ([209.132.176.167]) by dough.gmane.org with
 esmtp (Exim 4.50) id 1GtOug-0000Uf-3C for gcvg-git@gmane.org; Sun, 10 Dec
 2006 14:40:18 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1760727AbWLJNkK (ORCPT <rfc822;gcvg-git@m.gmane.org>); Sun, 10 Dec 2006
 08:40:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1760728AbWLJNkK
 (ORCPT <rfc822;git-outgoing>); Sun, 10 Dec 2006 08:40:10 -0500
Received: from smtpout.mac.com ([17.250.248.176]:56979 "EHLO smtpout.mac.com"
 rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP id S1760727AbWLJNkI
 (ORCPT <rfc822;git@vger.kernel.org>); Sun, 10 Dec 2006 08:40:08 -0500
Received: from mac.com (smtpin01-en2 [10.13.10.146]) by smtpout.mac.com
 (Xserve/8.12.11/smtpout06/MantshX 4.0) with ESMTP id kBADe8XD024419 for
 <git@vger.kernel.org>; Sun, 10 Dec 2006 05:40:08 -0800 (PST)
Received: from [10.0.7.253] (hc6524e82.dhcp.vt.edu [198.82.78.130])
 (authenticated bits=0) by mac.com (Xserve/smtpin01/MantshX 4.0) with ESMTP id
 kBADe2O7007143 (version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=NO) for
 <git@vger.kernel.org>; Sun, 10 Dec 2006 05:40:04 -0800 (PST)
To: git@vger.kernel.org
Sender: git-owner@vger.kernel.org

I've recently become somewhat interested in the idea of using GIT to  
store the contents of various folders in /etc.  However after a bit  
of playing with this, I discovered that GIT doesn't actually preserve  
all permission bits since that would cause problems with the more  
traditional software development model.  I'm curious if anyone has  
done this before; and if so, how they went about handling the  
permissions and ownership issues.

I spent a little time looking over how GIT stores and compares  
permission bits; trying to figure out if it's possible to patch in a  
new configuration variable or two; say "preserve_all_perms" and  
"preserve_owner", or maybe even "save_acls".  It looks like standard  
permission preservation is fairly basic; you would just need to patch  
a few routines which alter the permissions read in from disk or  
compare them with ones from the database.  On the other hand, it  
would appear that preserving ownership or full POSIX ACLs might be a  
bit of a challenge.

Thanks for your insight and advice!

Cheers,
Kyle Moffett
