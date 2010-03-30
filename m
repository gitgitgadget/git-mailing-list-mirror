From: Giuseppe Bilotta <giuseppe.bilotta@gmail.com>
Subject: git cvsimport and case-insensitive config
Date: Tue, 30 Mar 2010 10:32:37 +0200
Message-ID: <hoscv7$hmn$1@dough.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7Bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Mar 30 10:33:19 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NwWsv-0003iN-8h
	for gcvg-git-2@lo.gmane.org; Tue, 30 Mar 2010 10:33:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755709Ab0C3Ic7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 30 Mar 2010 04:32:59 -0400
Received: from lo.gmane.org ([80.91.229.12]:47705 "EHLO lo.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754887Ab0C3Ic6 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 30 Mar 2010 04:32:58 -0400
Received: from list by lo.gmane.org with local (Exim 4.69)
	(envelope-from <gcvg-git-2@m.gmane.org>)
	id 1NwWsX-0003WW-MH
	for git@vger.kernel.org; Tue, 30 Mar 2010 10:32:53 +0200
Received: from 151.60.178.71 ([151.60.178.71])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Tue, 30 Mar 2010 10:32:53 +0200
Received: from giuseppe.bilotta by 151.60.178.71 with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Tue, 30 Mar 2010 10:32:53 +0200
X-Injected-Via-Gmane: http://gmane.org/
Followup-To: gmane.comp.version-control.git
X-Complaints-To: usenet@dough.gmane.org
X-Gmane-NNTP-Posting-Host: 151.60.178.71
User-Agent: KNode/4.3.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/143554>

Hello all,

I just noticed that there's an annoying buglet in the way git cvsimport 
stores its configuration and the case-insensitive key lookup done by git.

git cvsimport looks for cvsimport.* single-letter keys that match the 
command-line option (e.g. cvsimport.r for -r). However, since there are some 
single-letter options which only differ by case (a vs A, r vs R) if you set 
either you get annoying messages (and potentially also odd results, although 
I haven't come across these yet).

I come with no patch because I'm not really sure what would be the best 
approach at fixing this. Changing the way cvsimport matches config to 
command-line options? An option to make git-config case-sensitive re. key 
names? Something else?
