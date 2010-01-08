From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: ssh username environment variable
Date: Fri, 8 Jan 2010 12:29:58 -0800
Message-ID: <20100108202958.GL32155@spearce.org>
References: <a038bef51001081224l33164526y51e5ca064b82b73a@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Chris Packham <judge.packham@gmail.com>
X-From: git-owner@vger.kernel.org Fri Jan 08 21:30:57 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NTLU1-0001bF-CR
	for gcvg-git-2@lo.gmane.org; Fri, 08 Jan 2010 21:30:57 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752760Ab0AHUaI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 8 Jan 2010 15:30:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752721Ab0AHUaI
	(ORCPT <rfc822;git-outgoing>); Fri, 8 Jan 2010 15:30:08 -0500
Received: from mail-yw0-f176.google.com ([209.85.211.176]:34010 "EHLO
	mail-yw0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752700Ab0AHUaE (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 8 Jan 2010 15:30:04 -0500
Received: by ywh6 with SMTP id 6so19829709ywh.4
        for <git@vger.kernel.org>; Fri, 08 Jan 2010 12:30:04 -0800 (PST)
Received: by 10.150.166.4 with SMTP id o4mr3972775ybe.53.1262982601871;
        Fri, 08 Jan 2010 12:30:01 -0800 (PST)
Received: from localhost (george.spearce.org [209.20.77.23])
        by mx.google.com with ESMTPS id 6sm8087047ywd.37.2010.01.08.12.29.59
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Fri, 08 Jan 2010 12:29:59 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <a038bef51001081224l33164526y51e5ca064b82b73a@mail.gmail.com>
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/136471>

Chris Packham <judge.packham@gmail.com> wrote:
> Just wondering if there is an environment variable I can use to tell
> git or ssh what user name to use for the ssh transport?

No.  But you can hack around it:

  cat >$HOME/bin/git-ssh
  #!/bin/sh
  ssh -l $GIT_SSH_USER "$@"
  ^D

  GIT_SSH=$HOME/bin/git-ssh GIT_SSH_USER=myname git clone ...

-- 
Shawn.
