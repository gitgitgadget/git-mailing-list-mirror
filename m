Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8EA061F404
	for <e@80x24.org>; Tue, 13 Mar 2018 22:42:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932565AbeCMWm5 (ORCPT <rfc822;e@80x24.org>);
        Tue, 13 Mar 2018 18:42:57 -0400
Received: from mail-vk0-f54.google.com ([209.85.213.54]:38855 "EHLO
        mail-vk0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932360AbeCMWm4 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 13 Mar 2018 18:42:56 -0400
Received: by mail-vk0-f54.google.com with SMTP id s1so842413vke.5
        for <git@vger.kernel.org>; Tue, 13 Mar 2018 15:42:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=42g10R6IQZpg6RpML/JshXDxceF2nKLJnjC3x8Zm43g=;
        b=XZPf8Zc9kR/8xmDzcJX9VPwQ3FwEgKOvc2m4n60rrzCwkHUhYOCBTFotNx7kNQdvOa
         bzL53Vxjy0Ytl/Ea3sWTFGGspgAgqbAA+7UTNhsOQvKHRh8VWPeBDfuiqC/y2e5qhPiW
         sdSNH20OS7+/SyL1gz+5B3OkZLsoTHASDbPhmymy+EMxvQm72TlFb0yW/ec3VqJwT9zz
         0aXt9dKZKugrY7puq3jfYgfC5dPB1zEveFDo7R0FHxEdwIlSoUNOqMoS+nkHH7f3Z6QO
         9qatCrDXHKg+eDxYXXCAW2ODMJaZcYC5z9P3QcM4FT7ISjRCo0E96gD5AaZOWX/nK0kK
         ph8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=42g10R6IQZpg6RpML/JshXDxceF2nKLJnjC3x8Zm43g=;
        b=ERT5ybMSAoCI89nzV53zQe3PdrqIpBCCe3ILV3rwDNMxIdDaZX/1dNSY0bk8DAcBjC
         /w34xCYkhhXdpq2aYQndv31DZXMRQLCeN/OByM9o5UXc9Wjxf/V0lo17KfwgdJ1Oc0uY
         2UslHcK3nCNNuj6aQXo+ZUzwR5fx+Q8zFuE+D+A3/NLd5tc7CZdjQYzDReB1FyzaTAGh
         /JSTTokIfaOk9g2iebNDGi7R7rcLAxtIroLH33fM3kqcJRtN9dwiyPGKNDKzlhzb8dW+
         g0+p/wnP5Z3QrvUN54n6R0/QVjARy65i50QlGbfzfDm3oyBy/wL0hoMCDZqVEovmVYLV
         PKFg==
X-Gm-Message-State: AElRT7HFeePALmgnU2o8YJZMw0XGEmLvNk57PdZhdFOa0sVbdFHKn88z
        wCh61Tc4u85sS7qM2Wy2Rh3oweuxecBDiN/DnNI=
X-Google-Smtp-Source: AG47ELvz4LaQk7GNU4LE8/jWRfnqXQrKoQnivKWGVMlxPIn6rQqJieGVsWb2X/i3I9tJSc9gWVJZWKS6CNQJcsXU3Mg=
X-Received: by 10.31.182.210 with SMTP id g201mr1594670vkf.187.1520980975655;
 Tue, 13 Mar 2018 15:42:55 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.176.3.241 with HTTP; Tue, 13 Mar 2018 15:42:54 -0700 (PDT)
In-Reply-To: <xmqqbmfr1uj3.fsf@gitster-ct.c.googlers.com>
References: <CABPp-BEXcvgxcn4-OrDhjUpuOsGCJwE_XT+0eYOK4Ad_O5maOg@mail.gmail.com>
 <20180312184734.GA58506@aiede.svl.corp.google.com> <CABPp-BEdh+UOCpFn5Y1_RydR==dDHWTeNtBub+pPjH_06Ub28w@mail.gmail.com>
 <CAPc5daVu8vv9RdGON8JiXEO3ycDVqQ38ySzZc-cpo+AQcAKXjA@mail.gmail.com>
 <CABPp-BF-LnGPx6vKzCNaFNi_fkxK-CpenatOVa2fvJRZHd0hZw@mail.gmail.com> <xmqqbmfr1uj3.fsf@gitster-ct.c.googlers.com>
From:   Elijah Newren <newren@gmail.com>
Date:   Tue, 13 Mar 2018 15:42:54 -0700
Message-ID: <CABPp-BGXdBJSi5EUyeom0PcgRXvwNy4EBA71MP3FZK9xsw-jdA@mail.gmail.com>
Subject: Re: Opinions on changing add/add conflict resolution?
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Jonathan Nieder <jrnieder@gmail.com>,
        Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Mar 13, 2018 at 3:26 PM, Junio C Hamano <gitster@pobox.com> wrote:
> Elijah Newren <newren@gmail.com> writes:
>
>> Cool, thanks for the context.  I'm happy to go down this path, but
>> there is one question I'd like your opinion on: what if the
>> intermediate content merges have conflicts themselves?  If that
>> question isn't clear, let me be more precise...
>
> I think you answered this yourself after (re)discovering the virtual
> ancestor merge in the recursive strategy, and no longer need my
> input here ;-)

The question about what to put into the index was another issue, and
it's good to hear that you seem to approve of my logic on that one.
Thanks.  :-)

However, my question here about what to write to the working tree for
a rename/rename(2to1) conflict in one particular corner case still
remains.  Should a two-way merge be performed even if it may result in
nested sets of conflict markers, or is that a sufficiently bad outcome
for the user that it's the one case we do want to write colliding
files out to different temporary paths?
