Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 85A2F1F404
	for <e@80x24.org>; Tue, 27 Mar 2018 18:02:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753142AbeC0SCq convert rfc822-to-8bit (ORCPT
        <rfc822;e@80x24.org>); Tue, 27 Mar 2018 14:02:46 -0400
Received: from elephants.elehost.com ([216.66.27.132]:24712 "EHLO
        elephants.elehost.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752876AbeC0SCo (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 27 Mar 2018 14:02:44 -0400
X-Virus-Scanned: amavisd-new at elehost.com
Received: from gnash (CPE00fc8d49d843-CM00fc8d49d840.cpe.net.cable.rogers.com [99.229.179.249])
        (authenticated bits=0)
        by elephants.elehost.com (8.15.2/8.15.2) with ESMTPSA id w2RI0W2O061937
        (version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Tue, 27 Mar 2018 14:00:32 -0400 (EDT)
        (envelope-from rsbecker@nexbridge.com)
From:   "Randall S. Becker" <rsbecker@nexbridge.com>
To:     "'Wink Saville'" <wink@saville.com>,
        "'Jeff Hostetler'" <git@jeffhostetler.com>
Cc:     "'Ramsay Jones'" <ramsay@ramsayjones.plus.com>,
        "'Git List'" <git@vger.kernel.org>,
        "'Junio C Hamano'" <gitster@pobox.com>, <peff@peff.net>,
        <l.s.r@web.de>, "'Jeff Hostetler'" <jeffhost@microsoft.com>
References: <20180326143136.47116-1-git@jeffhostetler.com> <20180326143136.47116-2-git@jeffhostetler.com> <ce076d5e-f30f-006e-a25e-ff1a900562bf@ramsayjones.plus.com> <ad15ccab-088d-b827-a9fa-c83d397c3479@ramsayjones.plus.com> <2bc6f6a6-bf53-b87c-af02-156ad006a878@jeffhostetler.com> <CAKk8isp5NncyDuGNhWctQfmjToWa8nAzHODi7SjbUW2i2R4kiw@mail.gmail.com>
In-Reply-To: <CAKk8isp5NncyDuGNhWctQfmjToWa8nAzHODi7SjbUW2i2R4kiw@mail.gmail.com>
Subject: RE: [PATCH v4] json_writer: new routines to create data in JSON format
Date:   Tue, 27 Mar 2018 14:00:27 -0400
Message-ID: <007a01d3c5f5$7fcd3290$7f6797b0$@nexbridge.com>
MIME-Version: 1.0
Content-Type: text/plain;
        charset="utf-8"
Content-Transfer-Encoding: 8BIT
X-Mailer: Microsoft Outlook 16.0
Content-Language: en-ca
Thread-Index: AQIWOmO/ta77Fqt/t6HhNmkaSYaAjgJC5YEnAg7HDisCOgXQrAIAMm5vAqGcF6OjBgoekA==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On March 27, 2018 1:43 PM, Wink Saville wrote:
> > the leading spaces are required in this case.
> > the pretty json output contains 8 spaces for that sub-structure not a tab.
> > is there a preferred way to denote this in the test script?
> >
> > Jeff
> 
> I've used "git diff --check" which I got from
> Documentation/SubmittingPatches.

While I have not done this in the git suite, my own suites use something along the lines of the following when I need (and have to validate) exact spacing at the beginning of lines in expected output:

cat <<-EOF | sed "1,\$s/_/ /g" >expect
{ level1 ...
________{ level2
Etc.
EOF

Providing you don't use _ elsewhere in the output. It's a bit hacky but works.

Cheers,
Randall

-- Brief whoami:
 NonStop developer since approximately 211288444200000000
 UNIX developer since approximately 421664400
-- In my real life, I talk too much.




