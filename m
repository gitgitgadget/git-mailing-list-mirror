From: Marat Radchenko <marat@slonopotamus.org>
Subject: [BUG] git push writes to stderr instead of stdout on success
Date: Mon, 19 May 2014 19:03:58 +0400
Message-ID: <20140519150358.GA3099@seldon>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon May 19 17:04:08 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WmP6l-0007GA-At
	for gcvg-git-2@plane.gmane.org; Mon, 19 May 2014 17:04:07 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751630AbaESPED (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 19 May 2014 11:04:03 -0400
Received: from seldon.slonopotamus.org ([94.242.204.247]:32822 "EHLO
	slonopotamus.org" rhost-flags-OK-FAIL-OK-OK) by vger.kernel.org
	with ESMTP id S1751003AbaESPEB (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 19 May 2014 11:04:01 -0400
Received: from marat by slonopotamus.org with local (Exim 4.80.1)
	(envelope-from <marat@slonopotamus.org>)
	id 1WmP6c-0000oW-Ka
	for git@vger.kernel.org; Mon, 19 May 2014 19:03:58 +0400
Content-Disposition: inline
User-Agent: Mutt/1.5.22 (2013-10-16)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/249582>

`git push` writes to stderr instead of stdout

Steps to reproduce:

  mkdir foo
  cd foo
  git init
  echo foo > fo
  git add -A
  git commit -am "foo"
  git push . HEAD:refs/heads/newbranch 2>out

Expected: `out` file is empty

Actual: `out` file contents:

To .
 * [new branch]      HEAD -> newbranch
