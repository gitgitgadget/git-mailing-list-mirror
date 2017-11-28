Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5C12120954
	for <e@80x24.org>; Tue, 28 Nov 2017 14:04:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752302AbdK1OEv (ORCPT <rfc822;e@80x24.org>);
        Tue, 28 Nov 2017 09:04:51 -0500
Received: from mail-pl0-f52.google.com ([209.85.160.52]:38304 "EHLO
        mail-pl0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751838AbdK1OEu (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 28 Nov 2017 09:04:50 -0500
Received: by mail-pl0-f52.google.com with SMTP id s10so242915plj.5
        for <git@vger.kernel.org>; Tue, 28 Nov 2017 06:04:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:subject:from:to:cc:in-reply-to:references:date
         :mime-version:content-transfer-encoding;
        bh=gBr5zMi2sO6CvHhakwBcBc3Nzuea5+CcdYLo2jEsV/M=;
        b=GJmifvwCqgtv8Ehe/+TPeH076SKfPU21z5dBI4IPE2n9dUuKPw2Q2r5Efuk3MyjT8R
         IgnQG1BgcbxwOUSGjGSvRSSgNXSHzL9gEYAyaf3kITrFxWn6IjBYk9wz6t0y0M3ToKFm
         krCj6jaJqDZDv1aqHxLDe3QpJdDgJEQt3kxtOWlueSIQMdVvLb6GeVZT8zrlsHxrcCZ2
         M2hFLcs5a25hjRx7AuOhVIp+xGvcb8kMfBJRbDUNsRJhGuiJPIC4p/iQxWhP1Fdm092g
         pc62kNRAOwfB6Mmiv6WGeqqMoYa3P73Mm1Bhnk1Aq9Ikl/wHqnbELDb32vcUMN0gDRIW
         1cbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:cc:in-reply-to
         :references:date:mime-version:content-transfer-encoding;
        bh=gBr5zMi2sO6CvHhakwBcBc3Nzuea5+CcdYLo2jEsV/M=;
        b=UXF5KEuwqtCFKZ2OtRLDVxllfLrbhvvHYXkRlXPVV1Eek6XSCP+6uL0b8w07LXSI3M
         I9om6bJxB/L9HBv2o1Qgj2cu8un44X7zez7U/cggTqsoR4khS0kzsAJU3p2oRvmCWJ7l
         brkv2NMKJ7jQ5XZpwQcMkrj590Z+5x1lpN++12LlfuYqjXuGoGURtKOhfY6r41mhQmhk
         U2QSW/jjnYovFXEEpesY3psryXlc00S1UwIZF2RJVIYW4P+UBCT58IPg8mtRaMqxTffT
         s/K5bWhblnuNbwEM6jvBnx5LUikFwZhRYx3v0VfP93WwwA7O98A98rK9DfYeYtC3qVA/
         SBmg==
X-Gm-Message-State: AJaThX4iKY54MD4cpNyYLLGQEEyz4v7KagAKLtGhY7LqjRRUJg5+xIZG
        v5jnFYhhF1hmE5XtHQUXxMjkZUSM
X-Google-Smtp-Source: AGs4zMYT6H52vL3/8WDLvYuIUYld9fB9MlteS421nhlNAXSQGwnbGZyixSg6LxIqY7YLH6DwXJXx0A==
X-Received: by 10.84.174.131 with SMTP id r3mr33754510plb.358.1511877890159;
        Tue, 28 Nov 2017 06:04:50 -0800 (PST)
Received: from unique-pc ([2405:204:7344:993e:9a3:d467:14f5:495b])
        by smtp.gmail.com with ESMTPSA id z78sm58193927pfk.115.2017.11.28.06.04.46
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 28 Nov 2017 06:04:48 -0800 (PST)
Message-ID: <1511877882.10193.2.camel@gmail.com>
Subject: Re: [PATCH v2 0/3] rebase: give precise error message
From:   Kaartic Sivaraam <kaartic.sivaraam@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Git mailing list <git@vger.kernel.org>
In-Reply-To: <xmqqpo8387hz.fsf@gitster.mtv.corp.google.com>
References: <xmqq60a3xdpw.fsf@gitster.mtv.corp.google.com>
         <20171127172104.5796-1-kaartic.sivaraam@gmail.com>
         <xmqqpo8387hz.fsf@gitster.mtv.corp.google.com>
Content-Type: text/plain; charset="ISO-8859-15"
Date:   Tue, 28 Nov 2017 19:34:42 +0530
Mime-Version: 1.0
X-Mailer: Evolution 3.22.6-1+deb9u1 
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, 2017-11-28 at 11:25 +0900, Junio C Hamano wrote:
> Kaartic Sivaraam <kaartic.sivaraam@gmail.com> writes:
> 
> > 1. "git rebase <upstream> <remote_branch>" does nothing
> 
> Not limited to "rebase", you do not muck with remote-tracking branch
> in your local repository, so it would be a bug if the above updated
> where the remote-tracking branch points at.
> 
> The form of "git rebase" with one extra argument (i.e. not rebasing
> the history that leads to the current checkout) is mere shorthand of
> checking that extra thing out before doing the rebase, i.e.
> 
> 	$ git rebase origin/next origin/maint
> 
> first checks out origin/maint (you'd get on a detached HEAD) and
> rebase the history leading to the detached HEAD on top of
> origin/next.  If it fast-forwards (and it should if you are talking
> about 'maint' and 'next' I publish), you'll end up sitting on a
> detached HEAD that points at origin/next.
> 
> There is nothing to see here.
> 

You're right. It was my mistake. It seems I didn't notice that I was
already on 'origin/next' before I did,

 	$ git rebase origin/next origin/maint

So (obviously) I thought it did nothing, sorry.


> > 2. It's possible to do "git rebase <upstream> <commit>"
> 
> Again, that's designed behaviour you can trigger by giving <commit>
> (not <branch>).  Very handy when you do not trust your upstream or
> yourself's ability to resolve potential conflicts as a trial run
> before really committing to perform the rebase, e.g.
> 
> 	$ git rebase origin master^0
> 

I can't comment about usefulness as I haven't used rebase in this way
but I'm pretty sure that this should be mentioned in the
"Documentation" to help those might be in bare need of syntax like this
to discover it.

Something like the following diff with additional changes to other
places that refer to <branch>,

diff --git a/Documentation/git-rebase.txt b/Documentation/git-rebase.txt
index 67d48e688..ba4a545bf 100644
--- a/Documentation/git-rebase.txt
+++ b/Documentation/git-rebase.txt
@@ -9,9 +9,9 @@ SYNOPSIS
 --------
 [verse]
 'git rebase' [-i | --interactive] [options] [--exec <cmd>] [--onto <newbase>]
-       [<upstream> [<branch>]]
+       [<upstream> [<ref>]]
 'git rebase' [-i | --interactive] [options] [--exec <cmd>] [--onto <newbase>]
-       --root [<branch>]
+       --root [<ref>]
 'git rebase' --continue | --skip | --abort | --quit | --edit-todo
 
 DESCRIPTION


If <ref> is the correct substitute <branch>, I could try to send a
patch that fixes this.


-- 
Kaartic
