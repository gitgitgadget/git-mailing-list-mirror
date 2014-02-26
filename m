From: "Leo R. Lundgren" <leo@finalresort.org>
Subject: Doc target fails to parse user-manual.xml
Date: Wed, 26 Feb 2014 17:13:47 +0100
Message-ID: <8244C605-810C-487A-8931-DBC15D4A3F2A@finalresort.org>
Mime-Version: 1.0 (Apple Message framework v1085)
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8BIT
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Feb 26 17:20:27 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WIhDb-0004Hz-Lm
	for gcvg-git-2@plane.gmane.org; Wed, 26 Feb 2014 17:20:24 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752434AbaBZQUV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 26 Feb 2014 11:20:21 -0500
Received: from mail.hobbyhotellet.se ([82.99.16.182]:46428 "EHLO
	mail.hobbyhotellet.se" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751790AbaBZQUS convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 26 Feb 2014 11:20:18 -0500
X-Greylist: delayed 384 seconds by postgrey-1.27 at vger.kernel.org; Wed, 26 Feb 2014 11:20:18 EST
Received: from localhost (localhost [127.0.0.1])
	by mail.hobbyhotellet.se (Postfix) with ESMTP id 9A58C46C8CB
	for <git@vger.kernel.org>; Wed, 26 Feb 2014 17:13:49 +0100 (CET)
X-Virus-Scanned: Debian amavisd-new at mail.hobbyhotellet.se
Received: from mail.hobbyhotellet.se ([127.0.0.1])
	by localhost (mail.hobbyhotellet.se [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id vAHPl+LGJ9Am for <git@vger.kernel.org>;
	Wed, 26 Feb 2014 17:13:48 +0100 (CET)
Received: from viston.lan (c-d925e353.366-1-64736c13.cust.bredbandsbolaget.se [83.227.37.217])
	by mail.hobbyhotellet.se (Postfix) with ESMTPSA id 48AA446C42C
	for <git@vger.kernel.org>; Wed, 26 Feb 2014 17:13:48 +0100 (CET)
X-Mailer: Apple Mail (2.1085)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/242734>

Hi,

I'm installing git 1.9.0 from source, on a freshly installed SLES 11 SP3. The git binaries work fine to compile and install, but `make doc` fails on some XML parsing errors.

The system is fully updated with the latest stable packages in the SLES 11 SP3 distribution. What I've done is:

- Extracted the 1.9.0 source code from GitHub.
- Ran `make configure` as regular user.
- Ran `./configure --prefix=/usr/local` as regular user.
- Ran `make all` as regular user - this works fine.
- Ran `make doc` as regular user - the log from this is below.

----- 8< -----

foo@bar:~> rpm -qa|grep xml
libxml2-python-2.7.6-0.23.1
php53-xmlwriter-5.3.17-0.13.7
libxml2-2.7.6-0.23.1
libxml2-32bit-2.7.6-0.23.1
php53-xmlreader-5.3.17-0.13.7
xmlcharent-0.3-403.14
python-xml-2.6.8-0.15.1
yast2-xml-2.16.1-1.23

foo@bar:~> rpm -qa|grep doc
docbook_4-4.5-111.14
pam-doc-1.1.5-0.10.17
perl-doc-5.10.0-64.67.52
readline-doc-5.2-147.17.30
docbook-xsl-stylesheets-1.78.1-0.7.17
apparmor-docs-2.5.1.r1445-55.59.1
asciidoc-8.2.7-29.21
PolicyKit-doc-0.9-14.39.2
nfs-doc-1.2.3-18.29.1
bash-doc-3.2-147.17.30
postgresql91-docs-9.1.9-0.3.1


foo@bar:~/git-1.9.0> make doc
make -C Documentation all
make[1]: Entering directory `/home/foo/git-1.9.0/Documentation'
    GEN mergetools-list.made
    GEN cmd-list.made
    GEN doc.dep
make[2]: Entering directory `/home/foo/git-1.9.0'
make[2]: `GIT-VERSION-FILE' is up to date.
make[2]: Leaving directory `/home/foo/git-1.9.0'
make[1]: Leaving directory `/home/foo/git-1.9.0/Documentation'
make[1]: Entering directory `/home/foo/git-1.9.0/Documentation'
make[2]: Entering directory `/home/foo/git-1.9.0'
make[2]: `GIT-VERSION-FILE' is up to date.
make[2]: Leaving directory `/home/foo/git-1.9.0'
    ASCIIDOC git-add.html
    ASCIIDOC git-am.html
    ASCIIDOC git-annotate.html
    ASCIIDOC git-apply.html
    ASCIIDOC git-archimport.html
    ASCIIDOC git-archive.html
    ASCIIDOC git-bisect.html
    ASCIIDOC git-blame.html
    ASCIIDOC git-branch.html
    ASCIIDOC git-bundle.html
    ASCIIDOC git-cat-file.html
    ASCIIDOC git-check-attr.html
    ASCIIDOC git-check-ignore.html
    ASCIIDOC git-check-mailmap.html
    ASCIIDOC git-checkout-index.html
    ASCIIDOC git-checkout.html
    ASCIIDOC git-check-ref-format.html
    ASCIIDOC git-cherry-pick.html
    ASCIIDOC git-cherry.html
    ASCIIDOC git-citool.html
    ASCIIDOC git-clean.html
    ASCIIDOC git-clone.html
    ASCIIDOC git-column.html
    ASCIIDOC git-commit-tree.html
    ASCIIDOC git-commit.html
    ASCIIDOC git-config.html
    ASCIIDOC git-count-objects.html
    ASCIIDOC git-credential-cache--daemon.html
    ASCIIDOC git-credential-cache.html
    ASCIIDOC git-credential-store.html
    ASCIIDOC git-credential.html
    ASCIIDOC git-cvsexportcommit.html
    ASCIIDOC git-cvsimport.html
    ASCIIDOC git-cvsserver.html
    ASCIIDOC git-daemon.html
    ASCIIDOC git-describe.html
    ASCIIDOC git-diff-files.html
    ASCIIDOC git-diff-index.html
    ASCIIDOC git-difftool.html
    ASCIIDOC git-diff-tree.html
    ASCIIDOC git-diff.html
    ASCIIDOC git-fast-export.html
    ASCIIDOC git-fast-import.html
    ASCIIDOC git-fetch-pack.html
    ASCIIDOC git-fetch.html
    ASCIIDOC git-filter-branch.html
    ASCIIDOC git-fmt-merge-msg.html
    ASCIIDOC git-for-each-ref.html
    ASCIIDOC git-format-patch.html
    ASCIIDOC git-fsck-objects.html
    ASCIIDOC git-fsck.html
    ASCIIDOC git-gc.html
    ASCIIDOC git-get-tar-commit-id.html
    ASCIIDOC git-grep.html
    ASCIIDOC git-gui.html
    ASCIIDOC git-hash-object.html
    ASCIIDOC git-help.html
    ASCIIDOC git-http-backend.html
    ASCIIDOC git-http-fetch.html
    ASCIIDOC git-http-push.html
    ASCIIDOC git-imap-send.html
    ASCIIDOC git-index-pack.html
    ASCIIDOC git-init-db.html
    ASCIIDOC git-init.html
    ASCIIDOC git-instaweb.html
    ASCIIDOC git-log.html
    ASCIIDOC git-ls-files.html
    ASCIIDOC git-ls-remote.html
    ASCIIDOC git-ls-tree.html
    ASCIIDOC git-mailinfo.html
    ASCIIDOC git-mailsplit.html
    ASCIIDOC git-merge-base.html
    ASCIIDOC git-merge-file.html
    ASCIIDOC git-merge-index.html
    ASCIIDOC git-merge-one-file.html
    ASCIIDOC git-mergetool--lib.html
    ASCIIDOC git-mergetool.html
    ASCIIDOC git-merge-tree.html
    ASCIIDOC git-merge.html
    ASCIIDOC git-mktag.html
    ASCIIDOC git-mktree.html
    ASCIIDOC git-mv.html
    ASCIIDOC git-name-rev.html
    ASCIIDOC git-notes.html
    ASCIIDOC git-p4.html
    ASCIIDOC git-pack-objects.html
    ASCIIDOC git-pack-redundant.html
    ASCIIDOC git-pack-refs.html
    ASCIIDOC git-parse-remote.html
    ASCIIDOC git-patch-id.html
    ASCIIDOC git-prune-packed.html
    ASCIIDOC git-prune.html
    ASCIIDOC git-pull.html
    ASCIIDOC git-push.html
    ASCIIDOC git-quiltimport.html
    ASCIIDOC git-read-tree.html
    ASCIIDOC git-rebase.html
    ASCIIDOC git-receive-pack.html
    ASCIIDOC git-reflog.html
    ASCIIDOC git-relink.html
    ASCIIDOC git-remote-ext.html
WARNING: git-remote-ext.txt: line 11: missing macro section: [ext]-inlinemacro
    ASCIIDOC git-remote-fd.html
WARNING: git-remote-fd.txt: line 10: missing macro section: [fd]-inlinemacro
    ASCIIDOC git-remote-testgit.html
    ASCIIDOC git-remote.html
    ASCIIDOC git-repack.html
    ASCIIDOC git-replace.html
    ASCIIDOC git-request-pull.html
    ASCIIDOC git-rerere.html
    ASCIIDOC git-reset.html
    ASCIIDOC git-revert.html
    ASCIIDOC git-rev-list.html
    ASCIIDOC git-rev-parse.html
    ASCIIDOC git-rm.html
    ASCIIDOC git-send-email.html
    ASCIIDOC git-send-pack.html
    ASCIIDOC git-shell.html
    ASCIIDOC git-sh-i18n--envsubst.html
    ASCIIDOC git-sh-i18n.html
    ASCIIDOC git-shortlog.html
    ASCIIDOC git-show-branch.html
    ASCIIDOC git-show-index.html
    ASCIIDOC git-show-ref.html
    ASCIIDOC git-show.html
    ASCIIDOC git-sh-setup.html
    ASCIIDOC git-stage.html
    ASCIIDOC git-stash.html
    ASCIIDOC git-status.html
    ASCIIDOC git-stripspace.html
    ASCIIDOC git-submodule.html
    ASCIIDOC git-svn.html
    ASCIIDOC git-symbolic-ref.html
    ASCIIDOC git-tag.html
    ASCIIDOC git-unpack-file.html
    ASCIIDOC git-unpack-objects.html
    ASCIIDOC git-update-index.html
    ASCIIDOC git-update-ref.html
    ASCIIDOC git-update-server-info.html
    ASCIIDOC git-upload-archive.html
    ASCIIDOC git-upload-pack.html
    ASCIIDOC git-var.html
    ASCIIDOC git-verify-pack.html
    ASCIIDOC git-verify-tag.html
    ASCIIDOC git-web--browse.html
    ASCIIDOC git-whatchanged.html
    ASCIIDOC git-write-tree.html
    ASCIIDOC git.html
    ASCIIDOC gitk.html
    ASCIIDOC gitremote-helpers.html
    ASCIIDOC gitweb.html
    ASCIIDOC gitattributes.html
    ASCIIDOC githooks.html
    ASCIIDOC gitignore.html
    ASCIIDOC gitmodules.html
    ASCIIDOC gitrepository-layout.html
    ASCIIDOC gitweb.conf.html
    ASCIIDOC gitcli.html
    ASCIIDOC gitcore-tutorial.html
    ASCIIDOC gitcredentials.html
    ASCIIDOC gitcvs-migration.html
    ASCIIDOC gitdiffcore.html
    ASCIIDOC gitglossary.html
    ASCIIDOC gitnamespaces.html
    ASCIIDOC gitrevisions.html
    ASCIIDOC gittutorial-2.html
    ASCIIDOC gittutorial.html
    ASCIIDOC gitworkflows.html
    ASCIIDOC git-remote-helpers.html
    GEN howto-index.txt
    ASCIIDOC howto-index.html
    ASCIIDOC everyday.html
    ASCIIDOC git-tools.html
    ASCIIDOC git-bisect-lk2009.html
    ASCIIDOC user-manual.xml
    XSLTPROC user-manual.html
user-manual.xml:3774: parser error : Opening and ending tag mismatch: emphasis line 3774 and literal
  char <emphasis role="strong"></literal>, but is actually expected to be a poin
                                         ^
user-manual.xml:3776: parser error : Opening and ending tag mismatch: literal line 3776 and emphasis
mit.  Note that whenever a SHA-1 is passed as <literal>unsigned char </emphasis>
                                                                               ^
user-manual.xml:4538: parser error : Opening and ending tag mismatch: emphasis line 4538 and literal
A leading "<literal><emphasis role="strong"></literal>" followed by a slash mean
                                                      ^
user-manual.xml:4539: parser error : Opening and ending tag mismatch: literal line 4539 and emphasis
   directories. For example, "<literal></emphasis>/foo</literal>" matches file o
                                                  ^
user-manual.xml:4547: parser error : Opening and ending tag mismatch: emphasis line 4547 and literal
A trailing "<literal>/<emphasis role="strong"></literal>" matches everything ins
                                                        ^
user-manual.xml:4548: parser error : Opening and ending tag mismatch: literal line 4548 and emphasis
   "<literal>abc/</emphasis></literal>" matches all files inside directory "abc"
                            ^
unable to parse user-manual.xml
make[1]: *** [user-manual.html] Error 6
make[1]: Leaving directory `/home/foo/git-1.9.0/Documentation'
make: *** [doc] Error 2

----- 8< -----

It's not a huge issue for me, since I don't really need the docs on this system anyway, and the binaries work, but it would of course be nice if git compiled on a system like this since it's a rather common commercial distribution.

I'd be happy to provide additional info if needed. Thanks!

Regards, Leo