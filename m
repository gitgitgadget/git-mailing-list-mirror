From: Steffen Prohaska <prohaska@zib.de>
Subject: How to reduce remaining differences to 4msysgit? (was What's cooking in git.git (topics))
Date: Mon, 30 Jun 2008 13:19:57 +0200
Message-ID: <4CE52307-A2DE-488B-998B-76D60B66E804@zib.de>
References: <7vlk4snpj3.fsf@gitster.siamese.dyndns.org> <7vd4pf7h9y.fsf@gitster.siamese.dyndns.org> <7vwsnjl21c.fsf@gitster.siamese.dyndns.org> <7vhcehzdeg.fsf@gitster.siamese.dyndns.org> <7vbq4j748l.fsf@gitster.siamese.dyndns.org> <7vr6d8apjx.fsf@gitster.siamese.dyndns.org> <7vhcdyfe9u.fsf@gitster.siamese.dyndns.org> <7vabjm1a0q.fsf@gitster.siamese.dyndns.org> <7vr6crj0jk.fsf@gitster.siamese.dyndns.org> <7vmyn4hr8f.fsf@gitster.siamese.dyndns.org> <7vmymsjz6x.fsf@gitster.siamese.dyndns.org> <7vabijxhk4.fsf@gitster.siamese.dyndns.org> <7vwslhg8qe.fsf@gitster.siamese.dyndns.org> <7vhccfiksy.fsf@gitster.siamese.dyndns.org> <7vod6k6zg4.fsf@gitster.siamese.dyndns.org> <7v4p7xwsfp.fsf@gitster.siamese.dyndns.org> <7v3anb19n7.fsf@gitster.siamese.dyndns.org> <7vwskjazql.fsf@gitster.siamese.dyndns.o
 rg> <7vk5ggipuw.fsf@gitster.siamese.dyndns.org> <7vej6l3lp7.fsf@gitster.siamese.dyndns.org> <7vod5kd3im.fsf@gitster.siamese.dyndns.org> <7v3amv1e8n.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0 (Apple Message framework v924)
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Content-Transfer-Encoding: 7bit
Cc: Git Mailing List <git@vger.kernel.org>
To: msysGit <msysgit@googlegroups.com>,
	Junio C Hamano <gitster@pobox.com>,
	Johannes Sixt <johannes.sixt@telecom.at>
X-From: git-owner@vger.kernel.org Mon Jun 30 13:21:09 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KDHRS-0007Gj-MH
	for gcvg-git-2@gmane.org; Mon, 30 Jun 2008 13:21:07 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756717AbYF3LUK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 30 Jun 2008 07:20:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756536AbYF3LUJ
	(ORCPT <rfc822;git-outgoing>); Mon, 30 Jun 2008 07:20:09 -0400
Received: from mailer.zib.de ([130.73.108.11]:63761 "EHLO mailer.zib.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752856AbYF3LUI (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 30 Jun 2008 07:20:08 -0400
Received: from mailsrv2.zib.de (sc2.zib.de [130.73.108.31])
	by mailer.zib.de (8.13.7+Sun/8.13.7) with ESMTP id m5UBJYNR017296;
	Mon, 30 Jun 2008 13:19:39 +0200 (CEST)
Received: from [192.168.178.21] (brln-4db83f6c.pool.einsundeins.de [77.184.63.108])
	(authenticated bits=0)
	by mailsrv2.zib.de (8.13.4/8.13.4) with ESMTP id m5UBJXMK009699
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=NO);
	Mon, 30 Jun 2008 13:19:33 +0200 (MEST)
In-Reply-To: <7v3amv1e8n.fsf@gitster.siamese.dyndns.org>
X-Mailer: Apple Mail (2.924)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/86905>


On Jun 30, 2008, at 11:08 AM, Junio C Hamano wrote:

> * MinGW will be in.


If this is done, we should be able to create the msysgit release  
directly
from Junio's master.  Hannes changes alone, however, are not sufficient,
because some commits have been parked in 4msysgit.  Now that MinGW is
on Junio's next and Junio's next is also on 4msysgit's next, it it easy
to see how much is left to do by running:

    git diff --stat junio/next..4msysgit/next

junio is a remote pointing to git://git.kernel.org/pub/scm/git/git.git.
4msysgit is a remote pointing to git://repo.or.cz/git/mingw/ 
4msysgit.git.
I attached the output below.

How should we proceed to get rid of the differences?

Should we prepare and send patches directly to the official git list  
now?
Should we wait until the first MinGW branch is on master?
Should we prepare a whole patch series?  Maybe Hannes would maintain  
this
patch series.

I have not yet looked at the remaining differences in detail.  I expect
most of them to be trivial.  But some might require discussion on the
list, so at some point we should send the patches to the official list.

	Steffen


$ git diff --stat junio/next..4msysgit/next
  Makefile                               |   23 ++-
  README.MinGW                           |   77 ++++++++
  RelNotes                               |    1 -
  builtin-fetch-pack.c                   |    3 +-
  builtin-tag.c                          |   14 ++
  builtin-verify-tag.c                   |    2 +
  cache.h                                |    2 +
  check-builtins.sh                      |    2 +-
  compat/mingw.c                         |    4 +-
  compat/winansi.c                       |  309 +++++++++++++++++++++++ 
+++++++++
  connect.c                              |    5 +-
  convert.c                              |    4 +
  fast-import.c                          |    2 +
  git-add--interactive.perl              |    2 +-
  git-compat-util.h                      |    7 +
  git-parse-remote.sh                    |    3 +-
  gitk-git/Makefile                      |    4 +
  gitk-git/gitk                          |    2 +
  help.c                                 |   30 +++-
  path.c                                 |   13 ++
  read-cache.c                           |    5 +
  setup.c                                |    7 +-
  t/t0000-basic.sh                       |   31 +++-
  t/t0001-init.sh                        |    2 +-
  t/t0004-unwritable.sh                  |    7 +
  t/t1002-read-tree-m-u-2way.sh          |    6 +
  t/t1003-read-tree-prefix.sh            |    4 +
  t/t1004-read-tree-m-u-wf.sh            |    2 +
  t/t1300-repo-config.sh                 |    1 +
  t/t1301-shared-repo.sh                 |    4 +
  t/t2001-checkout-cache-clash.sh        |    2 +
  t/t2003-checkout-cache-mkdir.sh        |    4 +
  t/t2004-checkout-cache-temp.sh         |    2 +
  t/t2007-checkout-symlink.sh            |    7 +
  t/t2100-update-cache-badpath.sh        |    2 +
  t/t2201-add-update-typechange.sh       |   11 +-
  t/t3000-ls-files-others.sh             |    1 +
  t/t3010-ls-files-killed-modified.sh    |    7 +
  t/t3100-ls-tree-restrict.sh            |   12 ++
  t/t3200-branch.sh                      |    2 +
  t/t3700-add.sh                         |   10 +
  t/t3901-i18n-patch.sh                  |    4 +
  t/t3903-stash.sh                       |   12 +-
  t/t4004-diff-rename-symlink.sh         |    7 +
  t/t4008-diff-break-rewrite.sh          |    4 +
  t/t4011-diff-symlink.sh                |    7 +
  t/t4023-diff-rename-typechange.sh      |    5 +
  t/t4109-apply-multifrag.sh             |    4 +
  t/t4110-apply-scan.sh                  |    4 +
  t/t4114-apply-typechange.sh            |    5 +
  t/t4115-apply-symlink.sh               |    7 +
  t/t4116-apply-reverse.sh               |    3 +-
  t/t4122-apply-symlink-inside.sh        |    7 +
  t/t4150-am.sh                          |    6 +-
  t/t5000-tar-tree.sh                    |    7 +
  t/t5300-pack-object.sh                 |   62 +++----
  t/t5502-quickfetch.sh                  |    3 +
  t/t5503-tagfollow.sh                   |   25 +++-
  t/t5505-remote.sh                      |    3 +
  t/t5511-refspec.sh                     |   11 +-
  t/t5512-ls-remote.sh                   |    3 +
  t/t5520-pull.sh                        |    1 +
  t/t5530-upload-pack-error.sh           |    1 +
  t/t7004-tag.sh                         |    5 +-
  t/t7005-editor.sh                      |    1 +
  t/t7201-co.sh                          |    6 +-
  t/t7401-submodule-summary.sh           |   30 ++--
  t/t7501-commit.sh                      |    1 +
  t/t7502-status.sh                      |    4 +
  t/t7503-pre-commit-hook.sh             |    6 +
  t/t7504-commit-msg-hook.sh             |    6 +
  t/t9001-send-email.sh                  |    4 +
  t/t9200-git-cvsexportcommit.sh         |    4 +
  t/t9500-gitweb-standalone-no-errors.sh |    3 +
  t/test-lib.sh                          |   17 ++
  templates/Makefile                     |    3 +
  utf8.c                                 |    7 +
  utf8.h                                 |    4 -
  78 files changed, 844 insertions(+), 86 deletions(-)
