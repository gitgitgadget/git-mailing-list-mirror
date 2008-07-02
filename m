From: Brian Gernhardt <benji@silverinsanity.com>
Subject: Re: [PATCH] prevent checkout from creating branches that start with a dash
Date: Wed, 2 Jul 2008 11:22:14 -0400
Message-ID: <3B740C23-95C7-44AD-8A36-9EFA2EEF0E8A@silverinsanity.com>
References: <20080702150128.GH26300@jukie.net>
Mime-Version: 1.0 (Apple Message framework v926)
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Content-Transfer-Encoding: 7bit
Cc: Git Mailing List <git@vger.kernel.org>
To: Bart Trojanowski <bart@jukie.net>
X-From: git-owner@vger.kernel.org Wed Jul 02 17:23:25 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KE4Ay-00049W-8v
	for gcvg-git-2@gmane.org; Wed, 02 Jul 2008 17:23:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754050AbYGBPWS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 2 Jul 2008 11:22:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753701AbYGBPWS
	(ORCPT <rfc822;git-outgoing>); Wed, 2 Jul 2008 11:22:18 -0400
Received: from vs072.rosehosting.com ([216.114.78.72]:54146 "EHLO
	silverinsanity.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753652AbYGBPWS (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 2 Jul 2008 11:22:18 -0400
Received: from [172.24.32.221] (dfpub107.digitalfocus.com [65.120.79.7])
	(using TLSv1 with cipher AES128-SHA (128/128 bits))
	(No client certificate requested)
	by silverinsanity.com (Postfix) with ESMTP id 593521FFC02D;
	Wed,  2 Jul 2008 15:22:13 +0000 (UTC)
In-Reply-To: <20080702150128.GH26300@jukie.net>
X-Mailer: Apple Mail (2.926)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/87151>


On Jul 2, 2008, at 11:01 AM, Bart Trojanowski wrote:

> +	if (opts.new_branch && validate_branch_name(opts.new_branch))
> +		die("git checkout: '%s' does not look like a valid branch name",
> +				opts.new_branch);
> +
> 	if (argc) {
> 		const char **pathspec = get_pathspec(prefix, argv);

Perhaps this should have !opts.force in that if?  That way if someone  
needs something like "-mm" branch, they can have it.

And that way, if people really want to shoot themselves in the foot  
with a -f branch, they can?  "git branch -f -b -f"?

~~ Brian
