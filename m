From: "franky" <yinping@kooxoo.com>
Subject: Is there any plan to support partial checkout or submoudule improvement?
Date: Tue, 16 Oct 2007 11:20:47 +0800
Message-ID: <20071016032048.771557E80@mail.kooxoo.com>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="US-ASCII"
Content-Transfer-Encoding: 7bit
To: <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Tue Oct 16 05:21:02 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IhczN-0003tN-HE
	for gcvg-git-2@gmane.org; Tue, 16 Oct 2007 05:21:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757836AbXJPDUu (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 15 Oct 2007 23:20:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757681AbXJPDUu
	(ORCPT <rfc822;git-outgoing>); Mon, 15 Oct 2007 23:20:50 -0400
Received: from mail.kooxoo.com ([60.28.194.208]:58465 "EHLO mail.kooxoo.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757555AbXJPDUt (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 15 Oct 2007 23:20:49 -0400
Received: from yinping (unknown [124.42.17.129])
	by mail.kooxoo.com (Postfix) with ESMTP id 771557E80
	for <git@vger.kernel.org>; Tue, 16 Oct 2007 11:20:48 +0800 (CST)
X-Mailer: Microsoft Office Outlook, Build 11.0.5510
Thread-Index: AcgPo4snNoptZmHQStapZuz1mbJx0A==
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2900.3198
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/61066>

Here is my pain when using git without partial checkout and submodule
improvement.
	I want to manage src and compiled bin together consistently. And
when deploying, I don't need the src directory.
	My directory structure is like
	Project
         Src
         Bin
Following is two schemes I have considered
1. src, bin as two submoudles
	When changes are made in src, compiled binaries are put in bin
directory. So when I commit, I have to commit 3 times and write 3 commit
comments separately (in Project, src, bin). 
	I think if some improvement in submodule, this problem can be
avoided. For example, when committing in Project directory, all changes in
submoules are also automatically committed. Maybe a new subcommand
"git-submodule commit" to commit all submodules but share a single comment
and "git-commit -A" to commit both files and submodule?

2. src, bin not submoudle, just sub directory
	When src changes, compiled binaries are still put in bin directory.
However, only one commit is required. Perfect? No, another problem when
deploying. I don't want the src directory to appear in the deployment
directory. However, without partial checkout, I can't do that, since every
time bin and src directories are checked out together.
