Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,T_DKIMWL_WL_MED,USER_IN_DEF_DKIM_WL shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 470C91F516
	for <e@80x24.org>; Mon, 25 Jun 2018 22:28:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754435AbeFYW2D (ORCPT <rfc822;e@80x24.org>);
        Mon, 25 Jun 2018 18:28:03 -0400
Received: from mail-qt0-f201.google.com ([209.85.216.201]:33251 "EHLO
        mail-qt0-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752998AbeFYW2C (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 25 Jun 2018 18:28:02 -0400
Received: by mail-qt0-f201.google.com with SMTP id o68-v6so14512541qte.0
        for <git@vger.kernel.org>; Mon, 25 Jun 2018 15:28:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:date:in-reply-to:message-id:references:subject:from:to
         :cc;
        bh=p+i8GF4uRyWlwoYv1ULGVonsPe+Ait4UKyYAUAFBFPI=;
        b=XHqNbFzHNRUvNJGjeqXsizBTHFUIrOPDF4RsdDmh6HGnxe0IXXZ+evRkPHj2Qqhhh5
         rU6uNdsc4/nwn+ZhdUmnp8KAvVPlgPUH0BCwppH7wpsX6a8oX77ynZ+SUTQ8RSNioVMk
         oHOceHM17grwfGJ5N5dsKGq5CeqQ1JXDoQqzhKiiudnBuPZPVxKmDSXFmsnBAVyXJ5ot
         EDWYxy4lVYJe6QP4JZ0ZfKqbYy0/2e7ZyTHGJPuWPLQ8iWrIqcUuHTWbaOMHXqPrfG7H
         EDYqRgmM+3eofNxW0AVTqhzkCd5pN+Uveg/su+i9uc3gGlCthVxe1A4NZei/d8Ur7l29
         zpDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id
         :references:subject:from:to:cc;
        bh=p+i8GF4uRyWlwoYv1ULGVonsPe+Ait4UKyYAUAFBFPI=;
        b=A9SfAJqfvEMc/4NFLyl0bINkmrWI5m1NF0BPCuoPYxEXE5zyzTq4zuCbrf9lcBgRfP
         fJf/Rj2mzp+9M8kLCJ559qskKHsruYm6ydt9Yh90fJzFdWJJkjGOgZezO26y2Lr8NlfD
         +I0L3HS9LRxWSR7IOJdKu6QGPRgJx8kLtRxD6qZ4U/9/o5szcR/oucdahZDtVjOuG6jF
         202lchpaV35EhuQE7Sdi4pUEUGKVQtPOC3yC4z22eVK29Qy32JfrtBvaIlo2OYnlYWcZ
         f7QDj8wiSNGghPTx2UYfvJkBaIu2EU/upgq0fBB9n56mHxpCu+QwaAOpA2QnM6W2GK0A
         /wxA==
X-Gm-Message-State: APt69E3BR87wpWEpA859HyA2CCuR4hcXS1JNZaH8klf8VryG8wvxw9w0
        phBAwHOYJ1R6Kv4Xq1Fmvk4Zx8RH+p3V3Fm8XUzn
X-Google-Smtp-Source: AAOMgpcPpppm0Rf05Xz+wnV+gYjCrKrPo3JfeQIrPlA1x7VlAlT6EP4l199ec6pABQ5eiY+QVth/QLqLwewRXSAhtos0
MIME-Version: 1.0
X-Received: by 2002:a0c:f6c5:: with SMTP id d5-v6mr7807334qvo.54.1529965681629;
 Mon, 25 Jun 2018 15:28:01 -0700 (PDT)
Date:   Mon, 25 Jun 2018 15:27:58 -0700
In-Reply-To: <20180625185332.164142-4-bmwill@google.com>
Message-Id: <20180625222758.202196-1-jonathantanmy@google.com>
References: <20180625185332.164142-4-bmwill@google.com>
X-Mailer: git-send-email 2.18.0.rc2.347.g0da03f3a46.dirty
Subject: Re: [PATCH v4 3/8] upload-pack: test negotiation with changing repository
From:   Jonathan Tan <jonathantanmy@google.com>
To:     bmwill@google.com
Cc:     git@vger.kernel.org, jonathantanmy@google.com, gitster@pobox.com,
        sbeller@google.com, jrnieder@gmail.com
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

> --- /dev/null
> +++ b/t/lib-httpd/one-time-sed.sh
> @@ -0,0 +1,16 @@
> +#!/bin/sh
> +
> +if [ -e one-time-sed ]; then
> +	"$GIT_EXEC_PATH/git-http-backend" >out
> +
> +	sed "$(cat one-time-sed)" <out >out_modified
> +
> +	if diff out out_modified >/dev/null; then
> +		cat out
> +	else
> +		cat out_modified
> +		rm one-time-sed
> +	fi
> +else
> +	"$GIT_EXEC_PATH/git-http-backend"
> +fi

Add an explanatory comment somewhere (maybe, at the beginning),
something like:

  If "one-time-sed" exists in $HTTPD_ROOT_PATH, run sed on the HTTP
  response, using the contents of "one-time-sed" as the sed command to
  be run. If the response was modified as a result, delete
  "one-time-sed" so that subsequent HTTP responses are no longer
  modified.

  This can be used to simulate the effects of the repository changing in
  between HTTP request-response pairs.

> +test_expect_failure 'server is initially ahead - ref in want' '

[snip]

> +test_expect_failure 'server is initially behind - ref in want' '

[snip]

These are test_expect_failure, I assume because the fetch part has not
been implemented yet. Can this be moved to the end of the patch set,
once the fetch part has been implemented?

There's also the case of when the server initially has a ref but later
does not - can this be tested here too? The server part is already
covered by the upload-pack test in which we craft a request with a
non-existent ref, but it would be good to test the client part too.
