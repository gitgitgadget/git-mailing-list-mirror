From: jussi.sirpoma@sks.fi
Subject: Dealing with mac linefeeds in git repository
Date: Wed, 31 Mar 2010 16:07:40 +0300
Message-ID: <OF7E748769.D4E7BC90-ONC22576F7.00483B3D-C22576F7.00484D0A@sks.fi>
Mime-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Mar 31 15:27:16 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Nwxwx-00075A-RR
	for gcvg-git-2@lo.gmane.org; Wed, 31 Mar 2010 15:27:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933306Ab0CaN1I (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 31 Mar 2010 09:27:08 -0400
Received: from sksci1.sks.fi ([193.208.185.25]:41623 "EHLO msg.sks.fi"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1757686Ab0CaN1H (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 31 Mar 2010 09:27:07 -0400
X-Greylist: delayed 1040 seconds by postgrey-1.27 at vger.kernel.org; Wed, 31 Mar 2010 09:27:06 EDT
Received: from sksinfo.sks.fi ([10.1.2.231])
	by msg.sks.fi (8.14.3/8.14.3) with ESMTP id o2VEmXX6022269
	for <git@vger.kernel.org>; Wed, 31 Mar 2010 17:48:33 +0300
X-KeepSent: 7E748769:D4E7BC90-C22576F7:00483B3D;
 type=4; name=$KeepSent
X-Mailer: Lotus Notes Release 8.0.2 August 07, 2008
X-MIMETrack: Serialize by Router on srvdomino1/SKS(Release 8.0.2FP1|January 12, 2009) at
 31.03.2010 16:07:39,
	Serialize complete at 31.03.2010 16:07:39
X-Proofpoint-Virus-Version: vendor=fsecure engine=1.12.8161:2.4.5,1.2.40,4.0.166
 definitions=2010-03-31_12:2010-02-06,2010-03-31,2010-03-30 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 ipscore=0 phishscore=0
 bulkscore=0 adultscore=0 classifier=spam adjust=0 reason=mlx
 engine=5.0.0-0908210000 definitions=main-1003310085
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/143673>

I am running cygwin git version 1.6.4.2.

Some of the source code for our projects is encoded in mac linefeeds due 
to proprietary
software platform. My current solution is to flag those files tu use no 
linefeed conversion and
to use separate diff program by having this in .gitattributes:

*.BA -crlf diff=winmerge

I also have these crlf settings enabled:

core.autocrlf=true
core.safecrlf=true

This solution works, but is not optimal as git cannot follow the changed 
lines, produce
annotations or diffs. Now I am wondering if I could make git work with a 
little different 
configuration:

* The *.BA files with mac linefeeds would be stored with normal linux 
linefeeds
* The files would be converted on checkout to mac linefeeds the same way 
as core.autcrlf works

Is this doable or even a good approach?

- Jussi Sirpoma
