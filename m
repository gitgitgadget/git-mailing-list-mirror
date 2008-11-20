From: Deskin Miller <deskinm@umich.edu>
Subject: Re: Challenge of setting up git server (repository). Please help!
Date: Thu, 20 Nov 2008 17:13:21 -0500
Message-ID: <20081120221321.GA6349@euler>
References: <829533.97868.qm@web37906.mail.mud.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Gary Yang <garyyang6@yahoo.com>
X-From: git-owner@vger.kernel.org Thu Nov 20 23:14:56 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1L3Hnb-0000Ls-6d
	for gcvg-git-2@gmane.org; Thu, 20 Nov 2008 23:14:55 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757355AbYKTWNe (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 20 Nov 2008 17:13:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757237AbYKTWNe
	(ORCPT <rfc822;git-outgoing>); Thu, 20 Nov 2008 17:13:34 -0500
Received: from ug-out-1314.google.com ([66.249.92.168]:51483 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756782AbYKTWNd (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 20 Nov 2008 17:13:33 -0500
Received: by ug-out-1314.google.com with SMTP id 39so420595ugf.37
        for <git@vger.kernel.org>; Thu, 20 Nov 2008 14:13:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :in-reply-to:user-agent:sender;
        bh=1ufEIpOSYICiBFmiacjIigHhykjZAnGdE0z2Rdh0WDs=;
        b=ILQutF9AT8UpQfv4l9Z5ryTqGkBsHtTzyN5b8rWNW+wrFa86BQVZidTSmKtOpHM/YN
         pJm5Ig1zy5aaN9AnRG7AQzEM6PZ0Z7mGS6vH0laiFShqgAbxGqqIWuyXg1II6aziYQcC
         asqRKB7ej1BIDVQP73wDTDfNgyUPd78xbvEK8=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent:sender;
        b=pH7RfsFRJahwiFyJ5H6YqqoWMr73IMKgjE3i1wjDwBsz95PX50u7CxFmVi5AGHoSl5
         ZNkB0vgAFN1sforpXVThGGcSgpNo+DMKFsKWEP9YZP1xRSyzXuJdU+1bI97H4CBtkfLz
         yZVwMrGjYg8h0meu521QzMsu7tA1/UdDHZP8E=
Received: by 10.66.245.2 with SMTP id s2mr3860624ugh.66.1227219211143;
        Thu, 20 Nov 2008 14:13:31 -0800 (PST)
Received: from euler ([68.40.49.130])
        by mx.google.com with ESMTPS id 30sm34889ugf.13.2008.11.20.14.13.28
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Thu, 20 Nov 2008 14:13:30 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <829533.97868.qm@web37906.mail.mud.yahoo.com>
User-Agent: Mutt/1.5.18 (2008-05-17)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/101473>

On Thu, Nov 20, 2008 at 01:39:12PM -0800, Gary Yang wrote:
> 
> I am working on setting up a git server so that people can clone, pull and push their code at git.mycompany.com/pub/git+project path. 
> However, I am having challenges. For people who setup their git servers, please share your experneces with me and tell me what I did wrong.
> I greatly appreciate it.
> 
> After I made configurations, I ran the command, git update-server-info at the public repository machine. But, I got the error.
> 
> git pull http://git.mycompany.com/pub/git/u-boot.git HEAD
> fatal: http://git.mycompany.com/pub/git/u-boot.git/info/refs not found: did you run git update-server-info on the server?
> 
> The file /pub/git/u-boot.git/info/refs dose exist.
> 
> cat /pub/git/u-boot.git/info/refs
> 87ee4576c4c31b7046fe2bbbdf309eaba5c3f346        refs/heads/master
> 
> My question:
> 
> Is the contet of /pub/git/u-boot.git/hooks/post-update correct? Should I change "exec git-update-server-info" to "exec git update-server-info"?
> 
> cat /pub/git/u-boot.git/hooks/post-update
> #!/bin/sh
> #
> # An example hook script to prepare a packed repository for use over
> # dumb transports.
> #
> # To enable this hook, rename this file to "post-update".
> exec git-update-server-info
> 
> I tried and changed "exec git-update-server-info" to "exec git update-server-info" in /pub/git/u-boot.git/hooks/post-update. But, I still got same error.
> git pull http://git.mycompany.com/pub/git/u-boot.git HEAD
> fatal: http://git.mycompany.com/pub/git/u-boot.git/info/refs not found: did you run git update-server-info on the server?
> 
> Which one is correct? "exec git-update-server-info" or "exec git update-server-info"? Eventhogh none of them working.
> 
> Below are my settings:
> 
> grep 9418 /etc/services
> git             9418/tcp                        # Git Version Control System
> 
> 
> grep git /etc/inetd.conf
> git     stream  tcp     nowait  nobody  /usr/local/libexec/git-core/git-daemon git-daemon --inetd --export-all /pub/git
> 
> 
> cat /etc/xinetd.d/git-daemon
> # default: off
> # description: The git server offers access to git repositories
> service git
> {
>         disable = no
>         type            = UNLISTED
>         port            = 9418
>         socket_type     = stream
>         wait            = no
>         user            = nobody
>         server          = /usr/local/libexec/git-core/git-daemon
>         server_args     = --inetd --export-all --base-path=/pub/git
>         log_on_failure  += USERID
> }
> 
> 
> I am running git at Linux box:
> uname -a
> Linux svdclw004 2.6.9-67.ELsmp #1 SMP Wed Nov 7 13:56:44 EST 2007 x86_64 GNU/Linux
> 
> Are there anything wrong? Please let me know.

You tried to fetch from a http url, but your settings make no mention of
running a web server.  git-update-server-info is only relevant in the context
of using a web server to serve git repositories via the same http protocol as
is used by web servers everywhere.  git-daemon, on the other hand, which is
what you show configured here, is used to serve git repositories via a git://
url.  Its configuration has no effect on whether using http to fetch a git
repository will work or not.

Either use a git:// url to fetch the project, or set up a web server which
serves stuff under /pub/git.

I'll also mention that you appear to have configuration for both inetd and
xinetd, which are two generally mutually-exclusive 'super-servers'; and
furthermore, your configurations are inconsistent in the arguments they pass to
git-daemon: it looks like, were you to replace http:// with git://, the inetd
config would work as listed, while xinetd would not.

Hope that helps,
Deskin Miller
