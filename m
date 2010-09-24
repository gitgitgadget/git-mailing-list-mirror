From: Joshua Jensen <jjensen@workspacewhiz.com>
Subject: git-upload-pack bandwidth cap over SSH?
Date: Fri, 24 Sep 2010 08:47:05 -0600
Message-ID: <4C9CB9E9.8010901@workspacewhiz.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
To: "git@vger.kernel.org" <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Fri Sep 24 16:47:17 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Oz9YR-00085R-OC
	for gcvg-git-2@lo.gmane.org; Fri, 24 Sep 2010 16:47:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755724Ab0IXOrJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 24 Sep 2010 10:47:09 -0400
Received: from hsmail.qwknetllc.com ([208.71.137.138]:43446 "EHLO
	hsmail.qwknetllc.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751043Ab0IXOrI (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 24 Sep 2010 10:47:08 -0400
Received: (qmail 14710 invoked by uid 399); 24 Sep 2010 08:47:07 -0600
Received: from unknown (HELO ?192.168.1.2?) (jjensen@workspacewhiz.com@75.196.230.186)
  by hsmail.qwknetllc.com with ESMTPAM; 24 Sep 2010 08:47:07 -0600
X-Originating-IP: 75.196.230.186
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 6.1; en-US; rv:1.9.2.9) Gecko/20100825 Lightning/1.0b3pre Thunderbird/3.1.3
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/156996>

  Our Git repository central server is running on some kind of 
enterprise VM software.  I can push repository changes through the 
Gitolite-monitored SSH tunnel at 10+ megabytes per second.

A 'git pull' operation (even a fresh clone of the packed repository) 
always caps at 1.55 MiB/s, according to the "Receiving objects" line in 
the status text.

Thinking it might be a hardware issue (half duplex?), I installed 
VirtualBox on my Windows 7 64-bit machine and then made an Ubuntu 
Gitolite install.  Running on my local hardware, the push is roughly 12 
megabytes per second.  The 'git pull' downstream again caps at 1.55 MiB/s.

I've been troubleshooting this for months.

Are there any configuration settings within Git that may limit the 
git-upload-pack operation's speed?

I realize this could be a MinGW issue via the msysGit client.

Update: I just copied a large file via 'scp', and the downstream still 
capped at 1.55-ish megabytes per second.  So it isn't Git.

I guess I'll post this anyway out of desperation.

Does anyone have any thoughts?

Josh
