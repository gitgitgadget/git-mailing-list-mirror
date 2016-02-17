From: Lars Schneider <larsxschneider@gmail.com>
Subject: Re: [PATCH v4 3/3] config: add '--show-origin' option to print the origin of a config value
Date: Wed, 17 Feb 2016 09:32:25 +0100
Message-ID: <DC5B6F35-CBB5-4DC4-A875-275BF072AD91@gmail.com>
References: <1455531466-16617-1-git-send-email-larsxschneider@gmail.com> <1455531466-16617-4-git-send-email-larsxschneider@gmail.com> <CAPig+cS=TtVGTxo0oHny4GpAAaej93T2kP93upfHtPMkAd7V0g@mail.gmail.com>
Mime-Version: 1.0 (Mac OS X Mail 7.3 \(1878.6\))
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8BIT
Cc: Git List <git@vger.kernel.org>, Jeff King <peff@peff.net>,
	Sebastian Schuberth <sschuberth@gmail.com>,
	Ramsay Jones <ramsay@ramsayjones.plus.com>,
	Heiko Voigt <hvoigt@hvoigt.net>,
	Stefan Beller <sbeller@google.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Junio C Hamano <gitster@pobox.com>
To: Eric Sunshine <sunshine@sunshineco.com>
X-From: git-owner@vger.kernel.org Wed Feb 17 09:32:35 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aVxXG-00052p-B5
	for gcvg-git-2@plane.gmane.org; Wed, 17 Feb 2016 09:32:34 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756893AbcBQIca (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 17 Feb 2016 03:32:30 -0500
Received: from mail-wm0-f53.google.com ([74.125.82.53]:33091 "EHLO
	mail-wm0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756871AbcBQIc3 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 17 Feb 2016 03:32:29 -0500
Received: by mail-wm0-f53.google.com with SMTP id g62so226259234wme.0
        for <git@vger.kernel.org>; Wed, 17 Feb 2016 00:32:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=content-type:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=RK+XTU0dBnjn8QXxat3/CMSam6DGYVl+EHKg9L3JUSQ=;
        b=bCQYKqfET6n4rFOgogUaOH2sfyt6ybstFwTzri6UFuU1pn3Rvp79ZU+FojQZmhjBXC
         j8WT81F2orfZ4anqr/Ei5VkNPwvqG//nLG7wSfTOBmfe7yiCe1/zm9XZCJGtpiicHz62
         wBBWHls1NaEQ0iRvzzUeJp8YjmGzblcCLSmJBBkxX41GSZUXq03tSMwYwUUUD4t9Nnem
         f5k3h9m/4ltsFawDkbj0JqDSIUAbvZcbIeqM/gS+Dd/CyKhib7MzsA5MPctHwfnbbB3h
         gYvXxN807wg00RrMmucWfjU9XWds1mOynBF0s7G+FJFmlewTn2JhqYelbLZVte67ACB9
         VSng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:content-type:mime-version:subject:from
         :in-reply-to:date:cc:content-transfer-encoding:message-id:references
         :to;
        bh=RK+XTU0dBnjn8QXxat3/CMSam6DGYVl+EHKg9L3JUSQ=;
        b=k7gziYffeQSNnBeq+3EaIZYwDNj/KQI+D4MY7zXyhZNCw06xDA8a330SlT6JMrhz97
         aqPfGGAYmsK7lftMPjDyMEu5I8WcLv6CyMNAcOvIeMA/DrquMgOcEGG74aiVIHUkit7C
         Z9Asi1DwI+vIc4eUSKkvD7gOPDQ5jvXBAM/hk+R0opIqwg2f/GOZX2bTNuFOHHk6wbXN
         mES7qviQK+7MiLDsZYiliGN8veliWpLZWNhN6SNxZzNNqPowsqK0Ps56cDE0KSSQPwrG
         Ml1HmFqa+lqR88yb7OAmOFfp/BQl2t2i9xDu3kSLBUXqidJZXnivDnY+gON2pgBvdQmD
         LuSA==
X-Gm-Message-State: AG10YOTS24xMxQQmO5Yu9pDJLEkYCMJ7si29EhOHnF6PJlaSaqSGEMU5n4auQJOL4UvVjg==
X-Received: by 10.28.140.85 with SMTP id o82mr2289503wmd.0.1455697948525;
        Wed, 17 Feb 2016 00:32:28 -0800 (PST)
Received: from slxbook3.fritz.box (p5DDB412D.dip0.t-ipconnect.de. [93.219.65.45])
        by smtp.gmail.com with ESMTPSA id 192sm1923690wmw.0.2016.02.17.00.32.26
        (version=TLS1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 17 Feb 2016 00:32:27 -0800 (PST)
In-Reply-To: <CAPig+cS=TtVGTxo0oHny4GpAAaej93T2kP93upfHtPMkAd7V0g@mail.gmail.com>
X-Mailer: Apple Mail (2.1878.6)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/286484>


On 15 Feb 2016, at 21:58, Eric Sunshine <sunshine@sunshineco.com> wrote:

> On Mon, Feb 15, 2016 at 5:17 AM,  <larsxschneider@gmail.com> wrote:
>> If config values are queried using 'git config' (e.g. via --get,
>> --get-all, --get-regexp, or --list flag) then it is sometimes hard to
>> find the configuration file where the values were defined.
>> 
>> Teach 'git config' the '--show-origin' option to print the source
>> configuration file for every printed value.
>> 
>> Based-on-patch-by: Jeff King <peff@peff.net>
>> Signed-off-by: Lars Schneider <larsxschneider@gmail.com>
>> ---
>> diff --git a/builtin/config.c b/builtin/config.c
>> @@ -27,6 +28,7 @@ static int actions, types;
>> static const char *get_color_slot, *get_colorbool_slot;
>> static int end_null;
> 
> Not related to your changes, but I just realized that this variable
> really ought to be named 'end_nul' since we're talking about the
> character NUL, not a NULL pointer.
> 
>> static int respect_includes = -1;
>> +static int show_origin;
>> @@ -81,6 +83,7 @@ static struct option builtin_config_options[] = {
>>        OPT_BOOL('z', "null", &end_null, N_("terminate values with NUL byte")),
> 
> Likewise, the long option name should be --nul rather than --null, or
> the long name could be dropped altogether since some other commands
> just recognize short option -z.
> 
> There is no need for this patch series to address this anomaly; it's
> perhaps low-hanging fruit for someone wanting to join the project. The
> only very minor wrinkle is that we'd still need to recognize --null as
> a deprecated (and undocumented) alias for --nul.

Does the list have a place to document these ideas for newbies to be found?

Thanks,
Lars