Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E04EE200B9
	for <e@80x24.org>; Thu,  3 May 2018 14:58:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751246AbeECO6x (ORCPT <rfc822;e@80x24.org>);
        Thu, 3 May 2018 10:58:53 -0400
Received: from mail-oi0-f47.google.com ([209.85.218.47]:44576 "EHLO
        mail-oi0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751195AbeECO6t (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 3 May 2018 10:58:49 -0400
Received: by mail-oi0-f47.google.com with SMTP id e80-v6so16316264oig.11
        for <git@vger.kernel.org>; Thu, 03 May 2018 07:58:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=AjBRlvbz0nZwG0fmKTWiisuYxxla8/0t9gvilwEFB7w=;
        b=rnIU81sRp0aY4ZeKpJfw+hekVLhb4XvhhBWPoNklBIz+xfgw14l3OpOofGADpDa+FA
         Wz6X5tmFsGJO1HLTbFWP3ufYvaq9X2puPIZJw8LF6CzZ1G0vrFVQtaRE2k+0cB0UZVxg
         SI+tL0YLbKnEQLHrpnZ+1AEcrNa6D+Tz/bv53gyXMzMgjJSQ1dIS5xonACZqiwNkYb6U
         5ey1DZ/jCQxkamAQzkXWv4JW+8QW2VU+UVHK5lsr4tJhQgz8aYGd32x5Nnu8106nLfAm
         sFvtDedXanvnuB2KVACASN+C+bdd5+PQhPVU6qiPzn5KhzCdR+OtJIVKiVwJH17IKsYQ
         aUdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=AjBRlvbz0nZwG0fmKTWiisuYxxla8/0t9gvilwEFB7w=;
        b=uRsgQi0nibAZGqX4bxp66Z+rTQQLATvWR4OJB3PivGMN8JXG6clhhnEpnAo3HWksGz
         xffgpmhDREvRzOZtBx2mhhneZQ4Kfh93kyZaFYRh1T0jAMCg6cvwZJL5qrVlzCJotyir
         CwiGVEAjRRJ5+V6+Rx1yWnwPAplGKG/2SUROUbSFme1Wk00nz6vriyZABANeVOM5AOTy
         KR+KgO6LVOXmDXuTSlQFad0kupCunbL1ZgXVW1UakdeZHFMr8biBk8FTZLOtZpdhDktJ
         XHm0GQRI9oKGjmnoIOMJjx5qvN44eAzsOlaq7ri592zOco4HPfUAdNX0+bf6tnKcu/28
         xc5w==
X-Gm-Message-State: ALQs6tCakYM9da5MvJFkJJD6z8os4NcG5xoaulcw06xz04qAYeCZ9od5
        CrF0N4EaigjynkCrzg2zOJ/AYAYEeUXd/1bL9x4=
X-Google-Smtp-Source: AB8JxZqaY645vVvIffkSYZSI7OqoPxHSxuhYFVUoelSGYp4rqGBEffJ2BX8N3raL1UTcL96NzIWqECVbeSABGeavp3A=
X-Received: by 2002:aca:2e09:: with SMTP id u9-v6mr15204754oiu.228.1525359528711;
 Thu, 03 May 2018 07:58:48 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.74.178.133 with HTTP; Thu, 3 May 2018 07:58:18 -0700 (PDT)
In-Reply-To: <20180501213403.14643-14-sbeller@google.com>
References: <20180501213403.14643-1-sbeller@google.com> <20180501213403.14643-14-sbeller@google.com>
From:   Duy Nguyen <pclouds@gmail.com>
Date:   Thu, 3 May 2018 16:58:18 +0200
Message-ID: <CACsJy8BwAL=fmHG1kDJ+hK4gLOaYMjfVgDqYtEOnos09XhYKFw@mail.gmail.com>
Subject: Re: [PATCH 13/13] alloc: allow arbitrary repositories for alloc functions
To:     Stefan Beller <sbeller@google.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Jameson Miller <jamill@microsoft.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, May 1, 2018 at 11:34 PM, Stefan Beller <sbeller@google.com> wrote:
> @@ -501,9 +516,12 @@ void raw_object_store_clear(struct raw_object_store *o)
>  void object_parser_clear(struct object_parser *o)
>  {
>         /*
> -        * TOOD free objects in o->obj_hash.
> -        *

You need to free(o->obj_hash) too. If you just want to reuse existing
obj_hash[] then at least clear it, leave no dangling pointers behind.

>          * As objects are allocated in slabs (see alloc.c), we do
>          * not need to free each object, but each slab instead.
>          */
> +       clear_alloc_state(o->blob_state);
> +       clear_alloc_state(o->tree_state);
> +       clear_alloc_state(o->commit_state);
> +       clear_alloc_state(o->tag_state);
> +       clear_alloc_state(o->object_state);
>  }
-- 
Duy
