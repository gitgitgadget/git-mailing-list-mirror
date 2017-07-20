Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5C6C61F600
	for <e@80x24.org>; Thu, 20 Jul 2017 21:18:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965647AbdGTVSK (ORCPT <rfc822;e@80x24.org>);
        Thu, 20 Jul 2017 17:18:10 -0400
Received: from mail-pg0-f53.google.com ([74.125.83.53]:37285 "EHLO
        mail-pg0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S965196AbdGTVSJ (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 20 Jul 2017 17:18:09 -0400
Received: by mail-pg0-f53.google.com with SMTP id y129so19728612pgy.4
        for <git@vger.kernel.org>; Thu, 20 Jul 2017 14:18:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=c61zRmkTNzMsE1axsON/d+381w9+sjzEbxkm7H4+TNA=;
        b=YyaFCLdhrjC0c+PFc4Ui2t+osteCpTfCSQAAlORxEk/YYW8YWJwX+G2+uGfQdlQPqP
         atFl4M9yTsbDUk+ubv2wO7vtov38aGB4LwA6SpnpONYBi25FSGfueEL+sng7T8WCjZJz
         GqW+DSTz+o24Vn6YB0F5uvlCiy4VX7UvakSEqReJaO3yCCvtkVnGEeHbYnyzOK6MBPmQ
         dkV9GXGYPBQc5sJJ5ZaDoEC/5oVGzFHOXVUE38NnN7pOn0FEDEHmQh3PAtktK82oBTch
         h/YKoTd6ZvqY6zoZhx0r6KTSAk4peOcDa6xjTXWZ8lfp901gI1gtFlhqf824H5+zn83W
         yVNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=c61zRmkTNzMsE1axsON/d+381w9+sjzEbxkm7H4+TNA=;
        b=oegnjsECXwa1uJfYkVTW+6u6ERPL96PEEittOlPuzN86G/0Jn3q+/D0cH4v/bokqMp
         zC513pXyllQDsQPLdO5CvfzTqetAb/ApwWzFofBFI4t1d+Jdbu5A0jxAJqc+iIwWz7IP
         zA3h1QWOqxlxDacvCZg2bBcPhtvAer2VxXtJctGiGtdOu8R9c07RcT1vBR+XdlbDiNUJ
         xNXsNm8i0Vg26ddM7xQJ63VdF1L72pay/+4Ci69+czButiV8JuZNkBAK1NMk9OmOQEru
         Iph9jT8RZo4hMxRoQ9azeCWESI3qDLgfiqi9SFjuZygeVi+cZmN/McvX58eejxB8UR3q
         IKYQ==
X-Gm-Message-State: AIVw111Z2DxTP5mO7A39yZdzdLSDCZSQhU8fBLhrC63mdnCL2TWaa7dS
        EX6EgPHSkzVugEi1
X-Received: by 10.99.168.76 with SMTP id i12mr5126954pgp.303.1500585488663;
        Thu, 20 Jul 2017 14:18:08 -0700 (PDT)
Received: from twelve2.svl.corp.google.com ([2620:0:100e:422:e9ae:e35a:1cee:5424])
        by smtp.gmail.com with ESMTPSA id z16sm5765172pgc.90.2017.07.20.14.18.07
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Thu, 20 Jul 2017 14:18:08 -0700 (PDT)
Date:   Thu, 20 Jul 2017 14:18:04 -0700
From:   Jonathan Tan <jonathantanmy@google.com>
To:     Ben Peart <peartben@gmail.com>
Cc:     Stefan Beller <sbeller@google.com>,
        Lars Schneider <larsxschneider@gmail.com>,
        "git@vger.kernel.org" <git@vger.kernel.org>,
        Jonathan Nieder <jrnieder@gmail.com>,
        Jeff Hostetler <git@jeffhostetler.com>,
        Philip Oakley <philipoakley@iee.org>
Subject: Re: [RFC PATCH v2 4/4] sha1_file: support promised object hook
Message-ID: <20170720141804.22cdd2bf@twelve2.svl.corp.google.com>
In-Reply-To: <75d5c3cd-c1d7-f06a-fc7e-894cde95afa7@gmail.com>
References: <cover.1499800530.git.jonathantanmy@google.com>
        <cover.1500508695.git.jonathantanmy@google.com>
        <a7fa848672281e29bff01f8caf2abe9f6ce5f4ba.1500508695.git.jonathantanmy@google.com>
        <CAGZ79ka6vcF4Douc7EizwL_+_xaorro=gVw=1hfJv56kvN+7oQ@mail.gmail.com>
        <75d5c3cd-c1d7-f06a-fc7e-894cde95afa7@gmail.com>
X-Mailer: Claws Mail 3.9.3 (GTK+ 2.24.23; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, 20 Jul 2017 16:58:16 -0400
Ben Peart <peartben@gmail.com> wrote:

> >> This is meant as a temporary measure to ensure that all Git commands
> >> work in such a situation. Future patches will update some commands to
> >> either tolerate promised objects (without invoking the hook) or be more
> >> efficient in invoking the promised objects hook.
> 
> I agree that making git more tolerant of promised objects if possible 
> and precomputing a list of promised objects required to complete a 
> particular command and downloading them with a single request are good 
> optimizations to add over time.

That's good to know!

> has_sha1_file also takes a hash "whether local or in an alternate object 
> database, and whether packed or loose" but never calls 
> sha1_object_info_extended.  As a result, we had to add support in 
> check_and_freshen to download missing objects to get proper behavior in 
> all cases.  I don't think this will work correctly without it.

Thanks for the attention to detail. Is this before or after commit
e83e71c ("sha1_file: refactor has_sha1_file_with_flags", 2017-06-26)?
