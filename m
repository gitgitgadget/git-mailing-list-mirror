Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7B3582022D
	for <e@80x24.org>; Mon, 21 Nov 2016 18:17:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753882AbcKUSRv (ORCPT <rfc822;e@80x24.org>);
        Mon, 21 Nov 2016 13:17:51 -0500
Received: from mail-qt0-f177.google.com ([209.85.216.177]:33389 "EHLO
        mail-qt0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753003AbcKUSRu (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 21 Nov 2016 13:17:50 -0500
Received: by mail-qt0-f177.google.com with SMTP id p16so208163988qta.0
        for <git@vger.kernel.org>; Mon, 21 Nov 2016 10:17:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=h1ZTob2kxB8+JSNbTY1XmkZ0khVn18OmVwEMyO6MaEI=;
        b=D3vC/d2W1zhzaGOpnSesZswlVs2Gg56ZH4aF3/nPTgGne/OyY6nBhbJx2GExoJMEuk
         5X5qaQsga82N/+qqr743g2IJN3k9o8v31zsRrp2lsESHeki16sieNdHGLti4k/8FkwC3
         IKqv+LxZjia641HYxjy1kjzrImN08DEKYq+OCEIZCj3108dqvbx8maa1dYtKAkSANDn8
         rX8AWHzGJ40Br5cp1hkC+VArIbXaOHRH7X8dyUmmSt9GdHqkM4mZNChj0WRxBcRYoJrK
         2L3KdhUd18AYRStLPORgGIwPuCBGSGPZQUI5sPMLPo3UNZWJEUQl/xCyK9QVKM//9jll
         6p8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=h1ZTob2kxB8+JSNbTY1XmkZ0khVn18OmVwEMyO6MaEI=;
        b=FfAmpFJYDRVgPmk5naSIgP7BBHdkuy6wtIL/9uuii7BYyf4/9uiQRWgj3de71ZPDGj
         RCGcJBPL/rKQwGmkFdnAWQOEKKutKlEQl83lGf1lgU2VI4Hngxa7zqfNV62rN8wJBgR0
         C62Je6U7gjjjJcTby5rYjbo9eAPwefVlZjmcMonOIeL4bbbv21VNXCaH0cquEUG7kMFL
         by9tLGvfgeM6V5be2RQvUzbmfll1tnFet4yjEJPi8/u1ssC5myiySYa+MAwlpSQjgJOY
         pm6qB3pz99zavJnHZFH4XoKCYlAg6MZZcTLGSeFG1Qb0+xODiLlkYg4NjXlsn3zkCmrZ
         yDAw==
X-Gm-Message-State: AKaTC01+h4RSrkCY5kDu37mJPh4ZBfMgHqOeyKBst5ukqv/vxV6bqF6cX21lGIfgUCq8ny2taj1BY3UmRdS1lN7t
X-Received: by 10.200.53.9 with SMTP id y9mr8690691qtb.176.1479752269606; Mon,
 21 Nov 2016 10:17:49 -0800 (PST)
MIME-Version: 1.0
Received: by 10.12.134.65 with HTTP; Mon, 21 Nov 2016 10:17:49 -0800 (PST)
In-Reply-To: <CA+P7+xrKfqOb-3FhKxXdnF6g9PktNWNzY+ZnHJS=yuVo1YdXzg@mail.gmail.com>
References: <14657461479715884@web21h.yandex.ru> <CA+P7+xrKfqOb-3FhKxXdnF6g9PktNWNzY+ZnHJS=yuVo1YdXzg@mail.gmail.com>
From:   Stefan Beller <sbeller@google.com>
Date:   Mon, 21 Nov 2016 10:17:49 -0800
Message-ID: <CAGZ79kZbGPneUXVEqJYhQAn+dfYve7qCjhO7QFaV1JBs3HD1aA@mail.gmail.com>
Subject: Re: Feature request: Improve diff algorithm
To:     Jacob Keller <jacob.keller@gmail.com>
Cc:     KES <kes-kes@yandex.ru>, git <git@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Nov 21, 2016 at 8:56 AM, Jacob Keller <jacob.keller@gmail.com> wrote:
> On Mon, Nov 21, 2016 at 12:11 AM, KES <kes-kes@yandex.ru> wrote:
>> Hi.
>>
>
> Hi,
>
>> I have some question about how diff works then give proposal:
>>
>> it will be very useful for each "symbol" store additional meta info as source line length. So in this case when git counter two equal sequence of commands it will do further comparison: Adds 23 chars deletes none VS adds 75 chars deletes 46
>>
>> Actually I got this:
>>
>> @@ -129,8 +132,9 @@ sub _preprocess_message {
>>  sub _process_message {
>>      my ($self, $message) = @_;
>>
>> -    my $method = ref($message) eq 'HASH' ? $message->{method} : undef;
>> +    my $time =  [ gettimeofday ];
>>
>> +    my $method = ref($message) eq 'HASH' ? $message->{method} : undef;
>>      return $self->send_error(ERROR_REQUEST_INVALID)
>>          unless defined($method);
>>
>> Instead of expected:
>> @@ -129,6 +132,8 @@ sub _preprocess_message {
>>  sub _process_message {
>>      my ($self, $message) = @_;
>>
>> +    my $time =  [ gettimeofday ];
>> +
>>      my $method = ref($message) eq 'HASH' ? $message->{method} : undef;
>> -
>>      return $self->send_error(ERROR_REQUEST_INVALID)
>>
>
> Have you tried the various options for git to search for smaller
> diffs? Or using the other diff algorithms such as histogram instead of
> patience?
>

The newest version of Git comes with a flag to move around the diff
better, based on the work at https://github.com/mhagger/diff-slider-tools
