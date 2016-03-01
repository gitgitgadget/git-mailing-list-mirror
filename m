From: Jacob Keller <jacob.keller@gmail.com>
Subject: Re: [PATCH v6 7/7] git: submodule honor -c credential.* from command line
Date: Tue, 1 Mar 2016 14:03:45 -0800
Message-ID: <CA+P7+xrXiGT+Pv07C6oPx0+opdnHmd3SQWPo3tVYO2LvkqOtnw@mail.gmail.com>
References: <1456786715-24256-1-git-send-email-jacob.e.keller@intel.com>
 <1456786715-24256-8-git-send-email-jacob.e.keller@intel.com>
 <CAGZ79kbDaV=i0augzh5RgGYpTWXOuTLx=7Occhc-6iE+0pBVNg@mail.gmail.com>
 <xmqqh9gq85yc.fsf@gitster.mtv.corp.google.com> <CA+P7+xp41mkHjA0CF=69extO4R2Oam2V3sJA7PoqNbHD=9kw+g@mail.gmail.com>
 <xmqqmvqi6mqb.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Stefan Beller <sbeller@google.com>,
	Jacob Keller <jacob.e.keller@intel.com>,
	"git@vger.kernel.org" <git@vger.kernel.org>,
	Jeff King <peff@peff.net>,
	Mark Strapetz <marc.strapetz@syntevo.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Mar 01 23:04:14 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aasOq-0007pB-Us
	for gcvg-git-2@plane.gmane.org; Tue, 01 Mar 2016 23:04:13 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751540AbcCAWEI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 1 Mar 2016 17:04:08 -0500
Received: from mail-io0-f170.google.com ([209.85.223.170]:34011 "EHLO
	mail-io0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750852AbcCAWEH (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 1 Mar 2016 17:04:07 -0500
Received: by mail-io0-f170.google.com with SMTP id b188so21176150iof.1
        for <git@vger.kernel.org>; Tue, 01 Mar 2016 14:04:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=Zn2MScwPv7nz0q0P4vw0RnrO6K9u12dX+LELvreQZZQ=;
        b=yy6m2dGM3ps5PNRGd/8IlYtWnEJyXbSPBOyc8UyJS58tNsWzA9XrVfBbTgPc7encfo
         z8MMUgG9MAVmpybWppWVFWUyAM4h6+q2OZ+QgjPVX7if47gFPBKF0k1SoHLiWOT6CDsG
         vweR6T3yPq0dnRXrV1X6un9JNQB3zpLj18ve+n25xlJyKnVWi0kgzxRTKxjB+nfxAQGl
         gPIFxSwCH7RN/yBQPnVZpaQZ8Ppr8TBRCHYr1q+JLQVBCo6PyWicheP4vUHoBWOXcMwG
         jhu8OpvvTVT9/TByx/RJJ+a9+HEa7FedvLXOkwsSXKJFtmtr8bYFkFLqQz5foT62tu+X
         oVnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=Zn2MScwPv7nz0q0P4vw0RnrO6K9u12dX+LELvreQZZQ=;
        b=BOieg+99VwNEBm8D+osOywJpbmsUm91gzIct3jrNgz1fGLC4yxg+bHO7Z7TsU0PrJp
         eqpaBU+z5VYlfpkjp0k0t2g1krcs5jWEwvQ3qyGJC9lU4v/87Or+EQTwzzlIOXUWaqBX
         D1xo2pqYNXnRuGTF50IiSvTYP4iGM7kXlalanirGTwx0CuQwmJimhi0It2tiB59T/IKY
         hc4TtkBEwDxYIY/Omy3TbWWOVVkmpB2zfMDHNervVPSdTyHez4FHOPFB9dcRRyV8S+Bf
         ErtAsfm1RMcKfYm1t7JzemzKkVq6Pkym/sqTxP8KGxVq0rxQ+1Yf4ixEqZAsu9hf+gCH
         cX6g==
X-Gm-Message-State: AD7BkJKivVTiuCNIPTVFA2fMAaMuebg5/jS39XpGCGk75be3eOKUzD2yOWyc6Odn5yl8wLCUk9httz9hIF2g3w==
X-Received: by 10.107.156.208 with SMTP id f199mr10425408ioe.0.1456869845319;
 Tue, 01 Mar 2016 14:04:05 -0800 (PST)
Received: by 10.107.20.76 with HTTP; Tue, 1 Mar 2016 14:03:45 -0800 (PST)
In-Reply-To: <xmqqmvqi6mqb.fsf@gitster.mtv.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/288070>

On Tue, Mar 1, 2016 at 11:07 AM, Junio C Hamano <gitster@pobox.com> wrote:
>> I could call expect_askpass here at each time but I don't think it
>> would be meaningful after a test_must_fail.
>
> Even if you call expect_askpass to check, another set_askpass is
> expected to start the next cycle anyway (unless we restructure the
> helpers around clear_askpass_query I alluded to, which I am not
> convinced is a good idea yet), so you'll still be asked "why another
> set_askpass to set the same 'wrong pass@host'?".
>
> So, I dunno.

Correct. I think it's not worth changing anything here now. The bigger
solution to change to clear_askpass_query might be the right answer
but it's a lot more involved.

Thanks,
Jake
