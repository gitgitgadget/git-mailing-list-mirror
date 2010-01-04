From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: Git Server Authentication & Management
Date: Mon, 4 Jan 2010 08:33:16 -0800
Message-ID: <20100104163316.GC22872@spearce.org>
References: <1a710981001040827q23f61bdew8db1ae76d5bfb855@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git <git@vger.kernel.org>
To: Pedro Lemos <pedrolemos454@gmail.com>
X-From: git-owner@vger.kernel.org Mon Jan 04 17:33:26 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NRprx-0007lz-TO
	for gcvg-git-2@lo.gmane.org; Mon, 04 Jan 2010 17:33:26 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753411Ab0ADQdV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 4 Jan 2010 11:33:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753280Ab0ADQdV
	(ORCPT <rfc822;git-outgoing>); Mon, 4 Jan 2010 11:33:21 -0500
Received: from mail-yx0-f188.google.com ([209.85.210.188]:41818 "EHLO
	mail-yx0-f188.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753221Ab0ADQdV (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 4 Jan 2010 11:33:21 -0500
Received: by yxe26 with SMTP id 26so14686479yxe.4
        for <git@vger.kernel.org>; Mon, 04 Jan 2010 08:33:19 -0800 (PST)
Received: by 10.151.59.20 with SMTP id m20mr7631022ybk.325.1262622799389;
        Mon, 04 Jan 2010 08:33:19 -0800 (PST)
Received: from localhost (george.spearce.org [209.20.77.23])
        by mx.google.com with ESMTPS id 21sm7305742yxe.19.2010.01.04.08.33.17
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Mon, 04 Jan 2010 08:33:17 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <1a710981001040827q23f61bdew8db1ae76d5bfb855@mail.gmail.com>
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/136129>

Pedro Lemos <pedrolemos454@gmail.com> wrote:
> I'm relatively new to Git.
> At the moment I'm trying to understand if it will be possible to:
> 
> 1 - configure a central server (server A) to host all my git repositories.
> 2 - also I would like to configure access to those Git repositories in
> order to use authentication:
>         - using LDAP;
>         - using MS Active Directory;

You might want to look at Gerrit Code Review [1].  It has
out-of-the-box support for integration with Active Directory.

[1] http://code.google.com/p/gerrit/
 
> 3 - Moreover, I would like to know if is there any administration
> interface to use within git repositories?

Gerrit Code Review uses a web based administration interface, though
with an LDAP/Active Directory configuration access controls will
most likely be managed in the directory server by user membership
to groups.

> 4 - And to close this email, I need a way to manage access permissions
> over the server repositories. Such as:
>         - read-write, read-only, or no access at all;
>         - deletes-allowed, renames-allowed, tags allowed;

Yup, Gerrit Code Review can do that.

It also can be used as a code review system.  :-) But if you don't
want to use the code review features, you can just grant out the
Push Branch +1 (or +2 or +3) permission to allow pushing to a branch.
 

A different, but much more popular choice is gitosis [2], but that
doesn't use LDAP for user authentication and access management.
It uses its own SSH key repository.  To be fair, Gerrit Code Review
also uses its own SSH key repository... but users can manage their
keys individually through the web interface, which is authenticated
by LDAP.

[2] http://eagain.net/gitweb/?p=gitosis.git

-- 
Shawn.
