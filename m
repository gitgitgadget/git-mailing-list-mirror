From: Geert Bosch <bosch@adacore.com>
Subject: Re: [PATCH] pull --rebase: exit early when the working directory is dirty
Date: Wed, 21 May 2008 11:11:20 -0400
Message-ID: <626F2244-15CE-481C-A8F5-D6744F06D46F@adacore.com>
References: <alpine.DEB.1.00.0805211230290.30431@racer>
Mime-Version: 1.0 (Apple Message framework v919.2)
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, gitster@pobox.com
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Wed May 21 17:14:19 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JypzD-0001ul-CF
	for gcvg-git-2@gmane.org; Wed, 21 May 2008 17:12:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758301AbYEUPLX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 21 May 2008 11:11:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758954AbYEUPLX
	(ORCPT <rfc822;git-outgoing>); Wed, 21 May 2008 11:11:23 -0400
Received: from rock.gnat.com ([205.232.38.15]:43141 "EHLO rock.gnat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1758301AbYEUPLW (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 21 May 2008 11:11:22 -0400
Received: from localhost (localhost.localdomain [127.0.0.1])
	by filtered-rock.gnat.com (Postfix) with ESMTP id 6F3F02A99A0;
	Wed, 21 May 2008 11:11:21 -0400 (EDT)
Received: from rock.gnat.com ([127.0.0.1])
	by localhost (rock.gnat.com [127.0.0.1]) (amavisd-new, port 10024)
	with LMTP id ZD2IHk584v44; Wed, 21 May 2008 11:11:21 -0400 (EDT)
Received: from [172.16.1.95] (sdsl-216-220-103-157.dsl.bway.net [216.220.103.157])
	(using TLSv1 with cipher AES128-SHA (128/128 bits))
	(No client certificate requested)
	by rock.gnat.com (Postfix) with ESMTP id 2E1EA2A9993;
	Wed, 21 May 2008 11:11:21 -0400 (EDT)
In-Reply-To: <alpine.DEB.1.00.0805211230290.30431@racer>
X-Mailer: Apple Mail (2.919.2)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/82552>


On May 21, 2008, at 07:32, Johannes Schindelin wrote:
> When rebasing fails during "pull --rebase", you cannot just clean up  
> the
> working directory and call "pull --rebase" again, since the remote  
> branch
> was already fetched.
>
> Therefore, die early when the working directory is dirty.
Much nicer indeed to die early on errors, as we also can
generally give better error messages.
> +	die "refusing to pull with rebase: your working tree is not up-to- 
> date"

I thought we'd prefer saying:
               "refusing to pull with rebase: your working tree has  
local changes"

   -Geert
