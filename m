From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [PATCH] config.c: Expand $HOME and tilde character in core.excludesfile
Date: Mon, 28 Jan 2008 14:32:51 -0800 (PST)
Message-ID: <m3y7a98ttg.fsf@localhost.localdomain>
References: <y7a9aaem.fsf@blue.sea.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Jari Aalto <jari.aalto@cante.net>
X-From: git-owner@vger.kernel.org Mon Jan 28 23:33:48 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JJcXy-0000cq-HX
	for gcvg-git-2@gmane.org; Mon, 28 Jan 2008 23:33:46 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1763116AbYA1Wc6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 28 Jan 2008 17:32:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1763068AbYA1Wc6
	(ORCPT <rfc822;git-outgoing>); Mon, 28 Jan 2008 17:32:58 -0500
Received: from fg-out-1718.google.com ([72.14.220.158]:33229 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1762978AbYA1Wc4 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 28 Jan 2008 17:32:56 -0500
Received: by fg-out-1718.google.com with SMTP id e21so1848385fga.17
        for <git@vger.kernel.org>; Mon, 28 Jan 2008 14:32:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:received:x-authentication-warning:to:cc:subject:references:in-reply-to:message-id:lines:user-agent:mime-version:content-type:from:date;
        bh=mT9BhvVlUZovskzejotMfm8Q0ZFsUJuoWawucYa5Kxw=;
        b=BebbuyuNyhaMcHOqiZJiUCF3STPIJ845tL+SioKuFKBnXdMrfvEvGcB54skiK4XuIUKJ/yVkHuLOGW+Lj7JtummpSOfssMbAiXbwCO7b466PSRCNuQYRV8IiUvmVTBuGnTPx5ErD/xk9H7VO581XK2c60MPzOSy0dvoSygRfMvc=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=x-authentication-warning:to:cc:subject:references:in-reply-to:message-id:lines:user-agent:mime-version:content-type:from:date;
        b=QtCU0EqqdhcYRARCzzoSyHfeAjDj2/XkqTrFLDf7+bHM/OEwsRlmqyVHt8lkekMS43ce66l9kX6gPwV4BZzYUgUs5BcL8CWIx3NbIgU0Wt8BPC4+dqD2DVzbwdaYrKS7c3rkXLvBzJxEkNPakThCfY201A9FVQD8WlaKjP2p7bk=
Received: by 10.82.150.20 with SMTP id x20mr10815867bud.5.1201559573926;
        Mon, 28 Jan 2008 14:32:53 -0800 (PST)
Received: from localhost.localdomain ( [83.8.198.108])
        by mx.google.com with ESMTPS id 35sm929756nfu.12.2008.01.28.14.32.50
        (version=TLSv1/SSLv3 cipher=OTHER);
        Mon, 28 Jan 2008 14:32:51 -0800 (PST)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by localhost.localdomain (8.13.4/8.13.4) with ESMTP id m0SMWjC6021732;
	Mon, 28 Jan 2008 23:32:46 +0100
Received: (from jnareb@localhost)
	by localhost.localdomain (8.13.4/8.13.4/Submit) id m0SMWi3H021729;
	Mon, 28 Jan 2008 23:32:44 +0100
X-Authentication-Warning: localhost.localdomain: jnareb set sender to jnareb@fuw.edu.pl using -f
In-Reply-To: <y7a9aaem.fsf@blue.sea.net>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/71905>

Jari Aalto <jari.aalto@cante.net> writes:

> * str_replace(): New function. Generic replace command.
> * str_replace_home(): New function. Substitute $HOME and tilde(~) in string.
> * git_default_config(): Pass core.excludesfile to str_replace_home().
> 
> Signed-off-by: Jari Aalto <jari.aalto AT cante.net>

First, git project does NOT use GNU ChangeLog convention for it's
commit messages.  We rather use descriptive commit messages.

Second, I'm not sure about str_replace... how it fits with strbufs?
AFAIK we try to use strbufs whenever possible and feasible, to avoid
errors in git.

Third, I agree that it is a good idea, but I'd rather have *full*
solution, i.e. for git to expand $HOME (or better yet any
environmental variable) and '~' everywhere, not only for
core.excludesfile, but also for --git-dir and GIT_DIR, for
core.worktree and --work-tree and GIT_WORK_TREE, and for all other
config variables and enviroment variables.

> ---
> 
>  From ac6941f5055b2acdded59627d228bbf03ba0d9fc

What does it mean? A bit cryptic, don't you think?


Comments on code below. One thing: we use tabs for indent, not
spaces.  You use spaces in your code, while context uses tabs.

> +char *str_replace(const char *str, const char *find, const char *replace)
> +{
> +        int maxlen   = strlen(str) + strlen(replace) + 1;
> +        char *start  = strstr(str, find);
> +        char *ptr    = (char *)malloc(maxlen);
> +        int len      = strlen(find);
> +        int llen, rlen;         /* left, right portion length */
> +
> +        if (start == (char *)NULL) {

There is no need to cast NULL. Besides, we write IIRC "if (!start)",
it is common enough idiom.

> +                strcpy( ptr, str);

Style: no space after opening parenthesis: "strcpy(ptr, str)".
Performance: I think it would be better to use stpcpy, although I'm
not quite sure if here too.

> +        }
> +        else{
> +                rlen = strlen(start) - strlen(find);
> +                llen = strlen(str) - strlen(start);
> +                strncpy( ptr, str, llen);
> +                strcat( ptr, replace);
> +                strncat( ptr, start + len, rlen); /* Does not add  '\0' */
> +                strcat( ptr, "");   /* Terminate with null string */

Performance suck here; although this is not time-critical path using
sequence of strcat is just bad style. And 'strcat( ptr, "");' just
takes the cake: use "ptr[len] = '\0'", ehere 'len' is calculated
length of string.

P.S. Junio, when do you think 1.5.4 would be finally released? We have
feature freeze still, isn't it?

-- 
Jakub Narebski
Poland
ShadeHawk on #git
