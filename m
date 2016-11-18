Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 718292021E
	for <e@80x24.org>; Fri, 18 Nov 2016 08:20:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752220AbcKRIUF (ORCPT <rfc822;e@80x24.org>);
        Fri, 18 Nov 2016 03:20:05 -0500
Received: from mail-yw0-f174.google.com ([209.85.161.174]:33869 "EHLO
        mail-yw0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751914AbcKRIUE (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 18 Nov 2016 03:20:04 -0500
Received: by mail-yw0-f174.google.com with SMTP id t125so158460018ywc.1
        for <git@vger.kernel.org>; Fri, 18 Nov 2016 00:20:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=4sKQRQFnAHASJnBM1v2gq43wTKMChwKqK/DpeK2YVSk=;
        b=eUhkqkJrFkB5o35WW2lfzCDF4vwzl41+x/z+AjDG4pFtwolTd+DJCuYfZIsXbDwt4a
         P0g9yqF8jf3oUviIA5a6Bl+i79XIT+8PLuiS4bRf5vpSiH6OMnIar/gt8AXPaKt6EPjH
         E1vuwHni4VZYdI+Fa6XBJ6ZEUD91cWv2a7v2EEl4RgzyLSKPZuhEzpLuH6Th/S8iNtWz
         ggw9zgEjQtAB4mC95LT8S1jFauTWdVXO9prBnENxtOYqfDB4Irq7g6o+usIl97RdZYje
         d5yLk2eO8gzqfqAqhJLqTR+hjKDN8UNlUToXt9k79EHuxLTcPi0qbWdD4CBKLLTrz+65
         6EfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=4sKQRQFnAHASJnBM1v2gq43wTKMChwKqK/DpeK2YVSk=;
        b=NF0JqGamOUA2lR2sGrzoztpC+2RxDTOxGyX17mTM4n/EBEzvjUwbYz2V5TpVWt7zv9
         q80/lvOG1Wr+x0E2ynJYdNBe5pkzxX0YA0EKoIBlPHE5j03ZlcaY63DnDYtif3UNIcrs
         jk6VkaiTmHOqpS+rtE9SUyHCdlA1s301ZSwovKy2u8WdF1vo4teb161sXnMq7+sMemvo
         RYgpxf0X7M7yUGfSJ/HGkPqVaNP6qCrRdtr9f5ZbaiNVAua0FClgwWV14MnOT8QNqGSp
         SE7Q9shYUSyCqa01B0rwrE8UpP+48XivuKpBGq7B0y9V2lr2XfVtvL8vvj8cK1bQ8zc8
         9aDg==
X-Gm-Message-State: AKaTC031Zf9Ld+qbRaghJYRu+g8V38qFclJ5cbA+8afXqyvvltrANxXxDY65BbNWVjYO5jjPmFobx6VjqkNTiw==
X-Received: by 10.13.254.71 with SMTP id o68mr7365553ywf.318.1479457203240;
 Fri, 18 Nov 2016 00:20:03 -0800 (PST)
MIME-Version: 1.0
Received: by 10.37.33.132 with HTTP; Fri, 18 Nov 2016 00:19:42 -0800 (PST)
In-Reply-To: <CAOLa=ZTVTZ+1dXpcp=kdoGbT1Feq=vOfFpNpBiZepajMucraPQ@mail.gmail.com>
References: <20161108201211.25213-1-Karthik.188@gmail.com> <20161108201211.25213-14-Karthik.188@gmail.com>
 <CA+P7+xqHKVUfNm+jCsbMNazHpVhB46h60k75JzS35CrkR-d-UQ@mail.gmail.com>
 <CAOLa=ZTWFuzWBjGUX_nV4rVVDRpaabmj0-M6S7aJkX3w+dK2Jw@mail.gmail.com>
 <xmqq60nqzuye.fsf@gitster.mtv.corp.google.com> <CAOLa=ZSFuq2+6xsrJ=CcXuOVbTnbDirbRtu7Fonfk+9EdRpbxg@mail.gmail.com>
 <xmqqy40lx2k8.fsf@gitster.mtv.corp.google.com> <CAOLa=ZQepW9GiUrKEWXojpy10B86K-jb84G_dJeL=mqtjZ4AWg@mail.gmail.com>
 <CA+P7+xo6OqcpLZ7v_m1EPm85eK2xCPD_LCw1Ly2RSPeSC0Ei7g@mail.gmail.com>
 <xmqq4m38vdw4.fsf@gitster.mtv.corp.google.com> <CAOLa=ZSaTdACC60g6D6k5frjKkChbkBL8+kLJjNgoutLSe8mOQ@mail.gmail.com>
 <xmqqmvgynee4.fsf@gitster.mtv.corp.google.com> <CAOLa=ZTVTZ+1dXpcp=kdoGbT1Feq=vOfFpNpBiZepajMucraPQ@mail.gmail.com>
From:   Jacob Keller <jacob.keller@gmail.com>
Date:   Fri, 18 Nov 2016 00:19:42 -0800
Message-ID: <CA+P7+xo847HRkm1Kur0mdB15OgwVMOckuK5fXNMkPxDGkK1XGA@mail.gmail.com>
Subject: Re: [PATCH v7 13/17] ref-filter: add `:dir` and `:base` options for
 ref printing atoms
To:     Karthik Nayak <karthik.188@gmail.com>
Cc:     Junio C Hamano <gitster@pobox.com>,
        Git mailing list <git@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Nov 17, 2016 at 11:33 PM, Karthik Nayak <karthik.188@gmail.com> wrote:
> Hey,
>
> On Fri, Nov 18, 2016 at 12:05 AM, Junio C Hamano <gitster@pobox.com> wrote:
>> Karthik Nayak <karthik.188@gmail.com> writes:
>>
>>> On Tue, Nov 15, 2016 at 11:12 PM, Junio C Hamano <gitster@pobox.com> wrote:
>>>> Jacob Keller <jacob.keller@gmail.com> writes:
>>>> ...
>>>> I think you are going in the right direction.  I had a similar
>>>> thought but built around a different axis.  I.e. if strip=1 strips
>>>> one from the left, perhaps we want to have rstrip=1 that strips one
>>>> from the right, and also strip=-1 to mean strip everything except
>>>> one from the left and so on?
>>> ...
>>
>>> If we do implement strip with negative numbers, it definitely
>>> would be neat, but to get the desired feature which I've mentioned
>>> below, we'd need to call strip twice, i.e
>>> to get remotes from /refs/foo/abc/xyz we'd need to do
>>> strip=1,strip=-1, which could be
>>> done but ...
>>
>> ... would be unnecessary if this is the only use case:
>>
>>> strbuf_addf(&fmt,
>>> "%%(if:notequals=remotes)%%(refname:base)%%(then)%s%%(else)%s%%(end)",
>>> local.buf, remote.buf);
>>
>> You can "strip to leave only 2 components" and compare the result
>> with refs/remotes instead, no?
>>
>
> Of course, my only objective was that someone would find it useful to
> have these two additional
> atoms. So if you think it's unnecessary we could drop it entirely :D
>
> --
> Regards,
> Karthik Nayak

I think having strip and rstrip make sense, (along with support for
negative numbers) I don't think we need to make them work together
unless someone is interested, since we can use strip=-2 to get the
behavior we need today.

Thanks,
Jake
