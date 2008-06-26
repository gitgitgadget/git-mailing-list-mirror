From: "Edward Z. Yang" <edwardzyang@thewritingpot.com>
Subject: [Bug?] git submodule add doesn't respect core.autocrlf
Date: Thu, 26 Jun 2008 01:43:48 -0400
Message-ID: <g3vaaq$pm1$1@ger.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jun 26 07:45:09 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KBkI7-0003gZ-Kf
	for gcvg-git-2@gmane.org; Thu, 26 Jun 2008 07:45:08 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754095AbYFZFoL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 26 Jun 2008 01:44:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753768AbYFZFoL
	(ORCPT <rfc822;git-outgoing>); Thu, 26 Jun 2008 01:44:11 -0400
Received: from main.gmane.org ([80.91.229.2]:60633 "EHLO ciao.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753548AbYFZFoK (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 26 Jun 2008 01:44:10 -0400
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1KBkH8-0000IQ-AG
	for git@vger.kernel.org; Thu, 26 Jun 2008 05:44:06 +0000
Received: from ool-18e45099.dyn.optonline.net ([24.228.80.153])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Thu, 26 Jun 2008 05:44:06 +0000
Received: from edwardzyang by ool-18e45099.dyn.optonline.net with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Thu, 26 Jun 2008 05:44:06 +0000
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@ger.gmane.org
X-Gmane-NNTP-Posting-Host: ool-18e45099.dyn.optonline.net
User-Agent: Thunderbird 2.0.0.14 (Windows/20080421)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/86399>

It doesn't appear that git-submodule add respects crlf, as evidenced by 
this set of commands on Windows:

mkdir test
cd test
git init
git config core.safecrlf true
git config core.autocrlf true
git submodule add http://repo.or.cz/w/htmlpurifier.git htmlpurifier

You get: "fatal: LF would be replaced by CRLF in .gitmodules" and 
inspecting .gitmodules reveals that it uses LF, instead of CRLF.

Can anyone reproduce? Thanks.
