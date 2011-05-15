From: Magnus =?iso-8859-1?Q?B=E4ck?= <magnus.back@sonyericsson.com>
Subject: Re: ACLs for GIT
Date: Sun, 15 May 2011 22:15:13 +0200
Message-ID: <20110515201513.GA27758@jpl.local>
References: <4DD02876.1040404@bbn.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Martin L Resnick <mresnick@bbn.com>
X-From: git-owner@vger.kernel.org Sun May 15 22:15:26 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QLhil-0003dK-PI
	for gcvg-git-2@lo.gmane.org; Sun, 15 May 2011 22:15:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752411Ab1EOUPQ convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 15 May 2011 16:15:16 -0400
Received: from smtprelay-b22.telenor.se ([195.54.99.213]:46282 "EHLO
	smtprelay-b22.telenor.se" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752158Ab1EOUPP (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 15 May 2011 16:15:15 -0400
Received: from ipb4.telenor.se (ipb4.telenor.se [195.54.127.167])
	by smtprelay-b22.telenor.se (Postfix) with ESMTP id 7A9F6EA74D
	for <git@vger.kernel.org>; Sun, 15 May 2011 22:15:14 +0200 (CEST)
X-SMTPAUTH-B2: [b627879]
X-SENDER-IP: [83.227.167.132]
X-LISTENER: [smtp.bredband.net]
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-Anti-Spam-Result: AuYcALAz0E1T46eEPGdsb2JhbACJII4vjkQLAQEBATcyiHC+DIYZBJ8I
X-IronPort-AV: E=Sophos;i="4.64,370,1301868000"; 
   d="scan'208";a="1729974961"
Received: from ua-83-227-167-132.cust.bredbandsbolaget.se (HELO elwood.jpl.local) ([83.227.167.132])
  by ipb4.telenor.se with ESMTP; 15 May 2011 22:15:13 +0200
Received: by elwood.jpl.local (Postfix, from userid 1000)
	id 8D093422B1; Sun, 15 May 2011 22:15:13 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <4DD02876.1040404@bbn.com>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/173658>

On Sunday, May 15, 2011 at 21:24 CEST,
     Martin L Resnick <mresnick@bbn.com> wrote:

> Is anyone working on adding access control to GIT ?
>
> I'm looking for the Subversion equivalent of mod_authz_svn.
> I need to restrict read access of ITAR documents that are
> scattered throughout the source tree.
> This restriction would need to deny fetch of the ITAR
> documents yet allow fetch of any other files.
>
> Looking through the source code it would seem that
> putting a hook call in the fetch-pack code would do it.

I doubt it would make sense to put per-file permissions in Git
as it doesn't version files but the complete state of a workspace.
Even if you manage to hack the pack code to not include certain
blobs when certain users ask for them, what would those users
do when they want to create new commits based on commits where
blobs are missing? Or would you send the protected blobs but
replace their contents? Then Git would complain about that.

However, both Gerrit Code Review and Gitolite offer per-branch
permissions, so if it would be possible to put these files on
branches of their own these tools would help.

--=20
Magnus B=E4ck                   Opinions are my own and do not necessar=
ily
SW Configuration Manager      represent the ones of my employer, etc.
Sony Ericsson
