From: Marco Costalba <mcostalba@yahoo.it>
Subject: [ANNOUNCE] qgit-0.9
Date: Sat, 13 Aug 2005 05:12:16 -0700 (PDT)
Message-ID: <20050813121216.15512.qmail@web26305.mail.ukl.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-From: git-owner@vger.kernel.org Sat Aug 13 14:13:09 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1E3usC-0007uz-VQ
	for gcvg-git@gmane.org; Sat, 13 Aug 2005 14:12:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932156AbVHMMMW (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 13 Aug 2005 08:12:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932157AbVHMMMW
	(ORCPT <rfc822;git-outgoing>); Sat, 13 Aug 2005 08:12:22 -0400
Received: from web26305.mail.ukl.yahoo.com ([217.146.176.16]:1366 "HELO
	web26305.mail.ukl.yahoo.com") by vger.kernel.org with SMTP
	id S932156AbVHMMMW (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 13 Aug 2005 08:12:22 -0400
Received: (qmail 15514 invoked by uid 60001); 13 Aug 2005 12:12:16 -0000
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.it;
  h=Message-ID:Received:Date:From:Subject:To:MIME-Version:Content-Type:Content-Transfer-Encoding;
  b=mHYDKaFvcXd9YfHPuEyFWmqdKV2E8sZzXPoBijKFan4zpo2DPD3sqqQlrGaXev9mDpEYvjnvmUJRBRB4jtdJl5L2BSjHefhSuDJMEI+cXmeEZU8ieLlqPbQaZ6Z3OIh4rB6ry6AaMutT+md45ehESJzMGj0TLEBQOcu0hDRnOhc=  ;
Received: from [151.38.101.92] by web26305.mail.ukl.yahoo.com via HTTP; Sat, 13 Aug 2005 05:12:16 PDT
To: git@vger.kernel.org
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

Hi all,

	qgit-0.9 has been released and can be downloaded from

http://prdownloads.sourceforge.net/qgit/qgit-0.9.tar.bz2?download



This version fixes a couple of nasty bugs, notably one in 
annotate, crept in after recent changes. Anyone interested in
annotate function should upgrade.


Big new feature is the commit dialog.

When enabled with 'edit->settings->cache->diff against working dir'
and there is something committable, qgit shows a special highlighted
first revision with the status of the archive and the possible pending
stuff. From edit->commit you can, then, invoke the commit viewer to 
select the files to commit or, simply, to call git-update-cache
on them (with sync button).

It is possible to use a template for commit message, use
edit->settings->cache to define template file path.

QGit checks for possible new files added in working directory using
ignoring rules according to git-ls-files specifications,  
--exclude-from and --exclude-per-directory files can be set in
menu->edit->settings->cache. Behaviour should be similar to cg-status.

Core commit function is performed by git-commit-script, although the
script itself is not enough to handle all the possibilities and some
work is necessary to prepare/restore the cache.

Commit feature and new files checking use some (transalted) code from 
Fredrik Kuivinen 'gct' tool (although commit logic is different) and 
Petr Baudis cg-status. Thanks to both ;-)


New select tag dialog

Another ineteresting new feature is a 'select tag' dialog shown when
qgit is launched without arguments. I found this useful to quickly
select revision range to display.
On the dialog are listed the tags, but you can paste anything that
is 'eatable' by git-rev-parse.


Complete changelog:

- added commit dialog to commit or simply update cache on selected files
- added revisions range select dialog when calling qgit 
  without arguments or when changing archive
- replace SHA's with short logs in commit messages links 
- added F3 accelerator in file viewer for find button
- fix a nasty bug in git-diff-tree interface that sometimes
  led to missing revision files
- fix proper closing of file and diff window when quitting
- fix a corner case in annotate
- fix annotation broke by a recent change
- fix spurious LF in diff viewer


	Marco


P.S: Sorry for the tarball, but SF doesn't yet answerd about
my request to setup a git archive on their site.


__________________________________________________
Do You Yahoo!?
Tired of spam?  Yahoo! Mail has the best spam protection around 
http://mail.yahoo.com 
