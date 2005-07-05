From: Jon Seymour <jon.seymour@gmail.com>
Subject: Re: [PATCH] Fixlet for argument parsing in rev-list.
Date: Tue, 5 Jul 2005 19:14:32 +1000
Message-ID: <2cfc40320507050214154c0fff@mail.gmail.com>
References: <7vpstxg02q.fsf@assigned-by-dhcp.cox.net>
Reply-To: jon@blackcubes.dyndns.org
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: torvalds@osdl.org, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jul 05 11:15:53 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DpjWB-00063H-Ke
	for gcvg-git@gmane.org; Tue, 05 Jul 2005 11:15:03 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261464AbVGEJOk (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 5 Jul 2005 05:14:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261770AbVGEJOk
	(ORCPT <rfc822;git-outgoing>); Tue, 5 Jul 2005 05:14:40 -0400
Received: from rproxy.gmail.com ([64.233.170.206]:57293 "EHLO rproxy.gmail.com")
	by vger.kernel.org with ESMTP id S261464AbVGEJOc convert rfc822-to-8bit
	(ORCPT <rfc822;git@vger.kernel.org>); Tue, 5 Jul 2005 05:14:32 -0400
Received: by rproxy.gmail.com with SMTP id i8so828518rne
        for <git@vger.kernel.org>; Tue, 05 Jul 2005 02:14:32 -0700 (PDT)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=kaBMCPisGOt4WgzcOHcmSFCQExtiTkH5nIWJp61WzAOFR6aK2QNk5Ff+qrvt4NCzla4iqOGhTW5OLParrJliKT3eUOilmwuikd1qrJ3peWFi29Ky2d9kBzJ3VlU86xu7LgjmZA9WQy+zm+JR8exS4hCruKyWtPqfn6IfHFiQ6j8=
Received: by 10.38.181.12 with SMTP id d12mr3729602rnf;
        Tue, 05 Jul 2005 02:14:32 -0700 (PDT)
Received: by 10.38.104.42 with HTTP; Tue, 5 Jul 2005 02:14:32 -0700 (PDT)
To: Junio C Hamano <junkio@cox.net>
In-Reply-To: <7vpstxg02q.fsf@assigned-by-dhcp.cox.net>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

I ack the patch, though --show-breaks could use the same treatment.

jon.

On 7/5/05, Junio C Hamano <junkio@cox.net> wrote:
> The --merge-order flag does not take parameter so there is no
> point doing strncmp with the length.
> 
> Signed-off-by: Junio C Hamano <junkio@cox.net>
> ---
> 
>  rev-list.c |    2 +-
>  1 file changed, 1 insertions(+), 1 deletions(-)
> 
> diff --git a/rev-list.c b/rev-list.c
> --- a/rev-list.c
> +++ b/rev-list.c
> @@ -462,7 +462,7 @@ int main(int argc, char **argv)
>                         limited = 1;
>                         continue;
>                 }
> -               if (!strncmp(arg, "--merge-order", 13)) {
> +               if (!strcmp(arg, "--merge-order")) {
>                         merge_order = 1;
>                         continue;
>                 }
> ------------------------------------------------
> 
> 


-- 
homepage: http://www.zeta.org.au/~jon/
blog: http://orwelliantremors.blogspot.com/
