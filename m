From: Lars Schneider <larsxschneider@gmail.com>
Subject: Re: [PATCH] convert: legitimately disable clean/smudge filter with an empty override
Date: Wed, 27 Jan 2016 10:50:26 +0100
Message-ID: <31B39C4A-0344-402B-9E0E-60D1B1FD75D9@gmail.com>
References: <1453638170-52041-1-git-send-email-larsxschneider@gmail.com> <20160124214459.GA31091@sigill.intra.peff.net>
Mime-Version: 1.0 (Mac OS X Mail 7.3 \(1878.6\))
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8BIT
Cc: Git Users <git@vger.kernel.org>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Wed Jan 27 10:51:16 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aOMki-00037z-2N
	for gcvg-git-2@plane.gmane.org; Wed, 27 Jan 2016 10:51:04 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754299AbcA0Juw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 27 Jan 2016 04:50:52 -0500
Received: from mail-wm0-f52.google.com ([74.125.82.52]:34440 "EHLO
	mail-wm0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754205AbcA0Ju3 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 27 Jan 2016 04:50:29 -0500
Received: by mail-wm0-f52.google.com with SMTP id n5so19295297wmn.1
        for <git@vger.kernel.org>; Wed, 27 Jan 2016 01:50:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=content-type:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=pzctynXtxkTrxpeiwacpNCReE82ZyvU4W1CNx1WFbjg=;
        b=RWX0g14FtpaLn998Q69y2duRg8LFOervOiov3iYghCYhzeI+YdvcMt3UttjzkP/g58
         2DQvmbCqjmUKDC+3qEe+ZROivVK/NPqdt0kPNxQ0T0apTENW9/RpjnNh8pBYdwxj7Lx+
         Ee8oGbIrHMW6CmGj9OrJ2ZT0MhNDty7GSkFS8lVOpsW/N7COETyCWmpDoQsg4tkCyNT8
         k5EKr67gpzmzdd5dcG0q1Fb8oKo6DL76J9kBdjjq/s+mM2yBIqZjpLqfrr578UeE7xL8
         ZwjV/t9cl9uRMAC5tYECdszOHVaYZLPwGW2mluOoeuxy+Ji1TgI+oRTyevqu4Zm2DRNP
         ZydQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:content-type:mime-version:subject:from
         :in-reply-to:date:cc:content-transfer-encoding:message-id:references
         :to;
        bh=pzctynXtxkTrxpeiwacpNCReE82ZyvU4W1CNx1WFbjg=;
        b=ZInVdvar50xvG/sXzq7onrMqMWDNZoIRwUz/1aciH1BWWhHBsEGbIwURn6U/rgwT2P
         YF3rNaSMWpMiqovteX1ozFYhiRhK1nYSIK9ojIQuvZRXWTNfnQCrEWZ17zYzZH2dAOn+
         tRdsfnD5cKW84l/jn9F/anHDfNgbUoXflNXc8YDRfJF3y8d+AjoqXNTNAWK4IQ4+YoJe
         4TMU1t2JcXZgNvz2+9ag/bmwjMjXSr+DHVdxtruaZaG50Jgr7WLHooTGQpHXGc3r/ySo
         IY7jLmRFqFpovy/9TE0UtBT65IfD0AvGLczP1abklqBOR5531W2a4Wp5Ff4kkP/w1dqz
         b/Vw==
X-Gm-Message-State: AG10YORmBbmiljYaKj26DRxqQG2qWNEnhaPtVG3UzYKiB5eFm6oYgsKHUGqozjVxixyfsQ==
X-Received: by 10.28.174.77 with SMTP id x74mr27292537wme.99.1453888227952;
        Wed, 27 Jan 2016 01:50:27 -0800 (PST)
Received: from slxbook3.fritz.box (p508BA675.dip0.t-ipconnect.de. [80.139.166.117])
        by smtp.gmail.com with ESMTPSA id z137sm6780386wmc.8.2016.01.27.01.50.26
        (version=TLS1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 27 Jan 2016 01:50:27 -0800 (PST)
In-Reply-To: <20160124214459.GA31091@sigill.intra.peff.net>
X-Mailer: Apple Mail (2.1878.6)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/284904>


On 24 Jan 2016, at 22:45, Jeff King <peff@peff.net> wrote:

> On Sun, Jan 24, 2016 at 01:22:50PM +0100, larsxschneider@gmail.com wrote:
> 
>> From: Lars Schneider <larsxschneider@gmail.com>
>> 
>> A clean/smudge filter can be disabled if set to an empty string. However,
>> Git will try to run the empty string as command which results in a error
>> message per processed file.
>> 
>> Teach Git to consider an empty clean/smudge filter as legitimately disabled
>> and do not print an error message.
> 
> That makes sense to me, as I do not think the empty filter name can
> possibly do anything useful. You omitted the real motivation here, but I
> know what it is from past discussions: you want to be able to
> temporarily disable a filter with "git -c filter.foo.clean= ...". Which
> I think makes it more immediately obvious that this is a useful thing to
> have, and not just user error.
> 
>> diff --git a/convert.c b/convert.c
>> index 814e814..58af965 100644
>> --- a/convert.c
>> +++ b/convert.c
>> @@ -786,7 +786,7 @@ int convert_to_git(const char *path, const char *src, size_t len,
>> 	struct conv_attrs ca;
>> 
>> 	convert_attrs(&ca, path);
>> -	if (ca.drv) {
>> +	if (ca.drv && ca.drv->clean && strlen(ca.drv->clean)) {
>> 		filter = ca.drv->clean;
>> 		required = ca.drv->required;
>> 	}
>> @@ -835,7 +835,7 @@ static int convert_to_working_tree_internal(const char *path, const char *src,
>> 	struct conv_attrs ca;
>> 
>> 	convert_attrs(&ca, path);
>> -	if (ca.drv) {
>> +	if (ca.drv && ca.drv->smudge && strlen(ca.drv->smudge)) {
>> 		filter = ca.drv->smudge;
>> 		required = ca.drv->required;
>> 	}
> 
> This catches two calls, but I think there are others. What about
> would_convert_to_git_filter_fd and convert_to_git_filter_fd?
> 
> Would it make more sense for apply_filter() to treat the empty string as
> a noop, just as it does for NULL?

Yes :-)

Thanks,
Lars

> 
> I.e.:
> 
> 
> diff --git a/convert.c b/convert.c
> index 814e814..02d5f1e 100644
> --- a/convert.c
> +++ b/convert.c
> @@ -395,7 +395,7 @@ static int apply_filter(const char *path, const char *src, size_t len, int fd,
> 	struct async async;
> 	struct filter_params params;
> 
> -	if (!cmd)
> +	if (!cmd || !*cmd)
> 		return 0;
> 
> 	if (!dst)
> 
> which I think would cover all callers?
> 
> -Peff
