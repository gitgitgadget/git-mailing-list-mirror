Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 52974C433B4
	for <git@archiver.kernel.org>; Mon,  3 May 2021 21:23:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 27C82611EE
	for <git@archiver.kernel.org>; Mon,  3 May 2021 21:23:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229607AbhECVYs (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 3 May 2021 17:24:48 -0400
Received: from elephants.elehost.com ([216.66.27.132]:14805 "EHLO
        elephants.elehost.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229497AbhECVYr (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 3 May 2021 17:24:47 -0400
X-Virus-Scanned: amavisd-new at elehost.com
Received: from gnash (cpe00fc8d49d843-cm00fc8d49d840.cpe.net.cable.rogers.com [173.33.197.34])
        (authenticated bits=0)
        by elephants.elehost.com (8.15.2/8.15.2) with ESMTPSA id 143LNfPx021150
        (version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Mon, 3 May 2021 17:23:42 -0400 (EDT)
        (envelope-from rsbecker@nexbridge.com)
From:   "Randall S. Becker" <rsbecker@nexbridge.com>
To:     "'Daniel Stenberg'" <daniel@haxx.se>
Cc:     "'Jeff King'" <peff@peff.net>,
        "'Daniel Carpenter'" <dc@ammonit.com>,
        "=?iso-8859-1?Q?'=C6var_Arnfj=F6r=F0_Bjarmason'?=" <avarab@gmail.com>,
        <git@vger.kernel.org>
References: <8f664b07d1df45bcb6b3f787f42bd046@ammonit.com> <87pmy7x6le.fsf@evledraar.gmail.com> <YJAEVMeY9v/j6PeS@coredump.intra.peff.net> <ed63aa37ef0547bd97a5d965fb5e123f@ammonit.com> <YJBhH0eLKRSpPFy3@coredump.intra.peff.net> <000c01d7405f$823fd090$86bf71b0$@nexbridge.com> <nycvar.QRO.7.76.2105032306580.30150@fvyyl>
In-Reply-To: <nycvar.QRO.7.76.2105032306580.30150@fvyyl>
Subject: RE: http.sslVersion only specifies minimum TLS version, later versions are allowed
Date:   Mon, 3 May 2021 17:23:33 -0400
Message-ID: <000d01d74062$95cf6a50$c16e3ef0$@nexbridge.com>
MIME-Version: 1.0
Content-Type: text/plain;
        charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Outlook 16.0
Content-Language: en-ca
Thread-Index: AQKPGlYstJZ8C8cfxIQEUsjO/sA2RwDtbvgMAogttL0B5xbjXgDjS/DiAVlmsj8BH0oORKkcyj5w
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On May 3, 2021 5:10 PM, Daniel Stenberg wrote:
>Subject: RE: http.sslVersion only specifies minimum TLS version, later
versions
>are allowed
>
>On Mon, 3 May 2021, Randall S. Becker wrote:
>
>> What if http.sslVersion=v1[,v2]... were supported, so there would be
>> an enumeration of allowed versions.
>
>That doesn't map very well to the options libcurl provide.
>
>> The benefit of an enumeration is that you could force something like
>> 3.0-fips if your environment requires a FIPS-certified version for
>> communication. Admittedly this is a different use case than discussed
above.
>
>Yes, and as "3.0-fips" is not a TLS version at all I think it would
complicate
>matters in a wrong direction.
>
>You can build libcurl to use use a FIPS compatible crypto library today,
but if you
>do then you still select TLS version using the same options like before.

Sadly, curl_version_info_data.ssl_version does not provide this level of
detail. Maybe it should, but I'm not about to go there.

Regards,
Randall

