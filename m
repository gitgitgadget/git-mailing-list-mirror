From: Andreas Stricker <astricker@futurelab.ch>
Subject: Re: Fwd: Error with git-svn pushing a rename
Date: Sun, 17 Nov 2013 23:55:13 +0100
Organization: FutureLAB
Message-ID: <52894951.7000303@futurelab.ch>
References: <CAM-uYMgy8duxdGY8rbCJv9To3FFMAUDv22nnzbQ+e3QrTCLLpQ@mail.gmail.com> <CAM-uYMigCTK=j3HkyT0F=jtDoDERdtkpZiTXRvBhSHJW3edJ-w@mail.gmail.com> <CAM-uYMiK4wkQyGJLemSAbNwHJNoH-k8Zv0W2yBtnTCbsFLj8Fg@mail.gmail.com> <5285CE6C.2030609@futurelab.ch> <CAM-uYMgn4SGqurqRG-RDiicLxpf9NfTPUvNn9FaFUUbxFRJsZw@mail.gmail.com> <5286235D.9060602@futurelab.ch> <20131115225316.GF27781@google.com>
Mime-Version: 1.0
Content-Type: multipart/mixed;
 boundary="------------060006040608040702040102"
Cc: Benjamin Pabst <benjamin.pabst85@gmail.com>, git@vger.kernel.org
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Sun Nov 17 23:55:25 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ViBFU-0004VV-D4
	for gcvg-git-2@plane.gmane.org; Sun, 17 Nov 2013 23:55:25 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751791Ab3KQWzU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 17 Nov 2013 17:55:20 -0500
Received: from host-179.futurelab.ch ([62.2.169.179]:53685 "EHLO
	primus.futurelab.ch" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751267Ab3KQWzS (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 17 Nov 2013 17:55:18 -0500
Received: from astricker.futurelab.ch (localhost.localdomain [127.0.0.1])
	(authenticated bits=0)
	by primus.futurelab.ch (8.13.8/8.13.8/fL-3.7) with ESMTP id rAHMtDra018054;
	Sun, 17 Nov 2013 23:55:14 +0100
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.7; rv:24.0) Gecko/20100101 Thunderbird/24.1.0
In-Reply-To: <20131115225316.GF27781@google.com>
X-Enigmail-Version: 1.6
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/237963>

This is a multi-part message in MIME format.
--------------060006040608040702040102
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

Hi Jonathan

> Can you give an exact sequence of steps (including "Upgrade Subversion
> at this step") to reproduce the problem?  That would help immensely
> --- if at all possible, I would very much like to keep existing
> git-svn repos working on upgrade.

Of course. I've attached a text file with the commands required to
reproduce this error.

>From my experiments it looks like after the subversion is upgraded
to 1.8 the problem only occurs if "git svn fetch" fetches new changes
from the subversion repository. Without changes in upstream subversion
repository I couldn't reproduce the error. And a rename is required too.

Hope this helps.

Regards, Andy

--------------060006040608040702040102
Content-Type: text/plain; charset=UTF-8;
 name="gitsvnplay.txt"
Content-Transfer-Encoding: 8bit
Content-Disposition: attachment;
 filename="gitsvnplay.txt"

andy@m:r $ git
-bash: /opt/local/bin/git: No such file or directory
andy@m:r $ svn
-bash: /opt/local/bin/svn: No such file or directory
andy@m:r $ sudo port install subversion--->  Computing dependencies for subversion
--->  Fetching archive for subversion
--->  Attempting to fetch subversion-1.7.10_1.darwin_11.x86_64.tbz2 from http://lil.fr.packages.macports.org/subversion
--->  Attempting to fetch subversion-1.7.10_1.darwin_11.x86_64.tbz2.rmd160 from http://lil.fr.packages.macports.org/subversion
--->  Installing subversion @1.7.10_1
--->  Activating subversion @1.7.10_1
--->  Cleaning subversion
--->  Updating database of binaries: 100.0%
--->  Scanning binaries for linking errors: 100.0%
--->  Found 15 broken file(s), matching files to ports
--->  Found 1 broken port(s), determining rebuild order
--->  Rebuilding in order
     subversion @1.7.10 
--->  Computing dependencies for subversion
--->  Cleaning subversion
--->  Scanning binaries for linking errors: 100.0%
--->  Found 15 broken file(s), matching files to ports
--->  Found 1 broken port(s), determining rebuild order
--->  Rebuilding in order
     subversion @1.7.10 
--->  Computing dependencies for subversion
--->  Fetching distfiles for subversion
--->  Verifying checksums for subversion
--->  Extracting subversion
--->  Applying patches to subversion
--->  Configuring subversion
--->  Building subversion
--->  Staging subversion into destroot
--->  Deactivating subversion @1.7.10_1
--->  Cleaning subversion
--->  Uninstalling subversion @1.7.10_1
--->  Cleaning subversion
--->  Computing dependencies for subversion
--->  Installing subversion @1.7.10_1
--->  Activating subversion @1.7.10_1
--->  Cleaning subversion
--->  Updating database of binaries: 100.0%
--->  Scanning binaries for linking errors: 100.0%
--->  No broken files found.
andy@m:r $ sudo port install git-core +bash_completion +credential_osxkeychain +doc +pcre +python27 +svn
Password:
--->  Computing dependencies for git-core
--->  Dependencies to be installed: p5.12-svn-simple subversion-perlbindings-5.12
--->  Fetching archive for subversion-perlbindings-5.12
--->  Attempting to fetch subversion-perlbindings-5.12-1.7.10_0.darwin_11.x86_64.tbz2 from http://lil.fr.packages.macports.org/subversion-perlbindings-5.12
--->  Attempting to fetch subversion-perlbindings-5.12-1.7.10_0.darwin_11.x86_64.tbz2.rmd160 from http://lil.fr.packages.macports.org/subversion-perlbindings-5.12
--->  Installing subversion-perlbindings-5.12 @1.7.10_0
--->  Activating subversion-perlbindings-5.12 @1.7.10_0
--->  Cleaning subversion-perlbindings-5.12
--->  Fetching archive for p5.12-svn-simple
--->  Attempting to fetch p5.12-svn-simple-0.280.0_4.darwin_11.noarch.tbz2 from http://lil.fr.packages.macports.org/p5.12-svn-simple
--->  Attempting to fetch p5.12-svn-simple-0.280.0_4.darwin_11.noarch.tbz2.rmd160 from http://lil.fr.packages.macports.org/p5.12-svn-simple
--->  Installing p5.12-svn-simple @0.280.0_4
--->  Activating p5.12-svn-simple @0.280.0_4
--->  Cleaning p5.12-svn-simple
--->  Fetching archive for git-core
--->  Attempting to fetch git-core-1.8.4.2_0+bash_completion+credential_osxkeychain+doc+pcre+python27+svn.darwin_11.x86_64.tbz2 from http://lil.fr.packages.macports.org/git-core
--->  Attempting to fetch git-core-1.8.4.2_0+bash_completion+credential_osxkeychain+doc+pcre+python27+svn.darwin_11.x86_64.tbz2 from http://mse.uk.packages.macports.org/sites/packages.macports.org/git-core
--->  Attempting to fetch git-core-1.8.4.2_0+bash_completion+credential_osxkeychain+doc+pcre+python27+svn.darwin_11.x86_64.tbz2 from http://packages.macports.org/git-core
--->  Fetching distfiles for git-core
--->  Verifying checksums for git-core
--->  Extracting git-core
--->  Applying patches to git-core
--->  Configuring git-core
--->  Building git-core
--->  Staging git-core into destroot
--->  Installing git-core @1.8.4.2_0+bash_completion+credential_osxkeychain+doc+pcre+python27+svn
--->  Activating git-core @1.8.4.2_0+bash_completion+credential_osxkeychain+doc+pcre+python27+svn
--->  Cleaning git-core
--->  Updating database of binaries: 100.0%
--->  Scanning binaries for linking errors: 100.0%
--->  No broken files found.
andy@m:r $ git version
git version 1.8.4.2
andy@m:r $ svn --version |head -n2svn, Version 1.7.10 (r1485443)
   übersetzt Nov 17 2013, 22:58:41
andy@m:r $ svnadmin create svnrepo
andy@m:r $ svn checkout file://$PWD/svnrepo svnwork
Ausgecheckt, Revision 0.
andy@m:r $ cd svnwork/
andy@m:svnwork $ echo 'original content' > content.txt
andy@m:svnwork $ git add content.txt 
fatal: Not a git repository (or any of the parent directories): .git
andy@m:svnwork $ svn add content.txt 
A         content.txt
andy@m:svnwork $ svn commit -m 'initial commit'
Hinzufügen     content.txt
Übertrage Daten .
Revision 1 übertragen.
andy@m:svnwork $ cd ..
andy@m:r $ git svn clone file://$PWD/svnrepo gitwork
Initialisierte leeres Git-Repository in /private/tmp/r/gitwork/.git/
	A	content.txt
r1 = e27a31ad2100f7080dcb2c63eaf8bc7b74130bd5 (refs/remotes/git-svn)
Checked out HEAD:
  file:///tmp/r/svnrepo r1
andy@m:r $ cd gitwork/
andy@m:gitwork (master) $ echo 'another line' >> content.txt 
andy@m:gitwork (master) $ echo 'new file' > newfile.txt
andy@m:gitwork (master) $ git add content.txt newfile.txt 
andy@m:gitwork (master) $ git commit -m 'changed content'
[master cd1a8ee] changed content
 2 files changed, 2 insertions(+)
 create mode 100644 newfile.txt
andy@m:gitwork (master) $ git svn dcommit
Committing to file:///tmp/r/svnrepo ...
	A	newfile.txt
	M	content.txt
Committed r2
	A	newfile.txt
	M	content.txt
r2 = 4bc308cdb2684887844e8dde973c9aa26b80e2ca (refs/remotes/git-svn)
No changes between cd1a8eeeba8cc2cd4f452eba922a09780658e096 and refs/remotes/git-svn
Resetting to the latest refs/remotes/git-svn
andy@m:gitwork (master) $ echo 'switch subversion 1.7 in local port repo off'
switch subversion 1.7 in local port repo off
andy@m:gitwork (master) $ sudo port -v upgrade subversion subversion-perlbindings-5.12
Password:
--->  Computing dependencies for subversion.
--->  Fetching archive for subversion
--->  subversion-1.8.4_1.darwin_11.x86_64.tbz2 doesn't seem to exist in /opt/local/var/macports/incoming/verified
--->  Attempting to fetch subversion-1.8.4_1.darwin_11.x86_64.tbz2 from http://lil.fr.packages.macports.org/subversion
--->  Attempting to fetch subversion-1.8.4_1.darwin_11.x86_64.tbz2.rmd160 from http://lil.fr.packages.macports.org/subversion
--->  Installing subversion @1.8.4_1
--->  Cleaning subversion
--->  Removing work directory for subversion
--->  Computing dependencies for subversion.
--->  Deactivating subversion @1.7.10_1
--->  Cleaning subversion
--->  Removing work directory for subversion
--->  Activating subversion @1.8.4_1
--->  Cleaning subversion
--->  Removing work directory for subversion
--->  Computing dependencies for subversion-perlbindings-5.12.
--->  Fetching archive for subversion-perlbindings-5.12
--->  subversion-perlbindings-5.12-1.8.4_0.darwin_11.x86_64.tbz2 doesn't seem to exist in /opt/local/var/macports/incoming/verified
--->  Attempting to fetch subversion-perlbindings-5.12-1.8.4_0.darwin_11.x86_64.tbz2 from http://lil.fr.packages.macports.org/subversion-perlbindings-5.12
--->  Attempting to fetch subversion-perlbindings-5.12-1.8.4_0.darwin_11.x86_64.tbz2.rmd160 from http://lil.fr.packages.macports.org/subversion-perlbindings-5.12
--->  Installing subversion-perlbindings-5.12 @1.8.4_0
--->  Cleaning subversion-perlbindings-5.12
--->  Removing work directory for subversion-perlbindings-5.12
--->  Computing dependencies for subversion-perlbindings-5.12.
--->  Deactivating subversion-perlbindings-5.12 @1.7.10_0
--->  Cleaning subversion-perlbindings-5.12
--->  Removing work directory for subversion-perlbindings-5.12
--->  Activating subversion-perlbindings-5.12 @1.8.4_0
--->  Cleaning subversion-perlbindings-5.12
--->  Removing work directory for subversion-perlbindings-5.12
--->  Updating database of binaries: 100.0%
--->  Scanning binaries for linking errors: 100.0%
--->  No broken files found.
andy@m:gitwork (master) $ git version
git version 1.8.4.2
andy@m:gitwork (master) $ svn --version |head -n2
svn, Version 1.8.4 (r1534716)
   übersetzt am Nov  1 2013, um 14:41:52 auf x86_64-apple-darwin11.4.2
andy@m:gitwork (master) $ cd ../svnwork/
andy@m:svnwork $ svn up
svn: E155036: Siehe Kommando »svn upgrade«
svn: E155036: Die Arbeitskopie in »/private/tmp/r/svnwork«
ist zu alt (Format 29) für die Verwendung mit der Version »1.8.4 (r1534716)« (erwartet Format 31). Sie müssen die Arbeitskopie zuerst in ein neues Format bringen.

andy@m:svnwork $ svn upgrade
In neues Format gebracht: ».«
andy@m:svnwork $ svn up
Aktualisiere ».«:
U    content.txt
A    newfile.txt
Aktualisiert zu Revision 2.
andy@m:svnwork $ cd ../gitwork/
andy@m:gitwork (master) $ git svn fetch
andy@m:gitwork (master) $ echo 'yet another line' >> content.txt 
andy@m:gitwork (master) $ git mv newfile.txt somefile.txt
andy@m:gitwork (master) $ git add content.txt 
andy@m:gitwork (master) $ git commit -m 'changed content, moved file'
[master c92f414] changed content, moved file
 2 files changed, 1 insertion(+)
 rename newfile.txt => somefile.txt (100%)
andy@m:gitwork (master) $ git svn dcommit
Committing to file:///tmp/r/svnrepo ...
	R	newfile.txt => somefile.txt
	M	content.txt
Committed r3
	D	newfile.txt
	M	content.txt
	A	somefile.txt
W: -empty_dir: newfile.txt
r3 = e46693b582c5c85710a9a3ea5179ac8fef2d2b22 (refs/remotes/git-svn)
No changes between c92f4143403de8088363551f92bca30499842a4c and refs/remotes/git-svn
Resetting to the latest refs/remotes/git-svn
andy@m:gitwork (master) $ cd ../svnwork/
andy@m:svnwork $ svn up
Aktualisiere ».«:
D    newfile.txt
A    somefile.txt
U    content.txt
Aktualisiert zu Revision 3.
andy@m:svnwork $ ls
content.txt  somefile.txt
andy@m:svnwork $ echo 'a line from svn repo' >> content.txt 
andy@m:svnwork $ echo 'a line from svn repo' >> somefile.txt 
andy@m:svnwork $ svn commit -m 'added something from svn repo'
Sende              content.txt
Sende              somefile.txt
Übertrage Daten ..
Revision 4 übertragen.
andy@m:svnwork $ cd ../gitwork/
andy@m:gitwork (master) $ git svn rebase
	M	somefile.txt
	M	content.txt
r4 = b629f9c35a718e99a811d7fd0ada607687aebde3 (refs/remotes/git-svn)
Zunächst wird der Branch zurückgespult, um Ihre Änderungen
darauf neu anzuwenden...
master zu refs/remotes/git-svn vorgespult.
andy@m:gitwork (master) $ echo 'add more content' >> content.txt 
andy@m:gitwork (master) $ git add content.txt 
andy@m:gitwork (master) $ git mv somefile.txt anyfile.txt
andy@m:gitwork (master) $ git commit -m 'change more content'
[master 453e050] change more content
 2 files changed, 1 insertion(+)
 rename somefile.txt => anyfile.txt (100%)
andy@m:gitwork (master) $ git svn dcommit
Committing to file:///tmp/r/svnrepo ...
	R	somefile.txt => anyfile.txt
	M	content.txt
Committed r5
	D	somefile.txt
	A	anyfile.txt
	M	content.txt
W: -empty_dir: somefile.txt
r5 = e038ff05f796c6f79c63556d6a75a7e86976f060 (refs/remotes/git-svn)
No changes between 453e050c2f6e4ca0de11b42bd9329aff43ec3da0 and refs/remotes/git-svn
Resetting to the latest refs/remotes/git-svn
andy@m:gitwork (master) $ cd ../svnwork/
andy@m:svnwork $ svn up
Aktualisiere ».«:
U    content.txt
D    somefile.txt
A    anyfile.txt
Aktualisiert zu Revision 5.
andy@m:svnwork $ echo 'more svn content' >> content.txt 
andy@m:svnwork $ echo 'new content' > newfile.txt
andy@m:svnwork $ svn add newfile.txt 
A         newfile.txt
andy@m:svnwork $ svn commit -m 'more data from svn'
Sende              content.txt
Füge hinzu         newfile.txt
Übertrage Daten ..
Revision 6 übertragen.
andy@m:svnwork $ cd ../gitwork/
andy@m:gitwork (master) $ git svn fetch
	A	newfile.txt
	M	content.txt
r6 = f98167f128945f5045342366ac9a84d72873c479 (refs/remotes/git-svn)
andy@m:gitwork (master) $ git mv anyfile.txt somefile.txt
andy@m:gitwork (master) $ echo 'changed too' >> somefile.txt 
andy@m:gitwork (master) $ git add somefile.txt 
andy@m:gitwork (master) $ echo 'replaced content' > content.txt 
andy@m:gitwork (master) $ git add content.txt 
andy@m:gitwork (master) $ git commit -m 'did some changes' 
[master 0cb4cd8] did some changes
 2 files changed, 2 insertions(+), 5 deletions(-)
 rename anyfile.txt => somefile.txt (71%)
andy@m:gitwork (master) $ git svn dcommit
Committing to file:///tmp/r/svnrepo ...
	R	anyfile.txt => somefile.txt

ERROR from SVN:
Transaktion ist veraltet: Datei »/content.txt« ist veraltet
W: 0cb4cd820d65cdf4d8a18146c54740e4af0dc533 and refs/remotes/git-svn differ, using rebase:
:000000 100644 0000000000000000000000000000000000000000 cd42f7309485e8df6f795807835ee1ef9d875556 A	anyfile.txt
:100644 100644 3d69ed67cef70be1a2357dcaaffcd5cc34aaa7ce 58fc0689b4691eb02c737f7cc1faf5a860b2a1d9 M	content.txt
:000000 100644 0000000000000000000000000000000000000000 b66ba06d315d46280bb09d54614cc52d1677809f A	newfile.txt
:100644 000000 949eb457147d5e2d187c4dd426b4a05df229900d 0000000000000000000000000000000000000000 D	somefile.txt
Zunächst wird der Branch zurückgespult, um Ihre Änderungen
darauf neu anzuwenden...
Wende an: did some changes
Verwende Informationen aus der Staging-Area um einen Basisverzeichnis nachzustellen
M	content.txt
Falle zurück zum Patchen der Basis und des 3-Wege-Merges...
automatischer Merge von somefile.txt
automatischer Merge von content.txt
KONFLIKT (Inhalt): Merge-Konflikt in content.txt
Merge der Änderungen fehlgeschlagen
Anwendung des Patches fehlgeschlagen bei 0001 did some changes
Die Kopie des fehlgeschlagenen Patches befindet sich in:
   /tmp/r/gitwork/.git/rebase-apply/patch

Wenn Sie das Problem aufgelöst haben, führen Sie "git rebase --continue" aus.
Falls Sie diesen Patch auslassen möchten, führen Sie stattdessen "git rebase --skip" aus.
Um den ursprünglichen Branch wiederherzustellen und den Rebase abzubrechen,
führen Sie "git rebase --abort" aus.

rebase refs/remotes/git-svn: command returned error: 1

andy@m:gitwork (master|REBASE 1/1) $ 


--------------060006040608040702040102--
