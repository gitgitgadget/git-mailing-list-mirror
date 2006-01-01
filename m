From: Olaf Hering <olh@suse.de>
Subject: Re: how to find outstanding patches in non-linux-2.6 repositories?
Date: Sun, 1 Jan 2006 22:04:39 +0100
Message-ID: <20060101210429.GA22033@suse.de>
References: <20060101200121.GA20633@suse.de> <43B83EBC.9070905@didntduck.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Jan 01 22:05:13 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EtAO8-00005q-2L
	for gcvg-git@gmane.org; Sun, 01 Jan 2006 22:05:12 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932195AbWAAVEv (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 1 Jan 2006 16:04:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932210AbWAAVEv
	(ORCPT <rfc822;git-outgoing>); Sun, 1 Jan 2006 16:04:51 -0500
Received: from cantor2.suse.de ([195.135.220.15]:28555 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S932195AbWAAVEv (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 1 Jan 2006 16:04:51 -0500
Received: from Relay2.suse.de (mail2.suse.de [195.135.221.8])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx2.suse.de (Postfix) with ESMTP id 80D591C649;
	Sun,  1 Jan 2006 22:04:39 +0100 (CET)
To: Brian Gerst <bgerst@didntduck.org>
Content-Disposition: inline
In-Reply-To: <43B83EBC.9070905@didntduck.org>
X-DOS: I got your 640K Real Mode Right Here Buddy!
X-Homeland-Security: You are not supposed to read this line! You are a terrorist!
User-Agent: Mutt und vi sind doch schneller als Notes (und GroupWise)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/14130>

 On Sun, Jan 01, Brian Gerst wrote:

> Pull the powerpc tree into your local repo, then do something like:
> git-whatchanged master..powerpc
> or
> gitk master..powerpc

This worked for me:

mkdir /dev/shm/x
cd /dev/shm/x
rsync -Ha --delete ~/kernel/git/{powerpc,linux-2.6} .
cd linux-2.6/
cat .git/HEAD  > ../start
git-pull /dev/shm/x/powerpc
cat .git/HEAD  > ../end
git-format-patch `cat ../start` `cat ../end`
view ????-*



-- 
short story of a lazy sysadmin:
 alias appserv=wotan
