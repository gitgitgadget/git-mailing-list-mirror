From: "Brown, Len" <len.brown@intel.com>
Subject: RE: new file leaked onto release branch
Date: Wed, 14 Dec 2005 04:58:51 -0500
Message-ID: <F7DC2337C7631D4386A2DF6E8FB22B300567ED88@hdsmsx401.amr.corp.intel.com>
Mime-Version: 1.0
Content-Type: multipart/mixed;
	boundary="----_=_NextPart_001_01C60094.FD6ED259"
Cc: <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Wed Dec 14 11:02:09 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EmTPv-0008IP-1B
	for gcvg-git@gmane.org; Wed, 14 Dec 2005 10:59:23 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932242AbVLNJ7N (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 14 Dec 2005 04:59:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932275AbVLNJ7N
	(ORCPT <rfc822;git-outgoing>); Wed, 14 Dec 2005 04:59:13 -0500
Received: from fmr13.intel.com ([192.55.52.67]:43151 "EHLO
	fmsfmr001.fm.intel.com") by vger.kernel.org with ESMTP
	id S932242AbVLNJ7N (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 14 Dec 2005 04:59:13 -0500
Received: from fmsfmr101.fm.intel.com (fmsfmr101.fm.intel.com [10.253.24.21])
	by fmsfmr001.fm.intel.com (8.12.10/8.12.10/d: major-outer.mc,v 1.1 2004/09/17 17:50:56 root Exp $) with ESMTP id jBE9wunB007506;
	Wed, 14 Dec 2005 09:58:56 GMT
Received: from fmsmsxvs043.fm.intel.com (fmsmsxvs043.fm.intel.com [132.233.42.129])
	by fmsfmr101.fm.intel.com (8.12.10/8.12.10/d: major-inner.mc,v 1.2 2004/09/17 18:05:01 root Exp $) with SMTP id jBE9wKBp003151;
	Wed, 14 Dec 2005 09:58:56 GMT
Received: from fmsmsx331.amr.corp.intel.com ([132.233.42.156])
 by fmsmsxvs043.fm.intel.com (SAVSMTP 3.1.7.47) with SMTP id M2005121401585613259
 ; Wed, 14 Dec 2005 01:58:56 -0800
Received: from fmsmsx311.amr.corp.intel.com ([132.233.42.214]) by fmsmsx331.amr.corp.intel.com with Microsoft SMTPSVC(6.0.3790.211);
	 Wed, 14 Dec 2005 01:58:56 -0800
Received: from hdsmsx401.amr.corp.intel.com ([10.127.2.60]) by fmsmsx311.amr.corp.intel.com with Microsoft SMTPSVC(6.0.3790.211);
	 Wed, 14 Dec 2005 01:58:55 -0800
X-MimeOLE: Produced By Microsoft Exchange V6.5.7226.0
Content-class: urn:content-classes:message
X-MS-Has-Attach: yes
X-MS-TNEF-Correlator: 
Thread-Topic: new file leaked onto release branch
Thread-Index: AcYAklHm//oLJTqyS1itVsec0Ma3TwAAF6sA
To: "Junio C Hamano" <junkio@cox.net>
X-OriginalArrivalTime: 14 Dec 2005 09:58:55.0204 (UTC) FILETIME=[FE86BA40:01C60094]
X-Scanned-By: MIMEDefang 2.52 on 10.253.24.21
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/13626>

This is a multi-part message in MIME format.

------_=_NextPart_001_01C60094.FD6ED259
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

>What do you use to create these "Auto-update" commits, and how
>can I help you to fix it?

I use the attached script, which I pasted from
git/Documentation/howto/using-topic-branches.txt

git.update linus

to get the latest stuff from Linus onto the linus branch

git.update release

to pull linus branch into my release branch

git.update release

to pull linus branch into my test branch

I also use the git.merge script to pull topic branches
into either release or test, or to pull release into test.
I used git.merge to pull release into acpica because
acpica had fallen behind the base at one point, and this
may be where the issue happened.

in the case of the acpica topic branch, it was not pulled
back into either release or into test after the file in question
was added.  Indeed, you can pull the acpica branch from the tree
on kernel.org.

I'm trying to remember if there were git error message along the way.
I do remember an issue with a commit where I had re-named a file
and git didn't recognize it as such.  so I put this in my git.commit
wrapper:

git-udpate-index --add --remove `quilt files`
git commit

dunno if that may be related to the issue at hand.
I don't really understand this index stuff...

thanks,
-Len

------_=_NextPart_001_01C60094.FD6ED259
Content-Type: application/octet-stream;
	name="git.update"
Content-Transfer-Encoding: base64
Content-Description: git.update
Content-Disposition: attachment;
	filename="git.update"

IyEvYmluL2Jhc2gKIyBVcGRhdGUgYSBicmFuY2ggaW4gbXkgR0lUIHRyZWUuICBJZiB0aGUgYnJh
bmNoIHRvIGJlIHVwZGF0ZWQKIyBpcyAibGludXMiLCB0aGVuIHB1bGwgZnJvbSBrZXJuZWwub3Jn
LiAgT3RoZXJ3aXNlIG1lcmdlIGxvY2FsCiMgbGludXMgYnJhbmNoIGludG8gdGVzdHxyZWxlYXNl
IGJyYW5jaAoKY2FzZSAiJDEiIGluCnRlc3R8cmVsZWFzZSkKICAgICAgICBnaXQgY2hlY2tvdXQg
JDEgJiYgZ2l0IG1lcmdlICJBdXRvLXVwZGF0ZSBmcm9tIHVwc3RyZWFtIiAkMSBsaW51cwogICAg
ICAgIDs7CmxpbnVzKQogICAgICAgIGJlZm9yZT0kKGNhdCAuZ2l0L3JlZnMvaGVhZHMvbGludXMp
CiAgICAgICAgZ2l0IGZldGNoIGxpbnVzCiAgICAgICAgYWZ0ZXI9JChjYXQgLmdpdC9yZWZzL2hl
YWRzL2xpbnVzKQogICAgICAgIGlmIFsgJGJlZm9yZSAhPSAkYWZ0ZXIgXQogICAgICAgIHRoZW4K
ICAgICAgICAgICAgICAgIGdpdC13aGF0Y2hhbmdlZCAkYWZ0ZXIgXiRiZWZvcmUgfCBnaXQtc2hv
cnRsb2cKICAgICAgICBmaQogICAgICAgIDs7CiopCiAgICAgICAgZWNobyAiVXNhZ2U6ICQwIGxp
bnVzfHRlc3R8cmVsZWFzZSIgMT4mMgogICAgICAgIGV4aXQgMQogICAgICAgIDs7CmVzYWMK

------_=_NextPart_001_01C60094.FD6ED259
Content-Type: application/octet-stream;
	name="git.merge"
Content-Transfer-Encoding: base64
Content-Description: git.merge
Content-Disposition: attachment;
	filename="git.merge"

IyEvYmluL2Jhc2gKIyBNZXJnZSBhIGJyYW5jaCBpbnRvIGVpdGhlciB0aGUgdGVzdCBvciByZWxl
YXNlIGJyYW5jaAoKcG5hbWU9JDAKCnVzYWdlKCkKewogICAgICAgIGVjaG8gIlVzYWdlOiAkcG5h
bWUgYnJhbmNoIHRlc3R8cmVsZWFzZSIgMT4mMgogICAgICAgIGV4aXQgMQp9CgppZiBbICEgLWYg
LmdpdC9yZWZzL2hlYWRzLyIkMSIgXQp0aGVuCiAgICAgICAgZWNobyAiQ2FuJ3Qgc2VlIGJyYW5j
aCA8JDE+IiAxPiYyCiAgICAgICAgdXNhZ2UKZmkKCmNhc2UgIiQyIiBpbgp0ZXN0fHJlbGVhc2Up
CiAgICAgICAgaWYgWyAkKGdpdC1yZXYtbGlzdCAkMSBeJDIgfCB3YyAtYykgLWVxIDAgXQogICAg
ICAgIHRoZW4KICAgICAgICAgICAgICAgIGVjaG8gJDEgYWxyZWFkeSBtZXJnZWQgaW50byAkMiAx
PiYyCiAgICAgICAgICAgICAgICBleGl0IDEKICAgICAgICBmaQogICAgICAgIGdpdCBjaGVja291
dCAkMiAmJiBnaXQgbWVyZ2UgIlB1bGwgJDEgaW50byAkMiBicmFuY2giICQyICQxCiAgICAgICAg
OzsKKikKICAgICAgICB1c2FnZQogICAgICAgIDs7CmVzYWMK

------_=_NextPart_001_01C60094.FD6ED259--
