Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2A0DB1F51C
	for <e@80x24.org>; Fri, 18 May 2018 18:10:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751156AbeERSKE (ORCPT <rfc822;e@80x24.org>);
        Fri, 18 May 2018 14:10:04 -0400
Received: from mail-wm0-f52.google.com ([74.125.82.52]:54777 "EHLO
        mail-wm0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750763AbeERSKD (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 18 May 2018 14:10:03 -0400
Received: by mail-wm0-f52.google.com with SMTP id f6-v6so15492207wmc.4
        for <git@vger.kernel.org>; Fri, 18 May 2018 11:10:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=o6MEQvw0Dkeq6GnoSVwfioYJqE8AgEeTZFQsMwfjuVc=;
        b=IjgB09kreqmLFvxSwoUUVDz2Mg3ryMxgVHHzR4nPYOtxg9+rsY836ta47Z3bBpAR5T
         oEc67npw2I0Pht3ArZk2yD1oKhTmLCXnDYNXH4OwxhN4DxTzvNCyB+kSWTW6M8rkSSOa
         7vPO5TZW+5E1wT76HGcv4VDG1Nrt8ccOTXwGlE7wkTfC3Ts+Bnch/MShxoXFNLGJYpVb
         tNcdSogjR1CPfKS28lU9OVJRR6545hc7Tsh7nVBq5dRM8mDyJFK4ANSZMDd4xKhP5mYH
         dFO/ruXWRvTqzbC4wRNDXGlIJNveqiVB/9ZWuVtpuMZnkQKW7gXC7ZYTvr979sMj43M/
         pNPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=o6MEQvw0Dkeq6GnoSVwfioYJqE8AgEeTZFQsMwfjuVc=;
        b=dWzL3ytwLj79kUxsu65PorsLsQpplko4/2A7bpsh1pkQ2ZB+0XZ0fviQdJ1SkXz2zI
         NqfpaOQ+KKJsYqdFUIQhLqGvNY5WYEvmnCQQGHFN4Mj/ZPYqvGoMzZ0fLhwS02n9puSo
         IVqQ/1RWPCsJOIORZJVoeRsdOmk9EJF2uE13XskuXmfn1BcdvI6gDRaM1wuW8bYoCIDp
         qztLWgp2CuodecDqxPC3U1/7MFBxg68hWMt5U81sjOYOH5JnAv1mOonfxmRI9eOK0Cx1
         55TuukMC2GKrdPBnFehA/F7lvKGiYhIkvbP9EcO4LAANyMWB2Mt/esTK+g1l/8rVhYPe
         cDCw==
X-Gm-Message-State: ALKqPwefos5Sxat00UD7AWKMImGUA5PFCQ6/1/iKzVH0GdhUDOaSsotc
        bkHUNNS5ps/B/4hAPv8N1KTOL7zsg2lOuVDt8s+o6Q==
X-Google-Smtp-Source: AB8JxZobzoXuaGMwqBjCYaLg0rxLGZk8UlqbWoRq8WJUakPwxnJ3kKJ1U1aiJkCgFzJfYgp2ryonybiDcpRLstSnEEg=
X-Received: by 2002:a50:c944:: with SMTP id p4-v6mr12944358edh.236.1526667002194;
 Fri, 18 May 2018 11:10:02 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.80.234.135 with HTTP; Fri, 18 May 2018 11:09:41 -0700 (PDT)
In-Reply-To: <30BAE567-25B9-4D5E-B86B-45A578DDC57A@anmol.io>
References: <285692D0-1DE8-4CAF-9BCE-F1A04D5C66B5@anmol.io>
 <CA+P7+xqQZzTrm274rbbP_O85Y+YGZ4PQ8PMFJnJtKR4wR0AObQ@mail.gmail.com> <30BAE567-25B9-4D5E-B86B-45A578DDC57A@anmol.io>
From:   Jacob Keller <jacob.keller@gmail.com>
Date:   Fri, 18 May 2018 11:09:41 -0700
Message-ID: <CA+P7+xpdKPsWuiurD_VEF1dtV44Omfx+Mq2SN1Y1-W1vWAzX_Q@mail.gmail.com>
Subject: Re: Add option to git to ignore binary files unless force added
To:     Anmol Sethi <me@anmol.io>
Cc:     Git mailing list <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, May 18, 2018 at 4:31 AM, Anmol Sethi <me@anmol.io> wrote:
> This definitely works but it would be more clean to just have git ignore the binary files from the get go.
>

Sure it'd be more convenient for you. But there are loads of possible
combinations, and the idea of what constitutes unwanted files is
hugely variable to each user. We don't really want to end up
supporting a million different ways to do this, and the hooks
interface provides a reasonable method for rejecting commits with
unwanted contents.


Thanks,
Jake
