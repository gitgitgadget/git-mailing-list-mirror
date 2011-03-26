From: Seth Robertson <in-gitvger@baka.org>
Subject: ANNOUNCE gitslave-2.0.1
Date: Sat, 26 Mar 2011 11:18:25 -0400
Message-ID: <201103261518.p2QFIPLJ020427@no.baka.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Mar 26 16:18:51 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Q3VGL-0002UN-HT
	for gcvg-git-2@lo.gmane.org; Sat, 26 Mar 2011 16:18:49 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752212Ab1CZPS3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 26 Mar 2011 11:18:29 -0400
X-Warning: Original message contained 8-bit characters, however during
	   the SMTP transport session the receiving system did not announce
	   capability of receiving 8-bit SMTP (RFC 1651-1653), and as this
	   message does not have MIME headers (RFC 2045-2049) to enable
	   encoding change, we had very little choice.
X-Warning: We ASSUME it is less harmful to add the MIME headers, and
	   convert the text to Quoted-Printable, than not to do so,
	   and to strip the message to 7-bits.. (RFC 1428 Appendix A)
X-Warning: We don't know what character set the user used, thus we had to
	   write these MIME-headers with our local system default value.
Received: from tsutomu.baka.org ([66.114.72.182]:33878 "EHLO tsutomu.baka.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751752Ab1CZPS2 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 26 Mar 2011 11:18:28 -0400
Received: from no.baka.org (no.baka.org [IPv6:2001:470:88bb::2])
	by tsutomu.baka.org (8.14.4/8.14.4) with ESMTP id p2QFIR91002373
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT)
	for <git@vger.kernel.org>; Sat, 26 Mar 2011 11:18:27 -0400
Received: from no.baka.org (localhost [127.0.0.1])
	by no.baka.org (8.14.4/8.14.0) with ESMTP id p2QFIPLJ020427
	for <git@vger.kernel.org>; Sat, 26 Mar 2011 11:18:26 -0400
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/170055>


Gitslave http://gitslave.sf.net creates a group of related
repositories=E2=80=94a superproject repository and a number of slave
repositories=E2=80=94all of which are concurrently developed on and on =
which
all git operations should normally operate; so when you branch, each
repository in the project is branched in turn. Similarly when you
commit, push, pull, merge, tag, checkout, status, log, etc; each git
command will run on the superproject and all slave repositories in
turn. This sort of activity may be very familiar to CVS and (to a
lesser extent) Subversion users. Gitslave's design is for simplicity
for normal git operations.

Gitslave is an alternative to git-submodules: easier to use and better
for some (but not all) workflows.

When you have a problem which calls for easy multirepository
management without lots of synchronization, where you typically might
want to run the same git command over every repository in your
project, gitslave is the solution for you.

Release note highlights since last announcement, see release notes at
http://gitslave.sf.net for more details.
----------------------------------------------------------------------
* Now supports git+ssh:// and host:repo style GRLs

Traditionally gitslave has only supported /path/to/repo and URL
(ssh://host/path/to/repo) style Git Resource Locators.  Gitslave has
now been taught about the alternate reference styles.


* gits now has pager support

gits will use less, $PAGER, and $GIT_PAGER hopefully similar to how
native git uses pagers for output.


* gits will not clean directories with .git in them

Replicating recent git functionality, `gits clean -dfx` will not
destroy repositories.  This helps the situation where different
branches have different slave modules attached.


* Recursive subprojects

With the use of `gits attach --recursive=3D.gitslave URL DIRECTORY`
gitslave now fully support recursive subprojects (or slaves which are
themselves gitslave masters of yet more slaves).


* gitslave tutorial created

A tutorial was created which walks the reader through a from-scratch
repository creation using the most popular and needed git commands in
the multi-repository gitslave environment.  The tutorial and overall
gitslave website is now stored as part of gitslave.


* gits pulls more efficient and safer.

Gits pulls perform a pull on all available local branches.  This now sh=
ould
perform only one fetch (in most cases).  Also --rebase is safer by
using --preserve-merges (in most cases).


* gits now implements paginated output by default, just like git

Pagination is only enabled if standard output is a tty (and there is a
controlling tty for the pager to take input from).  If you do not want
paginated output, the -n or --no-pager option disables it.  All the git
pager configuration settings (GIT_PAGER and PAGER environment variables=
,
and core.pager configuration setting) are honored.


* gits populate can now request population of specific ifpresent module=
s

* gits clone now supported for easy project cloning

* gits detach now supported for easier project maintenance
----------------------------------------------------------------------

					-Seth Robertson
