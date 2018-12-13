Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0187420A1E
	for <e@80x24.org>; Thu, 13 Dec 2018 16:15:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729042AbeLMQPA (ORCPT <rfc822;e@80x24.org>);
        Thu, 13 Dec 2018 11:15:00 -0500
Received: from elephants.elehost.com ([216.66.27.132]:39118 "EHLO
        elephants.elehost.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727942AbeLMQPA (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 13 Dec 2018 11:15:00 -0500
X-Virus-Scanned: amavisd-new at elehost.com
Received: from gnash (CPE00fc8d49d843-CM00fc8d49d840.cpe.net.cable.rogers.com [99.229.179.249])
        (authenticated bits=0)
        by elephants.elehost.com (8.15.2/8.15.2) with ESMTPSA id wBDGEvfW025387
        (version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO)
        for <git@vger.kernel.org>; Thu, 13 Dec 2018 11:14:58 -0500 (EST)
        (envelope-from rsbecker@nexbridge.com)
From:   "Randall S. Becker" <rsbecker@nexbridge.com>
To:     <git@vger.kernel.org>
References: <004501d492f5$98f0fcc0$cad2f640$@nexbridge.com>
In-Reply-To: <004501d492f5$98f0fcc0$cad2f640$@nexbridge.com>
Subject: RE: [Question] Complex textconv text
Date:   Thu, 13 Dec 2018 11:14:52 -0500
Message-ID: <005101d492fe$fde97130$f9bc5390$@nexbridge.com>
MIME-Version: 1.0
Content-Type: text/plain;
        charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Outlook 16.0
Thread-Index: AQGMalj/Tom5AwzJrmWB2lJYsrgoN6YNKL5Q
Content-Language: en-ca
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On December 13, 2018 10:08, I wrote: 
> I have a strange situation and need help with resolving funky characters
in
> .git/config. My situation is this:
> 
> [diff "*.dat"]
> 	textconv = enscribe-conv
> --format=-a1\(A=-a1,-a16,-a32\|P=-a1,-a32,-a16\|=-a1,-d,a14\),-a224
> 
> Basically this is a formatter for diff so that I can show structured
binary data.
> The unquoted syntax of the format string is:
>  --format=-a1(A=-a1,-a16,-a32|P=-a1,-a32,-a16|=-a1,-d,a14),-a224
> 
> Content is not really important. The issue is that git is reporting fatal:
> bad config line 2 in file .git/config when I escape the (, ), and |
characters. I
> get syntax errors otherwise from the shell running the textconv. I have
tried -
> -format="-a1(A=-a1,-a16,-a32|P=-a1,-a32,-a16|=-a1,-d,a14),-a224", to no
> avail. How should I safely escape the characters in here?

Easiest bypass was to wrap the mess above into a shell script and execute it
that way, which works just fine. I'm not sure it's possible to escape all of
the special characters. Seems like the safest approach anyway.

Cheers,
Randall

