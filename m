From: ddw_music <jamshark70@gmail.com>
Subject: (osx 10.4.11) can't push from linux to Apache on mac: can't access
 location
Date: Sat, 12 Jun 2010 17:48:26 -0700 (PDT)
Message-ID: <1276390106819-5173157.post@n2.nabble.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Jun 13 02:49:12 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ONbNv-0000bD-Bf
	for gcvg-git-2@lo.gmane.org; Sun, 13 Jun 2010 02:49:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752901Ab0FMAs2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 12 Jun 2010 20:48:28 -0400
Received: from kuber.nabble.com ([216.139.236.158]:49825 "EHLO
	kuber.nabble.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752369Ab0FMAs1 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 12 Jun 2010 20:48:27 -0400
Received: from jim.nabble.com ([192.168.236.80])
	by kuber.nabble.com with esmtp (Exim 4.63)
	(envelope-from <jamshark70@gmail.com>)
	id 1ONbNC-0003HT-Qb
	for git@vger.kernel.org; Sat, 12 Jun 2010 17:48:26 -0700
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/149034>


Apologies if this has been covered in the past -- I searched the nabble
archives but didn't find the answer.

I'm new to git, and wanted to synchronize repositories between my main
machine (OSX 10.4.11) and satellite net book (puredyne 9.10, based on ubuntu
karmic). I've gotten as far as being able to get the directory listing in
Firefox on the Mac (same machine where Apache is running) at
http://ip.address/~username/git/kc ('git/kc' is the bare repository under
~/Sites/).

I tried to follow the directions in setup-git-server-over-http.txt:

- added at the end of the load module section of httpd.conf:

LoadModule dav_module libexec/httpd/libdav.so

- added at the end of the add module section of httpd.conf:

AddModule mod_dav.c

- added at the end of the file, just above the final "include":

DAVLockDB "/usr/local/apache2/temp/DAV.lock"

  <Location /git/kc>
     DAV on
     AuthType Basic
     AuthName "Git"
     AuthUserFile /usr/local/apache2/conf/passwd.git
     Require valid-user
  </Location>

- chmod -R ugo+w ~/Sites/git

git clone works.

git push... fails. The remote machine says that it couldn't access the
location. Apache's access log shows:

"PROPFIND /~dewdrop/git/kc/ HTTP/1.1" 404 288

404? The folder most certainly exists.

Anyway, I'm confused. I'm not an expert in Web server configuration, would
appreciate some advice.

Thanks!
James
-- 
View this message in context: http://git.661346.n2.nabble.com/osx-10-4-11-can-t-push-from-linux-to-Apache-on-mac-can-t-access-location-tp5173157p5173157.html
Sent from the git mailing list archive at Nabble.com.
