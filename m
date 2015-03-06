From: Akshay Aurora <akshayaurora@yahoo.com>
Subject: Re: [PATCH][GSoC] revision: forbid --graph and --no-walk usage
Date: Fri, 6 Mar 2015 10:38:56 +0530
Message-ID: <CAPGnZZ=WJcd=GWkMqq93RXpJz8jvqnaZctcF2Tni3qkO2vhSOw@mail.gmail.com>
References: <1425582632-28273-1-git-send-email-akshayaurora@yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Akshay Aurora <akshayaurora@yahoo.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Mar 06 06:09:07 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YTkVT-0005NV-3r
	for gcvg-git-2@plane.gmane.org; Fri, 06 Mar 2015 06:09:03 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751962AbbCFFI6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 6 Mar 2015 00:08:58 -0500
Received: from mail-wi0-f169.google.com ([209.85.212.169]:40635 "EHLO
	mail-wi0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751138AbbCFFI5 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 6 Mar 2015 00:08:57 -0500
Received: by wivr20 with SMTP id r20so865292wiv.5
        for <git@vger.kernel.org>; Thu, 05 Mar 2015 21:08:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc:content-type;
        bh=F1fjHVVuMP9VSKX2SHhYrJI6slImdfEm22Sq76U/Akg=;
        b=quyTDl4yAgLzJKAPSfARYmuhD/0ba8DvR2dBcDoz+9kr0aUxmqHhUqnVAhqQvQ6xjs
         Bb+684ho+kMpFOOw9XnDxslXkTrVZlfdq3dN3C0uO0SpoA/DVhfeM17uGdGk4kqwzAzW
         H2IfCllkVG3H9m+9SOXlkE/NGptDz590NIIwtZBmSjkrVlBZiVFEqOonmBOK7Aibe2M+
         JR+uDnyvbsnzuP+vWP/JoHCAC/gsZYG/fixiY99wtR5ncg2PuKgd0SSI27Lxb9dpqrcD
         OSYP+bn7FPVdp8H2ZLj2+FXqPZcmyiPMf5A++q78fNwRsAu4S0gf4PqraaLBu3iFkLA8
         lQqQ==
X-Received: by 10.194.239.134 with SMTP id vs6mr12760218wjc.158.1425618536385;
 Thu, 05 Mar 2015 21:08:56 -0800 (PST)
Received: by 10.27.45.1 with HTTP; Thu, 5 Mar 2015 21:08:56 -0800 (PST)
In-Reply-To: <1425582632-28273-1-git-send-email-akshayaurora@yahoo.com>
X-Google-Sender-Auth: bMkIgtTm83siAk69IIASMybFRfA
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/264888>

Not sure, why this mail is not showing on Gmane.

I used git to send the email, and tested it by sending the patch to
myself before sending it to the list.

On Fri, Mar 6, 2015 at 12:40 AM, Akshay Aurora <akshayaurora@yahoo.com> wrote:
> Signed-off-by: Akshay Aurora <akshayaurora@yahoo.com>
> ---
> This is my first patch for a GSoC Microproject, would be great to have your feedback.
>
>  revision.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/revision.c b/revision.c
> index bd027bc..d578652 100644
> --- a/revision.c
> +++ b/revision.c
> @@ -2248,7 +2248,8 @@ int setup_revisions(int argc, const char **argv, struct rev_info *revs, struct s
>          */
>         if (revs->reverse && revs->graph)
>                 die("cannot combine --reverse with --graph");
> -
> +       if (revs->no_walk && revs->graph)
> +               die("cannot combine --no-walk with --graph");
>         if (revs->reflog_info && revs->graph)
>                 die("cannot combine --walk-reflogs with --graph");
>         if (!revs->reflog_info && revs->grep_filter.use_reflog_filter)
> --
> 2.3.1
>



-- 
AA
