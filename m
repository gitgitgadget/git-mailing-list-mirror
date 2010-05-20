From: Michael J Gruber <git@drmicha.warpmail.net>
Subject: Re: git-status and git-diff now very slow in project with a submodule
Date: Thu, 20 May 2010 17:52:45 +0200
Message-ID: <4BF55ACD.3060009@drmicha.warpmail.net>
References: <ht3194$1vc$1@dough.gmane.org> <4BF50A92.3060209@atlas-elektronik.com> <ht36u4$lo4$1@dough.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Andy Parkins <andyparkins@gmail.com>
X-From: git-owner@vger.kernel.org Thu May 20 17:53:06 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OF83U-0001So-R1
	for gcvg-git-2@lo.gmane.org; Thu, 20 May 2010 17:53:05 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753623Ab0ETPwz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 20 May 2010 11:52:55 -0400
Received: from out1.smtp.messagingengine.com ([66.111.4.25]:44573 "EHLO
	out1.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751031Ab0ETPwy (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 20 May 2010 11:52:54 -0400
Received: from compute2.internal (compute2.internal [10.202.2.42])
	by gateway1.messagingengine.com (Postfix) with ESMTP id B2773F739C;
	Thu, 20 May 2010 11:52:53 -0400 (EDT)
Received: from heartbeat1.messagingengine.com ([10.202.2.160])
  by compute2.internal (MEProxy); Thu, 20 May 2010 11:52:53 -0400
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=messagingengine.com; h=message-id:date:from:mime-version:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding; s=smtpout; bh=CrQTKPy/g7v1mD3XiRJLz+V0Kho=; b=Rfm0ed6ujpcr9GMmsf0aYn/HFyDDcGpW+KGTn5Ln+vyXhhoD+tweNKxuQbckjSR/GapzSZqZgeu89Ak0PyVacJUrVYkhUaIJXxJMKZ5SZm+V+oCMXP5pnkfsgzQfIy890kj539ReAlzZk84c0sn93ZhAjxoeaYcDAFAIc4fT/2k=
X-Sasl-enc: 6JGQ1kqXyp4OmZZI1As3fBp2pcXiPf0wXBtV/HRMHDks 1274370773
Received: from localhost.localdomain (whitehead.math.tu-clausthal.de [139.174.44.12])
	by mail.messagingengine.com (Postfix) with ESMTPSA id 1B1C64B4341;
	Thu, 20 May 2010 11:52:52 -0400 (EDT)
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.9.2.5pre) Gecko/20100519 Lightning/1.0b2pre Lanikai/3.1pre
In-Reply-To: <ht36u4$lo4$1@dough.gmane.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/147395>

Andy Parkins venit, vidit, dixit 20.05.2010 13:37:
> Stefan Naewe wrote:
> 
>>> circumstances it is exactly right; however, I'd like to be able to turn
>>> off dirty
>>> detection in submodules.  Is this already possible, and I've just missed
>>> the configuration option?
>>
>> Maybe:
>>
>>    git config status.submodulesummary false
> 
> Hey! Thanks for the reply. Exactly the right option... except it doesn't work :-(
> 
> $ git --version
> git version 1.7.1
> $ git config status.submodulesummary
> false
> $ git status -uno
> # On branch master
> # Changed but not updated:
> #   (use "git add <file>..." to update what will be committed)
> #   (use "git checkout -- <file>..." to discard changes in working directory)
> #   (commit or discard the untracked or modified content in submodules)
> #
> #       modified:   ffmpeg (modified content)
> #
> no changes added to commit (use "git add" and/or "git commit -a")

You see: No submodule summary here!
Try setting the variable to true and see the difference. False is the
default.

Git needs to check the submodule in order to produce the "modified" line
even when no summary is required. Stopping Git from looking at the
submodule at all is impossible, I think. One could only hope that it
stops scanning after the first modification.

Michael
