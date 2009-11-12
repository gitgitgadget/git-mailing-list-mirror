From: Eric Wong <normalperson@yhbt.net>
Subject: Re: git svn show-ignore bug?
Date: Thu, 12 Nov 2009 10:41:55 -0800
Message-ID: <20091112184155.GA4390@dcvr.yhbt.net>
References: <01C132B1-3CEE-4EF2-A4BC-5C1D71088FBF@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Niko Schwarz <niko.schwarz@googlemail.com>
X-From: git-owner@vger.kernel.org Thu Nov 12 19:42:08 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1N8ecO-00064W-Tw
	for gcvg-git-2@lo.gmane.org; Thu, 12 Nov 2009 19:42:05 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752468AbZKLSlu convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 12 Nov 2009 13:41:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751657AbZKLSlu
	(ORCPT <rfc822;git-outgoing>); Thu, 12 Nov 2009 13:41:50 -0500
Received: from dcvr.yhbt.net ([64.71.152.64]:47692 "EHLO dcvr.yhbt.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752021AbZKLSlt (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 12 Nov 2009 13:41:49 -0500
Received: from localhost (unknown [127.0.2.5])
	by dcvr.yhbt.net (Postfix) with ESMTP id 581491F677;
	Thu, 12 Nov 2009 18:41:55 +0000 (UTC)
Content-Disposition: inline
In-Reply-To: <01C132B1-3CEE-4EF2-A4BC-5C1D71088FBF@gmail.com>
User-Agent: Mutt/1.5.18 (2008-05-17)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/132791>

Niko Schwarz <niko.schwarz@googlemail.com> wrote:
> Hi there, in the IRC channel today, someone asked me to report this =20
> behavior to you because they suspect a bug in show-ignore.
>
> Ok, so here's the output of git svn info:
>
> Path: .
> URL: https://www.iam.unibe.ch/scg/svn_repos
> Repository Root: https://www.iam.unibe.ch/scg/svn_repos
> Repository UUID: 54883e8d-cf1d-0410-83d6-f114b9419f37
> Revision: 29639
> Node Kind: directory
> Schedule: normal
> Last Changed Author: oscar
> Last Changed Rev: 29639
> Last Changed Date: 2009-11-12 11:22:35 +0100 (Do, 12 Nov 2009)
>
>
> I can do git svn rebase, git svn fetch, and those things work. Dcommi=
t,=20
> works, too. But git svn show-ignore >> .gitignore does not work.

Hi Niko, this is really strange, especially when dcommit works.

> This is the dialog with the system:
> Nikos-Mbp-3:svn_repos niko$ git svn show-ignore >> .gitignore
> Authentication realm: <https://www.iam.unibe.ch:443> SCG Subversion =20
> Repository
> Password for 'schwarz':
> Authentication realm: <https://www.iam.unibe.ch:443> SCG Subversion =20
> Repository
> Username: schwarz
> Password for 'schwarz':
> Authentication realm: <https://www.iam.unibe.ch:443> SCG Subversion =20
> Repository
> Username: schwarz
> Password for 'schwarz':
> Autorisierung schlug fehl: PROPFIND von =BB/scg/svn_repos/IAM=AB: =20
> Autorisierung schlug fehl: Could not authenticate to server: rejected=
 =20
> Basic challenge (https://www.iam.unibe.ch) at /opt/local/libexec/git-=
=20
> core/git-svn line 2276
>
>
> That's all the info I have, I'm afraid. I'm sure that the password is=
 =20
> correct, as it works from XCode.

Which version of git is this?  Are you in contact with the SVN server
administrator?  Maybe they can look at server logs for you.

Also, can you try the following command with plain svn?

  svn pg -R svn:ignore https://www.iam.unibe.ch/scg/svn_repos

Thanks.  Also, if anybody else there can help look into this it would b=
e
greatly appreciated, my authentication knowledge is still a bit on the
weak side.

--=20
Eric Wong
