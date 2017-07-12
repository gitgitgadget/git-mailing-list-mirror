Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 212B620357
	for <e@80x24.org>; Wed, 12 Jul 2017 19:06:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752827AbdGLTGz (ORCPT <rfc822;e@80x24.org>);
        Wed, 12 Jul 2017 15:06:55 -0400
Received: from mail-pg0-f47.google.com ([74.125.83.47]:33117 "EHLO
        mail-pg0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752434AbdGLTGz (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 12 Jul 2017 15:06:55 -0400
Received: by mail-pg0-f47.google.com with SMTP id k14so17508099pgr.0
        for <git@vger.kernel.org>; Wed, 12 Jul 2017 12:06:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=gDI7mfNGVoUvs8DOHjBv1lv2hdOHxoKfW0Dki0cU89w=;
        b=oV8L2qF/POiUsvLR0SESNEl4LVrP+toSdmb9RoBMlD+2HTHtiCjgqDZ0fd0fxrgCKi
         baPVJ1Ku2e1uRp1KS/cpsTVijjBmduI7+Cdhljv2n0olprby9JcigLf69ihBaS72Bgxi
         XWnf/U/+NQXcelTKOWCvzz4WjksOPVM6nten4N31YZ6gXtavSYYPdGZEj6K+CLzddB6i
         aRhZJ8CbAd0uvGLacEg2ApaBuLZInZX0T0UptZY8OFASyrTLWjbSxFC2Mene2z0w6xhb
         Aqf/pPBAX7CJg+XQVrS+WFPxjLC9IpUE6FRmdYHbDypnClsh7tA/B7IdsaaCtjIMWPve
         mEeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=gDI7mfNGVoUvs8DOHjBv1lv2hdOHxoKfW0Dki0cU89w=;
        b=iqQO3pBiaLs7jgHKkI0aLZL1kJWYsVCQlbT+Q8ggv5B4LQ8s5xzreC6lSiR/Bt8KzM
         X2Oju15Dpp9XHj1b3n6EvYl6nXEsyT3M/LUm4KTWfKmjWKI9CRiwlauSK2jnK+sVZZ2e
         a1cTAXNKIWVQu01Gyhyuk/YVr93y2NlGtkIQMOvcREpGIh855KH/j+K40a0lP3QtG85f
         gMBTP0HftVQoSQOsxzKFyPnWWMMzGmIdaMebSylXrCx3GSXEXMDAezDgESSIhZM8Xt+u
         fv31kiCv0QbQr6OVsF7NXejiqqGiLQlQSeSgootwRNhDpsl5PcOt0D6GrT7tuMX8+JKq
         qP0w==
X-Gm-Message-State: AIVw111Pages1UIt8e7UZXp60BUHIO2mbTzAQ0YHIpj3v8khBLMqw7lM
        iqIvTtoRFNx9xAdA
X-Received: by 10.99.158.18 with SMTP id s18mr5173899pgd.113.1499886413970;
        Wed, 12 Jul 2017 12:06:53 -0700 (PDT)
Received: from twelve2.svl.corp.google.com ([2620:0:100e:422:1ce6:29df:5a5f:94ee])
        by smtp.gmail.com with ESMTPSA id g79sm6853284pfg.121.2017.07.12.12.06.53
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Wed, 12 Jul 2017 12:06:53 -0700 (PDT)
Date:   Wed, 12 Jul 2017 12:06:47 -0700
From:   Jonathan Tan <jonathantanmy@google.com>
To:     Christian Couder <christian.couder@gmail.com>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Jeff King <peff@peff.net>, Ben Peart <Ben.Peart@microsoft.com>,
        Nguyen Thai Ngoc Duy <pclouds@gmail.com>,
        Mike Hommey <mh@glandium.org>,
        Lars Schneider <larsxschneider@gmail.com>,
        Eric Wong <e@80x24.org>,
        Christian Couder <chriscool@tuxfamily.org>
Subject: Re: [RFC/PATCH v4 00/49] Add initial experimental external ODB
 support
Message-ID: <20170712120647.6340f75a@twelve2.svl.corp.google.com>
In-Reply-To: <20170620075523.26961-1-chriscool@tuxfamily.org>
References: <20170620075523.26961-1-chriscool@tuxfamily.org>
X-Mailer: Claws Mail 3.9.3 (GTK+ 2.24.23; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, 20 Jun 2017 09:54:34 +0200
Christian Couder <christian.couder@gmail.com> wrote:

> Git can store its objects only in the form of loose objects in
> separate files or packed objects in a pack file.
> 
> To be able to better handle some kind of objects, for example big
> blobs, it would be nice if Git could store its objects in other object
> databases (ODB).

Thanks for this, and sorry for the late reply. It's good to know that
others are thinking about "missing" objects in repos too.

>   - "have": the helper should respond with the sha1, size and type of
>     all the objects the external ODB contains, one object per line.

This should work well if we are not caching this "have" information
locally (that is, if the object store can be accessed with low latency),
but I am not sure if this will work otherwise. I see that you have
proposed a local cache-using method later in the e-mail - my comments on
that are below.

>   - "get <sha1>": the helper should then read from the external ODB
>     the content of the object corresponding to <sha1> and pass it to
> Git.

This makes sense - I have some patches [1] that implement this with the
"fault_in" mechanism described in your e-mail.

[1] https://public-inbox.org/git/cover.1499800530.git.jonathantanmy@google.com/

> * Transfering information
> 
> To tranfer information about the blobs stored in external ODB, some
> special refs, called "odb ref", similar as replace refs, are used in
> the tests of this series, but in general nothing forces the helper to
> use that mechanism.
> 
> The external odb helper is responsible for using and creating the refs
> in refs/odbs/<odbname>/, if it wants to do that. It is free for
> example to just create one ref, as it is also free to create many
> refs. Git would just transmit the refs that have been created by this
> helper, if Git is asked to do so.
> 
> For now in the tests there is one odb ref per blob, as it is simple
> and as it is similar to what git-lfs does. Each ref name is
> refs/odbs/<odbname>/<sha1> where <sha1> is the sha1 of the blob stored
> in the external odb named <odbname>.
> 
> These odb refs point to a blob that is stored in the Git
> repository and contain information about the blob stored in the
> external odb. This information can be specific to the external odb.
> The repos can then share this information using commands like:
> 
> `git fetch origin "refs/odbs/<odbname>/*:refs/odbs/<odbname>/*"`
> 
> At the end of the current patch series, "git clone" is teached a
> "--initial-refspec" option, that asks it to first fetch some specified
> refs. This is used in the tests to fetch the odb refs first.
> 
> This way only one "git clone" command can setup a repo using the
> external ODB mechanism as long as the right helper is installed on the
> machine and as long as the following options are used:
> 
>   - "--initial-refspec <odbrefspec>" to fetch the odb refspec
>   - "-c odb.<odbname>.command=<helper>" to configure the helper

A method like this means that information about every object is
downloaded, regardless of which branches were actually cloned, and
regardless of what parameters (e.g. max blob size) were used to control
the objects that were actually cloned.

We could make, say, one "odb ref" per size and branch - for example,
"refs/odbs/master/0", "refs/odbs/master/1k", "refs/odbs/master/1m", etc.
- and have the client know which one to download. But this wouldn't
scale if we introduce different object filters in the clone and fetch
commands.

I think that it is best to have upload-pack send this information
together with the packfile, since it knows exactly what objects were
omitted, and therefore what information the client needs. As discussed
in a sibling e-mail, clone/fetch already needs to be modified to omit
objects anyway.
