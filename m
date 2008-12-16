From: =?iso-8859-1?Q?Bj=F6rn?= Steinbrink <B.Steinbrink@gmx.de>
Subject: Re: [usability bug] git branch -a does not disambiguate remote and
	local branches
Date: Tue, 16 Dec 2008 07:26:34 +0100
Message-ID: <20081216062634.GB3684@atjola.homenet>
References: <85647ef50812151015t4d5bc2b8p4ea53a0e4ad25e64@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Constantine Plotnikov <constantine.plotnikov@gmail.com>
X-From: git-owner@vger.kernel.org Tue Dec 16 07:28:02 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LCTPQ-0002DF-Nz
	for gcvg-git-2@gmane.org; Tue, 16 Dec 2008 07:27:57 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751060AbYLPG0j convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 16 Dec 2008 01:26:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751169AbYLPG0j
	(ORCPT <rfc822;git-outgoing>); Tue, 16 Dec 2008 01:26:39 -0500
Received: from mail.gmx.net ([213.165.64.20]:35324 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751035AbYLPG0i (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 16 Dec 2008 01:26:38 -0500
Received: (qmail invoked by alias); 16 Dec 2008 06:26:35 -0000
Received: from i577BB567.versanet.de (EHLO atjola.local) [87.123.181.103]
  by mail.gmx.net (mp001) with SMTP; 16 Dec 2008 07:26:35 +0100
X-Authenticated: #5039886
X-Provags-ID: V01U2FsdGVkX18GDA999mAGgHu/9opJhujZ3a85ou21lEKCHIYvo6
	v3YSF+JjmqWgye
Content-Disposition: inline
In-Reply-To: <85647ef50812151015t4d5bc2b8p4ea53a0e4ad25e64@mail.gmail.com>
User-Agent: Mutt/1.5.18 (2008-05-17)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.6899999999999999
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/103251>

On 2008.12.15 21:15:15 +0300, Constantine Plotnikov wrote:
> After this scenario is executed, git branch -a will give the followin=
g output:
>   master
> * origin/master
>   origin/master
>=20
> Note that there is two origin/master entries, but it is not clear
> which is remote is and which is the local. I think that "git branch
> -a" should print unambiguous names, qualifying them if needed.

Actually, it is clear. The one with the * is the local one. The remote
tracking branch will never be marked as checked out, as you would get a
detached HEAD when you do "git checkout remotes/origin/master".

When there are duplicate entries, you can be sure that you have a local
branch head and a remote tracking branch with the same shortname. And
when one of them has been marked as checked out, you can be sure that i=
t
is the local one.

Bj=F6rn
