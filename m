From: Jay Soffian <jaysoffian@gmail.com>
Subject: Re: [PATCH] fetch: ignore wildcarded refspecs that update local
 symbolic refs
Date: Wed, 12 Dec 2012 12:17:35 -0500
Message-ID: <CAG+J_Dw5jG4GoTuteD=w+CFG3ZbJsCB=coW9CAw=g7kz3cD2og@mail.gmail.com>
References: <1271694343-31876-2-git-send-email-jaysoffian@gmail.com>
	<1271714912-56659-1-git-send-email-jaysoffian@gmail.com>
	<7v62488j8a.fsf_-_@alter.siamese.dyndns.org>
	<7vmwxk6x0a.fsf_-_@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git@vger.kernel.org, "Shawn O . Pearce" <spearce@spearce.org>,
	Stefan Zager <szager@google.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Dec 12 18:18:01 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TipwS-0006lY-7t
	for gcvg-git-2@plane.gmane.org; Wed, 12 Dec 2012 18:17:56 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754598Ab2LLRRi (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 12 Dec 2012 12:17:38 -0500
Received: from mail-oa0-f46.google.com ([209.85.219.46]:33265 "EHLO
	mail-oa0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754413Ab2LLRRg (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 12 Dec 2012 12:17:36 -0500
Received: by mail-oa0-f46.google.com with SMTP id h16so1008782oag.19
        for <git@vger.kernel.org>; Wed, 12 Dec 2012 09:17:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=BDITNSSTeHR4DuYX3RB1IpYkvwbEaPqjyXxunGJkd0g=;
        b=tvby8TWVGDrbewXBgM7vTAyiGP86QbjMjWDoxMEC/x9pjK2eXHCTPxWulCsGA8pWpB
         Ooz2rk2yrVcNYS38jZKDerpQ5Vy33PeyPE9+iJ2gIdInPFv6VMYXpFc5H9xlia8OEhgu
         7wQKtkCUsrU+OVyAvHDOPU2hVYPm2NhV3iJtO5PgPSQTKdNDmkteFZH2HDCL1ePTLc60
         +kOXUrnVNAhUCh5oCUwnhhv38EghBDavgjW6mXXJDcGsLhQok4kS5xZZGbTOPLUpidsD
         LPsrludYfNasSPWMakJ2c5gIl31Zhr6Vp/hWKgIKKuDKCKUJBFRGH4myWBy3mdCmnwtt
         Qncw==
Received: by 10.182.41.6 with SMTP id b6mr833837obl.23.1355332656079; Wed, 12
 Dec 2012 09:17:36 -0800 (PST)
Received: by 10.60.39.35 with HTTP; Wed, 12 Dec 2012 09:17:35 -0800 (PST)
In-Reply-To: <7vmwxk6x0a.fsf_-_@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/211366>

On Tue, Dec 11, 2012 at 5:32 PM, Junio C Hamano <gitster@pobox.com> wrote:
> In a repository cloned from somewhere else, you typically have a
> [...]
>  * This time with minimal tests and an updated log message.

Sorry I haven't been reading the list much lately, so I don't know the
context which motivated this patch beyond the commit message. But,
this message is quite clear. So:

Acked-by: Jay Soffian

> diff --git a/remote.c b/remote.c
> index 04fd9ea..a72748c 100644
> --- a/remote.c
> +++ b/remote.c
> @@ -1370,6 +1370,16 @@ int branch_merge_matches(struct branch *branch,
>         return refname_match(branch->merge[i]->src, refname, ref_fetch_rules);
>  }
>
> +static int ignore_symref_update(const char *refname)

s/ignore_symref_update/is_existing_symref/ ?

j.
