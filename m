From: Bill Lear <rael@zopyra.com>
Subject: Error "fatal: cannot pread pack file: Success"
Date: Tue, 27 Feb 2007 21:45:48 -0600
Message-ID: <17892.64236.443170.43061@lisa.zopyra.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Feb 28 04:46:28 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HMFls-0008FG-93
	for gcvg-git@gmane.org; Wed, 28 Feb 2007 04:46:28 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750838AbXB1DqT (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 27 Feb 2007 22:46:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751385AbXB1DqT
	(ORCPT <rfc822;git-outgoing>); Tue, 27 Feb 2007 22:46:19 -0500
Received: from mail.zopyra.com ([65.68.225.25]:61859 "EHLO zopyra.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750838AbXB1DqR (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 27 Feb 2007 22:46:17 -0500
Received: (from rael@localhost)
	by zopyra.com (8.11.6/8.11.6) id l1S3k4310391;
	Tue, 27 Feb 2007 21:46:04 -0600
X-Mailer: VM 7.18 under Emacs 21.1.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/40885>

Using 1.5.0.1.  Can't see what is wrong with this clone...

% df -h .
Filesystem            Size  Used Avail Use% Mounted on
store:/storage/disk1
                      682G  113G  535G  18% /austin

% git clone --bare ~/devel/project
Initialized empty Git repository in /austin/users/rael/repos/git/project/
remote: Generating pack...
remote: Done counting 4589 objects.
remote: Deltifying 4589 objects.
 100% (4589/4589) done89) done
Indexing 4589 objects.
remote: Total 4589 (delta 2209), reused 4589 (delta 2209)
 100% (4589/4589) done
Resolving 2209 deltas.
fatal: cannot pread pack file: Success
fatal: index-pack died with error code 128
fetch-pack from '/home/rael/devel/project/.git' failed.

% mkdir project
% touch project/foo
% ls -l project/foo
-rw-r--r--  1 rael software 0 Feb 27 21:44 project/foo
% rm -rf project

% cd ~/devel
% df -h .
Filesystem            Size  Used Avail Use% Mounted on
/dev/sda5             186G   82G   95G  47% /home
% mkdir test
% cd test

% git clone --bare ~/devel/project
Initialized empty Git repository in /home/rael/test/project/
remote: Generating pack...
remote: Done counting 4589 objects.
remote: Deltifying 4589 objects.
  7Indexing 4589 objects. done
 100% (4589/4589) done89) done4589) done
remote: Total 4589 (delta 2209), reused 4589 (delta 2209)
 100% (4589/4589) done
Resolving 2209 deltas.
 100% (2209/2209) done

This happens repeatedly.  git fsck of my repo shows no problems.

Anything else I can check?


Bill
