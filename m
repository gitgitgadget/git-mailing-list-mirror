Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7412320248
	for <e@80x24.org>; Wed, 10 Apr 2019 20:41:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726624AbfDJUlH (ORCPT <rfc822;e@80x24.org>);
        Wed, 10 Apr 2019 16:41:07 -0400
Received: from mout.gmx.net ([212.227.17.20]:45865 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725782AbfDJUlG (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 10 Apr 2019 16:41:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1554928854;
        bh=dcXRmYnQYf/+T5P8IlZCf+xnVSoWq6G/m1D/4NlmvTQ=;
        h=X-UI-Sender-Class:Subject:To:Cc:References:From:Date:In-Reply-To;
        b=iQ+PqmfLn47p5D5xN2T5bZHRXdunp5Mcm6v/UrAgSBWToLIdFIcPnNdwzYbqyyPRd
         TaU8r4ZpzQ8tsc2yslucdp6aTkZbOFtmlHGgOkysddAcOP/yXYkAhsRyhEEuEsdneU
         IwYm+a/1yz2B8973FY8GAoOBNndwe9GSXbYUqJdw=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [192.168.123.60] ([84.118.159.3]) by mail.gmx.com (mrgmx102
 [212.227.17.168]) with ESMTPSA (Nemesis) id 0LmNHK-1geiIB34dO-00ZuQD; Wed, 10
 Apr 2019 22:40:53 +0200
Subject: Re: [PATCH 1/1] send-email: fix transferencoding config option
To:     Junio C Hamano <gitster@pobox.com>,
        Jonathan Nieder <jrnieder@gmail.com>
Cc:     Brian M Carlson <sandals@crustytoothpaste.net>, git@vger.kernel.org
References: <20190409192733.10173-1-xypron.glpk@gmx.de>
 <20190409215856.GD92879@google.com>
 <xmqq8swi34h5.fsf@gitster-ct.c.googlers.com>
From:   Heinrich Schuchardt <xypron.glpk@gmx.de>
Message-ID: <668fc68f-4d94-39e8-256d-55229472761f@gmx.de>
Date:   Wed, 10 Apr 2019 22:40:51 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <xmqq8swi34h5.fsf@gitster-ct.c.googlers.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:5yzECMnpjfU3K1jqn/g3/8qqFzlVvQlGuDx9VKGOUP0jKylSS7o
 Q0ZtVdqPtfoSGeDRPB9jviclk9xABsH4wujeh8w06RuaL/nEkDGFDRHu9fGjepDGR+p/8h4
 YQhvqSywe2iOEPrEUyliwXny9yVvcd8EX3KKITpLN6oOG5Q1GYgQFBR0Nye/EzeG/lbb8GU
 n38CQJJg2P4U5CcvxOa3g==
X-UI-Out-Filterresults: notjunk:1;V03:K0:mcIgoflMVAw=:/HCtasc0oMvJJ//f7eJQv/
 3seZv3TGslle34Uml5AEILUpYhkmq6kUG5my/roc+002Lbm/FbsFphcCvWbGrFKm41JHqcO4d
 9qKVIwLZihJszz+gnCPEA8dVbBTajR4ioMBfBzPLWb8jzrKffgMsncJoLY27tEmrDHgyT6W5D
 wE0m6cdefdOCosMxOCAsrGUT5gG+fCHqeVybtSIZYp/kzFtNIk6uA/g4kdLiMrvQxC+Sl2QDF
 ZbzsmT07vXeTFzEVHfmK02sbWemCIrzmNM3Z+sKaW6wk9PkUhCllnA1Ek/648FMRI4bdk/dWA
 Hocod7UXKQGiuQ8tJNUtnm6lHbOP1CG4OUMXFIRAQG1xul/Y0zYlFkH/Nb0q5LylAcfh7gAwK
 rD/QxerbrP84LzZWuii6DArqlZdOC1KKFGKME2BmWE/NurKmBnXi1EbAz14cEyn8QCy3f9+oj
 Zu2vnj+FT6jcdT01jQD74fNKBIiwGH1HyJxnVMfYNl+csoDLD17kpEwvnR+M9JkiE3OqBDnxc
 F/+fgYumOjRKHlfgD6tUKLKIORGKrf7s0NpciQ9xPdBjmBmf70N1SkcbpKuT4uXTdIr9gYMU1
 ETOr58yqj4934hNd1sRII3zPbXnLuDPNHLJopnvMpSMngSmYdvu227NhN/EsS88Zah34/OTz8
 f5kXRQiipRAFbWaTBAmo/oFLBy3nCEh53aByZzxv7BAeJgRLt5vKFoGzmN+02oq4n7/tAGiQL
 ulYCmW7h+Q6ISfjAmGd0V4XPOsOU8xE9fZfU/wsBYWEMQLehpsPCtWCNNlNnxmht1fOgD/jPo
 JI+OWB9OsthXSn9Asddo1xkX1J7pIXdjp18GUmQuroKSQTaeN2koZhsmLaVF1JI9w8xtYKmwe
 sb8dor2LATVKpQs1CaH2Rn03MPydCRMF9mL1bOkufdo7Igq0bknV+6nbZ3sYU06rEaGUS9AzZ
 JAOm5MycGag==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 4/10/19 5:48 AM, Junio C Hamano wrote:
> Jonathan Nieder <jrnieder@gmail.com> writes:
>
>> nit: I was confused when first reading this, since I read "the
>> configuration $target_xfer_encoding" as a single phrase.  A comma
>> after "configuration" might help.
>> ...
>> run-on sentence.  I'm having trouble parsing this part.
>
> I had the same issue with the wording.  Without addressing other
> parts of the suggestions in the thread (like describing the
> motivating use case, and protecting this with the test), here is
> what I have tentatively queued.
>
> As all the $scalar variables that are referenced by %config_settings
> etc. all potentially share this issue, I wonder if it makes sense to
> have a validation at the very beginning of the read_config sub,
> something along the lines of....
>
> 	sub read_config {
> 		my ($prefix) =3D @_;
>
> 		while (my ($k, $v) =3D each %config_bool_settings) {
>                  	if (defined $$v) {
> 				die "BUG: \%config_bool_settings{$k} is not undef\n";
> 			}
> 		}
> 		... similarly for %config_path_settings and %config_settings ...
>
> 		... then the original code ...
> 		foreach my $setting (keys %config_bool_settings) {
> 			...
> 	}
>
> By the way, if we look more closely to the two callsites of
> read_config(), however, we realize that Heinrich's patch is a wrong
> solution to the problem.
>
> What happens when "sendemail.<ident>.xferencoding" is not set, but
> "sendemail.xferencoding" is, with the updated code?  The "ah, the
> configuration file did not define the xfer-encoding, so let's set it
> to auto" at the end of read_config is done still too early.  After
> checking "sendemail.<ident>.*", the code added by the patch under
> review assigns 'auto' to $target_xfer_encoding and this assignment
> causes "sendemail.xferencoding" to be ignored, just like BMC's bug.
>
> In other words, the patch is reproducing the same bug it is
> attempting to fix; a quick-and-dirty and obvious band-aid is to move
> the assignment of 'auto' further down, outside the read_config()
> sub, after two calls to the sub is made by the caller, but singling
> this single variable out is very unsatisfactory.
>
> I wonder if we can follow the pattern used by the code to handle the
> fallback for %config_bool_settings we can see immediately after
> these two calls to read_config()?  That is, each of the element in
> the %config_* hash is not merely a pointer to where the value is
> stored, but also knows what the default fallback value should be,
> and a loop _in the caller of_ read_config(), after it finishes
> making calls to the read_config function, fills in the missing
> default?

Sounds reasonable. But including the tests requested nothing I could
easily shoulder.

Just a quite different thought:

'auto' should discover a safe transfer encoding. Why does 'auto' not
discover that a patch contains carriage returns and should be base64
encoded (see subroutine apply_transfer_encoding())?

Best regards

Heinrich

>
> -- >8 --
> From: Heinrich Schuchardt <xypron.glpk@gmx.de>
> Date: Tue, 9 Apr 2019 21:27:33 +0200
> Subject: [PATCH] send-email: honor transferencoding config option again
>
> Since e67a228cd8a ("send-email: automatically determine
> transfer-encoding"), the value of sendmail.transferencoding in the
> configuration file is ignored, because $target_xfer_encoding is
> already defined read_config sub parses the configuration file.
>
> Instead of initializing variable $target_xfer_encoding to 'auto' on
> definition, we have to set it to the default value of 'auto' if is
> undefined after parsing the configuration files.
>
> Signed-off-by: Heinrich Schuchardt <xypron.glpk@gmx.de>
> Signed-off-by: Junio C Hamano <gitster@pobox.com>
> ---
>   git-send-email.perl | 4 +++-
>   1 file changed, 3 insertions(+), 1 deletion(-)
>
> diff --git a/git-send-email.perl b/git-send-email.perl
> index f4c07908d2..db32cddbde 100755
> --- a/git-send-email.perl
> +++ b/git-send-email.perl
> @@ -231,7 +231,7 @@ sub do_edit {
>   my (@suppress_cc);
>   my ($auto_8bit_encoding);
>   my ($compose_encoding);
> -my $target_xfer_encoding =3D 'auto';
> +my ($target_xfer_encoding);
>
>   my ($debug_net_smtp) =3D 0;		# Net::SMTP, see send_message()
>
> @@ -434,6 +434,8 @@ sub read_config {
>   			$smtp_encryption =3D 'ssl';
>   		}
>   	}
> +
> +	$target_xfer_encoding =3D 'auto' unless (defined $target_xfer_encoding=
);
>   }
>
>   # read configuration from [sendemail "$identity"], fall back on [sende=
mail]
>

