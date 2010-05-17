From: Eli Barzilay <eli@barzilay.org>
Subject: gitk (or tcl/tk) slow to start?
Date: Mon, 17 May 2010 06:58:23 -0400
Message-ID: <19441.8527.606063.296769@winooski.ccs.neu.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon May 17 12:58:31 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ODy1k-00022q-Uh
	for gcvg-git-2@lo.gmane.org; Mon, 17 May 2010 12:58:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754815Ab0EQK6Y (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 17 May 2010 06:58:24 -0400
Received: from winooski.ccs.neu.edu ([129.10.115.117]:53058 "EHLO barzilay.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753179Ab0EQK6Y (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 17 May 2010 06:58:24 -0400
Received: from eli by barzilay.org with local (Exim 4.66)
	(envelope-from <eli@barzilay.org>)
	id 1ODy1f-0001Uj-Ju
	for git@vger.kernel.org; Mon, 17 May 2010 06:58:23 -0400
X-Mailer: VM 8.0.12 under 23.1.1 (x86_64-unknown-linux-gnu)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/147223>

Every time I run gitk when I didn't use it for a while, it takes a
long time to start (more than 30 seconds) with no visible cpu load.  I
tried to strace it, and the result shows that the time is spent
stat()ing my whole /usr/lib directory:

  ...
  stat("/usr/lib/libelf-0.131.so", {st_mode=S_IFREG|0755, st_size=87496, ...}) = 0
  stat("/usr/lib/libungif.so.4", {st_mode=S_IFREG|0755, st_size=2444, ...}) = 0
  stat("/usr/lib/libtiff.so.3.8.2", {st_mode=S_IFREG|0755, st_size=360268, ...}) = 0
  ...

Is this expected?  Anything that can be done to avoid it?

[This is using a new git version (1.7.1), but it's an old OS (Fedora
7), so maybe tcl/tk is buggy?]

-- 
          ((lambda (x) (x x)) (lambda (x) (x x)))          Eli Barzilay:
                    http://barzilay.org/                   Maze is Life!
