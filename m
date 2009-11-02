From: Dmitry Potapov <dpotapov@gmail.com>
Subject: Re: Unhappy git in a jailshell?
Date: Mon, 2 Nov 2009 15:47:46 +0300
Message-ID: <20091102124746.GA27126@dpotapov.dyndns.org>
References: <130714cd0911020416r6a686026q697d843f47b68692@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Alex MDC <alex.mdc@gmail.com>
X-From: git-owner@vger.kernel.org Mon Nov 02 13:47:07 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1N4wJL-0006vf-VE
	for gcvg-git-2@lo.gmane.org; Mon, 02 Nov 2009 13:47:04 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754765AbZKBMqt (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 2 Nov 2009 07:46:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754762AbZKBMqt
	(ORCPT <rfc822;git-outgoing>); Mon, 2 Nov 2009 07:46:49 -0500
Received: from mail-bw0-f227.google.com ([209.85.218.227]:50955 "EHLO
	mail-bw0-f227.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754705AbZKBMqs (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 2 Nov 2009 07:46:48 -0500
Received: by bwz27 with SMTP id 27so6256523bwz.21
        for <git@vger.kernel.org>; Mon, 02 Nov 2009 04:46:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :in-reply-to:user-agent;
        bh=Xv2UoQj9F+AGqYKS8L3lVTBzP38+bIopVM6u/fqg1C0=;
        b=rD9uxZTJ8HPNovPpxTbYk3xA8IYW1WI63h1ufrxTmmZdSq+xbpcBqccrs1qgCszK3S
         1WGNoaOlb0nMssEmmHNFyrLHhmTNSPT+5SDmPsyUqrjHiYFlGACNpNQYzxvxUpaP7G5x
         HYkG+4vahlPdgtJ2abYjqvVpxeHdrNK2EFsIo=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=c7LI9zNfpKjIy8zCzlf/s0It6yVApxDLsSKhb5bYe1zJgwp4J7c9tHfkd6GePjqeLM
         W9G/JHUwBdbUZYfUjnpCCmFnjsGnSkxW3BVGfYCRLWECrMzCcrInkT44GeLxGH2yyEmt
         e1L/+8Yiy2Nsnzvd8p50FtBos1ChMRMAOfkDM=
Received: by 10.102.170.12 with SMTP id s12mr2130960mue.12.1257166012589;
        Mon, 02 Nov 2009 04:46:52 -0800 (PST)
Received: from localhost (ppp91-77-227-241.pppoe.mtu-net.ru [91.77.227.241])
        by mx.google.com with ESMTPS id 23sm60291mun.33.2009.11.02.04.46.51
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Mon, 02 Nov 2009 04:46:51 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <130714cd0911020416r6a686026q697d843f47b68692@mail.gmail.com>
User-Agent: Mutt/1.5.18 (2008-05-17)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/131904>

On Mon, Nov 02, 2009 at 11:16:43PM +1100, Alex MDC wrote:
> Hello,
> 
> I'm trying to use git on a linux server, but unfortunately I've only
> been granted jailshelled access. Most of git works, but some commands
> just fail to run, e.g.
> git repack
> git rebase
> git index-pack

Most Git commands are builtin, so they are executed by git.exe directly,
but some commands are implemented as separate binaries or shell files.
These commands require `git --exec-path` in PATH to run. Normally, git
adds `git --exec-path` in its environment before running them.

Apparently, jailshelled access prevents that somehow. So, I suggest you
contact your system administrator and tell him that you need to be able
to run files from `git --exec-path` to being able to use git, as git
needs them internally for normal work.


Dmitry
