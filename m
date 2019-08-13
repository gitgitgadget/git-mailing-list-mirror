Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	FROM_EXCESS_BASE64,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8A7061F45A
	for <e@80x24.org>; Tue, 13 Aug 2019 06:36:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727182AbfHMGgX (ORCPT <rfc822;e@80x24.org>);
        Tue, 13 Aug 2019 02:36:23 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:40647 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725820AbfHMGgX (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 13 Aug 2019 02:36:23 -0400
Received: by mail-wr1-f68.google.com with SMTP id r1so7570654wrl.7
        for <git@vger.kernel.org>; Mon, 12 Aug 2019 23:36:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=U6XrfFoOZEwn0LpiCNcyPUep2JR9t+va+t35aILsDlg=;
        b=pPqE7yAEoP6fU6Ge6SqauNNb/KP+AE43Yz1olU4idyv/cpqWFENPsF9oxySc00ZACZ
         YcsDp9aRaRfdWX0ifqJmq/PqzvQgoEVc1wemsW+JTHZK9uw2DcxGzxpMUntoGNAU9HaM
         Bjcr180v8oOFuJx+EVmq3h5g93lAW4puUeIUSceltHrv6THhOsoB35A675Z+uN5SkHZ7
         +mtw6zrzGHxUk85mV/v347+nLo9Okll0B1Vl+XCvNG+juCD7yYTRMa41jk7L28EGhbrq
         GUp+P9L38tSuL9I9J6AIL8sMX2MBPgNG3Vwi/3xRPTt1qbRKIoAfLVumRn79TKe7Rj2j
         IyYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=U6XrfFoOZEwn0LpiCNcyPUep2JR9t+va+t35aILsDlg=;
        b=mjcQnpY3hfiwqy/7b4X4JVbKNl+LnLOaw1PfX5zV91fkEFEyygpPmU+kzwVzaqMmsL
         UXd51Hw4uFQImQaxRBvrL9qqVOzwkdSKOJWVwT8Qwv2TwhYhP4x7AKTRyH3ioJyfyWF5
         B+WVVSQH2gWMYpTgPXt25mYcn3GVlHSJs759UuBI0MnrsuuODZsfVrFCARAq0J++6ce3
         rpuJVKwvY9MAUW+LRkz8x/VymABrKFTQasuH9zmJDGdJkvfDFX+x0rUykXYk1khgA7c+
         b9Rw5s8qAEKnEwk5s/xUbawyhjN2tqvXQrTMv8EoV47FeThGdxjVK+b/5EMhKN46C23I
         ebSA==
X-Gm-Message-State: APjAAAWbvzdrgExSsM8XLeF9gpOk4il3eamh2ZGER9eRL27+RiB153Wf
        wpobEKzqEFF1MDSVY+QoYaI=
X-Google-Smtp-Source: APXvYqxl5ax7xHBJfKA22u2foYAf6gP8TkvNBgq8qL+i9x+F+iTc3eMQS5UMEmx9p4XaiAwCRUTsqQ==
X-Received: by 2002:a05:6000:110f:: with SMTP id z15mr31883019wrw.162.1565678181459;
        Mon, 12 Aug 2019 23:36:21 -0700 (PDT)
Received: from szeder.dev (x4db44abf.dyn.telefonica.de. [77.180.74.191])
        by smtp.gmail.com with ESMTPSA id u186sm791222wmu.26.2019.08.12.23.36.19
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 12 Aug 2019 23:36:20 -0700 (PDT)
Date:   Tue, 13 Aug 2019 08:36:18 +0200
From:   SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     "brian m. carlson" <sandals@crustytoothpaste.net>,
        git@vger.kernel.org, Taylor Blau <me@ttaylorr.com>,
        Jeff King <peff@peff.net>
Subject: Re: [PATCH v2 1/2] path: add a function to check for path suffix
Message-ID: <20190813063618.GO20404@szeder.dev>
References: <20190809100217.427178-1-sandals@crustytoothpaste.net>
 <20190811174748.33552-1-sandals@crustytoothpaste.net>
 <20190811174748.33552-2-sandals@crustytoothpaste.net>
 <xmqq1rxrcjfp.fsf@gitster-ct.c.googlers.com>
 <20190812011054.GA9180@genre.crustytoothpaste.net>
 <xmqq7e7iba7j.fsf@gitster-ct.c.googlers.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqq7e7iba7j.fsf@gitster-ct.c.googlers.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Aug 12, 2019 at 09:49:20AM -0700, Junio C Hamano wrote:
> "brian m. carlson" <sandals@crustytoothpaste.net> writes:
> 
> > On 2019-08-12 at 00:32:26, Junio C Hamano wrote:
> >> "brian m. carlson" <sandals@crustytoothpaste.net> writes:
> >> > +static ssize_t stripped_path_suffix_offset(const char *path, const char *suffix)
> >> 
> >> Perhaps
> >> 
> >>     static ssize_t last_path_component_offset(const char *path, const char *name)
> >> 
> >> I am tempted to also call the second parameter to this function
> >> "basename", as we know from the proposed log message that you wish
> >> "basename" were usable for this purpose, but basename itself has
> >> another confusing factor (i.e. "are we stripping ".exe" extension?",
> >> to which the answer is no in the context of these functions).
> >> 
> >> If we agree with the "last path component" phrasing, has_path_suffix()
> >> would become something like:
> >> 
> >>     int last_path_component_equals(const char *path, const char *name);
> >
> > Except this is not necessarily the last path component. It could match
> > one or more path components with the way the function is written.
> 
> That's fair.  Is the feature that allows the function called
> ends_with_component*S* like Szeder suggests designed one, i.e. with
> an explicit purpose of supporting callers that pass "foo/bar" as the
> "suffix" to it, or is it merely that the implementation happens to
> work that way, even though the expected use that is supported is to
> pass only one level component but the implementation did not even
> bother asserting that the "suffix" does not have a slash in it?

The plural in the suggested function name was intentional on my part,
even though in this callsite in question we are only interested in the
filename, i.e. only a single path component.

I was hoping that the names of these related functions will be kept in
sync, and all will somehow contain the "path_components" substring,
e.g. strip_path_suffix() becomes strip_suffix_path_components() or
something.  And that function must be able to handle multiple path
components, becase there is this callsite:

  exec-cmd.c:         !(prefix = strip_path_suffix(executable_dirname, GIT_EXEC_PATH)) &&

and the build sets '-DGIT_EXEC_PATH="libexec/git-core"' by default.

