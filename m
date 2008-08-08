From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] tests: use $TEST_DIRECTORY to refer to the t/
 directory
Date: Fri, 8 Aug 2008 12:35:12 +0200 (CEST)
Message-ID: <alpine.DEB.1.00.0808081232210.9611@pacific.mpi-cbg.de.mpi-cbg.de>
References: <alpine.DEB.1.00.0808080752210.9611@pacific.mpi-cbg.de.mpi-cbg.de> <alpine.DEB.1.00.0808080754230.9611@pacific.mpi-cbg.de.mpi-cbg.de> <489BF95F.1070000@lsrfire.ath.cx> <7vprojgbbu.fsf@gitster.siamese.dyndns.org>
 <7vod43etuw.fsf_-_@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: =?ISO-8859-15?Q?Ren=E9_Scharfe?= <rene.scharfe@lsrfire.ath.cx>,
	git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Aug 08 12:31:49 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KRPG4-0003ej-6M
	for gcvg-git-2@gmane.org; Fri, 08 Aug 2008 12:31:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753881AbYHHKaj (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 8 Aug 2008 06:30:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753891AbYHHKaj
	(ORCPT <rfc822;git-outgoing>); Fri, 8 Aug 2008 06:30:39 -0400
Received: from mail.gmx.net ([213.165.64.20]:52867 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1753419AbYHHKai (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 8 Aug 2008 06:30:38 -0400
Received: (qmail invoked by alias); 08 Aug 2008 10:30:37 -0000
Received: from pacific.mpi-cbg.de (EHLO pacific.mpi-cbg.de) [141.5.10.38]
  by mail.gmx.net (mp034) with SMTP; 08 Aug 2008 12:30:37 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1+4NvhNUIq46ur7JyDW25kK+uMif08TAilGDCqBLM
	Mbodu3HXtFZwTh
X-X-Sender: schindelin@pacific.mpi-cbg.de.mpi-cbg.de
In-Reply-To: <7vod43etuw.fsf_-_@gitster.siamese.dyndns.org>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.55
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/91649>

Hi,

On Fri, 8 Aug 2008, Junio C Hamano wrote:

> |  # Test repository
> | -test="trash directory"
> | +test="trash directory/another level/yet another"

Oh my.  If you continue like that, we are soon going to hit PATH_MAX on 
some systems (*cough* Windows *cough*), badly.

>  t/t0022-crlf-rename.sh                   |    4 ++--
>  t/t1000-read-tree-m-3way.sh              |    2 +-
>  t/t3900-i18n-commit.sh                   |   18 +++++++++---------
>  t/t3901-i18n-patch.sh                    |   28 ++++++++++++++--------------
>  t/t4000-diff-format.sh                   |    2 +-
>  t/t4001-diff-rename.sh                   |    2 +-
>  t/t4002-diff-basic.sh                    |    2 +-
>  t/t4003-diff-rename-1.sh                 |    6 +++---
>  t/t4004-diff-rename-symlink.sh           |    2 +-
>  t/t4005-diff-rename-2.sh                 |    6 +++---
>  t/t4007-rename-3.sh                      |    4 ++--
>  t/t4008-diff-break-rewrite.sh            |    6 +++---
>  t/t4009-diff-rename-4.sh                 |    6 +++---
>  t/t4010-diff-pathspec.sh                 |    2 +-
>  t/t4011-diff-symlink.sh                  |    2 +-
>  t/t4012-diff-binary.sh                   |    2 +-
>  t/t4013-diff-various.sh                  |    2 +-
>  t/t4015-diff-whitespace.sh               |    2 +-
>  t/t4020-diff-external.sh                 |    2 +-
>  t/t4022-diff-rewrite.sh                  |    4 ++--
>  t/t4023-diff-rename-typechange.sh        |   14 +++++++-------
>  t/t4027-diff-submodule.sh                |    2 +-
>  t/t4100-apply-stat.sh                    |    4 ++--
>  t/t4101-apply-nonl.sh                    |    2 +-
>  t/t5100-mailinfo.sh                      |   18 +++++++++---------
>  t/t5515-fetch-merge-logic.sh             |    4 ++--
>  t/t5540-http-push.sh                     |    2 +-
>  t/t6002-rev-list-bisect.sh               |    2 +-
>  t/t6003-rev-list-topo-order.sh           |    2 +-
>  t/t6023-merge-file.sh                    |    2 +-
>  t/t6027-merge-binary.sh                  |    2 +-
>  t/t6101-rev-parse-parents.sh             |    2 +-
>  t/t6200-fmt-merge-msg.sh                 |    4 ++--
>  t/t7001-mv.sh                            |    4 ++--
>  t/t7004-tag.sh                           |    2 +-
>  t/t7101-reset.sh                         |   10 +++++-----
>  t/t7500-commit.sh                        |   16 ++++++++--------
>  t/t8001-annotate.sh                      |    2 +-
>  t/t8002-blame.sh                         |    2 +-
>  t/t9110-git-svn-use-svm-props.sh         |    2 +-
>  t/t9111-git-svn-use-svnsync-props.sh     |    2 +-
>  t/t9115-git-svn-dcommit-funky-renames.sh |    2 +-
>  t/t9121-git-svn-fetch-renamed-dir.sh     |    2 +-
>  t/t9200-git-cvsexportcommit.sh           |   14 +++++++-------
>  t/t9300-fast-import.sh                   |    2 +-
>  t/t9301-fast-export.sh                   |    2 +-
>  t/t9500-gitweb-standalone-no-errors.sh   |   16 ++++++++--------
>  t/t9700-perl-git.sh                      |    2 +-
>  t/t9700/test.pl                          |    3 ---
>  t/test-lib.sh                            |    2 +-
>  50 files changed, 123 insertions(+), 126 deletions(-)

Frankly, I do not have the time.  It is not only about looking what you 
changed, but also what you did not change.

Besides, I do not see the point.  "clean" can just as well

	$(RM) -r 'trash directory.t'[0-9]*

Ciao,
Dscho
