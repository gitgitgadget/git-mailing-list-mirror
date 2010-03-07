From: Nicolas Sebrecht <nicolas.s.dev@gmx.fr>
Subject: Re: How do you add an external directory to repository?
Date: Sun, 7 Mar 2010 22:36:24 +0100
Message-ID: <20100307213624.GA12937@vidovic>
References: <1267992229319-4691734.post@n2.nabble.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Nicolas Sebrecht <nicolas.s.dev@gmx.fr>
To: slipstream180 <ivan.barrios@gmail.com>
X-From: git-owner@vger.kernel.org Sun Mar 07 22:36:48 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NoO9W-0002HE-TL
	for gcvg-git-2@lo.gmane.org; Sun, 07 Mar 2010 22:36:47 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754860Ab0CGVgm (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 7 Mar 2010 16:36:42 -0500
Received: from mail-bw0-f209.google.com ([209.85.218.209]:59425 "EHLO
	mail-bw0-f209.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753096Ab0CGVgl (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 7 Mar 2010 16:36:41 -0500
Received: by bwz1 with SMTP id 1so2336336bwz.21
        for <git@vger.kernel.org>; Sun, 07 Mar 2010 13:36:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:sender:date:from:to:cc
         :subject:message-id:references:mime-version:content-type
         :content-disposition:in-reply-to:user-agent;
        bh=4+LTmqSi4KlzYx6b7QSkINsyj/tGfFeliZK9IgVpPPk=;
        b=OqXwkFxSsK3z+7JppcO/HZMxM6IMEa67x4I2tWd+s5PlnpNrDLXr6YY6m4sBGOumyA
         SRodxE+DiBFNYzA89JXss6SH8sx+c2BbQVHnYyWpRRksUe0aD0OWZ3/70Y/fs3QrgcDi
         N2s4jTEPzPo/ABB+C+ochbqFseYFnVf79h1WQ=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=SbuZJyVTSec9Srr7d5gf0IYetklHPJ+v1DBoki4DxHWodp0Goes2n+goZguEbXNGAy
         3NrMbs5dk4SOGbzsK7/mIpviDiHhrjAkuWIt43K5VQwPMFUIXohqIytiH7hbOj28W8hs
         dZtUAqCqXY0NF4iVJGjCxswGu3aOJe2kfuytI=
Received: by 10.204.174.194 with SMTP id u2mr1053162bkz.40.1267997797948;
        Sun, 07 Mar 2010 13:36:37 -0800 (PST)
Received: from @ (91-164-141-129.rev.libertysurf.net [91.164.141.129])
        by mx.google.com with ESMTPS id s17sm13528494bkd.22.2010.03.07.13.36.27
        (version=SSLv3 cipher=RC4-MD5);
        Sun, 07 Mar 2010 13:36:35 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <1267992229319-4691734.post@n2.nabble.com>
User-Agent: Mutt/1.5.18 (2008-05-17)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/141736>

The 07/03/10, slipstream180 wrote:

> I understand that I can add a symbolic link to /home/some/directory, but I
> believe that only track the link. How do I track all files under the
> directory as well?

I think you're looking for the bind option of mount. This is what I use
to track all my configuration files in one "conf" repository.

Here is an extract of how my fstab looks like:

  /home/nicolas/.zsh /home/nicolas/dev/conf/zsh				auto	bind,user	0 0 
  /home/nicolas/.vim /home/nicolas/dev/conf/vim				auto	bind,user	0 0 
  /home/nicolas/.mutt /home/nicolas/dev/conf/mutt				auto	bind,user	0 0 
  /home/nicolas/.screen /home/nicolas/dev/conf/screen			auto	bind,user	0 0 
  /home/nicolas/.offlineimapconf/ /home/nicolas/dev/conf/offlineimap	auto	bind,user	0 0 

I also use a symbolic link ~/.zshrc to .zsh/zshrc to track it too. This
is very useful because one logical change may affect configuration files
from various programs (e.g. have a new mailbox concerns mutt,
offlineimap, imapfilter, and some other scripts of my own).


Also, I use this trick for web projects:

  /home/nicolas/dev/wsb /var/www/localhost/htdocs/wsb			auto	bind,user	0 0
  

-- 
Nicolas Sebrecht
