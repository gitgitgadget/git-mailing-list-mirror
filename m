Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 68F4B20248
	for <e@80x24.org>; Tue,  9 Apr 2019 23:39:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726748AbfDIXjS (ORCPT <rfc822;e@80x24.org>);
        Tue, 9 Apr 2019 19:39:18 -0400
Received: from mout.gmx.net ([212.227.15.18]:34725 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726640AbfDIXjS (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 9 Apr 2019 19:39:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1554853145;
        bh=xNR/zGbDqDS5rgOoGJOUHd8VewMI2qNW+Z99GzRj030=;
        h=X-UI-Sender-Class:Subject:To:Cc:References:From:Date:In-Reply-To;
        b=Hq0VJ9gub17APJSqHD5HtUXChgV2eT3jOphHrqY32NHZDWkXvbGi/jFZTTBp0yw8j
         gqeMWRMOPKuXacgrU/U7Hp0EkzTxqBi/cMExSKPaLqJYh100hMq8bEzp4m219uwO/P
         2ElJvOkZBIhZ6jAAvVcTDHGV9Y1wwTcIWaLfrAfc=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [192.168.123.60] ([84.118.159.3]) by mail.gmx.com (mrgmx003
 [212.227.17.190]) with ESMTPSA (Nemesis) id 0LaWlT-1gT4fW1vSB-00mN3G; Wed, 10
 Apr 2019 01:39:05 +0200
Subject: Re: [PATCH 1/1] send-email: fix transferencoding config option
To:     Jonathan Nieder <jrnieder@gmail.com>
Cc:     Junio C Hamano <gitster@pobox.com>,
        Brian M Carlson <sandals@crustytoothpaste.net>,
        git@vger.kernel.org
References: <20190409192733.10173-1-xypron.glpk@gmx.de>
 <20190409215856.GD92879@google.com>
From:   Heinrich Schuchardt <xypron.glpk@gmx.de>
Message-ID: <44afdc46-260d-2ad3-0a00-5789615146a8@gmx.de>
Date:   Wed, 10 Apr 2019 01:39:03 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190409215856.GD92879@google.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:WluHbFJsnjmP/T/z4V0SBLuCGTBbGZRp6mIDKVmcovpWhp9DZ5d
 Jx+DvNz460JRS7d54GUk09WsniE4ionfpYJ8hrHF8h4mTYHT8Avk9J+3AZN2gD9LfFzXsjY
 UIXCHUeJgruefwdht5Ze876nzOdWYq90t6Ihz7qr8RDxbzhJZp2L0rytLSq9wSO/bj1vQaA
 oq9MYAYLs95SMr1BlwMtA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:8VlIdfAzDv4=:rkrof94U7a+WIqzHrTn2hq
 uakuXQnse5l8rSvr9lMmGiJoxYSzNL/PS4sYe/c/s4xLI/1w6Wg4gzYclp7ioyh7z8mH9EQkK
 5kS2t8QhwNoXzzSFepbBAgvOnWvwCgW34fNV/G6MbcCiXH+COS5X04sMuP4SxkLitKI/pxmcS
 J4duTPJ2GVPi2QfDa6AZWy7q1ynm4AKaiD94C0fAqCZ+3bTkY/coXJm+b6b20689o9tNr2Adg
 g2bnlGbquzyLHu2obW94skAKIcQbTW4fIUD2CEz9La7NTroDf/4xmTiJeED46xhSnRsFrfK+z
 fmAaIllI3z3k/NGV36ZijicGpdjR7Pkz9o7ogtkAvnducmiJRNAve89Hzz1enZPAlMA7JaOqN
 Beu/n0CipFjVgmy1B0MRQ3Ym22hJfNab2Ai/XFRJvZKCNu1gzww84SRY0wS/kqg81TaZ7l4aO
 pKZloox3e+ybr2lMg9q7WVcg4q9BHpl7Ql622Nnhdvcp1Zr1X6FpfqfBq6XBM/Z7XeFpcaH/q
 C55fJMCXz8NC9ozmC2mxb6T7c7N59wouspVtC/yrYywuE5VffX990MiMMZVgqruzRalkQWsvo
 6Gf4u+PWy4niI3qUYvxW+APFVjFKXaQD0Fcy36iyAdgovgQ/LaySucEjlF2gV58CFF5lJOIf3
 gitWBxc0qPX8No7EE2hGIvet4Tsb1uMaspixgKCjKE4ladb12Ea9wMD/Z+iUw02CYj9QAojHc
 2TXd6zflMl01r3MIR6uXhbnyEU9XqPh//EKsfhsA85CKQtVDG3Gcaocqv2P5D1e4yVS3apAn3
 /TktXQWtgLA2Y3b/g3y4IWXYmk151z49TL+ApCBMh03HKX43IjnKw5BY2qQgqbLrIZvjZS+uW
 YYrwU9yjpkkM4tQ+xAz5wqqZ61qyw5D1N2+zYtcMLPf6C/1535R9qvrMc8iqqpfLfJeDe6J4k
 mskvsKPj8nw==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 4/9/19 11:58 PM, Jonathan Nieder wrote:
> (thanks for cc-ing bmc!)
> Hi,
>
> Heinrich Schuchardt wrote:
>
>> Subject: send-email: fix transferencoding config option
>
> nit: "fix" doesn't tell me what was broken and what you improved about
> it.  Here, I think you mean "respect transferencoding config option".
>
>> Since e67a228cd8a ("send-email: automatically determine transfer-encodi=
ng")
>> the value of sendmail.transferencoding is ignored because when parsing
>> the configuration $target_xfer_encoding is not initial anymore.
>
> nit: I was confused when first reading this, since I read "the
> configuration $target_xfer_encoding" as a single phrase.  A comma
> after "configuration" might help.
>
>> Instead of initializing variable $target_xfer_encoding on definition we
>> have to set it to the default value of 'auto' if is initial after parsi=
ng
>> the configuration files.
>
> run-on sentence.  I'm having trouble parsing this part.
>
> Can you start from the beginning and describe again what this does?
> In other words, tell me
>
> - What is the user-facing effect of the change?  What workflow is it
>   part of?

I am working with a repository which uses CRLF line endings. So when
sending patches I should use an appropriate encoding. There should be
two ways to do it:

- call git-send-email with --transfer-encoding base64
- git config --global sendmail.transferencoding base64

Unfortunately the latter method did not show the expected result. The
setting was simply ignored.

>
> - Any risks or complications?

None that I am aware of.

>
> - Any technical details that might be interesting to the later reader?

As I tried to explain above the setting is ignored because a variable is
initialized too early.

>
> - What does this allow me to do that I couldn't do before?

You can use a global setting for the transfer encoding.

>
> The code can speak for itself, so this should primarily focus on the
> intention behind the change.
>
> [...]
>> --- a/Documentation/git-send-email.txt
>> +++ b/Documentation/git-send-email.txt
>> @@ -146,7 +146,7 @@ Note that no attempts whatsoever are made to valida=
te the encoding.
>>  	even more opaque.  auto will use 8bit when possible, and quoted-print=
able
>>  	otherwise.
>>  +
>> -Default is the value of the `sendemail.transferEncoding` configuration
>> +Default is the value of the `sendemail.transferencoding` configuration
>
> Unrelated change?
>
> [...]
>> --- a/git-send-email.perl
>> +++ b/git-send-email.perl
>> @@ -239,7 +239,7 @@ sub do_edit {
>>  my (@suppress_cc);
>>  my ($auto_8bit_encoding);
>>  my ($compose_encoding);
>> -my $target_xfer_encoding =3D 'auto';
>> +my ($target_xfer_encoding);
>>
>>  my ($debug_net_smtp) =3D 0;		# Net::SMTP, see send_message()
>>
>> @@ -446,6 +446,8 @@ sub read_config {
>>  			$smtp_encryption =3D 'ssl';
>>  		}
>>  	}
>> +
>> +	$target_xfer_encoding =3D 'auto' unless (defined $target_xfer_encodin=
g);
>
> Makes sense.
>
> Is there a way to cover this in tests (t/t9001-send-email.sh) so we
> can avoid regressing again?

I will give it a try.

>
> The rest looks good.
>
> Thanks for noticing, and hope that helps,
> Jonathan
>
Thanks for reviewing.

Best regards

Heinrich
