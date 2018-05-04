Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id DD49F200B9
	for <e@80x24.org>; Fri,  4 May 2018 15:56:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751459AbeEDP4g (ORCPT <rfc822;e@80x24.org>);
        Fri, 4 May 2018 11:56:36 -0400
Received: from mail-wm0-f51.google.com ([74.125.82.51]:40190 "EHLO
        mail-wm0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751229AbeEDP4f (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 4 May 2018 11:56:35 -0400
Received: by mail-wm0-f51.google.com with SMTP id j5-v6so5679448wme.5
        for <git@vger.kernel.org>; Fri, 04 May 2018 08:56:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=uVYXbYb1saZ94Tjz5w6capRDEU2RMhX0rf2nI1TqXgI=;
        b=XyGftkHheTlQoOWgLQ7jbL71/8IIdnQC1RkqL9YaFBXlo6RGj/rpyNbsF6dyOxKd8D
         sVwD3rq1HcwXAQNddOoUooFVrazJvvWj1BhDtJaMNoPmRjjUc9MMMugUNkAO6RH2rG5S
         9J8NcETWYwgSjeMVDtdxf53PO7r2JymjkCb64kq5FgbncC8d9qhIZ0mZGTfmnQSz/cKw
         BiS5KgHZ1OmU8u3yszF4LPzshH3C1gctlikj8r0M1JCp3uoshpsDoZJawA6afDw9aiXI
         MFt3A8N6GMoOv5qyx6HQuGm2h0GRW9FRXH0pEqseLnsOwHyjjfdmMr9ptdmnEDLRLI7o
         Qwug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=uVYXbYb1saZ94Tjz5w6capRDEU2RMhX0rf2nI1TqXgI=;
        b=Ego4SV19Zr2bmC3tQgiXvCTBWyl1Qc8TBStx5Qd3WJWXMgQxer+LLL2bcwV8F3fqIb
         HmuSlHks7LYUEu8YdKS239mmCz4tjeZDGqQTElnmhnTshWoeSVAb0Q02fN//6w90m+wY
         ek1fLRD329gdWwYOjQgv3OHZ0IRr/1A8m5fPWUd35J3/EMfsmRLfbvZ/CqCdkjyB/Npm
         VFK+vtRG4rf3OFp6Y6pCaDbumb4/sTzBVQ37eVuHD1pEBEZAPpPAmElzBHPnCuV+CAq3
         c1dh3fTKFvGa9s+pndUN+CMK+9xUMY47ec0cqKm+LfwQkxwmPBIAz7wFqZ/6oGEPR3L6
         9aZg==
X-Gm-Message-State: ALQs6tAH3+DCVYuAc5O27d4fSv0mbDfgOCPu42B7bWMJtiG9s1X275pq
        TlHhQyU0pVJAK5TO9zGVRgmyZpXCj0xDVUFoEQDLfw==
X-Google-Smtp-Source: AB8JxZq5NG4ipcbZLFBZnFf21iAUOFVohOPh1Hb3wCU89Z3m23YR1H4WMvWYwSbvWp0aahgETvVJOAeQmpsvIBhEqKQ=
X-Received: by 2002:a50:ab42:: with SMTP id t2-v6mr28167819edc.133.1525449394215;
 Fri, 04 May 2018 08:56:34 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.80.234.135 with HTTP; Fri, 4 May 2018 08:56:13 -0700 (PDT)
In-Reply-To: <CAGyf7-GhK_wAZn8zO35rsgQ=meLc=Lr+Q=S8omHg1c413dMsFw@mail.gmail.com>
References: <CAKk8isrAmWOdioJe2CdY+2F_AzKxcTGwd+kBsrAmGx-U=ZHGgA@mail.gmail.com>
 <xmqqzi1s3y5h.fsf@gitster-ct.c.googlers.com> <CAKk8isr-7bSVqEv8EjF2UgFfw75D2oVZPJFui30pbY6kWfeL_Q@mail.gmail.com>
 <CAKk8ispWBoG7D+u8x+s+iB+wzXUN=7vpxgmz5wjL67P6XUmw9g@mail.gmail.com>
 <xmqqfu3h1t22.fsf@gitster-ct.c.googlers.com> <xmqqbme51rgn.fsf@gitster-ct.c.googlers.com>
 <CAKk8isqAd11W4DpjNkd9AeMDGi=ESyhVSFXcvwteasTfHMPGLA@mail.gmail.com> <CAGyf7-GhK_wAZn8zO35rsgQ=meLc=Lr+Q=S8omHg1c413dMsFw@mail.gmail.com>
From:   Jacob Keller <jacob.keller@gmail.com>
Date:   Fri, 4 May 2018 08:56:13 -0700
Message-ID: <CA+P7+xp_FWrvY8M+K_1ogK27Rm0pDvBDL73n7nFu34tv557vKg@mail.gmail.com>
Subject: Re: Fetching tags overwrites existing tags
To:     Bryan Turner <bturner@atlassian.com>
Cc:     Wink Saville <wink@saville.com>,
        Junio C Hamano <gitster@pobox.com>,
        Git List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Apr 27, 2018 at 12:13 PM, Bryan Turner <bturner@atlassian.com> wrote:
> On Fri, Apr 27, 2018 at 12:08 PM, Wink Saville <wink@saville.com> wrote:
>>
>> The other change was rather than using ""+refs/tags/*:refs/remote-tags/$name/*"
>> I've changed it to "+refs/tags/*:refs/remote/tags/$name/*" which seems cleaner.
>> Again, if remote-tags is preferred I'll change it back.
>
>
> From looking at the code, it looks like you mean
> "+refs/tags/*:refs/remotes/tags/$name/*".
>
> The issue with that approach is that it collides with a remote named
> "tags". "refs/remote-tags", on the other hand, represents a new-to-Git
> path, one that won't already be in use by any other standard
> functionality. That seems like a better approach than hoping no one
> out there will call one of their remotes "tags".
>
> Bryan

Note that my suggestion was very specific "remote" not pluralized,
which is obviously a bit confusing, since there's remote and
"remotes".

The goal being that you put "remote/<name>/" followed by the full
remote ref minus the refs prefix.

It specifically is attempting to avoid the problem of expanding
"remotes". Unfortunately, I don't have a better alternative format,
and i very much want to avoid having to do "remote-tags",
"remote-notes", "remote-replaces", "remote-meta" etc...

In that spirit, I'm working to hopefully propose something today.

Thanks,
Jake
