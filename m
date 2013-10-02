From: John Keeping <john@keeping.me.uk>
Subject: Re: Automatically filling in git send-email arguments based on an
 existing e-mail
Date: Wed, 2 Oct 2013 11:19:30 +0100
Message-ID: <20131002101930.GH27238@serenity.lan>
References: <20131002082525.GU10217@login.drsnuggles.stderr.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: Matthijs Kooijman <matthijs@stdin.nl>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Oct 02 12:19:43 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VRJWw-0008Im-26
	for gcvg-git-2@plane.gmane.org; Wed, 02 Oct 2013 12:19:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753195Ab3JBKTj (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 2 Oct 2013 06:19:39 -0400
Received: from coyote.aluminati.org ([72.9.247.114]:49701 "EHLO
	coyote.aluminati.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753650Ab3JBKTh (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 2 Oct 2013 06:19:37 -0400
Received: from localhost (localhost [127.0.0.1])
	by coyote.aluminati.org (Postfix) with ESMTP id AFACC19803D;
	Wed,  2 Oct 2013 11:19:36 +0100 (BST)
X-Virus-Scanned: Debian amavisd-new at caracal.aluminati.org
X-Spam-Flag: NO
X-Spam-Score: -0.999
X-Spam-Level: 
X-Spam-Status: No, score=-0.999 tagged_above=-9999 required=6.31
	tests=[ALL_TRUSTED=-1, URIBL_BLOCKED=0.001] autolearn=ham
Received: from coyote.aluminati.org ([127.0.0.1])
	by localhost (coyote.aluminati.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 9C9AWfTfE9eF; Wed,  2 Oct 2013 11:19:36 +0100 (BST)
Received: from serenity.lan (mink.aluminati.org [10.0.7.180])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by coyote.aluminati.org (Postfix) with ESMTPSA id 3766C198044;
	Wed,  2 Oct 2013 11:19:32 +0100 (BST)
Content-Disposition: inline
In-Reply-To: <20131002082525.GU10217@login.drsnuggles.stderr.nl>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/235667>

On Wed, Oct 02, 2013 at 10:25:25AM +0200, Matthijs Kooijman wrote:
> sometimes when I send a patch, I want to reply it to an existing e-mail,
> using pretty much the same recipient list. Currently, I have to:
> 
>  - copy-paste the message id for --in-reply-to header
>  - copy one address for --to
>  - copy the other addresses for the --cc's
> 
> Since I can't just chuck a list of addresses into --cc and I need to
> quote every one because of the <> and spaces in there, this feels like
> it's more tedious than needed.
> 
> It seems like there should be a weay to just copy paste the headers from
> the original e-mail into the stdin of git send-email or a wrapper script
> and let it sort things out from there.
> 
> 
> Is there any interest in something like this? Does anyone else perhaps
> already have such a script lying around?

I have been working on this for a while, but haven't yet got anything
into a suitable state for submission (and haven't made progress on it
for a while).  My WIP is at:

    https://github.com/johnkeeping/git/tree/format-patch-msgstore

The idea is to introduce a new helper protocol so that you can implement
various ways of finding a message given a message-id; I've implemented
one that finds the message from gmane.

What's there works in format-patch but not with send-email, which
implements message IDs itself rather than forwarding the arguments to
format-patch and I haven't had time to investigate changing send-email
to work with these patches.
