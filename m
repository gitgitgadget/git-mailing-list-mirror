Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.3 required=3.0 tests=AWL,BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD,T_DKIM_INVALID shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6049520196
	for <e@80x24.org>; Thu, 14 Jul 2016 16:57:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751805AbcGNQ5P (ORCPT <rfc822;e@80x24.org>);
	Thu, 14 Jul 2016 12:57:15 -0400
Received: from mail-io0-f176.google.com ([209.85.223.176]:34350 "EHLO
	mail-io0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751750AbcGNQ5N convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 14 Jul 2016 12:57:13 -0400
Received: by mail-io0-f176.google.com with SMTP id q83so81410061iod.1
        for <git@vger.kernel.org>; Thu, 14 Jul 2016 09:57:13 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=iOCMEfFySq/KWTHnrvLf9ThGmGyr8dvEDkjSEkNAnHI=;
        b=L7MkHsxlV+nTFs927PcYc2ht5DRrjarpuzEmszNPp6TOv9wsXEhjiOQaX9O46587U6
         XF2MEBXzYi1dCwZHN9sBG8fdFgL1jRuYSsNuF6i06xaaLBaQjli75SNN6YWHdWGbCJEd
         rSM3ChrcD9YSEsRFgvTbKDVZSZqt3DazJjUTcW9QSqLS3bUH6Zqzld8psBm5oiM4bRbk
         idWEp48uXBiPJQXQqVY3bEAakfHV+emk+zWZfh6W3snlXEebHvQ8qZQdRenkAdXrUK4S
         bT6ZUvjuJYqfesRuH8XO913gtbDVX+BuBXdOMs4K8GsmzBbnAwh72Hw50U4us+bWfpM7
         94oA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=iOCMEfFySq/KWTHnrvLf9ThGmGyr8dvEDkjSEkNAnHI=;
        b=DV82tS4Ty2K0NH/bkOpmprt/7xpWA4MMxauCX0k4Gyujg+IEmPOBimc3H9wHiEL4YJ
         Bg6MvKlq/a+e7+yTJLS0wSZldlBRKH08XWXHRdyUoAv6Ln7UROyP693wpuNGwEo7zO9m
         26Qjm0GlbGm9VEytc1wpbV8EbgX0yjdjxel6gng9W83a74MZGV64yrk+GRdoUWFT0FgG
         5MuNKxq8hx9tIEVjLOu/ZuEJjKGqw9Okkjbv7sBOKQPmPQNSlWmYAHL0WffkFEPrunVw
         vJs9T/eJXo8UOkNpGgPOH+upWAX559Rotg6nAdW1gTuZUxBqf/UCa30Gs4jdUfcJ+373
         EdkQ==
X-Gm-Message-State: ALyK8tKUERUf6x2Ow5XLFUQSLk+RBsp0XEYnol333ujuq7Cr6nAJybWoSrSEBKY/0a/xG1XvT6FqTRfIWsq/VD/K
X-Received: by 10.107.131.38 with SMTP id f38mr16322570iod.173.1468515432667;
 Thu, 14 Jul 2016 09:57:12 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.107.128.66 with HTTP; Thu, 14 Jul 2016 09:57:12 -0700 (PDT)
In-Reply-To: <alpine.DEB.2.20.1607141725390.25238@tglase.lan.tarent.de>
References: <alpine.DEB.2.20.1607141725390.25238@tglase.lan.tarent.de>
From:	Stefan Beller <sbeller@google.com>
Date:	Thu, 14 Jul 2016 09:57:12 -0700
Message-ID: <CAGZ79kb=2rpYucjhavNB_XHLk9rjKSoHzL9bwM5buDO0GyW3vw@mail.gmail.com>
Subject: Re: Server-side preventing some files from being overwritten
To:	Thorsten Glaser <t.glaser@tarent.de>
Cc:	"git@vger.kernel.org" <git@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

On Thu, Jul 14, 2016 at 8:31 AM, Thorsten Glaser <t.glaser@tarent.de> wrote:
> Hi *,
>
> is there a way, for example with some sort of pre-receive hook,
> to prevent some files from being overwritten by a push?

pre-receive hooks are a thing!

 pre-receive
       This hook is invoked by git-receive-pack on the remote
repository, which happens when a git push is done on a local
repository. Just before starting to update refs on the remote
repository,
       the pre-receive hook is invoked. Its exit status determines the
success or failure of the update.

       This hook executes once for the receive operation. It takes no
arguments, but for each ref to be updated it receives on standard
input a line of the format:

           <old-value> SP <new-value> SP <ref-name> LF

       where <old-value> is the old object name stored in the ref,
<new-value> is the new object name to be stored in the ref and
<ref-name> is the full name of the ref. When creating a new ref,
       <old-value> is 40 0.

       If the hook exits with non-zero status, none of the refs will
be updated. If the hook exits with zero, updating of individual refs
can still be prevented by the update hook.

       Both standard output and standard error output are forwarded to
git send-pack on the other end, so you can simply echo messages for
the user.


As you have access to the old and new value, just check them out to
/tmp and inspect the files?
(That is slower than optimal I'd assume, so to get it faster you could
go roughly like

    git ls-tree -r <oldvalue> | grep <certain dir>  >old_interest
    git ls-tree -r <newvalue> | grep <certain dir> >new_interest
    if diff old_interest new_interest
    then
        echo "There is a difference in  <certain dir>
        exit 1
    fi



>
> Use case:
>
> In some project, we use Flyway to manage the database schema,
> and Jenkins to automatically build master’s HEAD after each
> push (and install it, thus activating the schema files almost
> immediately). Now, I wish to prevent coworkers from changing
> anything in the SQL subdirectory that has ever been pushed,
> forcing them to push new SQL files with ALTER statements instead.
> (Yes, I am aware this will likely make me even less liked. No,
> this is not an issue.)
>
> As for the comparison, only the changes between the previous
> HEAD of master and the new HEAD of master after the push would
> have been accepted need to be taken into account; any intermediate
> commits, merges, etc. are no problem (because Jenkins does not
> build them, and because, once a push fails, the developer will
> have to add a commit reverting their change and moving it to
> another file on top, I’m no friend of rewriting).
>
> File matching would be “any files under a certain subdirectory”,
> nothing fancier than that.
>
> I’ve tried a web search (with two different search engines) for
> “git prevent pushed files from modification”, but this seems to
> only show people who want to ignore local changes or somesuch…
>
> I’ve asked in IRC, but with no answer for hours I thought that
> maybe this was the better place to ask for it.
>
> Thanks in advance,
> //mirabilos
> --
> tarent solutions GmbH
> Rochusstraße 2-4, D-53123 Bonn • http://www.tarent.de/
> Tel: +49 228 54881-393 • Fax: +49 228 54881-235
> HRB 5168 (AG Bonn) • USt-ID (VAT): DE122264941
> Geschäftsführer: Dr. Stefan Barth, Kai Ebenrett, Boris Esser, Alexander Steeg
> --
> To unsubscribe from this list: send the line "unsubscribe git" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
