From: Franck Bui-Huu <vagabon.xyz@gmail.com>
Subject: Re: Add git-archive [take #2]
Date: Fri, 08 Sep 2006 11:43:54 +0200
Message-ID: <45013B5A.8000301@innova-card.com>
References: <cda58cb80609050516v699338b9y57fd54f50c66e49e@mail.gmail.com>	<7vfyf6ce29.fsf@assigned-by-dhcp.cox.net>	<44FED12E.7010409@innova-card.com>	<7vac5c7jty.fsf@assigned-by-dhcp.cox.net>	<cda58cb80609062332p356bd26bw852e31211c43d1ac@mail.gmail.com>	<7v1wqo400b.fsf@assigned-by-dhcp.cox.net>	<44FFD00E.5040305@innova-card.com>	<7vr6yo2isu.fsf@assigned-by-dhcp.cox.net>	<450019C3.4030001@innova-card.com>	<7v8xkvqjlq.fsf@assigned-by-dhcp.cox.net>	<45012752.4070300@innova-card.com> <7v64fyivk0.fsf@assigned-by-dhcp.cox.net>
Reply-To: Franck <vagabon.xyz@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Cc: Franck <vagabon.xyz@gmail.com>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Sep 08 11:44:02 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GLctm-00058s-WE
	for gcvg-git@gmane.org; Fri, 08 Sep 2006 11:43:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750752AbWIHJnn (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 8 Sep 2006 05:43:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750753AbWIHJnn
	(ORCPT <rfc822;git-outgoing>); Fri, 8 Sep 2006 05:43:43 -0400
Received: from nz-out-0102.google.com ([64.233.162.200]:56887 "EHLO
	nz-out-0102.google.com") by vger.kernel.org with ESMTP
	id S1750752AbWIHJnm (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 8 Sep 2006 05:43:42 -0400
Received: by nz-out-0102.google.com with SMTP id n1so260080nzf
        for <git@vger.kernel.org>; Fri, 08 Sep 2006 02:43:41 -0700 (PDT)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:reply-to:user-agent:mime-version:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding:from;
        b=C/O2wNONl1e6St+oQNGsXMNZGS5oON9AjSY36ftaQwKM+6n5W1XjThagPe8uSBdXOYF9ZB0PHxUNmG50+SxS0pOz/oGgv1+9d7kLlmVklueSKSsngZwLfnLGcYYj22RagA9/AsRpgzTgGdhGMBgTQyFMU0GgzucJSOg5Nb9bW+A=
Received: by 10.65.251.1 with SMTP id d1mr1571147qbs;
        Fri, 08 Sep 2006 02:43:41 -0700 (PDT)
Received: from ?192.168.0.24? ( [81.252.61.1])
        by mx.gmail.com with ESMTP id f18sm456934qba.2006.09.08.02.43.40;
        Fri, 08 Sep 2006 02:43:40 -0700 (PDT)
User-Agent: Thunderbird 1.5.0.4 (X11/20060614)
To: Junio C Hamano <junkio@cox.net>
In-Reply-To: <7v64fyivk0.fsf@assigned-by-dhcp.cox.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/26694>

Junio C Hamano wrote:
> 
> I do not think I removed upload-tar.  I removed it from daemon
> service list and the documentation for daemon, because that part
> is a new code.
> 
> 	git tar-tree --remote=../linux-2.6/.git HEAD
> 	git tar-tree --remote=kernel.org:git next
> 
> should still work; the former is "from a directory next door"
> and connect.c invokes local /bin/sh as the transport, and the
> latter is "ssh login to kernel.org and use ./git directory".
> 

Sorry I was speaking about the git protocol. It has been included
in master branch. But

	git tar-tree --remote=git://anything/repo.git

does not work anymore, does it ? Do you plan to make it work again
with git-upload-archive (that would need some modifications in
git-tar-tree --remote code) or just let the --remote option work
for local and ssh transport (that would be one good reason for using
for git-archive instead of git-tar-tree) ?

> I recall from earlier review of your code, "git archive" should
> work well over these two transports in addition to git://
> protocol that talks with git-daemon.
> 
yes
		Franck
