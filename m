Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD,T_DKIM_INVALID shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 90DC2202A0
	for <e@80x24.org>; Wed,  1 Nov 2017 19:56:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755167AbdKAT4x (ORCPT <rfc822;e@80x24.org>);
        Wed, 1 Nov 2017 15:56:53 -0400
Received: from mail-qt0-f174.google.com ([209.85.216.174]:53159 "EHLO
        mail-qt0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755157AbdKAT4w (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 1 Nov 2017 15:56:52 -0400
Received: by mail-qt0-f174.google.com with SMTP id 31so4130673qtz.9
        for <git@vger.kernel.org>; Wed, 01 Nov 2017 12:56:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc:content-transfer-encoding;
        bh=DPIqt8qSrKiP6Ip81ndu7DpIGr8v4RYfB99sEpUh6lc=;
        b=enosQH0X0sqFQCTTEOO3NLMjqtgSS1LDCaY+tuvTvWetGGY4ChlrXAF8yHnnbL6q+U
         kkNZnM/3aaDbu2JmHYizUeqthkFOhAUK21JN/Fy1X+suVJofU9IQp/SL4ebU14Ab70wm
         hHJYu/3e3Oko3Bcb4U3bJZTtMldj6zGzCQE04BA4Q0hXsH3A3A9FRK+TVnqMbWQV28HZ
         vGdHlFsekOoHPjz7L/Lh/SZO/Z1jZEOxxJinTpZSAeVNDX/FSpdldAUg/5YgEwzmPnw5
         mlnsbIHxMTA4ACvfeJJ6qdxQkJ7lnsxu60z6LBFWXVMupvN+HEebA8KtJbRi9J5WDrl5
         tfQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:from
         :date:message-id:subject:to:cc:content-transfer-encoding;
        bh=DPIqt8qSrKiP6Ip81ndu7DpIGr8v4RYfB99sEpUh6lc=;
        b=ib7/7rTzL7xLviEC+RtXsPkrVqkZFq4LKZLHL0+jHEqy+aOrl3TuA3ar5aT+o8SZxd
         ifCw6Xjrnbb6Or59tTev8g8jLXstJNNsZqqAoV//aHLpjXWD89MMZ2RQ1JdIqzP8uhGF
         0oNGFVJLXInSPQnzjuydzspCXhgsPi3sKOo0nBrrxalssiw4UPzCLsxjBDTJ5dST6NRC
         gUvk/hZJrP38B/7Jwl/xMxLhg3bf/xzQYugVgjrPd51GtGASKXLH4wy4XBcfX01JiFDZ
         lUppgIsJLTl2uv84qRguKY7nj9cAv9lQqTIoQ5OgX948eI36M4c1oPEt8qDATsEc12VA
         p6+w==
X-Gm-Message-State: AMCzsaVQ1o23slklo/mDoGmCvj/zZrCrIhv7e1gPKc4xBbLlZV9D+ftR
        ukHFtfeYdPKIkxHGIWe9QhDvvCcbEov5C/WG3To=
X-Google-Smtp-Source: ABhQp+RvO+HqaVG7RbMhDCTkSe3zdW8ZREsN032BW/4ot6DYvl/Bv6hV/Ec2S87BlAc26KeehTKaBKnZLBOOQJwPlzE=
X-Received: by 10.200.53.12 with SMTP id y12mr1787029qtb.84.1509566211771;
 Wed, 01 Nov 2017 12:56:51 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.12.146.118 with HTTP; Wed, 1 Nov 2017 12:56:51 -0700 (PDT)
In-Reply-To: <20171030025142.19421-6-anarcat@debian.org>
References: <20171029160857.29460-2-anarcat@debian.org> <20171030025142.19421-1-anarcat@debian.org>
 <20171030025142.19421-6-anarcat@debian.org>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Wed, 1 Nov 2017 15:56:51 -0400
X-Google-Sender-Auth: YNp5BtJK6_BiK0vJwYJ8sjXhEe0
Message-ID: <CAPig+cTX1kBCk-phodTanU1dmwjM_2TNevKyGvdCWonqhEU5Dg@mail.gmail.com>
Subject: Re: [PATCH 5/7] remote-mediawiki: support fetching from (Main) namespace
To:     =?UTF-8?Q?Antoine_Beaupr=C3=A9?= <anarcat@debian.org>
Cc:     Git List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sun, Oct 29, 2017 at 10:51 PM, Antoine Beaupr=C3=A9 <anarcat@debian.org>=
 wrote:
> When we specify a list of namespaces to fetch from, by default the MW
> API will not fetch from the default namespace, refered to as "(Main)"
> in the documentation:
>
> https://www.mediawiki.org/wiki/Manual:Namespace#Built-in_namespaces
>
> I haven't found a way to address that "(Main)" namespace when getting
> the namespace ids: indeed, when listing namespaces, there is no
> "canonical" field for the main namespace, although there is a "*"
> field that is set to "" (empty). So in theory, we could specify the
> empty namespace to get the main namespace, but that would make
> specifying namespaces harder for the user: we would need to teach
> users about the "empty" default namespace. It would also make the code
> more complicated: we'd need to parse quotes in the configuration.
>
> So we simply override the query here and allow the user to specify
> "(Main)" since that is the publicly documented name.

Thanks, this explanation makes the patch a lot clearer. More below...

> Signed-off-by: Antoine Beaupr=C3=A9 <anarcat@debian.org>
> ---
> diff --git a/contrib/mw-to-git/git-remote-mediawiki.perl b/contrib/mw-to-=
git/git-remote-mediawiki.perl
> @@ -264,9 +264,14 @@ sub get_mw_tracked_categories {
>  sub get_mw_tracked_namespaces {
>      my $pages =3D shift;
>      foreach my $local_namespace (@tracked_namespaces) {
> -        my $namespace_id =3D get_mw_namespace_id($local_namespace);
> +        my ($namespace_id, $mw_pages);
> +        if ($local_namespace eq "(Main)") {
> +            $namespace_id =3D 0;
> +        } else {
> +            $namespace_id =3D get_mw_namespace_id($local_namespace);
> +        }

I meant to ask this in the previous round, but with the earlier patch
mixing several distinct changes into one, I plumb forgot: Would it
make sense to move this "(Main)" special case into
get_mw_namespace_id() itself? After all, that function is all about
determining an ID associated with a name, and "(Main)" is a name.

>          next if $namespace_id < 0; # virtual namespaces don't support al=
lpages
> -        my $mw_pages =3D $mediawiki->list( {
> +        $mw_pages =3D $mediawiki->list( {

Why did the "my" of $my_pages get moved up to the top of the foreach
loop? I can't seem to see any reason for it. Is this an unrelated
change accidentally included in this patch?

>              action =3D> 'query',
>              list =3D> 'allpages',
>              apnamespace =3D> $namespace_id,
> --
