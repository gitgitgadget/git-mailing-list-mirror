Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD,T_DKIM_INVALID
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 57804202A5
	for <e@80x24.org>; Tue, 26 Sep 2017 01:56:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S967039AbdIZB4i (ORCPT <rfc822;e@80x24.org>);
        Mon, 25 Sep 2017 21:56:38 -0400
Received: from mail-pg0-f51.google.com ([74.125.83.51]:49730 "EHLO
        mail-pg0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S935034AbdIZB4g (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 25 Sep 2017 21:56:36 -0400
Received: by mail-pg0-f51.google.com with SMTP id m30so5075785pgn.6
        for <git@vger.kernel.org>; Mon, 25 Sep 2017 18:56:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:in-reply-to:references:user-agent:date
         :message-id:mime-version;
        bh=TtjJ9bNmkUWVLE41zZgOLiG3P1UnpClsuI9rIct0Em0=;
        b=Gz2pRRq1ZsvuIy7ALPMN0s7SLmprW/33sWj2CKUFXcz/iZT7f/PjCdU23Xl7xFXYWH
         s0Reb9TX5Qx5hJfBJH8Lm/njdDlkJV8I9Ft9L02ASfPJB2OWhuSjo6kQkgOef/TXBLfz
         Mi/w4o4ZgPhT6cJeaCMvpjVQ7fQUfk58Gz3Bj8ParPlyMsocOatu4hic4QBjGYA/j2fC
         sMcH3DAXgpq8r5vnftxLhFLd0A/CEH+ylSBpyQJtMQv0mgt/gKJ3caZ3PUax34IUVjnN
         qplORAA+yo6e/EnwKzRnDe/nmSQ+DdUXz4AZ2lmJ15LGbkkaFfXH5k/yrg3A/Ykd7xGA
         sbqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:in-reply-to:references
         :user-agent:date:message-id:mime-version;
        bh=TtjJ9bNmkUWVLE41zZgOLiG3P1UnpClsuI9rIct0Em0=;
        b=gaj/AXpt8ahLBZTne8s46nwNsZ7ywNZq77FDoto3BA+tqpF5MsTy/Kz+FsTKuQJiWH
         Cz9LyDQXb44pdowH5ojUNFqEI9gahJI4ZkVeZPxn2TyIlK16TT/VSjwpIWv5QSjOcMq/
         mrDqqF1A6Tp2Tanad8mVHUIeAq9D0MgBQYeTzT3gTo7h173qLkWoeeGfHaC0ZHmXS/lS
         zHMfS6DtgqzkgMaTcbR+4b4zfxmy3nqAKDAY6rBKFCkLkgrVAGSzWn7RWBuhUHxqF78K
         F7CNUcKm7X9ZONjWPJi08wACQ5x7C5uY6eMjE6wMk8W0SlVKCNWHdpkBjALZGb5wv+V1
         B4IA==
X-Gm-Message-State: AHPjjUhSFBvyrjiWas7lzWLGx5W0c3YLEwKVz5gJSXuQ8mzGXSyUIOCy
        wL0O1PhJ2TnCnF/U/OubLdS1tzy6
X-Google-Smtp-Source: AOwi7QAavukTqPIogiE1FYBcKk4SjO9l/21qD8e3ze3V36eqyDWd6seA9xQn1261CajfCxM6Hgq0Gg==
X-Received: by 10.99.126.84 with SMTP id o20mr9344496pgn.183.1506390995567;
        Mon, 25 Sep 2017 18:56:35 -0700 (PDT)
Received: from localhost ([2620:0:1000:8622:8cad:f525:a0b8:9738])
        by smtp.gmail.com with ESMTPSA id f3sm14386200pfd.82.2017.09.25.18.56.32
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Mon, 25 Sep 2017 18:56:33 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Yaroslav Halchenko <yoh@onerussian.com>
Cc:     "git\@vger.kernel.org" <git@vger.kernel.org>
Subject: Re: -X theirs does not resolve symlink conflict  Was: BUG: merge -s theirs  is not in effect
In-Reply-To: <20170925143040.4qgofxcdahal46r7@hopa.kiewit.dartmouth.edu>
        (Yaroslav Halchenko's message of "Mon, 25 Sep 2017 10:30:40 -0400")
References: <20170925000213.rilmsczdbi3jqkta@hopa.kiewit.dartmouth.edu>
        <xmqqwp4nfuv1.fsf@gitster.mtv.corp.google.com>
        <20170925031751.lg7zk6krt65dxwas@hopa.kiewit.dartmouth.edu>
        <xmqqmv5je412.fsf_-_@gitster.mtv.corp.google.com>
        <20170925143040.4qgofxcdahal46r7@hopa.kiewit.dartmouth.edu>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
Date:   Tue, 26 Sep 2017 10:56:32 +0900
Message-ID: <xmqqing6cje7.fsf@gitster.mtv.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Yaroslav Halchenko <yoh@onerussian.com> writes:

> yes it does. Thanks.  And that is where I realized that I should have used -X
> theirs (not -s theirs), as the instruction on the option for the
> (recursive) merge.  And now problem is more specific:
>
> - conflict within file content editing was resolved as instructed
>   (taking "theirs" version)
>
> - BUT symlink was not taken from "theirs" and left as unresolved conflict:

I wouldn't call it working-as-intended, but this unfortunately is
expected.  You'd encounter exactly the same behaviour when changes
to a binary file conflicts.

It is because -X<ours|theirs> _ONLY_ kicks in (i.e. that is how it
is defined) when we would otherwise throw the half-merged result:

	<<<<<<<
	our version looks like this
	=======
	their version looks like this
	>>>>>>>

and ask you to edit that to a correct resolution.

Because you would not normally be given something like the above
when merging conflicted changes to symbolic links or to binary
files, -X<ours|theirs> has no chance of affecting the outcome.

I do not recall people talking about symbolic links but the case of
binary files has been on the wishlist for a long time, and I do not
know of anybody who is working on (or is planning to work on) it.
