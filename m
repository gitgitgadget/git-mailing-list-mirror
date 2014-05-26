From: Jeremiah Mahler <jmmahler@gmail.com>
Subject: Re: [PATCH 01/15] builtin/add.c: rearrange xcalloc arguments
Date: Mon, 26 May 2014 16:11:56 -0700
Message-ID: <20140526231156.GA8570@hudson.localdomain>
References: <1401118436-66090-1-git-send-email-modocache@gmail.com>
 <1401118436-66090-2-git-send-email-modocache@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Brian Gesiak <modocache@gmail.com>
X-From: git-owner@vger.kernel.org Tue May 27 01:12:13 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Wp43r-0006eS-6O
	for gcvg-git-2@plane.gmane.org; Tue, 27 May 2014 01:12:07 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752126AbaEZXMD (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 26 May 2014 19:12:03 -0400
Received: from mail-pb0-f52.google.com ([209.85.160.52]:42411 "EHLO
	mail-pb0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751128AbaEZXMB (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 26 May 2014 19:12:01 -0400
Received: by mail-pb0-f52.google.com with SMTP id rr13so8217362pbb.25
        for <git@vger.kernel.org>; Mon, 26 May 2014 16:12:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:date:to:cc:subject:message-id:mail-followup-to:references
         :mime-version:content-type:content-disposition:in-reply-to
         :user-agent;
        bh=uvfVm6i4dgd4HZByg8qYRv7h4fQjtlBF1CuM4wqKPeA=;
        b=K7LcxFSiB7UEAKa0W/DHQY9GG/CdxXhdzbn5TZx44rxnqzA1Y87ZidNRSgK5A2VbYb
         VEFN9Zptt2i0ZAl67dLzlIQ63t5uO3od3qXx5eXqT6ZzAc5itQ0fnwkOg3JJPzU2dH/P
         aZitRWlQqGuQU8PxKWrw8KANHCJmNyO7cibO4BPITdCySX592CIvI1hVJjEP6FfX/TEC
         7kXZTY5i/rxR45ati+Vx1URvICq0P5TqKAr9Eh+LL2KhEMAw+XZX4cQzjK1shtg+x6tn
         bRGRFNzwECE79oKLP6W820DD15LhADrXsOeTfFL2QTT2y+jeOjRCJtoDBGvccbsPd1Bd
         ppsA==
X-Received: by 10.68.201.10 with SMTP id jw10mr31755210pbc.25.1401145920644;
        Mon, 26 May 2014 16:12:00 -0700 (PDT)
Received: from hudson (108-76-185-60.lightspeed.frokca.sbcglobal.net. [108.76.185.60])
        by mx.google.com with ESMTPSA id tl3sm64145514pac.41.2014.05.26.16.11.57
        for <multiple recipients>
        (version=TLSv1 cipher=RC4-SHA bits=128/128);
        Mon, 26 May 2014 16:11:59 -0700 (PDT)
X-Google-Original-From: "Jeremiah Mahler" <jeri@hudson>
Received: by hudson (sSMTP sendmail emulation); Mon, 26 May 2014 16:11:56 -0700
Mail-Followup-To: Jeremiah Mahler <jmmahler@gmail.com>,
	Brian Gesiak <modocache@gmail.com>, git@vger.kernel.org
Content-Disposition: inline
In-Reply-To: <1401118436-66090-2-git-send-email-modocache@gmail.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/250133>

Brian,

On Tue, May 27, 2014 at 12:33:42AM +0900, Brian Gesiak wrote:
> xcalloc takes two arguments: the number of elements and their size.
> run_add_interactive passes the arguments in reverse order, passing the
> size of a char*, followed by the number of char* to be allocated.
> Rearrgange them so they are in the correct order.
> 
> Signed-off-by: Brian Gesiak <modocache@gmail.com>
> ---
>  builtin/add.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/builtin/add.c b/builtin/add.c
> index 672adc0..488acf4 100644
> --- a/builtin/add.c
> +++ b/builtin/add.c
> @@ -248,7 +248,7 @@ int run_add_interactive(const char *revision, const char *patch_mode,
>  	int status, ac, i;
>  	const char **args;
>  
> -	args = xcalloc(sizeof(const char *), (pathspec->nr + 6));
> +	args = xcalloc((pathspec->nr + 6), sizeof(const char *));
>  	ac = 0;
>  	args[ac++] = "add--interactive";
>  	if (patch_mode)
> 

This patch doesn't apply to any of the branches I have available
(master, pu, next).  And there is no line containing "pathspec->nr + 6"
anywhere in my builtin/add.c.  Which branch is your work based off?

-- 
Jeremiah Mahler
jmmahler@gmail.com
http://github.com/jmahler
