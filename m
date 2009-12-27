From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: [PATCH] Smart-http documentation: add example of how to
	execute from userdir
Date: Sun, 27 Dec 2009 13:15:57 -0800
Message-ID: <20091227211557.GC609@spearce.org>
References: <1261847255-13970-1-git-send-email-tarmigan+git@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Tarmigan Casebolt <tarmigan+git@gmail.com>
X-From: git-owner@vger.kernel.org Sun Dec 27 22:16:31 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NP0TU-0006th-VK
	for gcvg-git-2@lo.gmane.org; Sun, 27 Dec 2009 22:16:29 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751235AbZL0VQY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 27 Dec 2009 16:16:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751137AbZL0VQY
	(ORCPT <rfc822;git-outgoing>); Sun, 27 Dec 2009 16:16:24 -0500
Received: from mail-yx0-f187.google.com ([209.85.210.187]:64537 "EHLO
	mail-yx0-f187.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751127AbZL0VQY (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 27 Dec 2009 16:16:24 -0500
Received: by yxe17 with SMTP id 17so8953255yxe.33
        for <git@vger.kernel.org>; Sun, 27 Dec 2009 13:16:23 -0800 (PST)
Received: by 10.150.70.39 with SMTP id s39mr21659363yba.167.1261948560391;
        Sun, 27 Dec 2009 13:16:00 -0800 (PST)
Received: from localhost (george.spearce.org [209.20.77.23])
        by mx.google.com with ESMTPS id 20sm10385307iwn.13.2009.12.27.13.15.58
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sun, 27 Dec 2009 13:15:59 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <1261847255-13970-1-git-send-email-tarmigan+git@gmail.com>
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/135715>

Tarmigan Casebolt <tarmigan+git@gmail.com> wrote:
> Smart-http may be an attactive and easy way for people to setup git
> hosting on shared servers whose primary web server configuration they
> do not control.  To facilite this, provide an example of how it may be
> done.
...
> +       \~/public_html/cgi-bin/.htaccess:
> ++
> +----------------------------------------------------------------
> +SetHandler cgi-script
> +Options +SymLinksIfOwnerMatch
> +SetEnv GIT_PROJECT_ROOT /home/$username/devel
> +----------------------------------------------------------------

At this point, isn't this just easier?

  mkdir ~/public_html/git
  vi ~/public_html/git/.htaccess

  SetEnv GIT_PROJECT_ROOT /home/$username/devel
  ScriptAlias / /usr/libexec/git-core/git-http-backend/

No need to mess around with SymlinksIfOwnerMatch and all of that fun.
If you have .htaccess override allows, you should be able to setup
a ScriptAlias without needing to use a cgi-bin directory.

-- 
Shawn.
