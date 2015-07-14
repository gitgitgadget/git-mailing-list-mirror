From: Sebastian Schuberth <sschuberth@gmail.com>
Subject: Issues with git diff-tree --quiet --ignore-space-change
Date: Tue, 14 Jul 2015 23:03:14 +0200
Message-ID: <mo3tel$otc$1@ger.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jul 14 23:03:40 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZF7MX-0007Hc-NY
	for gcvg-git-2@plane.gmane.org; Tue, 14 Jul 2015 23:03:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753092AbbGNVDd (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 14 Jul 2015 17:03:33 -0400
Received: from plane.gmane.org ([80.91.229.3]:41304 "EHLO plane.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752503AbbGNVDc (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 14 Jul 2015 17:03:32 -0400
Received: from list by plane.gmane.org with local (Exim 4.69)
	(envelope-from <gcvg-git-2@m.gmane.org>)
	id 1ZF7MJ-0007Cg-6B
	for git@vger.kernel.org; Tue, 14 Jul 2015 23:03:23 +0200
Received: from p4ff45fce.dip0.t-ipconnect.de ([79.244.95.206])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Tue, 14 Jul 2015 23:03:23 +0200
Received: from sschuberth by p4ff45fce.dip0.t-ipconnect.de with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Tue, 14 Jul 2015 23:03:23 +0200
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@ger.gmane.org
X-Gmane-NNTP-Posting-Host: p4ff45fce.dip0.t-ipconnect.de
X-Mozilla-News-Host: news://news.gmane.org:119
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; en-US; rv:1.8.1.12)
 Gecko/20080213 Thunderbird/2.0.0.12 Mnenhy/0.7.5.0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/273975>

Hi,

I believe there's something wrong with diff-tree's --ignore-space-change option in conjunction with --quiet. In Git's repo, I get

$ git --version
git version 2.4.5

$ git diff-tree --quiet --ignore-space-change c925fe23684455735c3bb1903803643a24a58d8f ; echo $?
c925fe23684455735c3bb1903803643a24a58d8f
0

First question is, why do I see the SHA1 printed to the output, esp. as I specified --quiet?

Secondly, the exit code of 0 indicates there's no diff. However, using

$ git diff-tree --patch --ignore-space-change c925fe23684455735c3bb1903803643a24a58d8f

I see the diff (which does not only consist of whitespaces).

If I omit --ignore-space-change the return value is correct:

$ git diff-tree --quiet c925fe23684455735c3bb1903803643a24a58d8f ; echo $?
c925fe23684455735c3bb1903803643a24a58d8f
1

Am I missing something, or are these bugs?

-- 
Sebastian Schuberth
