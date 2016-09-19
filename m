Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id F31E02070F
	for <e@80x24.org>; Mon, 19 Sep 2016 20:54:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752039AbcISUyJ (ORCPT <rfc822;e@80x24.org>);
        Mon, 19 Sep 2016 16:54:09 -0400
Received: from mail-yw0-f173.google.com ([209.85.161.173]:33189 "EHLO
        mail-yw0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751029AbcISUyI (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 19 Sep 2016 16:54:08 -0400
Received: by mail-yw0-f173.google.com with SMTP id i129so164070715ywb.0
        for <git@vger.kernel.org>; Mon, 19 Sep 2016 13:54:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=8oPzItRN3kmvt5/K4GjqU+wN0Yvj5CajGwxz0xk+jtY=;
        b=qvWTb9sD55fdET1tI35VFWZxVZBO14YiKlo5utPZe1UOvIYl8v7lo6u7K3SmOklLhG
         vVMUZpavg1JfqHQ849EnsWlk8s6InKHy+LUaJN492tePE1Vx1hunAVJnZVQo0YOmnaEI
         Ex+sCAh309+xE37XuUl834vXtLEnuCHzgdZB0JmB/AWMt+xAkJMaIA+2nZp4r21DA1NY
         aZQnf5C+IhcF5Pft9yavZadNMSq+E1iTtqKq6AkAB9IDjB3ZyvvBYZJJLyCYbDtdXC8Z
         3Hf6kidatmQPc9GDbW8Ai9RXt2Tell75f5FjLZ5nwVJvI24OWV3GKk4BjAzyKGrQgKrt
         ngNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=8oPzItRN3kmvt5/K4GjqU+wN0Yvj5CajGwxz0xk+jtY=;
        b=MEjRP6hpEQyxprN5jQc9HOC49s9OhPRjmwL3gW+cI/VD7D8RxOhl/4xwqRfjlyH2Qi
         XX9lwqCkmkPw4vOOv0TY11B/tSNgJDz/MOzglBKvFudGTjOod+WIdBtvpdSXKiFPoxA0
         ZZfGlc0kZ3wvnNMO9qfy+OffFD9e/UoGzG9XghbqwoT8YDYS96o5YhYW5NtSOFkTmTnR
         rh/EA3DZWgy0Kfo/u2kcrhF9+VbYQdpmrUQOoecUu6t+nzZefKB5E2QEyAovp7NWovZ9
         0STB9+sRkZjENOVVqnHnnP386XXO/s/3UnshVhL8Y60qg9h04GWxRAmVguFj8lrdg/G+
         8I/A==
X-Gm-Message-State: AE9vXwP4TyrzTFXP4X7kKrUF0wEYL9YSlUeB+BmRLCswxdjd2Qp3UepHnoBDNOTjJc3QW24oDzs/dJFi9CxpLg==
X-Received: by 10.129.78.18 with SMTP id c18mr27625840ywb.160.1474318448051;
 Mon, 19 Sep 2016 13:54:08 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.37.96.195 with HTTP; Mon, 19 Sep 2016 13:53:47 -0700 (PDT)
In-Reply-To: <1474317076.23916.6.camel@gmail.com>
References: <1474317076.23916.6.camel@gmail.com>
From:   Jacob Keller <jacob.keller@gmail.com>
Date:   Mon, 19 Sep 2016 13:53:47 -0700
Message-ID: <CA+P7+xp5ehLnuQjekhJ6mfRVmm-pdxm96wcCDfBH15Hj+RTuAg@mail.gmail.com>
Subject: Re: .git directory tree as tar-file
To:     Martin Bammer <mrbm74@gmail.com>
Cc:     Git mailing list <git@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Sep 19, 2016 at 1:31 PM, Martin Bammer <mrbm74@gmail.com> wrote:
> Hi,
>
> it would be nice to have an option to have a .git.tar instead of the .git
> directory tree. This tree quickly gets very big and copy and compare actions
> take very long. I've observed that even in small projects with only a few files
> the .git tree can contain several thousand entries. Especially when projects are
> saved on shares copy and compare actions are getting very slow.
> Is such a feature already planned or is there a chance to have such a feature in
> the near future?
>
> Best regards,
>

It sounds like you're mis-using the git directory and attempting to
share by copying it instead of using any of the protocols designed for
sharing such as local file, ssh, or https.

I don't believe that storing the git via compression is really a good
idea, as many of the operations inside are based on files and we
already try to keep things compressed using various methods already
(pack files)

If you want to actually share a git repository as a bundle, you can
generate such a bundle. See "git help bundle" for more information.

Regards,
Jake

> Martin
>
