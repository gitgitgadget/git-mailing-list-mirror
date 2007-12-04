From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: Building git-1.5.3.7 on HP-UX 11.00
Date: Tue, 4 Dec 2007 15:39:47 +0000 (GMT)
Message-ID: <Pine.LNX.4.64.0712041536180.27959@racer.site>
References: <20071204130922.731c407a@pc09.procura.nl>
 <Pine.LNX.4.64.0712041343040.27959@racer.site> <20071204140326.14d9e7a0@pc09.procura.nl>
 <Pine.LNX.4.64.0712041439590.27959@racer.site> <20071204150102.7f3ec3e9@pc09.procura.nl>
 <47556EE2.6040105@op5.se> <20071204152240.6cb6018e@pc09.procura.nl>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Andreas Ericsson <ae@op5.se>, git@vger.kernel.org,
	Sam Vilain <sam@vilain.net>
To: "H.Merijn Brand" <h.m.brand@xs4all.nl>
X-From: git-owner@vger.kernel.org Tue Dec 04 16:40:45 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IzZsw-00066K-SD
	for gcvg-git-2@gmane.org; Tue, 04 Dec 2007 16:40:35 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753785AbXLDPkQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 4 Dec 2007 10:40:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753836AbXLDPkP
	(ORCPT <rfc822;git-outgoing>); Tue, 4 Dec 2007 10:40:15 -0500
Received: from mail.gmx.net ([213.165.64.20]:46149 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1753284AbXLDPkN (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 4 Dec 2007 10:40:13 -0500
Received: (qmail invoked by alias); 04 Dec 2007 15:40:11 -0000
Received: from unknown (EHLO [138.251.11.74]) [138.251.11.74]
  by mail.gmx.net (mp033) with SMTP; 04 Dec 2007 16:40:11 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX18vK/tVtpovZ6FF4iF0Gvkt0wgRfW0kiIvvmazNED
	N4+ZJ8Ep1PJ+1v
X-X-Sender: gene099@racer.site
In-Reply-To: <20071204152240.6cb6018e@pc09.procura.nl>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/67057>

Hi,

On Tue, 4 Dec 2007, H.Merijn Brand wrote:

> + + pwd
> GIT_EXEC_PATH=/pro/3gl/LINUX/git-1.5.3.7/t/..
> + + pwd
> GIT_TEMPLATE_DIR=/pro/3gl/LINUX/git-1.5.3.7/t/../templates/blt
> + GIT_CONFIG=.git/config
> + export PATH GIT_EXEC_PATH GIT_TEMPLATE_DIR GIT_CONFIG
> + + pwd
> + pwd
> GITPERLLIB=/pro/3gl/LINUX/git-1.5.3.7/t/../perl/blib/lib:/pro/3gl/LINUX/git-1.5.3.7/t/../perl/blib/arch/auto/Git
> + export GITPERLLIB
> + test -d ../templates/blt
> + test -x ../test-chmtime
> + test=trash
> + rm -fr trash
> + test_create_repo trash
> + cd trash
> + + expr ./t0001-init.sh : .*/\(t[0-9]*\)-[^/]*$
> this_test=t0001
> + test_expect_success plain
>         (
>                 unset GIT_DIR GIT_WORK_TREE &&
>                 mkdir plain &&
>                 cd plain &&
>                 git init
>         ) &&
>         check_config plain/.git false unset
> 
> * expecting success:
>         (
>                 unset GIT_DIR GIT_WORK_TREE &&
>                 mkdir plain &&
>                 cd plain &&
>                 git init
>         ) &&
>         check_config plain/.git false unset
> 
> * FAIL 1: plain
> 
>                 (
>                         unset GIT_DIR GIT_WORK_TREE &&
>                         mkdir plain &&
>                         cd plain &&
>                         git init
>                 ) &&
>                 check_config plain/.git false unset

That's not good.  The relevant part here reads:

-- snip --
+ test_description='git init'
+ . ./test-lib.sh
++ LANG=C
++ LC_ALL=C
++ PAGER=cat
++ TZ=UTC
++ export LANG LC_ALL PAGER TZ
++ EDITOR=:
++ VISUAL=:
++ unset GIT_EDITOR
++ unset AUTHOR_DATE
++ unset AUTHOR_EMAIL
++ unset AUTHOR_NAME
++ unset COMMIT_AUTHOR_EMAIL
++ unset COMMIT_AUTHOR_NAME
++ unset EMAIL
++ unset GIT_ALTERNATE_OBJECT_DIRECTORIES
++ unset GIT_AUTHOR_DATE
++ GIT_AUTHOR_EMAIL=author@example.com
++ GIT_AUTHOR_NAME='A U Thor'
++ unset GIT_COMMITTER_DATE
++ GIT_COMMITTER_EMAIL=committer@example.com
++ GIT_COMMITTER_NAME='C O Mitter'
++ unset GIT_DIFF_OPTS
++ unset GIT_DIR
++ unset GIT_WORK_TREE
++ unset GIT_EXTERNAL_DIFF
++ unset GIT_INDEX_FILE
++ unset GIT_OBJECT_DIRECTORY
++ unset SHA1_FILE_DIRECTORIES
++ unset SHA1_FILE_DIRECTORY
++ GIT_MERGE_VERBOSITY=5
++ export GIT_MERGE_VERBOSITY
++ export GIT_AUTHOR_EMAIL GIT_AUTHOR_NAME
++ export GIT_COMMITTER_EMAIL GIT_COMMITTER_NAME
++ export EDITOR VISUAL
++ unset CDPATH
++ case $(echo $GIT_TRACE |tr "[A-Z]" "[a-z]") in
+++ echo
+++ tr '[A-Z]' '[a-z]'
++ '[' xxterm '!=' xdumb ']'
++ '[' -t 1 ']'
++ test 2 -ne 0
++ case "$1" in
++ immediate=t
++ shift
++ test 1 -ne 0
++ case "$1" in
++ verbose=t
++ shift
++ test 0 -ne 0
++ test -n ''
++ test 'git init' '!=' ''
++ test '' = t
++ exec
++ test t = t
++ exec
++ test_failure=0
++ test_count=0
++ trap 'echo >&5 "FATAL: Unexpected exit with code $?"; exit 1' exit
+++ pwd
++ PATH=/home/gitte/my/git/t/..:/home/gene099/bin:/usr/local/bin:/usr/bin:/usr/X11R6/bin:/bin:/usr/games:/opt/gnome/bin:/opt/kde3/bin:/usr/lib/mit/bin:/usr/lib/mit/sbin:/usr/lib/qt3/bin
+++ pwd
++ GIT_EXEC_PATH=/home/gitte/my/git/t/..
+++ pwd
++ GIT_TEMPLATE_DIR=/home/gitte/my/git/t/../templates/blt
++ GIT_CONFIG=.git/config
++ export PATH GIT_EXEC_PATH GIT_TEMPLATE_DIR GIT_CONFIG
+++ pwd
+++ pwd
++ GITPERLLIB=/home/gitte/my/git/t/../perl/blib/lib:/home/gene099/my/git/t/../perl/blib/arch/auto/Git
++ export GITPERLLIB
++ test -d ../templates/blt
++ test -x ../test-chmtime
++ test=trash
++ rm -fr trash
++ test_create_repo trash
++ test 1 = 1
+++ pwd
++ owd=/home/gitte/my/git/t
++ repo=trash
++ mkdir trash
++ cd trash
++ /home/gitte/my/git/t/../git init --template=/home/gene099/my/git/t/../templates/blt/
++ mv .git/hooks .git/hooks-disabled
++ cd /home/gitte/my/git/t
++ cd trash
+++ expr ./t0001-init.sh : '.*/\(t[0-9]*\)-[^/]*$'
++ this_test=t0001
+ test_expect_success plain '
	(
		unset GIT_DIR GIT_WORK_TREE &&
		mkdir plain &&
		cd plain &&
		git init
	) &&
	check_config plain/.git false unset
'
+ test 2 = 2
+ test_skip plain '
	(
		unset GIT_DIR GIT_WORK_TREE &&
		mkdir plain &&
		cd plain &&
		git init
	) &&
	check_config plain/.git false unset
'
-- snap --

So I get way more information.  Which let's me suspect that your shell 
might be the culprit?  Can you try with bash?

Ciao,
Dscho
