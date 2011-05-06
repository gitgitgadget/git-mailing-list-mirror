From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [PATCH v2] status: display "doing what" information in git status
Date: Fri, 06 May 2011 03:13:55 -0700 (PDT)
Message-ID: <m3oc3guogs.fsf@localhost.localdomain>
References: <7vr58c4sip.fsf@alter.siamese.dyndns.org>
	<1304667535-4787-1-git-send-email-madcoder@debian.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>, Git ML <git@vger.kernel.org>
To: Pierre Habouzit <madcoder@debian.org>
X-From: git-owner@vger.kernel.org Fri May 06 12:14:18 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QII38-0006MR-HB
	for gcvg-git-2@lo.gmane.org; Fri, 06 May 2011 12:14:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755868Ab1EFKN7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 6 May 2011 06:13:59 -0400
Received: from mail-wy0-f174.google.com ([74.125.82.174]:44663 "EHLO
	mail-wy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755601Ab1EFKN6 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 6 May 2011 06:13:58 -0400
Received: by wya21 with SMTP id 21so2279853wya.19
        for <git@vger.kernel.org>; Fri, 06 May 2011 03:13:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:x-authentication-warning:to:cc:subject
         :references:from:date:in-reply-to:message-id:lines:user-agent
         :mime-version:content-type;
        bh=bptJMpYY8Z+Y5GVArYer7EZP7tCr94koqBKczZER/DM=;
        b=amu3PLahq0AgTMBnUuMAKAPkkTYBYUgEp5GVUttR2xhYCmWkGQnKf7DygO/+RcZAa7
         FWE3qnWP20z2WHjqKjO0UBfyvIu4IPzHnx2SiXMpO4AomsF/hbnYJ8sC34wKUmLtqcbP
         yW2BkAeSWaohwCeV3NCj12F5LphM0diXqUezA=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=x-authentication-warning:to:cc:subject:references:from:date
         :in-reply-to:message-id:lines:user-agent:mime-version:content-type;
        b=bmuQwsHKu4+5Ftng4ziDjgeybHJpDCkQ595cWjv319eAegxWso/liBs1Y5eHUUe3GY
         JGRACK4z0BOQZbLHlxYOauyy2cJEQzSxX1BlvhVCfcxmCs8XBQv4nNxlBRs07pNDrDSR
         yyKxGKTzCq2Eh/zmdCmFGc0+SCTQWEpoVscGo=
Received: by 10.216.239.65 with SMTP id b43mr1008136wer.29.1304676836809;
        Fri, 06 May 2011 03:13:56 -0700 (PDT)
Received: from localhost.localdomain (aeho239.neoplus.adsl.tpnet.pl [79.186.196.239])
        by mx.google.com with ESMTPS id t5sm1528282wes.33.2011.05.06.03.13.53
        (version=TLSv1/SSLv3 cipher=OTHER);
        Fri, 06 May 2011 03:13:55 -0700 (PDT)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by localhost.localdomain (8.13.4/8.13.4) with ESMTP id p46ADE5P009745;
	Fri, 6 May 2011 12:13:25 +0200
Received: (from jnareb@localhost)
	by localhost.localdomain (8.13.4/8.13.4/Submit) id p46ACqXw009659;
	Fri, 6 May 2011 12:12:52 +0200
X-Authentication-Warning: localhost.localdomain: jnareb set sender to jnareb@gmail.com using -f
In-Reply-To: <1304667535-4787-1-git-send-email-madcoder@debian.org>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/172967>

Pierre Habouzit <madcoder@debian.org> writes:

> This provides the same information as the git bash prompt about the
> current operation that is going on: rebase, merge, am, cherry-pick or
> bisect.
> 
> This is very useful for "beginners" who don't have their shell prompt set
> up for git.
> 
> The logic has been largely borrowed from
> contrib/completion/git-completion.bash

Very nice idea.
 
> when hints are enabled, it also gives hints on how to abort or resolve

s/^when/When/

> If we have an ongoing operation then:
> - if we are on a branch it displays:
>   # On branch $branch ($what_is_ongoing)
>   #   ($ongoing_hint)
> - if we are on a detached head it displays:
>   # $what_is_ongoing (detached head)
>   #   ($ongoing_hint)
> 
> If we have no ongoing operation the git status does as before:
> - if we are on a branch it displays:
>   # On branch $branch
> - if we are on a detached head it displays:
>   # Not currently on any branch.

Very nice to have such example in commit message.
 
> Since the ongoing operation is usually something to be done with before
> continuing with further git operations, the hint and ongoing operations
> are displayed with the "WT_STATUS_NOBRANCH" color to be easy to spot.
> 
> Signed-off-by: Pierre Habouzit <madcoder@debian.org>
> ---
>  wt-status.c |  138 ++++++++++++++++++++++++++++++++++++++++++++++++++++------
>  1 files changed, 123 insertions(+), 15 deletions(-)

Could you please add some *tests* for this new feature?  

Don't forget to mark it with C_LOCALE_OUTPUT or use test_i18ncmp /
/ test_i18ngrep in tests.
 
> +static void wt_status_print_doingwhat(struct wt_status *s)
> +{
> +	const char *status_nobranch = color(WT_STATUS_NOBRANCH, s);
> +	const char *branch_name = s->branch;
> +	const char *advice = NULL;
> +
> +	const char * const rebase_advice =
> +		_("use \"git rebase --abort\" to abort current rebase or proceed");
> +	const char * const am_advice =
> +		_("use \"git am --abort\" to abort current mailbox apply or proceed");
> +	const char * const merge_advice =
> +		_("use \"git reset --hard\" to abort, or resolve conflicts and commit");

Thanks for marking it up for i18n... though I am not sure if we should
use _() or N_() here...

-- 
Jakub Narebski
Poland
ShadeHawk on #git
