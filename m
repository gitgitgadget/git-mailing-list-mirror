Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD,T_DKIM_INVALID shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5F6D9202A0
	for <e@80x24.org>; Wed,  1 Nov 2017 19:59:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933147AbdKAT7S (ORCPT <rfc822;e@80x24.org>);
        Wed, 1 Nov 2017 15:59:18 -0400
Received: from mail-qt0-f170.google.com ([209.85.216.170]:50852 "EHLO
        mail-qt0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932705AbdKAT7R (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 1 Nov 2017 15:59:17 -0400
Received: by mail-qt0-f170.google.com with SMTP id d9so4141368qtd.7
        for <git@vger.kernel.org>; Wed, 01 Nov 2017 12:59:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc:content-transfer-encoding;
        bh=CK0GKa+9ugyEPimkkTHVeka/fxC5GjNvAPbg0n++gOg=;
        b=WjD9kIDhamtwbeSJdKhLID44Q971MST7jI6VoDpqKunTH3kwrwXKS129Kcn6koDigE
         xOf2QKZb4blJsT2QgAAoNvHP6fmZdWki7c61qchcEkrd0zEgt36EiEmMyOHFNi7ZJQyv
         nf0+Pb2mML/W+blAaJbgWlz09NIuNE93W6i7m47ioIawVJCFFtbHHgKUpoSr6yFvG6F/
         2l8DW5QoDecVCDDawKdK1Vno0jALVmUofGMSFO3Zi3yYAcMhs7QV8FY8p7gJMpBiBKpe
         0ckYixx7smG0ZD1EnhIzb6FtmsykDXcFXwVllJQF+0ko8uneirSg/s12ms43w8QGQxsG
         l1Tg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:from
         :date:message-id:subject:to:cc:content-transfer-encoding;
        bh=CK0GKa+9ugyEPimkkTHVeka/fxC5GjNvAPbg0n++gOg=;
        b=ljQfpmYB98dfv1JizIjTQ8Q1ZAoKwtN/JXqePtxexA9zy4uXmtTTiMZBDlHbAH8ucZ
         EF9/BgsBDXulUH+lS/UVC3bzIsUdEjI2XQ8t5m/5RkRbEWCN0bp7QhSZeqILr3iaT79e
         tePZyJmHfkE7J/BEPXU9NP52EPpol8VH6DSeJztNSwee8WmXHAr06PatckrmqBXJBK41
         KZbTy/SDsjPQr6ZkZJi2I9R27ggmkYDR8xoNjdYYZh05QB3oEB+I8E5pAeXi/q0gp6b9
         vkBSL23qEIxXnkOFyZxivEHRbn4DWu/bfLzu0SxiwZ97GKukTja3XnmyUwt0TEJp/hIh
         qPrg==
X-Gm-Message-State: AMCzsaVIlbk5xPLPeygVeityDDl877CdlWPrFyTHo6XmcpfvytxSjNVa
        kWmpGMuZb0VoXxSURbjf8Y6wP7vWyUJCoKULkow=
X-Google-Smtp-Source: ABhQp+Qe8PRfNfwdgkUTNOiEkoWZ09KXzTgdsvHl62RlfjrjYqDRH8Xcmw4+Hdxe0ZscSiRWC3yzJtjtDNf7NozUBkc=
X-Received: by 10.200.56.83 with SMTP id r19mr1578252qtb.293.1509566356867;
 Wed, 01 Nov 2017 12:59:16 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.12.146.118 with HTTP; Wed, 1 Nov 2017 12:59:16 -0700 (PDT)
In-Reply-To: <20171030025142.19421-7-anarcat@debian.org>
References: <20171029160857.29460-2-anarcat@debian.org> <20171030025142.19421-1-anarcat@debian.org>
 <20171030025142.19421-7-anarcat@debian.org>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Wed, 1 Nov 2017 15:59:16 -0400
X-Google-Sender-Auth: mPmPQhqNn43h976idqavQOhfTDo
Message-ID: <CAPig+cSKxaMkaHMKwRWB716RZ1=yBWFDaWJFFCNa29TUc+rpNQ@mail.gmail.com>
Subject: Re: [PATCH 6/7] remote-mediawiki: process namespaces in order
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
> Ideally, we'd process them in numeric order since that is more
> logical, but we can't do that yet since this is where we find the
> numeric identifiers in the first place. Lexicographic order is a good
> compromise.

The reader of this commit message is left with the question: Why is
this change needed? Is it for the benefit of a human eventually seeing
the output? Is it because a subsequent patch requires a certain order?

> Signed-off-by: Antoine Beaupr=C3=A9 <anarcat@debian.org>
> ---
>  contrib/mw-to-git/git-remote-mediawiki.perl | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/contrib/mw-to-git/git-remote-mediawiki.perl b/contrib/mw-to-=
git/git-remote-mediawiki.perl
> index 2c2a7367b..5199af6f6 100755
> --- a/contrib/mw-to-git/git-remote-mediawiki.perl
> +++ b/contrib/mw-to-git/git-remote-mediawiki.perl
> @@ -263,7 +263,7 @@ sub get_mw_tracked_categories {
>
>  sub get_mw_tracked_namespaces {
>      my $pages =3D shift;
> -    foreach my $local_namespace (@tracked_namespaces) {
> +    foreach my $local_namespace (sort @tracked_namespaces) {
>          my ($namespace_id, $mw_pages);
>          if ($local_namespace eq "(Main)") {
>              $namespace_id =3D 0;
> --
