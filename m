Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 23E641F4F8
	for <e@80x24.org>; Thu, 13 Oct 2016 10:37:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753933AbcJMKg7 (ORCPT <rfc822;e@80x24.org>);
        Thu, 13 Oct 2016 06:36:59 -0400
Received: from mail-it0-f46.google.com ([209.85.214.46]:36456 "EHLO
        mail-it0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752940AbcJMKg5 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 13 Oct 2016 06:36:57 -0400
Received: by mail-it0-f46.google.com with SMTP id l13so176607854itl.1
        for <git@vger.kernel.org>; Thu, 13 Oct 2016 03:36:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=v4ELhSjiYq5jlvl9HOU5KfWIPcgT1CE0XnftRShstJg=;
        b=CLLMuuM5Lxk6PK7hwzoNGEioUQQZTAXFDTWtFUDdu/z53LbK4YkDbgj1eAedgXfWgX
         HblnHqpfsnsabPJYrmDiSGsiVMhs8+4HmwK3W6QlMP2sBK44uMNLl66NJz3tjKLi/Q6+
         cJXJapAFqtJ2HkiMbTM899+jgZP3p5G1RtI28Uew6ao4U04NavLsfpCfDjQy88bhwcg1
         7Yb4c1g7X+STlagtG/lg0Y5uLXtHafcBrid8HEBrg3ELLrbiJER6JRdV/M/jQ6ebZnNg
         fzAR9I6GUZw3T/GhxP7UvobnT+tQfNlgTdKctu4UJ6a+NgfjXxSUXHBS6GjgEjrtmv5Y
         CEWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=v4ELhSjiYq5jlvl9HOU5KfWIPcgT1CE0XnftRShstJg=;
        b=YFJnJTayoiW8yf1C6WQMxPZmC9UidAASxlBNYMQauWL8bvMMQhBsw90+TMMm2FJiS1
         wRxKJCBlPGKqFp8nUzpwyE7RC/tt+uDsYSEckIa7iDuqsQqSgmcCRTLOyspltpsMDuk7
         pND5ZVNBvOWWol8j8EqqwTq1CV4qiOUmvTgrLOYJWizqfzLWlqvW8s3BmJgFV1IQPQbG
         GLZI1YJu8hRmZVDph0FpEu3qfpK/3Sdh90sE4EY6ePdKrQKBEsjFUdqRJ1cAFprJgxb3
         CYtwjaDU3dNbf+Yd+uCbrR770NKyAziJD2gu5k/x/QH/Fnj8IJ7W0TQylF78RtLCZzR7
         coYA==
X-Gm-Message-State: AA6/9RnvCCuTq3MIt38DiO8TRgGeFRxEa1tu/rrmFbgxTwl376GbtDq4B2mXHX9j0icZPebZKtrW8KPepthdDA==
X-Received: by 10.36.36.214 with SMTP id f205mr7129441ita.50.1476354597721;
 Thu, 13 Oct 2016 03:29:57 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.64.230.206 with HTTP; Thu, 13 Oct 2016 03:29:27 -0700 (PDT)
In-Reply-To: <20161013015233.GA18001@whir>
References: <6c83c905-b10a-7f54-873f-54186faacfc8@FreeBSD.org>
 <CAGZ79kZo5W1r0s26G3foB7caP6+u66mdzqzyneqXBX_B7A0RKg@mail.gmail.com> <20161013015233.GA18001@whir>
From:   Duy Nguyen <pclouds@gmail.com>
Date:   Thu, 13 Oct 2016 17:29:27 +0700
Message-ID: <CACsJy8ADmHLW5ba4bVTGN9ccqpMDNFgkqE_5JvnqZ0BxWcaCvw@mail.gmail.com>
Subject: Re: problem with git worktree and git svn
To:     Eric Wong <e@80x24.org>
Cc:     Mathieu Arnold <mat@freebsd.org>,
        Stefan Beller <sbeller@google.com>,
        Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Oct 13, 2016 at 8:52 AM, Eric Wong <e@80x24.org> wrote:
> +sub svn_dir {
> +       my $git_dir = scalar @_ ? $_[0] : $ENV{GIT_DIR};
> +       my $common = $ENV{GIT_COMMON_DIR} || "$git_dir/commondir";
> +       $git_dir .= '/'.::file_to_s($common) if -e $common;
> +       my $svn_dir = $git_dir . '/svn';
> +       $svn_dir =~ tr!/!/!s;
> +       $svn_dir;
> +}


If this is shell script, this function could be just

svn_dir() {
    git rev-parse --git-path svn
}

which should give you correct path in either single or multi-worktree
context and you don't need to bother with details like
$GIT_COMMON_DIR. But I don't know how Perl bindings are implemented, I
don't know if we have something similar (or easy to add it, like
Git::git_path()).

I don't know much about git-svn, but from the look of it I agree
replacing $ENV{GIT_DIR}/svn with svn_dir() should fix it, assuming
that you don't hard code $ENV{GIT_DIR}/blahblah somewhere else. I
don't see any other potential problems (from multi-worktree
perspective).
-- 
Duy
