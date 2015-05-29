From: Jonas Berlin <xkr47@outerspace.dyndns.org>
Subject: BUG: Wrong error message when access to .git directory denied
Date: Fri, 29 May 2015 10:47:43 +0300
Message-ID: <20150529104743.6220a11f@outerspace.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri May 29 09:48:00 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YyF1K-00023p-QJ
	for gcvg-git-2@plane.gmane.org; Fri, 29 May 2015 09:47:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754436AbbE2Hrz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 29 May 2015 03:47:55 -0400
Received: from filtteri5.pp.htv.fi ([213.243.153.188]:42810 "EHLO
	filtteri5.pp.htv.fi" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751933AbbE2Hrx (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 29 May 2015 03:47:53 -0400
Received: from localhost (localhost [127.0.0.1])
	by filtteri5.pp.htv.fi (Postfix) with ESMTP id F23855A6F1D
	for <git@vger.kernel.org>; Fri, 29 May 2015 10:47:37 +0300 (EEST)
X-Virus-Scanned: Debian amavisd-new at pp.htv.fi
Received: from smtp4.welho.com ([213.243.153.38])
	by localhost (filtteri5.pp.htv.fi [213.243.153.188]) (amavisd-new, port 10024)
	with ESMTP id KkRLB-QqohY0 for <git@vger.kernel.org>;
	Fri, 29 May 2015 10:47:33 +0300 (EEST)
Received: from outerspace.dyndns.org (cs27032225.pp.htv.fi [89.27.32.225])
	by smtp4.welho.com (Postfix) with ESMTP id 781725BC02D
	for <git@vger.kernel.org>; Fri, 29 May 2015 10:47:44 +0300 (EEST)
X-Mailer: Claws Mail 3.9.0 (GTK+ 2.24.22; x86_64-pc-linux-gnu)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/270214>

Hi,

Severity: Low
Impact: Confusion
Git version: 1.9.1

If I don't have permissions to access the .git folder of a non-bare git repository, I get the following output:

  fatal: Not a git repository (or any of the parent directories): .git

Expected output:

  fatal: Permission denied while accessing .git directory

Steps to reproduce:

  mkdir foo
  cd foo
  git init
  chmod 000 .git
  git log

- xkr47
