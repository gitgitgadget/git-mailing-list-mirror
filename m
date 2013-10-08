From: Shlomit Afgin <shlomit.afgin@weizmann.ac.il>
Subject: Error in creating git over http
Date: Tue, 8 Oct 2013 15:05:22 +0000
Message-ID: <51123DD1BF2E03418A1296748DA730927454504A@ibwmbx03>
References: <51123DD1BF2E03418A1296748DA730927454460F@ibwmbx03>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
To: "git@vger.kernel.org" <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Tue Oct 08 17:05:32 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VTYqn-0007CD-Fg
	for gcvg-git-2@plane.gmane.org; Tue, 08 Oct 2013 17:05:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754569Ab3JHPFZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 8 Oct 2013 11:05:25 -0400
Received: from sentinel1-in.weizmann.ac.il ([132.76.60.31]:14116 "EHLO
	Sentinel1-in.weizmann.ac.il" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751339Ab3JHPFZ convert rfc822-to-8bit
	(ORCPT <rfc822;git@vger.kernel.org>); Tue, 8 Oct 2013 11:05:25 -0400
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-Anti-Spam-Result: AkUFAPodVFKETARK/2dsb2JhbABZgwc4UsEjgR4WbYIuBTpRASoUQiUCBBuHfgyZDZgriRSMYIIxOIMfgQQDmTCQUYMkgio
X-IronPort-AV: E=Sophos;i="4.90,1056,1371070800"; 
   d="scan'208";a="3076796"
Received: from doar.weizmann.ac.il ([132.77.4.35])
  by Sentinel1-out.weizmann.ac.il with ESMTP; 08 Oct 2013 17:05:23 +0200
Received: from smtp.weizmann.ac.il (ibwhbxv02.wismain.weizmann.ac.il [132.76.4.74])
	by doar.weizmann.ac.il (8.13.8/8.13.8) with ESMTP id r98G4s94026315
	for <git@vger.kernel.org>; Tue, 8 Oct 2013 18:04:54 +0200
Received: from IBWMBX03.wismain.weizmann.ac.il ([132.76.4.77]) by
 IBWHBXV02.wismain.weizmann.ac.il ([132.77.160.74]) with mapi id
 14.02.0318.004; Tue, 8 Oct 2013 18:05:23 +0300
Thread-Topic: Error in creating git over http
Thread-Index: AQHOxDJDbgBV697Y0k2SOI9i0dnZMZnq5zcA
In-Reply-To: <51123DD1BF2E03418A1296748DA730927454460F@ibwmbx03>
Accept-Language: en-US, he-IL
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Microsoft-MacOutlook/14.3.6.130613
x-originating-ip: [132.77.26.178]
Content-ID: <EABD3DC2B9BC8242953106EF6E5EA4E8@weizmann.ac.il>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/235779>


I'm trying to set a http git server.

I do the following on the git server:
       cd /var/www/html/
git clone --bare  /path/to/dir/ gitproject.git
cd gitproject.git/
mv hooks/post-update.sample hooks/post-update
chmod a+x hooks/post-update

on the local machine run:
git clone http://server.name/gitproject.git

I got the error:
"Initialized empty Git repository in /local/path/gitproject/.git/
fatal: http://server.name/gitproject.git/info/refs not found: did you run
git update-server-info on the server?"


I saw that the file does not exist,  it seem that the file post-update is
not execute.

I run it on the git server:
git update-server-info

Now the info/ref is created.

On local machine I run again :
git clone http://server.name/gitproject.git

Now I get the error:
  Initialized empty Git repository in /local/path/gitproject/.git/
error: The requested URL returned error: 403 (curl_result = 22, http_code
= 403, sha1 = 9d83b83df9fbc75ecd754264f95793fca93ccf93)
error: Unable to find 9d83b83df9fbc75ecd754264f95793fca93ccf93 under
http://server.name/gitproject.git
Cannot obtain needed object 9d83b83df9fbc75ecd754264f95793fca93ccf93


What I'm doing wrong?
Any ideas are welcome.
Thanks.
