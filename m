From: Lars Noschinski <lars@public.noschinski.de>
Subject: Re: [PATCH] filter-branch -d: Export GIT_DIR earlier
Date: Mon, 16 Feb 2009 15:51:37 +0100
Message-ID: <20090216145137.GA4431@lars.home.noschinski.de>
References: <20090216130951.GA3769@lars.home.noschinski.de> <alpine.DEB.1.00.0902161441190.6289@intel-tinevez-2-302>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Cc: git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Mon Feb 16 15:59:50 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LZ4wi-00033M-FO
	for gcvg-git-2@gmane.org; Mon, 16 Feb 2009 15:59:44 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751167AbZBPO6G (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 16 Feb 2009 09:58:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751250AbZBPO6E
	(ORCPT <rfc822;git-outgoing>); Mon, 16 Feb 2009 09:58:04 -0500
Received: from smtprelay09.ispgateway.de ([80.67.29.23]:56097 "EHLO
	smtprelay09.ispgateway.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751246AbZBPO6C (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 16 Feb 2009 09:58:02 -0500
X-Greylist: delayed 382 seconds by postgrey-1.27 at vger.kernel.org; Mon, 16 Feb 2009 09:58:02 EST
Received: from [134.61.47.191] (helo=fruehjahrsmuede.home.noschinski.de)
	by smtprelay09.ispgateway.de with esmtpsa (TLSv1:AES256-SHA:256)
	(Exim 4.68)
	(envelope-from <lars@public.noschinski.de>)
	id 1LZ4or-0000ac-P4; Mon, 16 Feb 2009 15:51:37 +0100
Received: from lars by fruehjahrsmuede.home.noschinski.de with local (Exim 4.69)
	(envelope-from <lars@public.noschinski.de>)
	id 1LZ4or-00019k-91; Mon, 16 Feb 2009 15:51:37 +0100
Content-Disposition: inline
In-Reply-To: <alpine.DEB.1.00.0902161441190.6289@intel-tinevez-2-302>
User-Agent: mutt-ng/devel-r804 (Linux)
X-Df-Sender: 336680
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/110188>

Hello,

* Johannes Schindelin <Johannes.Schindelin@gmx.de> [09-02-16 15:42]:
>> This fix is not yet ready for commit, as it lacks a test case.
>> 
>> Writing a test case for this bug, I wonder about the preferred way to use a
>> directory outside any git repository in a test: Using some directory below
>> git/t/ will not work, as (in most cases) git is a git repository.
>
>How about using a filter-branch call with a filter that echoes GIT_DIR 
>into a file, then fails, and then checking the exact contents of GIT_DIR?

This would not catch this bug: for-each-ref is the only git command
called after changing to the temporary directory and before exporting
GIT_DIR.

It would help only if GIT_DIR would never be exported.

 - Lars.
