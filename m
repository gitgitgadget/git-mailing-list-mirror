Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B1E452089D
	for <e@80x24.org>; Fri, 28 Jul 2017 23:50:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753159AbdG1Xum (ORCPT <rfc822;e@80x24.org>);
        Fri, 28 Jul 2017 19:50:42 -0400
Received: from mail-pg0-f52.google.com ([74.125.83.52]:33405 "EHLO
        mail-pg0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752987AbdG1Xul (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 28 Jul 2017 19:50:41 -0400
Received: by mail-pg0-f52.google.com with SMTP id c14so24009244pgn.0
        for <git@vger.kernel.org>; Fri, 28 Jul 2017 16:50:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=+obWntseJyg/QJCIy+tmQOoNvI2vpzHiih6DGX7BYRk=;
        b=sg5gxW9WCxn/3Pu0RVYRBQpDt8Cw0+QtqMVQeJkSVHt5zJILV8OjOiZXT8IYAZSoHF
         v0oiGqymF6PQNXYD+oTqCxR9+j2VtWo3uPrkUy7+Be/veN2RFU55zurNFQmMLiB78X/Z
         oArkqpfpQgnaHet3TKhXNRmw12tMhxppC05UmRT4GmGyNqOrV1J6rhb4JdOAZDlP+O97
         vMdpixoo+y5OX/kQ0Ey3zenamYM3uDMKflrQOu4fSX+FcuLA00umb0awrjisnWdlo5Ua
         D/8/TG8PrUWLu/+/juQuIkQB0vxn6S92F9HScgyNw2d4S3zdlCXD7DVkkAny3FvLa1YW
         uVfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=+obWntseJyg/QJCIy+tmQOoNvI2vpzHiih6DGX7BYRk=;
        b=iW8lmBfEIfDYdKp68Ts/gcgcUtsRs5IsVyf9PHYiEeAF5iyMMGi/gqUsHpDcPkbYwZ
         JmLkRQt6nvL/2RUBYRjLAJQlQeH1DN/P1d/kmSGdlsOJJjtkbMS19KallnX2hJtm3smH
         pGDrb6MXl0qLvSTgYfImX+Gz0QHeCZfgSnYsVrOHIvKGvpQqWY1+wjQkd51V3GzXE03Y
         2DGI7bkFk1xncUoTrkRMD7UYRdM58Ovr+4RQmzJiUahN6/hJfDFs90EKoyuZ+LzQcwY6
         LmC1O8pdc4vnWEKEhPVXm574qNCmfHyZBF2m3ozGXUa+VIPpNdlFczT9fRFliyE/nyrV
         hE8A==
X-Gm-Message-State: AIVw1122egJsix6nlOoKLbFixRgWQQkPy1PUJG0mBSo66qW3W2phwxk4
        J7d8fUabL7ZrsY97
X-Received: by 10.99.121.1 with SMTP id u1mr8688730pgc.217.1501285840710;
        Fri, 28 Jul 2017 16:50:40 -0700 (PDT)
Received: from twelve2.svl.corp.google.com ([2620:0:100e:422:857b:d662:4289:61ab])
        by smtp.gmail.com with ESMTPSA id r2sm30915302pgs.85.2017.07.28.16.50.39
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Fri, 28 Jul 2017 16:50:40 -0700 (PDT)
Date:   Fri, 28 Jul 2017 16:50:35 -0700
From:   Jonathan Tan <jonathantanmy@google.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org, peartben@gmail.com, christian.couder@gmail.com
Subject: Re: [RFC PATCH 1/4] environment, fsck: introduce lazyobject
 extension
Message-ID: <20170728165035.2be61cec@twelve2.svl.corp.google.com>
In-Reply-To: <xmqqzibpn1zh.fsf@gitster.mtv.corp.google.com>
References: <cover.1501111615.git.jonathantanmy@google.com>
        <cover.1501111615.git.jonathantanmy@google.com>
        <75766ee26264e50b7fcb3c7a8cc5808907586799.1501111615.git.jonathantanmy@google.com>
        <xmqqzibpn1zh.fsf@gitster.mtv.corp.google.com>
X-Mailer: Claws Mail 3.9.3 (GTK+ 2.24.23; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, 27 Jul 2017 11:55:46 -0700
Junio C Hamano <gitster@pobox.com> wrote:

> My reading hiccupped after the first sentence, as the problem
> description made it sound like this was a boolean ("are we using
> lazy object feature?"), after reading "data type string".  And then
> "the command in that option" made me hiccup one more time, as it did
> not "click" that "in that option" was trying to say that the string
> is used as the command name (or is it a whole command line?  The
> leading part of the command line to which some arguments are
> appended before it gets invoked as a command? or what?).
> 
> Logically, I think it is more like
> 
>  - extensions.lazyobject can be set to tell Git to consider missing
>    objects in certain cases are not errors;
> 
>  - the value of extensions.lazyobject variable must be a string,
>    which is used to name the command to lazily make the object
>    "appear" in the repository on demand.

OK, I'll update the commit message in the next reroll.

> >  extern int repository_format_precious_objects;
> > +extern char *repository_format_lazy_object;
> 
> This is not a new problem, but I think these two should be
> called repository_extension_$NAME not repository_format_$NAME.

Looking at the original commit 067fbd4 ("introduce "preciousObjects"
repository extension", 2015-06-24), it seems that this was so named to
be analogous to the existing "struct repository_format { int version;
...}" => "int repository_format_version;". The existing
repository_format_$NAME thus seems reasonable to me.
