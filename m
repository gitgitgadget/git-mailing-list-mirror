Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD,T_DKIM_INVALID shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C489320357
	for <e@80x24.org>; Mon, 17 Jul 2017 20:18:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751336AbdGQUSj (ORCPT <rfc822;e@80x24.org>);
        Mon, 17 Jul 2017 16:18:39 -0400
Received: from mail-pf0-f170.google.com ([209.85.192.170]:34015 "EHLO
        mail-pf0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751320AbdGQUSi (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 17 Jul 2017 16:18:38 -0400
Received: by mail-pf0-f170.google.com with SMTP id q85so284416pfq.1
        for <git@vger.kernel.org>; Mon, 17 Jul 2017 13:18:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=d8boI5Vxoweh6E/bK9oOaK1xTP6VzOfb8bTpF+rrIt4=;
        b=DgvW02RADvd61zQag4x4YKwlN7+ZB9OqgCI/rg1Ujcgu1lM/1o+4wNA+cM9mMuUvbh
         15Dkne1B7uXxfIPHevBRfc1RQI4R31LJCqEJM8+z7ZSYWlzy/QvIc/3r46+G6hce6FjZ
         7RZpncjMmb+GrefzkkJNoWg4e2vTBv3WPyF1fh2NQaT6JiFBcXbZaDwoyq3FUsQR58DE
         C+fDzmYvv8P7ZjNkKxbNELt4xq2EKoapW56SZLy060IB/d+VX2qunqf5O0Tz8TLQs8DU
         Ylo1HUf5ZJO2rKqTro/wq7F5ZiGmrc3a/rcbGzDBB/b40FmoCsh/tom+kA7+wpIsP0dK
         NQgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=d8boI5Vxoweh6E/bK9oOaK1xTP6VzOfb8bTpF+rrIt4=;
        b=i8CwT0hkjMWyFJO3l0ryD4F40b/2Llrbm35VpNSrI6hQI25PiIOBca9PrcEtGqhAry
         Cq6pmdkWGtYgArllorrCjAAlhDiJjJ/afcckdN1GrlO1+87w1ofGUidWdgfc51tNqy5T
         OvGfCnGiacI/X/MpiKphtdiMv9cC6FEUQdLd+HeczPfiSngfsxVz4IGcmJ7EO7nIxL2N
         xB9JWYOZ4wfEF3X4HdKGIgAmXHpmT8V4RNx4qsYOA1PxcG31R9302VwbLtuCzFWmxtXK
         k1CzKk7ziqF0NMspWBfThGaJU5SEVw+Em3Y7iUABrXBPw6ucPnYuscHj9wl1tWbZ0Fl1
         3wQA==
X-Gm-Message-State: AIVw1109RVPAydfUDosCJNWNFJOdNY7onMfEU05S+i40jw8fDDH6z7ba
        Gbx0In5yYoEfQQ==
X-Received: by 10.98.65.194 with SMTP id g63mr3936380pfd.196.1500322717982;
        Mon, 17 Jul 2017 13:18:37 -0700 (PDT)
Received: from localhost ([2620:0:1000:8622:480d:579b:4a3b:27f3])
        by smtp.gmail.com with ESMTPSA id k127sm169524pfc.75.2017.07.17.13.18.37
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Mon, 17 Jul 2017 13:18:37 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Hielke Christian Braun <hcb@unco.de>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH] check for search permission
References: <0102015d5203f2ae-c7f1daeb-a6ab-413d-9036-c8da816c4c18-000000@eu-west-1.amazonses.com>
Date:   Mon, 17 Jul 2017 13:18:36 -0700
In-Reply-To: <0102015d5203f2ae-c7f1daeb-a6ab-413d-9036-c8da816c4c18-000000@eu-west-1.amazonses.com>
        (Hielke Christian Braun's message of "Mon, 17 Jul 2017 19:26:16
        +0000")
Message-ID: <xmqqd18yhl5v.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hielke Christian Braun <hcb@unco.de> writes:

> ---
>  gitweb/gitweb.perl | 2 ++
>  1 file changed, 2 insertions(+)

Thanks for trying to help and welcome to Git development community.
But

 (1) Please double-check the title of your change.  Imagine that the
     title appears in a list of 600 other commits that goes in a
     single release in "git shortlog --no-merges" output.  Does it
     tell readers of the list what the change is about?  We cannot
     even guess that it is about the project list that appears in
     gitweb output.

 (2) Please explain what problem this is trying to solve; that is
     what the blank space before "---" line we see up above is for.
     What happens in the current code under what condition, until we
     do not apply this patch, and why is it a bad thing to happen?
     Once we apply this patch, in what way the situation gets
     improved?

 (3) Please sign-off your patch (see SubmittingPatches in
     Documentation).

Thanks.

>
> diff --git a/gitweb/gitweb.perl b/gitweb/gitweb.perl
> index 3d4a8ee27c96a..9208f42ed1753 100755
> --- a/gitweb/gitweb.perl
> +++ b/gitweb/gitweb.perl
> @@ -3071,6 +3071,8 @@ sub git_get_projects_list {
>  				return if (m!^[/.]$!);
>  				# only directories can be git repositories
>  				return unless (-d $_);
> +				# need search permission
> +				return unless (-x $_);
>  				# don't traverse too deep (Find is super slow on os x)
>  				# $project_maxdepth excludes depth of $projectroot
>  				if (($File::Find::name =~ tr!/!!) - $pfxdepth > $project_maxdepth) {
>
> --
> https://github.com/git/git/pull/384
