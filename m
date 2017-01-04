Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-6.4 required=3.0 tests=BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 73E912092F
	for <e@80x24.org>; Wed,  4 Jan 2017 06:56:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933514AbdADG4l (ORCPT <rfc822;e@80x24.org>);
        Wed, 4 Jan 2017 01:56:41 -0500
Received: from mout.web.de ([212.227.15.14]:52268 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932981AbdADG4j (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 4 Jan 2017 01:56:39 -0500
Received: from birne12.local ([213.64.64.87]) by smtp.web.de (mrweb001
 [213.165.67.108]) with ESMTPSA (Nemesis) id 0MWirL-1c1NMB371v-00XwRC; Wed, 04
 Jan 2017 07:56:08 +0100
Subject: Re: [PATCH v4 0/5] road to reentrant real_path
To:     Jeff King <peff@peff.net>, Brandon Williams <bmwill@google.com>
References: <1481566615-75299-1-git-send-email-bmwill@google.com>
 <20170103190923.11882-1-bmwill@google.com>
 <20170104004825.3s27dsircdp5lqte@sigill.intra.peff.net>
Cc:     git@vger.kernel.org, sbeller@google.com, jacob.keller@gmail.com,
        gitster@pobox.com, ramsay@ramsayjones.plus.com, j6t@kdbg.org,
        pclouds@gmail.com, larsxschneider@gmail.com
From:   =?UTF-8?Q?Torsten_B=c3=b6gershausen?= <tboegi@web.de>
Message-ID: <3f9a530c-402f-f276-4721-fa6a8a6fef41@web.de>
Date:   Wed, 4 Jan 2017 07:56:02 +0100
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.12; rv:45.0)
 Gecko/20100101 Thunderbird/45.5.1
MIME-Version: 1.0
In-Reply-To: <20170104004825.3s27dsircdp5lqte@sigill.intra.peff.net>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K0:Tzk9mjRhjycR7LDB3o/ikFccMF6XEoZ+FXG08XbZktGzzwa2jUa
 1VIylb2d0oGj/zopZTwVMs32SUswV15Co87/GEiT4Cen8bmsw85eQONYn5SNdtD3HFx9b/4
 TJ37pmoFFjKG0xDN6/jwsBKZ3+fqob9h+Jc5+zHW5jRdCj2jNqCsT7Y+P3Xi0IrWU35apyC
 Lr2qG6oGr20APKZGGUAZQ==
X-UI-Out-Filterresults: notjunk:1;V01:K0:Hmy2G8jJiUo=:+B5QC3RqKm9q2AuqshoZ/I
 3hl3oVgp3PH9OIfyDxWo4KSEHQXCoO0D0I6hHTdfH9YUuK6tAn/7d2cf7Idk+L2sUneIhO55H
 MLbbY4Lz6rx6pp/evgVFZTPpvT5kMerCERvn1VLAzUDcS+p36uMGz/TcKUR85U9oUmB/EHnir
 TJBjHn3mM/j6zNidYL72H1uY1djsijESb1WO4wI5nQMQn2VoQz6Db38XoFCn0plxV+ABC+uLl
 p0lOiD7GNzDIKaDxGsAXkRPhdjy/eIamn71KGQIT42Zt1kuVLGpFKS9mQWX403Mo2W0JTCiAZ
 5dXu1QSCSUaTBCtwQX2oXlbAdE1QcwzLl7Hv3GZ4zbnKWKDqvSlPXSdzpTL7WjsC4ECTi4Hy4
 kI4Xv8HmVZayyU9Rh/LuxYTEoKDLWLzQBXmXkhtiJ8DjY1RqwvobSDj+HC+qIN4wCzQ100KlV
 43yVIWmBuMBkyVVk6NwqwKcyOZ0JL5iEV8oc1WGn7UuTgvtPtkj8vgQgMmiXIr3ljoYPPufA3
 89e1ZCjYLJ/pXykfc7zUTEcTAGSlQB7JMrK6iFx7x9pVkXoW1H3DaOwvaJU4INnBdoNCjuKib
 8VzjLx44UNML+9uM/8ORoFUFGoIjXjkfSn01PRwfOOMOrZw2ZCPg31amgyHaBqz+ypUCQh7kt
 LMifM2YgNSrG8faCI1a5GIPBdm6PLu4FFO7x+uCV1/9mB8Dmlm1rDp6okD1+7ySXOp51zhqfa
 waH4j8kpv88y0gYugew2UM2Hve+PYdxCz/049lj6SoeHDw64YujfiRPRAtbr5lB2pBU9I+4mB
 ieqC06c
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 04.01.17 01:48, Jeff King wrote:
> On Tue, Jan 03, 2017 at 11:09:18AM -0800, Brandon Williams wrote:
> 
>> Only change with v4 is in [1/5] renaming the #define MAXSYMLINKS back to
>> MAXDEPTH due to a naming conflict brought up by Lars Schneider.
> 
> Hmm. Isn't MAXSYMLINKS basically what you want here, though? It what's
> what all other similar functions will be using.
> 
> The only problem was that we were redefining the macro. So maybe:
> 
>   #ifndef MAXSYMLINKS
>   #define MAXSYMLINKS 5
>   #endif
> 
> would be a good solution?
Why 5  ? (looking at the  20..30 below)
And why 5 on one system and e.g. on my Mac OS
#define MAXSYMLINKS     32  

Would the same value value for all Git installations on all platforms make sense?
#define GITMAXSYMLINKS 20

> 
> It looks like the "usual" value is more like 20 or 30 on most systems,
> though.  We should probably also set errno to ELOOP when we hit the
> limit, which is what other symlink-resolving functions would do.
> 
> I'm surprised we didn't hit this on Linux, which has MAXSYMLINKS, too.
> We should be picking it up from <sys/param.h>.
> 
> -Peff
> 

