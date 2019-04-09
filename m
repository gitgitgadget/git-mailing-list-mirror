Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id EC27320248
	for <e@80x24.org>; Tue,  9 Apr 2019 23:06:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726680AbfDIXGd (ORCPT <rfc822;e@80x24.org>);
        Tue, 9 Apr 2019 19:06:33 -0400
Received: from mout.gmx.net ([212.227.15.15]:39569 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726592AbfDIXGd (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 9 Apr 2019 19:06:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1554851184;
        bh=MqEUzUmdo93R05toIcKrubPu4VrYrNzF2nL7iT+trzM=;
        h=X-UI-Sender-Class:Subject:To:References:From:Date:In-Reply-To;
        b=WEgWEC4epryETi2WlkaAjZXVzSaiWff5o6/Wx8F0dEHwbdtDzTOfjzTAWCxYCe7t6
         TSMo5zK01Cm7PgWEWyHOcW6msyZKlSGrDqi+JVB2xuXDuAn0opv7z+sgMNIXsNzSok
         eOlDnSIAj6sWGLtpqpoMDC4B/4nHf8xhnd1GSRUY=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [192.168.123.60] ([84.118.159.3]) by mail.gmx.com (mrgmx001
 [212.227.17.190]) with ESMTPSA (Nemesis) id 0MU0pN-1hMYNK2xAP-00QiJ3; Wed, 10
 Apr 2019 01:06:23 +0200
Subject: Re: [PATCH 1/1] send-email: fix transferencoding config option
To:     "brian m. carlson" <sandals@crustytoothpaste.net>,
        Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
References: <20190409192733.10173-1-xypron.glpk@gmx.de>
 <20190409225531.GI12419@genre.crustytoothpaste.net>
From:   Heinrich Schuchardt <xypron.glpk@gmx.de>
Message-ID: <bd431817-3c47-c05c-5a92-b26eb2b25d4d@gmx.de>
Date:   Wed, 10 Apr 2019 01:06:22 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190409225531.GI12419@genre.crustytoothpaste.net>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:LQ3IShzZqbwkndyIqfgvDKf2shsrzYe21T3RpNlrsMZt8n01YDe
 D3Q+gJvJeM86VBkI21wpxKHh42Jifd5jpCOhKHAZs2VrLprgQmfSA3211BP9DQcYJEhxluR
 Le5LhRwNwSYt0D9bqXiYfsZYxqf789pS7QA/sVaDfhEac0d1bHMUx+MxkJWLfLjYfao4uad
 rbGGW5gdvMf01F/oQ68Ag==
X-UI-Out-Filterresults: notjunk:1;V03:K0:pCeBe4Gls8E=:Rskd8LZzXGyBmdt8tNhVY2
 QNUowEAimjfZYEREpW/uqzq6CEPMDvOaG8teAZzyOxxtpLE0zzT3sqYrkB4Ws006V5J0lVJ3G
 nAI6ChgBN1rh9rqqSUeT/Mbl48mXHcdR3g8uKSTO4BRZIS+0wX9WuhlXyjsljn65Tr5E+Qn++
 OxYaaSqppF6/pPpqP35xettbjLrjQtTc5K8Z1DhosiSkO8a7xWuo5/GQNdw8pf29XBqWvPCx9
 n+Nb8tnsS1rkN9tR+kDH4ITjEUmlXygczYOOM372ziynnhngvqBd//oUTqwHj636uLlosdL56
 +AO9n0ZdPPJn/33xpGXyxmppX5jU6MJL+phb58ZxyZ0rtFjHN+dseShSC2SNQaQwNIig6/Yq2
 ORgeOiSadxmZyuvgXPDvYGULI+0/XE6ccdc/MSj89Q7nHxG70kBhAR6FrjIQD6VK5ORm06FQo
 7tiUWp/6Q8OJanjLTQO1e2Ule0up/NKez/NK3TnqnwEMq1HNspuoOEVj+9TmqJqM2viM0ZdC7
 CvbKmFQfGyyDDNRXW0sS9Auo4TerLPzUJOrUdAoznB4TZhB7v9G0aY6KKMOMfe2IkpBgBQutt
 VXgEujdKIuAhrXAPorHdo4J1LH4u15QRJxkKMPiXcmXrPHSfGS3ytsSCueK99H80uzBYWi+a4
 P4PbComz8K4tT5dpLVL3qQXZ1EE49eugE05N9DsOe1WLn0GWgCmSoJI6JiDSL3ERfVyNLHhzZ
 5ytYUSN6rB0x79sy92MHxUTZhHRMo62qStFEZ1nWZWB6FEEU5YOlYvcvG7fGpfs9ehtR8Y+53
 r38Jd7KdvF6eHcXMzI6M1QkiFQQ3JYtt6zYQ6GWOGaRVkSh5rk4OHbrIAkc1pl8Z0vDLyI0KR
 50JU+dAnPSo6JNAfwGFPTMVQjVNZoeL8VpW4ZzKoA8tkw3zf7QVfp2IV73fiMC8KG70Ho6Vpx
 gRyG2WonClg==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 4/10/19 12:55 AM, brian m. carlson wrote:
> On Tue, Apr 09, 2019 at 09:27:33PM +0200, Heinrich Schuchardt wrote:
>> diff --git a/Documentation/git-send-email.txt b/Documentation/git-send-=
email.txt
>> index 1afe9fc858..884e776add 100644
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
>>  value; if that is unspecified, default to `auto`.
>
> In Git, two-part config settings are case-insensitive. We traditionally
> write them in lower camel case because it's easier for people to read.
> Git will canonicalize the values when "git config" runs.
>
> So I don't think we should change this.

Thanks for the hint.

>
>> diff --git a/git-send-email.perl b/git-send-email.perl
>> index 8200d58cdc..0e23193939 100755
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
>>  }
>>
>>  # read configuration from [sendemail "$identity"], fall back on [sende=
mail]
>
> Thanks for fixing this. I didn't realize that we only set values if the
> variable holding them is undef. Would you mind adding a test for this
> case so we won't regress it in the future?
>

Nice challenge for my first patch for git :)
I will give it a try.

Best regards

Heinrich
