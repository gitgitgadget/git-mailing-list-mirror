From: Michael J Gruber <git@drmicha.warpmail.net>
Subject: Re: [PATCH] branch: say "Reset to" in reflog entries for 'git branch
 -f' operations
Date: Fri, 09 Apr 2010 19:55:06 +0800
Message-ID: <4BBF159A.1000206@drmicha.warpmail.net>
References: <1270799112-4308-1-git-send-email-rctay89@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
Cc: Git Mailing List <git@vger.kernel.org>
To: Tay Ray Chuan <rctay89@gmail.com>
X-From: git-owner@vger.kernel.org Fri Apr 09 13:55:23 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1O0Cny-0004N6-Ji
	for gcvg-git-2@lo.gmane.org; Fri, 09 Apr 2010 13:55:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751335Ab0DILzQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 9 Apr 2010 07:55:16 -0400
Received: from out2.smtp.messagingengine.com ([66.111.4.26]:40867 "EHLO
	out2.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750883Ab0DILzO (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 9 Apr 2010 07:55:14 -0400
Received: from compute1.internal (compute1.internal [10.202.2.41])
	by gateway1.messagingengine.com (Postfix) with ESMTP id 122C1EB365;
	Fri,  9 Apr 2010 07:55:14 -0400 (EDT)
Received: from heartbeat2.messagingengine.com ([10.202.2.161])
  by compute1.internal (MEProxy); Fri, 09 Apr 2010 07:55:14 -0400
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=messagingengine.com; h=message-id:date:from:mime-version:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding; s=smtpout; bh=mKxaJKcPD5YzCRxzb4JbXAO9GDs=; b=dm5V598h/zB/sdchCFPb4OtPlfOyE9QRf3y7g+OlhXsvCmITYhhTWg+/Pa8JM4a18kr9qJvO3WDHT27kiJ4ycQ5nSGYPgVdKgBBimNzzvoCLuNhWQ3V3OzAz/vW6PEUJpVl0YxQeSq0bZEHgF6ZR9okyOtIiYHpP4YVIGxquvLs=
X-Sasl-enc: xCKjzTaVoLd3NuESDOLgBU0SLo0I1BnaX1Ao3G4YVicR 1270814113
Received: from localhost.localdomain (unknown [202.113.236.7])
	by mail.messagingengine.com (Postfix) with ESMTPSA id 16DB135A9C;
	Fri,  9 Apr 2010 07:55:11 -0400 (EDT)
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.9.1.10pre) Gecko/20100319 Lightning/1.0b2pre Shredder/3.0.5pre
In-Reply-To: <1270799112-4308-1-git-send-email-rctay89@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/144425>

Tay Ray Chuan venit, vidit, dixit 09.04.2010 15:45:
> In 5f856dd (fix reflog entries for "git-branch"), it is mentioned that
> 'git branch -f' is intended to be equivalent to 'git reset'. Since we
> usually say "reset to <commit>" in the git-reset Documentation and
> elsewhere, it would make sense to say "Reset to" here as well.
> 

I know the patch is not large, but one really has to read it after
wondering: Huh? What is branch -f doing now before the patch? To me it
sounded as if it didn't write to the reflog at all. So, how about

elsewhere, it would make sense to say "Reset to" here as well rather
than "Rest from".

But I also have a functional question: Is "start_from" really the ref
*to* which the branch is reset? I hope reset does it right.

> Signed-off-by: Tay Ray Chuan <rctay89@gmail.com>
> ---
> 
>   I happened to be perusing my branch's reflog when I spotted this.
> 
>  branch.c |    2 +-
>  1 files changed, 1 insertions(+), 1 deletions(-)
> 
> diff --git a/branch.c b/branch.c
> index 9e1f63e..2ab42aa 100644
> --- a/branch.c
> +++ b/branch.c
> @@ -198,7 +198,7 @@ void create_branch(const char *head,
>  		log_all_ref_updates = 1;
> 
>  	if (forcing)
> -		snprintf(msg, sizeof msg, "branch: Reset from %s",
> +		snprintf(msg, sizeof msg, "branch: Reset to %s",
>  			 start_name);
>  	else if (!dont_change_ref)
>  		snprintf(msg, sizeof msg, "branch: Created from %s",
> --
> 1.7.1.rc0.240.gba75f
> 
