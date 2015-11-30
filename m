From: Stefan Beller <sbeller@google.com>
Subject: Re: [PATCH v8] Add Travis CI support
Date: Mon, 30 Nov 2015 11:04:13 -0800
Message-ID: <CAGZ79kaOFsm+GcqzgLQSbY-VFnQsbEJfg+RSjUBozXeE-qLN4g@mail.gmail.com>
References: <1448616207-45035-1-git-send-email-larsxschneider@gmail.com>
	<20151128171223.GD27264@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Lars Schneider <larsxschneider@gmail.com>,
	"git@vger.kernel.org" <git@vger.kernel.org>,
	=?UTF-8?Q?Torsten_B=C3=B6gershausen?= <tboegi@web.de>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Mon Nov 30 20:04:29 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1a3TkS-0000eX-HV
	for gcvg-git-2@plane.gmane.org; Mon, 30 Nov 2015 20:04:28 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754593AbbK3TEX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 30 Nov 2015 14:04:23 -0500
Received: from mail-yk0-f177.google.com ([209.85.160.177]:36516 "EHLO
	mail-yk0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754644AbbK3TEN (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 30 Nov 2015 14:04:13 -0500
Received: by ykdr82 with SMTP id r82so195150890ykd.3
        for <git@vger.kernel.org>; Mon, 30 Nov 2015 11:04:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=cuokLCRqzqyzzh2TfkqFux3M4fSqFn2R3jft4N9ieRY=;
        b=XW9lGSmdZmddh3FxXAWYd5ioZJj1r4VBRnXNKCHOtgq3mOPfU/2Id/l6ZmRrRQAfDD
         bnYr0IYKIrC53MpQxLP1pbu+xKKl933UUMda/xXssRKbIGkDdqGtNB6rcJjCrVxUKAfc
         8j9IB14uw4gECG+klUtAV5l7zc0f8vYNavlmjOv+jXTBSXT0sTNFrpYyb1Hd1COzUTgd
         n3yVLE93bqwnGGnouS1I9rVYwnSfopnp8r66SsijuG3bjgF4bibXBDmUFoVSsu/EKsBP
         C3ihKfRLhKGlL+smxjjJjOGs+xi2j0DXJurB6yxnhlg715OwdBw+zceCRAPHw189MR0l
         oQFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type;
        bh=cuokLCRqzqyzzh2TfkqFux3M4fSqFn2R3jft4N9ieRY=;
        b=dMEyGViWcjyR6nLnhxXKH9/ljJc57J6XzX7cSMyLxk+t+4uJEE3WX8TOkjjAbrCgiI
         Q/tuFECG4ENL22YqaZbFVdLTOv6DZCsjovKFBZ17swcBAd1jvhODtzLHP9wy7U5cghSs
         UJ0bRdBOx0E1tBaDKp9T+gNaD8g3pxk8PnecIrWXsV91nth3KDr1FVo1K0bfcESNH5wx
         K0uSZg2E5SnQ4GAJ6qDAvg3QP7iTWN2uaYIrf9jWtaw3iRz0T4n957W4+TWyTfT8s3u6
         XIDcpvNv360ZpuGbWilcRgSE8oC/4hWjf9WmtYke+/YtcvcWSSlugSsxrT3UFSuDO9EN
         mCnQ==
X-Gm-Message-State: ALoCoQnhG2we4VFd16kkx1NlsMnGqFsRrS/nBuL8nfrebBRc/ZMvxjyjKrIr96JQDqNz1aXmnBSs
X-Received: by 10.13.251.2 with SMTP id l2mr54923061ywf.44.1448910253135; Mon,
 30 Nov 2015 11:04:13 -0800 (PST)
Received: by 10.37.215.16 with HTTP; Mon, 30 Nov 2015 11:04:13 -0800 (PST)
In-Reply-To: <20151128171223.GD27264@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/281811>

On Sat, Nov 28, 2015 at 9:12 AM, Jeff King <peff@peff.net> wrote:
> On Fri, Nov 27, 2015 at 10:23:26AM +0100, larsxschneider@gmail.com wrote:
>
>> From: Lars Schneider <larsxschneider@gmail.com>
>>
>> diff to v7:
>> * remove NO_GETTEXT patch and install gettext on OS X to compile with
>>   no additional flags (thanks Torsten)
>> * fix P4 version (15.2 is the latest one available)
>
> Thanks. I don't have any other comments on this one. I guess the next
> step is for me to get git/git signed up for Travis, and then merging
> this to 'master' will have the desired effect.

I think you can merge it even before signing up for travis. Then it
would be in the repository
and any fork (say github.com/stefanbeller/git) could enable it for
themselves even faster that you
could for the main repository :)

>
> -Peff
> --
> To unsubscribe from this list: send the line "unsubscribe git" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
