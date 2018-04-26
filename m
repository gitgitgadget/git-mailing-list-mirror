Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIM_INVALID shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1CEBB1F424
	for <e@80x24.org>; Thu, 26 Apr 2018 04:10:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750924AbeDZEK2 (ORCPT <rfc822;e@80x24.org>);
        Thu, 26 Apr 2018 00:10:28 -0400
Received: from mail-wm0-f68.google.com ([74.125.82.68]:54055 "EHLO
        mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750760AbeDZEK0 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 26 Apr 2018 00:10:26 -0400
Received: by mail-wm0-f68.google.com with SMTP id 66so10433819wmd.3
        for <git@vger.kernel.org>; Wed, 25 Apr 2018 21:10:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=qoqbuyc4WT0d5mjD6pzwGFe+aUJw/7FEJqWNu7u9Cnc=;
        b=N9hAoQwjNS7JKylp1en8rhzDNbjFmq3JpOHawDNIL3gho5GR0nCuR/vsQF8oAzl9GR
         lxA8S+bLrut2moPHW+nqgwtNtHmW+0Eok17r/fJuu4imQOCsSlc5lvWTzzqGsVuTRtEf
         7Tnenwnce0GRbhCVX8b1ptNZf+24eo2ui7vJVUEPbgDiCnmLOLFkjLzYZCn/9IFWhBY/
         EtER8Mj6k2rrRVBGqPZI5+AVMNlYjWyd35BDQX3aawtyZRz506fdyJQ/pF3SPr5w8oyb
         IyJRBunofTTj3mNqwBZuIWua0JXesQPYAtJfZr0dtkum6EybWIX5f6MG4D5Uqm6mkAmY
         bdig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=qoqbuyc4WT0d5mjD6pzwGFe+aUJw/7FEJqWNu7u9Cnc=;
        b=Fk0TcqRuoonPKRlE6deUD+k4DvaMJjuJGWsbpCEf9f73wVyDfMGXFqdGj8MBbfmyd/
         fWIp3/QczEXviAJ2jFm4gziz5SjI1BTDIYiE1cKUediLMJpVb7hCNxyoyN55DW+dJM3s
         e1VL/QL6rsT6KFwoGIUOErHbYqgKtPnC3uRGF4Qxk6gIs0MtcSh4wYD5kbijI324VaKN
         IFBNhRcZXgSYjNgSAnXuZldXqwDLuN5ZbzZS/IZjTfV4DPFhJ4R1k+XKxrSLJGN2rZQd
         c7srf/tjve1wB+pfdmJ1FDdw/DNUvTjrPjVg3QwUwrfoCjgCBPBSKIJMygBv2Y+Q/aUF
         YRJQ==
X-Gm-Message-State: ALQs6tDbZ/xWtHSsaKqIgmGTZAZRtvVgQ1mndlsas2M+vXv+k4IFEGeV
        4CUFUTKu3Z9ZkbPhCX5OTLA=
X-Google-Smtp-Source: AB8JxZo0IecA0N+WDJY2fwYLiOXM86l9pgJmOf+xl2TV8bo0jQAcEt0oS12zD/kZCuisMgv2MmAZAQ==
X-Received: by 10.28.173.198 with SMTP id w189mr12575781wme.15.1524715825436;
        Wed, 25 Apr 2018 21:10:25 -0700 (PDT)
Received: from localhost (168.50.187.35.bc.googleusercontent.com. [35.187.50.168])
        by smtp.gmail.com with ESMTPSA id z5-v6sm4900479wrm.61.2018.04.25.21.10.24
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 25 Apr 2018 21:10:24 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Johannes Schindelin <johannes.schindelin@gmx.de>
Cc:     git@vger.kernel.org, Jakub Narebski <jnareb@gmail.com>,
        Stefan Beller <sbeller@google.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Christian Couder <christian.couder@gmail.com>,
        Philip Oakley <philipoakley@iee.org>
Subject: Re: [PATCH v5 00/11] Deprecate .git/info/grafts
References: <cover.1524303776.git.johannes.schindelin@gmx.de>
        <cover.1524650028.git.johannes.schindelin@gmx.de>
Date:   Thu, 26 Apr 2018 13:10:24 +0900
In-Reply-To: <cover.1524650028.git.johannes.schindelin@gmx.de> (Johannes
        Schindelin's message of "Wed, 25 Apr 2018 11:53:49 +0200")
Message-ID: <xmqqin8e38wf.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Johannes Schindelin <johannes.schindelin@gmx.de> writes:

>  -	if (export_object(&old_oid, type, raw, tmpfile))
>  -		return -1;
>  -	if (launch_editor(tmpfile, NULL, NULL) < 0)
>  -		return error("editing object file failed");
>  -	if (import_object(&new_oid, type, raw, tmpfile))
>  +	tmpfile = git_pathdup("REPLACE_EDITOBJ");
>  +	if (export_object(&old_oid, type, raw, tmpfile) ||
>  +	    (launch_editor(tmpfile, NULL, NULL) < 0 &&
>  +	     error("editing object file failed")) ||
>  +	    import_object(&new_oid, type, raw, tmpfile)) {
>  +		free(tmpfile);
>   		return -1;
>  -
>  +	}

I know the above is to avoid leaking tmpfile, but a single if ()
condition that makes multiple calls to functions primarily for their
side effects is too ugly to live.  Perhaps something like

	if (export_object(...))
		goto clean_fail;
	if (launch_editor(...)) {
		error("editing object file failed");
		goto clean_fail;
	}
	if (import_object(...)) {
	clean_fail:
		free(tmpfile);
		return -1;
	}

would keep the ease-of-reading of the original while plugging the
leak.  It would even be cleaner to move the body of clean_fail:
completely out of line, instead of having it in the last of three
steps like the above.

Other than that, looked cleanly done.  Thanks for a pleasant read.

Will queue.
