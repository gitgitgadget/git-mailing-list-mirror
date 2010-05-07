From: Eli Barzilay <eli@barzilay.org>
Subject: git diff flags
Date: Fri, 7 May 2010 15:41:56 -0400
Message-ID: <19428.27908.870639.422432@winooski.ccs.neu.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri May 07 21:42:03 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OATQx-000438-I4
	for gcvg-git-2@lo.gmane.org; Fri, 07 May 2010 21:42:03 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932138Ab0EGTl6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 7 May 2010 15:41:58 -0400
Received: from winooski.ccs.neu.edu ([129.10.115.117]:44126 "EHLO barzilay.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932088Ab0EGTl6 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 7 May 2010 15:41:58 -0400
Received: from eli by barzilay.org with local (Exim 4.66)
	(envelope-from <eli@barzilay.org>)
	id 1OATQq-0005Fp-Vv
	for git@vger.kernel.org; Fri, 07 May 2010 15:41:56 -0400
X-Mailer: VM 8.0.12 under 23.1.1 (x86_64-unknown-linux-gnu)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/146570>

There's something strange with how `git diff' parses its flags:

  git diff --some-bogus-flag
  --> complains as expected

  git diff --follow
  --> works but there's no mention of this in the man page, and it
      doesn't look like it's doing anything

  git diff -C -M
  --> works as expected too

  git diff -CM
  --> doesn't say anything (but it does exit with an error code)

  git diff -CM --I-can-write-anything here!
  --> does the same

-- 
          ((lambda (x) (x x)) (lambda (x) (x x)))          Eli Barzilay:
                    http://barzilay.org/                   Maze is Life!
