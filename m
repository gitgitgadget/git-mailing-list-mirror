Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1A1232021E
	for <e@80x24.org>; Fri, 18 Nov 2016 07:34:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751913AbcKRHeG (ORCPT <rfc822;e@80x24.org>);
        Fri, 18 Nov 2016 02:34:06 -0500
Received: from mail-yb0-f170.google.com ([209.85.213.170]:33327 "EHLO
        mail-yb0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751574AbcKRHeG (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 18 Nov 2016 02:34:06 -0500
Received: by mail-yb0-f170.google.com with SMTP id a184so78620709ybb.0
        for <git@vger.kernel.org>; Thu, 17 Nov 2016 23:34:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=IfsJAKfhaotW9zCRVAHWdPUjzmm/Ahvvw2NcvsVUbjA=;
        b=U4xNYAtq5OxvGxNbwPOwZlLs9hV4mzJwvq3cfgsOJ7GBsgPPg4mGgXcUO+W9sP1svE
         cVlipd6sSpr4wJPOfViS0BHpaDSjqKes2j7yeBsYxsmVhz23vJYQj9JBb8SIkhE4dkJf
         nFQni0GU2hUEMuVo7sFv1+LTU52D57fLjberqUhEFNiKgelJzRFBwxWkoJ/Nw8MqV95c
         jqGNADxtQ36PdV2L+L7gA/GoUnlVrsRQAHsBXhhyahk90S/YbnHcnG8UdtuoNpbr49PC
         ScLWT8e8vq2yWP9Y/lhRSbthy9mcPiX7q+8b/WL5FKyKpVSxwsTeqXW0otmo+2Bph31/
         4jxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=IfsJAKfhaotW9zCRVAHWdPUjzmm/Ahvvw2NcvsVUbjA=;
        b=H1EDTZ2qv7xxHC8Sxaq2zUUqzK2Fio6vStB1ZMXChoYRw1zaN54s17C52Z0AUswn9L
         Xv+WLQewbiC0DKs3aBS6zD0fm/r5JGQUkhdO1lH3ACRsCk4VZow6LmJrbZnz/pc4IfEr
         BE7KJ/grlJqly/5Qg0D5gKDXWY6HRXWmPm/BHyQNyfjC12IRk2i2YuqLAr/d8/SUy34V
         ud0s6o3eo85t0Kc+SdYuvF2rEAarnvL1rLIlBBnxJlR/oVGpbNnzAdkGd6fzMEJsFkom
         T3QtBaIcHYsaR+Tqf1Qrc+M3p2fFVcvpXCN05HFVIhJV5qJe8WZVdqbcmqFWXuFR00KF
         IkEA==
X-Gm-Message-State: AKaTC00ZOR1nfb//H3OtrgjboIkhj8VsYIPSIZge0HxG9FLJZhCKQWJrCIYm1vcg+BS11ImIAEs1zqR9BUpXAQ==
X-Received: by 10.37.172.230 with SMTP id x38mr3888270ybd.96.1479454445097;
 Thu, 17 Nov 2016 23:34:05 -0800 (PST)
MIME-Version: 1.0
Received: by 10.13.207.69 with HTTP; Thu, 17 Nov 2016 23:33:34 -0800 (PST)
In-Reply-To: <xmqqmvgynee4.fsf@gitster.mtv.corp.google.com>
References: <20161108201211.25213-1-Karthik.188@gmail.com> <20161108201211.25213-14-Karthik.188@gmail.com>
 <CA+P7+xqHKVUfNm+jCsbMNazHpVhB46h60k75JzS35CrkR-d-UQ@mail.gmail.com>
 <CAOLa=ZTWFuzWBjGUX_nV4rVVDRpaabmj0-M6S7aJkX3w+dK2Jw@mail.gmail.com>
 <xmqq60nqzuye.fsf@gitster.mtv.corp.google.com> <CAOLa=ZSFuq2+6xsrJ=CcXuOVbTnbDirbRtu7Fonfk+9EdRpbxg@mail.gmail.com>
 <xmqqy40lx2k8.fsf@gitster.mtv.corp.google.com> <CAOLa=ZQepW9GiUrKEWXojpy10B86K-jb84G_dJeL=mqtjZ4AWg@mail.gmail.com>
 <CA+P7+xo6OqcpLZ7v_m1EPm85eK2xCPD_LCw1Ly2RSPeSC0Ei7g@mail.gmail.com>
 <xmqq4m38vdw4.fsf@gitster.mtv.corp.google.com> <CAOLa=ZSaTdACC60g6D6k5frjKkChbkBL8+kLJjNgoutLSe8mOQ@mail.gmail.com>
 <xmqqmvgynee4.fsf@gitster.mtv.corp.google.com>
From:   Karthik Nayak <karthik.188@gmail.com>
Date:   Fri, 18 Nov 2016 13:03:34 +0530
Message-ID: <CAOLa=ZTVTZ+1dXpcp=kdoGbT1Feq=vOfFpNpBiZepajMucraPQ@mail.gmail.com>
Subject: Re: [PATCH v7 13/17] ref-filter: add `:dir` and `:base` options for
 ref printing atoms
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Jacob Keller <jacob.keller@gmail.com>,
        Git mailing list <git@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hey,

On Fri, Nov 18, 2016 at 12:05 AM, Junio C Hamano <gitster@pobox.com> wrote:
> Karthik Nayak <karthik.188@gmail.com> writes:
>
>> On Tue, Nov 15, 2016 at 11:12 PM, Junio C Hamano <gitster@pobox.com> wrote:
>>> Jacob Keller <jacob.keller@gmail.com> writes:
>>> ...
>>> I think you are going in the right direction.  I had a similar
>>> thought but built around a different axis.  I.e. if strip=1 strips
>>> one from the left, perhaps we want to have rstrip=1 that strips one
>>> from the right, and also strip=-1 to mean strip everything except
>>> one from the left and so on?
>> ...
>
>> If we do implement strip with negative numbers, it definitely
>> would be neat, but to get the desired feature which I've mentioned
>> below, we'd need to call strip twice, i.e
>> to get remotes from /refs/foo/abc/xyz we'd need to do
>> strip=1,strip=-1, which could be
>> done but ...
>
> ... would be unnecessary if this is the only use case:
>
>> strbuf_addf(&fmt,
>> "%%(if:notequals=remotes)%%(refname:base)%%(then)%s%%(else)%s%%(end)",
>> local.buf, remote.buf);
>
> You can "strip to leave only 2 components" and compare the result
> with refs/remotes instead, no?
>

Of course, my only objective was that someone would find it useful to
have these two additional
atoms. So if you think it's unnecessary we could drop it entirely :D

-- 
Regards,
Karthik Nayak
