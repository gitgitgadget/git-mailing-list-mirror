From: masonk <mason.kramer@gmail.com>
Subject: Re: P4 Sync problem
Date: Thu, 22 Jul 2010 11:21:54 -0700 (PDT)
Message-ID: <1279822914118-5326585.post@n2.nabble.com>
References: <loom.20091110T145046-137@post.gmane.org> <1a6be5fa0911110043i63b5c032s7924f9f1cdfe32ee@mail.gmail.com> <loom.20091111T100646-406@post.gmane.org> <1a6be5fa0911110400l1fe931afmbb53ceba8704e029@mail.gmail.com> <loom.20091111T131837-901@post.gmane.org> <1a6be5fa0911110554u7c3a04c8hf50100b784b63c7a@mail.gmail.com> <loom.20091111T154425-182@post.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jul 22 20:22:02 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Oc0PC-0005L8-Dh
	for gcvg-git-2@lo.gmane.org; Thu, 22 Jul 2010 20:22:02 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755072Ab0GVSV4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 22 Jul 2010 14:21:56 -0400
Received: from kuber.nabble.com ([216.139.236.158]:57250 "EHLO
	kuber.nabble.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754612Ab0GVSVy (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 22 Jul 2010 14:21:54 -0400
Received: from jim.nabble.com ([192.168.236.80])
	by kuber.nabble.com with esmtp (Exim 4.63)
	(envelope-from <mason.kramer@gmail.com>)
	id 1Oc0P4-0004aw-40
	for git@vger.kernel.org; Thu, 22 Jul 2010 11:21:54 -0700
In-Reply-To: <loom.20091111T154425-182@post.gmane.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/151466>


Hi, I know this is an old thread, but I think it might be relevant.  (At any
rate, at least you know I've been looking).

I'm trying to use git-p4 with a very large P4 repository, of which my client
view is a small fraction.  
My client view is within the administrator-set file limit of P4 files. 
E.G., p4 sync //depot/... works.

When I call git-p4 sync or clone, however, it bumps into the limit.  Even if
I am using client spec and detecting branches.  If p4 were successfully
detecting my branches -or- using my client spec, I would not be running into
the limit.  But:

git p4 sync //depot@all --use-client-spec --detect-branches --verbose
Syncing with origin first by calling git fetch origin
executing git fetch origin
Reading pipe: git config git-p4.user
Reading pipe: git config git-p4.password
Reading pipe: git config git-p4.port
Reading pipe: git config git-p4.host
Reading pipe: git config git-p4.client
p4 -u mkramer -c mkramer -G client -o
Opening pipe: p4 -u mkramer -c mkramer -G client -o
Reading pipe: git rev-parse --symbolic  --remotes
Reading pipe: git rev-parse p4/master
p4-git branches: []
initial parents: {}
Getting p4 changes for //depot/...
p4 -u mkramer -c mkramer changes //depot/...
Reading pipe: p4 -u mkramer -c mkramer changes //depot/...
Request too large (over 110000); see 'p4 help maxresults'.
Traceback (most recent call last):
  File "/home/mkramer/git/bin/git-p4", line 1924, in <module>
    main()
  File "/home/mkramer/git/bin/git-p4", line 1919, in main
    if not cmd.run(args):
  File "/home/mkramer/git/bin/git-p4", line 1671, in run
    changes = p4ChangesForPaths(self.depotPaths, self.changeRange)
  File "/home/mkramer/git/bin/git-p4", line 444, in p4ChangesForPaths
    for p in depotPaths]))
  File "/home/mkramer/git/bin/git-p4", line 108, in p4_read_pipe_lines
    return read_pipe_lines(real_cmd)
  File "/home/mkramer/git/bin/git-p4", line 101, in read_pipe_lines
    die('Command failed: %s' % c)
  File "/home/mkramer/git/bin/git-p4", line 59, in die
    raise Exception(msg)
Exception: Command failed: p4 -u mkramer -c mkramer changes //depot/...


Is this a limitation in the current --use-client-spec or --detect-branches
flags, or am I doing it wrong?
-- 
View this message in context: http://git.661346.n2.nabble.com/P4-Sync-problem-tp3979793p5326585.html
Sent from the git mailing list archive at Nabble.com.
