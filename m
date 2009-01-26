From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: Hosting from Windows XP.
Date: Mon, 26 Jan 2009 09:34:13 -0800 (PST)
Message-ID: <m3bptux984.fsf@localhost.localdomain>
References: <c115fd3c0901260827ge5e4b29w871b345da2373f6b@mail.gmail.com>
	<20090126163124.GA31810@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Tim Visher <tim.visher@gmail.com>, git@vger.kernel.org
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Mon Jan 26 18:35:53 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LRVN9-0007Eg-5L
	for gcvg-git-2@gmane.org; Mon, 26 Jan 2009 18:35:43 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751824AbZAZReR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 26 Jan 2009 12:34:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751613AbZAZReQ
	(ORCPT <rfc822;git-outgoing>); Mon, 26 Jan 2009 12:34:16 -0500
Received: from mail-ew0-f21.google.com ([209.85.219.21]:41755 "EHLO
	mail-ew0-f21.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751544AbZAZReQ (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 26 Jan 2009 12:34:16 -0500
Received: by ewy14 with SMTP id 14so787007ewy.13
        for <git@vger.kernel.org>; Mon, 26 Jan 2009 09:34:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:received
         :x-authentication-warning:to:cc:subject:references:from:date
         :in-reply-to:message-id:lines:user-agent:mime-version:content-type;
        bh=0dVzt+vZtZEFOnnQk0i/W+dMqigOoNamW1XgKdSiFI8=;
        b=C0JLAYiZeVhnGPwS6xPPjEaLJvY1h1VmPkAArPlflC+Xgoq+GZAXRzJ0BqkDGKDV9d
         j32GRVJzhUpOMoUVMFosUSuHoYenSDw2Qac4jPnDRWTNZdFm57tUE4x0jPcnccEphVn4
         KndwN/aL+vJHhNTF4geRfElxBpwoFTmk8zvIM=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=x-authentication-warning:to:cc:subject:references:from:date
         :in-reply-to:message-id:lines:user-agent:mime-version:content-type;
        b=UaFee6eNhPww9oZZ3RMT+tyRi4t5O2MnaXPQRxn/M3ZfCEeyHBxKOVfFUThr7fV/dx
         NolCs9WjoGTTIG+/CfoFFCBlFfcdSIGcILhzBZbRBIsL9j6zJwvg/XDRT+dL3ZvfNheC
         2obrvCihK0uMYtTJi16qoyYP3h/GLQEF12sP0=
Received: by 10.86.76.16 with SMTP id y16mr83721fga.17.1232991254219;
        Mon, 26 Jan 2009 09:34:14 -0800 (PST)
Received: from localhost.localdomain (abvk161.neoplus.adsl.tpnet.pl [83.8.208.161])
        by mx.google.com with ESMTPS id 4sm2108378fgg.24.2009.01.26.09.34.12
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Mon, 26 Jan 2009 09:34:13 -0800 (PST)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by localhost.localdomain (8.13.4/8.13.4) with ESMTP id n0QHYAsV027799;
	Mon, 26 Jan 2009 18:34:10 +0100
Received: (from jnareb@localhost)
	by localhost.localdomain (8.13.4/8.13.4/Submit) id n0QHY4c3027795;
	Mon, 26 Jan 2009 18:34:04 +0100
X-Authentication-Warning: localhost.localdomain: jnareb set sender to jnareb@gmail.com using -f
In-Reply-To: <20090126163124.GA31810@spearce.org>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/107234>

"Shawn O. Pearce" <spearce@spearce.org> writes:
> Tim Visher <tim.visher@gmail.com> wrote:

> > I'm trying to get git set up for my company.  We're stuck using
> > Windows for the foreseeable future so for now I have to host the
> > central integration repository out of a Windows box.  I figured the
> > easiest way to do this, short of installing cygwin, would be to do a
> > simple msysgit install and then run git daemon with the relevant repo
> > copied over onto the server.  Then devs could track that repo.
> > However, it appears that msysgit does not install git daemon.
> 
> git-daemon isn't ported yet, due to its heavy reliance on POSIX
> behavior during fork+exec.

You can use instead "dumb" HTTP protocol, or network filesystem
(network share).  Or SSH.

Note that for push you don't [usually] use git-daemon: you can use
SSH, filesystem (network share), HTTPS with WebDAV.

> > I may totally be missing something here, but I don't know what.  Short
> > of the question is, how do I host a repo out of Windows?
> 
> I think your options are limited to:
[...]
> - Use JGit and its daemon

>From what I remember currently JGit daemon generates suboptimal
packfiles, as it does not support delta compression yet...

-- 
Jakub Narebski
Poland
ShadeHawk on #git
