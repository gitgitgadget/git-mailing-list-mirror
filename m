From: Dror Levy <drorlevy@live.com>
Subject: Bug when merging non normalized branch with normalized branch using the -X theirs -X renormalize options
Date: Fri, 15 May 2015 13:56:48 +0000 (UTC)
Message-ID: <loom.20150515T153902-500@post.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri May 15 16:00:21 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YtGA0-0007B3-LN
	for gcvg-git-2@plane.gmane.org; Fri, 15 May 2015 16:00:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1423010AbbEOOAO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 15 May 2015 10:00:14 -0400
Received: from plane.gmane.org ([80.91.229.3]:60991 "EHLO plane.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1422896AbbEOOAL (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 15 May 2015 10:00:11 -0400
Received: from list by plane.gmane.org with local (Exim 4.69)
	(envelope-from <gcvg-git-2@m.gmane.org>)
	id 1YtG9j-0006ym-UA
	for git@vger.kernel.org; Fri, 15 May 2015 16:00:04 +0200
Received: from mail.tradologic.com ([77.70.98.102])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Fri, 15 May 2015 16:00:03 +0200
Received: from drorlevy by mail.tradologic.com with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Fri, 15 May 2015 16:00:03 +0200
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@ger.gmane.org
X-Gmane-NNTP-Posting-Host: sea.gmane.org
User-Agent: Loom/3.14 (http://gmane.org/)
X-Loom-IP: 77.70.98.102 (Mozilla/5.0 (Windows NT 6.3; WOW64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/42.0.2311.135 Safari/537.36)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/269142>

This bug happens when attempting to merge a branch which was committed 
without normalization, with a branch which is normalized, from a machine 
set with normalization enabled.

When attempting to merge to normalized branch it returns an error and 
requests for manual merge.

Example of the output of the issue from the command line
https://gist.github.com/Jiyuu/1ed14ac32e25abb884ef

repo for replication
https://github.com/Jiyuu/gitbug


To replicate run(from a system using crlf line endings) the following 
command from the "a" branch:
git merge -v -X theirs -X renormalize b
