From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: Windows symlinks
Date: Tue, 24 Jun 2008 16:28:22 -0700 (PDT)
Message-ID: <m3od5qjtv1.fsf@localhost.localdomain>
References: <911589C97062424796D53B625CEC0025E4618F@USCOBRMFA-SE-70.northamerica.cexp.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: "Patrick Higgins" <Patrick.Higgins@cexp.com>
X-From: git-owner@vger.kernel.org Wed Jun 25 01:29:28 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KBHwy-0000zK-IN
	for gcvg-git-2@gmane.org; Wed, 25 Jun 2008 01:29:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758061AbYFXX23 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 24 Jun 2008 19:28:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751693AbYFXX23
	(ORCPT <rfc822;git-outgoing>); Tue, 24 Jun 2008 19:28:29 -0400
Received: from nf-out-0910.google.com ([64.233.182.191]:1601 "EHLO
	nf-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758061AbYFXX21 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 24 Jun 2008 19:28:27 -0400
Received: by nf-out-0910.google.com with SMTP id d3so78510nfc.21
        for <git@vger.kernel.org>; Tue, 24 Jun 2008 16:28:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:received
         :x-authentication-warning:to:cc:subject:references:from:in-reply-to
         :message-id:lines:user-agent:mime-version:content-type:date;
        bh=6WaZIv9C3tiwEZXrMu8Ipkr+fsZ7z9Cwks0iFGCrtJE=;
        b=H6G3SV6BcJYz0mntHlKxH7t9tLAur2vvv++VNAlqWoK6J27dCQSLchRRDOVJHn8N5o
         p4N3auv+g52f06EhBFEQ2m29yy2F3JRr0pvZCvmt9HCEKRc/ge4ysEWkxH5shy70dcp7
         t6KmhFv65y98IotdveP9hUywmjAx1n+6wYXpo=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=x-authentication-warning:to:cc:subject:references:from:in-reply-to
         :message-id:lines:user-agent:mime-version:content-type:date;
        b=Wyuu8g83bDlZeOsbH+z7t8JDJAGcyugrUVMHShwEOVC+L7jDOkwGEU5fpFsyXeWCfx
         gxALmGGhUoYL9hazaddbmyWBSAcUVghRJNP8CVv3b3yX29XbG3RCcFN9HgzN29ozR/tD
         Gvu2c2Y5vIUo8ywIQSzFbOQ//qpK+YBxEUcaY=
Received: by 10.210.117.1 with SMTP id p1mr1036399ebc.4.1214350103859;
        Tue, 24 Jun 2008 16:28:23 -0700 (PDT)
Received: from localhost.localdomain ( [83.8.223.44])
        by mx.google.com with ESMTPS id d27sm1230463nfh.12.2008.06.24.16.28.21
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Tue, 24 Jun 2008 16:28:22 -0700 (PDT)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by localhost.localdomain (8.13.4/8.13.4) with ESMTP id m5ONSK0a011958;
	Wed, 25 Jun 2008 01:28:20 +0200
Received: (from jnareb@localhost)
	by localhost.localdomain (8.13.4/8.13.4/Submit) id m5ONSJBN011955;
	Wed, 25 Jun 2008 01:28:19 +0200
X-Authentication-Warning: localhost.localdomain: jnareb set sender to jnareb@gmail.com using -f
In-Reply-To: <911589C97062424796D53B625CEC0025E4618F@USCOBRMFA-SE-70.northamerica.cexp.com>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/86180>

Patrick Higgins <Patrick.Higgins@cexp.com> writes:

> It looks like one of the bigger (biggest?) hurdles for git adoption
> at my company is going to be handling symlinks on Windows. We may be
> able to sidestep the issue [...] by [...] run[ning] Linux
> in a virtual machine [...]

If only MS Windows supported other filesystems which have symlinks...

> Has anyone thought about a way for git to handle symlinks? Vista
> seems to have added native symlinks, but you need have elevated
> privilege to create them. NTFS junction points seem helpful for
> older versions of Windows, but don't work for anything except
> directories, and seem to be dangerous to use with tools that do
> recursive deletes. Neither junction points nor native symlinks sound
> like great options.
> 
> Cygwin's clever symlink trick seems to work pretty well in
> practice. I'm not exactly sure what it's doing, but it seems to
> create a shortcut that it's own programs understand. Some other
> non-Cygwin programs seem to understand them, too, but Java does not
> which is a big problem for me.

First, I think that both "git on Windows" solutions, namely Cygwin and
msysGit port, don't use symlinks either in installed programs, nor in
repository layout.

Second, the problem there can be _only_ if your repository contains
(or contained) symlinks, and then it is your own damn fault.  I don't
know how Cygwin, or msysGit deals with symlinks in a wirking
directory, but you can work around symlinks (although in a bit
unwieldy way) by using `core.symlinks' configuration variable;
see git-config(1):

 core.symlinks::
        If false, symbolic links are checked out as small plain files
        that contain the link text. git-update-index(1) and git-add(1)
        will not change the recorded type to regular file. Useful on
        filesystems like FAT that do not support symbolic links. True
        by default.

-- 
Jakub Narebski
Poland
ShadeHawk on #git
