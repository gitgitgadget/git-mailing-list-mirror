From: Asheesh Laroia <asheesh@asheesh.org>
Subject: Re: [PATCH] Switch receive.denyCurrentBranch to "refuse"
Date: Thu, 29 Jan 2009 17:32:27 -0800 (PST)
Message-ID: <alpine.DEB.2.00.0901291729540.22558@vellum.laroia.net>
References: <cover.1233275583u.git.johannes.schindelin@gmx.de> <alpine.DEB.1.00.0901300133070.3586@pacific.mpi-cbg.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Cc: git@vger.kernel.org, gitster@pobox.com
To: Johannes Schindelin <johannes.schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Fri Jan 30 02:34:03 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LSiGg-0001cf-KQ
	for gcvg-git-2@gmane.org; Fri, 30 Jan 2009 02:34:03 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756097AbZA3Bci (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 29 Jan 2009 20:32:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756058AbZA3Bch
	(ORCPT <rfc822;git-outgoing>); Thu, 29 Jan 2009 20:32:37 -0500
Received: from rose.makesad.us ([219.105.37.19]:51191 "EHLO rose.makesad.us"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755429AbZA3Bcg (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 29 Jan 2009 20:32:36 -0500
Received: from vellum.laroia.net (localhost [127.0.0.1])
	by rose.makesad.us (Postfix) with ESMTP id D5B8FA00AE;
	Thu, 29 Jan 2009 20:32:34 -0500 (EST)
Received: from localhost (localhost [127.0.0.1])
	by vellum.laroia.net (Postfix) with ESMTPS id C34DB3A65B4;
	Thu, 29 Jan 2009 20:32:27 -0500 (EST)
X-X-Sender: paulproteus@vellum.laroia.net
In-Reply-To: <alpine.DEB.1.00.0901300133070.3586@pacific.mpi-cbg.de>
User-Agent: Alpine 2.00 (DEB 1167 2008-08-23)
X-OpenPGP-Key-ID: 0x70096AD1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/107763>

On Fri, 30 Jan 2009, Johannes Schindelin wrote:

> 	case DENY_REFUSE:
> -		if (!is_ref_checked_out(name))
> +		if (is_bare_repository() || !is_ref_checked_out(name))
> 			break;
> -		error("refusing to update checked out branch: %s", name);
> +		error("refusing to update checked out branch: %s\n"
> +			"if you know what you are doing, you can allow it by "
> +			"setting\n\n"
> +			"\tgit config receive.denyCurrentBranch true\n", name);

It seems like those new users you're trying to protect could use an 
additional sentence, like:

 	"A bare repository would not have this issue."

or

 	"You may prefer to have a bare repository instead."

Being told how to do it right is even better than being told that you're 
doing it wrong. (-:

-- Asheesh.

-- 
Fame is a vapor; popularity an accident; the only earthly certainty is
oblivion.
 		-- Mark Twain
