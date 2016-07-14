Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD,T_DKIM_INVALID
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0841B20196
	for <e@80x24.org>; Thu, 14 Jul 2016 18:44:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751741AbcGNSoj (ORCPT <rfc822;e@80x24.org>);
	Thu, 14 Jul 2016 14:44:39 -0400
Received: from mail-yw0-f176.google.com ([209.85.161.176]:36008 "EHLO
	mail-yw0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751451AbcGNSoh (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 14 Jul 2016 14:44:37 -0400
Received: by mail-yw0-f176.google.com with SMTP id w127so81910272ywf.3
        for <git@vger.kernel.org>; Thu, 14 Jul 2016 11:44:37 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc;
        bh=vxvn+gkiJ1WHkfAfLVDRM9L6KWYAZKvoSiTDzNZUvvM=;
        b=RJTRySfcjLFZwl0RlKQe2vxr21a1TvBPcIkm6K/4j681kRMS7mHep7rlwW1v+IlBCC
         xiv3n3Mw6wdYKeHbaskgliB3cDlxsHOt6zY6aSv5/SCd4CiCAM2ciVPzKs9OQt1jTGKk
         Y5knqVO19LQk75lUn7OBM19DKZpnqfvqV3hE1CdQ3+t+UvdZ/5Qcx3tHPd63GfY4qePy
         iDgECc8w1rPKWLpDZYnulal87qODH4rsPOjPNXU9lZSZzT4zmx+WvejeSfaTEulVXk9k
         F0tlofImPZH6WW9ceroV55C7CqtzGRzPGTNA9aXsUoIYWS+o2LkegSIYq3lPaRuZCGlh
         hMbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:from
         :date:message-id:subject:to:cc;
        bh=vxvn+gkiJ1WHkfAfLVDRM9L6KWYAZKvoSiTDzNZUvvM=;
        b=LFP7bMuu2X+PacJGZB/kW06DDDwZlyj6Uy1iQEEUBItTjas2I+082q+DuaPj+Cev4+
         8G6ZSs0sb9wjoVYxFfXRv1qm4c1TC6QgnOC58o35K5aAhfnAaKlRtTQtFgdiTPYdaLcq
         koAptpgnTRdrXR1FrMXu0XzQNNFtL8GD6QxQjnlEVJ+EZzf/8KwhaHyYbmwz6IGb12o0
         OqfXkQvSnY+UO2Rmk0xzJsOeiyPXwgWX8wVbaIEcsNvxYXZ8bKNBpBFrTEOOMNjdrJoC
         wn4HX8Wkyyy76lSwB8rOVt2YgiVrz3seipfAS31gIqDxU2cUN9DVZ16B0roPXYHzAUrt
         uXMw==
X-Gm-Message-State: ALyK8tJbsiWc+loS/L0EEgOmpEFqBwSZABv5RCuS/+t5SjSbSUAi6NzjvGO86D5pQiYzeK+n3eC1xhQf3vfSaw==
X-Received: by 10.129.94.133 with SMTP id s127mr11660628ywb.69.1468521876382;
 Thu, 14 Jul 2016 11:44:36 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.13.240.66 with HTTP; Thu, 14 Jul 2016 11:44:17 -0700 (PDT)
In-Reply-To: <xmqqpoqgqdlz.fsf@gitster.mtv.corp.google.com>
References: <alpine.DEB.2.20.1607141725390.25238@tglase.lan.tarent.de>
 <CAGZ79kb=2rpYucjhavNB_XHLk9rjKSoHzL9bwM5buDO0GyW3vw@mail.gmail.com>
 <alpine.DEB.2.20.1607141948530.25238@tglase.lan.tarent.de> <xmqqpoqgqdlz.fsf@gitster.mtv.corp.google.com>
From:	Junio C Hamano <gitster@pobox.com>
Date:	Thu, 14 Jul 2016 11:44:17 -0700
X-Google-Sender-Auth: 7YMmGT6bH74b0U6H8Xv7bwReRn8
Message-ID: <CAPc5daXxAqXtUvs1Xr_vgncXqcvR8-VG67oDAgOQ8xPcT7nCeQ@mail.gmail.com>
Subject: Re: Server-side preventing some files from being overwritten
To:	Thorsten Glaser <t.glaser@tarent.de>
Cc:	Stefan Beller <sbeller@google.com>,
	"git@vger.kernel.org" <git@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

On Thu, Jul 14, 2016 at 11:27 AM, Junio C Hamano <gitster@pobox.com> wrote:
> Thorsten Glaser <t.glaser@tarent.de> writes:
>
>>       if test x"0" != x"$(comm -23z \
>>           <(git ls-tree -r -z "$old" "$subdir" | sort -z) \
>>           <(git ls-tree -r -z "$new" "$subdir" | sort -z) | wc -c)"; then
>>               echo >&2 'Untouchable files touched, commit rejected!'
>>               exit 1
>>       fi
>
> Can't this become simpler, e.g.
>
>         if ! git diff-tree --quiet "$old" "$new" -- "$subdir"
>         then
>                 echo >&2 "Ooh, $subdir is touched"
>                 exit 1
>         fi

Ehh, you need to tell diff-tree to recurse, i.e. "diff-tree -r".
