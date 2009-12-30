From: Sebastian Thiel <byronimo@gmail.com>
Subject: Re: [PATCH] git-update-index: report(...) now flushes stdout after printing the report line
Date: Wed, 30 Dec 2009 13:56:32 +0000 (UTC)
Message-ID: <loom.20091230T145525-818@post.gmane.org>
References: <loom.20091119T221732-624@post.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Dec 30 14:57:11 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NPz2r-0002U7-JH
	for gcvg-git-2@lo.gmane.org; Wed, 30 Dec 2009 14:57:01 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752763AbZL3N46 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 30 Dec 2009 08:56:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752327AbZL3N45
	(ORCPT <rfc822;git-outgoing>); Wed, 30 Dec 2009 08:56:57 -0500
Received: from lo.gmane.org ([80.91.229.12]:48842 "EHLO lo.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751900AbZL3N45 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 30 Dec 2009 08:56:57 -0500
Received: from list by lo.gmane.org with local (Exim 4.50)
	id 1NPz2k-0002Rk-I7
	for git@vger.kernel.org; Wed, 30 Dec 2009 14:56:54 +0100
Received: from 91-64-162-37-dynip.superkabel.de ([91.64.162.37])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Wed, 30 Dec 2009 14:56:54 +0100
Received: from byronimo by 91-64-162-37-dynip.superkabel.de with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Wed, 30 Dec 2009 14:56:54 +0100
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@ger.gmane.org
X-Gmane-NNTP-Posting-Host: sea.gmane.org
User-Agent: Loom/3.14 (http://gmane.org/)
X-Loom-IP: 91.64.162.37 (Mozilla/5.0 (Macintosh; U; Intel Mac OS X 10.6; de; rv:1.9.1.6) Gecko/20091201 Firefox/3.5.6)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/135899>

I'd like to add that since version 1.6.5, non-tty's do not receive any progress
information anymore. The patch causing this says it wants to, in short words,
unify the push and fetch handling regarding the way progress messages are sent.

Now third-party wrappers, such as git-python, are unable to provide any progress
information anymore for possibly lengthy operations.

This is why I clearly recommend to add some kind of a "progress-force" flag that
turns progress messages on again for send-pack and receive-pack.
