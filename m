Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	DATE_IN_PAST_12_24,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 868DC1FD99
	for <e@80x24.org>; Wed, 10 Aug 2016 20:27:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933766AbcHJU1h (ORCPT <rfc822;e@80x24.org>);
	Wed, 10 Aug 2016 16:27:37 -0400
Received: from mail-yw0-f180.google.com ([209.85.161.180]:36138 "EHLO
	mail-yw0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933530AbcHJU1f (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 10 Aug 2016 16:27:35 -0400
Received: by mail-yw0-f180.google.com with SMTP id u134so32198483ywg.3
        for <git@vger.kernel.org>; Wed, 10 Aug 2016 13:27:34 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=PpOqtKOi5E4/9Rm/hWmB7bidgw6B7z+9OaxKZMentrw=;
        b=iUGMNNV9C1VaVOIy6+k9VWhY+FqVGoQDwNVXHvRUN0Vi08vNJFBUkaY4qysDiYuBHd
         nnkLN35zSYg03KlTpTPKGND+fSTVoumNqklDPIGFCAoJnuSbAbnEyVWlM7U56JBvECfV
         ryUvRVqY7lVxhQDDLVZIhD0ttmlUqVtCfoVh6aZDp9pYfXYdHuvBJHPcKgkahPUFX8V+
         gT70JEX6UgesXyyBkB3tZEFyAGnM+vWvFBydnDXoq8j06VA8Euvl54KhPmEAuDeZtJMA
         7tdnoygfe0WdLsvDyr42yazzxGb5sMeeB/tjKqJ5oJ4wkmUHrk7WQCFxyJBDjZfsDlZu
         24Xg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=PpOqtKOi5E4/9Rm/hWmB7bidgw6B7z+9OaxKZMentrw=;
        b=fhcMmo4ecV+YtGrxRF/J7AGsUfPwG6iGoV1OQrPbovcKCivz4aO0tU/3Gx158YUdNy
         /dx3JVYzZr5CzrZJa5ArCRqk12jtBv71d4v5JzO5OwxKxCbO6AFrzFKS++Kb1loiHjNh
         oqcWcE+14XVxW3KCdGGCrnS/bBnNFSkPYHslFznAN9Vugh6f48PrP01jWtIA3OFTAvEc
         uVbU5jAhybCIaBA7N4E06jIoQMr0vFE9gMTiYMl8X/Migzf/3fq6t/QdLXDhPFpD2ZBa
         I+fSEbkA4TTFSC8a93dHq+aas3RWoHNmDQUX7fDuq4863riVVqrHtkGmFn8k4/t5bx/a
         f5lg==
X-Gm-Message-State: AEkoouvfxGMF81PkUWXRNg2Obed6u980B40b57m5xZqxrzy0kZ4zJZacpEJUzKN8c2Pfsh09YQgRJNnIV4IJ0A==
X-Received: by 10.129.95.70 with SMTP id t67mr1649664ywb.284.1470811764775;
 Tue, 09 Aug 2016 23:49:24 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.37.50.196 with HTTP; Tue, 9 Aug 2016 23:49:04 -0700 (PDT)
In-Reply-To: <CAGZ79kYLLJCq0OZANSyrYmuq1Mm6w3Ks8CHC-_0uicDps0srpg@mail.gmail.com>
References: <20160810002315.25236-1-jacob.e.keller@intel.com> <CAGZ79kYLLJCq0OZANSyrYmuq1Mm6w3Ks8CHC-_0uicDps0srpg@mail.gmail.com>
From:	Jacob Keller <jacob.keller@gmail.com>
Date:	Tue, 9 Aug 2016 23:49:04 -0700
Message-ID: <CA+P7+xqBU1j=0bRRSBG6VHfDDzZfzFamgObVnMgTdDaCH0ZWSg@mail.gmail.com>
Subject: Re: [PATCH RFC v2] diff: add SUBMODULE_DIFF format to display
 submodule diff
To:	Stefan Beller <sbeller@google.com>
Cc:	Jacob Keller <jacob.e.keller@intel.com>,
	"git@vger.kernel.org" <git@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

On Tue, Aug 9, 2016 at 5:53 PM, Stefan Beller <sbeller@google.com> wrote:
> This is not used any more, but the child is run directly below?
>               unsigned char one[20], unsigned char two[20])
>> +{
>

Yea I meant to take it all out and forgot. Will be gone in v3.

>
> This pattern seems familar, do we have a function for that?
> (get a submodules git dir? As I was mainly working on the helper
> I do not know off hand)
>

I copied it from somewhere, I didn't see a helper. It's probably worth
making one.

> diff is a FILE* pointer. cp.out is a standard int file descriptor
>
> Maybe you'd want a similar thing as strbuf_getwholeline_fd()
> just instead of adding it to the strbuf, adding it to `f` ?
>

Junio has a much better suggestion in another thread, which I will use.

Thanks,
Jake

> (Which is what you have here? I just wonder about the buffer size,
> as I think reading 1 by 1 is not beneficial)
>
>> +
>> +       c = fgetc(diff);
>> +       while (c != EOF) {
>> +               fputc(c, f);
>> +               c = fgetc(diff);
>> +       }
>> +
