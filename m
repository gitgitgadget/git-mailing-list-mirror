From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: git-svn: both merged commits and original commits are showing
	up in branches after migration
Date: Mon, 12 Jul 2010 13:24:21 -0500
Message-ID: <20100712182421.GA8644@dert.cs.uchicago.edu>
References: <AANLkTikwyFwO2G1E6rozSxrI4g51wyA8CFV5jl30qRo-@mail.gmail.com> <AANLkTin3TYuC-y2U-o4NEgXH7N4M59vqWxXsa6J2Ae74@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Bradley Wagner <bradley.wagner@hannonhill.com>
X-From: git-owner@vger.kernel.org Mon Jul 12 20:24:34 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OYNg5-0000Zs-Sm
	for gcvg-git-2@lo.gmane.org; Mon, 12 Jul 2010 20:24:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756140Ab0GLSYZ convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 12 Jul 2010 14:24:25 -0400
Received: from camembert.cs.uchicago.edu ([128.135.11.243]:48464 "EHLO
	smtp.cs.uchicago.edu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753258Ab0GLSYY (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 12 Jul 2010 14:24:24 -0400
Received: from dert.cs.uchicago.edu (dert.cs.uchicago.edu [128.135.11.157])
	by smtp.cs.uchicago.edu (Postfix) with ESMTP id C0806A0F1;
	Mon, 12 Jul 2010 13:24:21 -0500 (CDT)
Received: by dert.cs.uchicago.edu (Postfix, from userid 10442)
	id 9511D4E5A; Mon, 12 Jul 2010 13:24:21 -0500 (CDT)
Content-Disposition: inline
In-Reply-To: <AANLkTin3TYuC-y2U-o4NEgXH7N4M59vqWxXsa6J2Ae74@mail.gmail.com>
User-Agent: Mutt/1.5.18 (2008-05-17)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/150835>

Hi Bradley,

Bradley Wagner wrote:
> On Thu, Jul 8, 2010 at 10:58 PM, Bradley Wagner wrote:

>> I've done a migration using "git-svn init" and "git-svn fetch". Afte=
r
>> the migration, I did a "git log refs/remotes/svn/6.7" and found that
>> it listed both the commits that I merged into the 6.7 branch and the
>> original commits to the trunk/master even though the SVN history
>> obviously only has what was merged into that branch.

Yes, this is intentional.  If you try =E2=80=98gitk --all=E2=80=99, you=
 can see
the history of all branches, where they branched from, and so on.

As far as I know the svn:mergeinfo is not actually used until
a merge.  Instead, git-svn uses subversion=E2=80=99s file copy tracking
information to follow history past a branch point; see the
find_parent_branch function in the git-svn script for details.

Hope that helps,
Jonathan
