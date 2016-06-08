From: Christian Couder <christian.couder@gmail.com>
Subject: Re: [PATCH v2 56/94] apply: move 'struct apply_state' to apply.h
Date: Wed, 8 Jun 2016 17:25:10 +0200
Message-ID: <CAP8UFD0EwZMs0XotZE3jP1edUOUY87xRSZNPoKPS_sXJc7zE8A@mail.gmail.com>
References: <20160511131745.2914-1-chriscool@tuxfamily.org>
 <20160511131745.2914-57-chriscool@tuxfamily.org> <CAPig+cS98guXbeRH6oW8n2tPAa3u=2MvSx1H5rixGKdGTrVJPg@mail.gmail.com>
 <xmqqwpmu2do5.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Eric Sunshine <sunshine@sunshineco.com>,
	Git List <git@vger.kernel.org>,
	=?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= <avarab@gmail.com>,
	Nguyen Thai Ngoc Duy <pclouds@gmail.com>,
	Stefan Beller <sbeller@google.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Ramsay Jones <ramsay@ramsayjones.plus.com>,
	Jeff King <peff@peff.net>,
	Karsten Blees <karsten.blees@gmail.com>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
	Christian Couder <chriscool@tuxfamily.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Jun 08 17:29:20 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1bAfMB-00086k-U5
	for gcvg-git-2@plane.gmane.org; Wed, 08 Jun 2016 17:25:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757472AbcFHPZR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 8 Jun 2016 11:25:17 -0400
Received: from mail-wm0-f49.google.com ([74.125.82.49]:36310 "EHLO
	mail-wm0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757470AbcFHPZM (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 8 Jun 2016 11:25:12 -0400
Received: by mail-wm0-f49.google.com with SMTP id n184so186988485wmn.1
        for <git@vger.kernel.org>; Wed, 08 Jun 2016 08:25:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=28TlHk8bo9I7YbPmasiV7Mn70dkVHz5eAa8+RNM44zw=;
        b=d24M6XWqfLbEzixElgaWFAvCSNJU6iiiJKgoIsp+YPRObMP23SfDpQ7/hfHJJUZVxW
         vb5+CPCUjc4ZvAc7n7PVwG+BXdRww2CSM7fL0sZGjKOsubxqiWsxBMfuBAz+FJJAd0CZ
         1f24RYG8KyMncAzxFkxBLCtQ9BeAKKPxJ4BFsvgh0qwY4RvNCniadd33OopDnBn1avEJ
         mB82oRXqiiVeIhUiKDoNyx+vsz61Hji3oU1s1Ln3RNMfW1c/WF7iFFnSBEpC8/zeRRvc
         bjpzcQRanwfN+G31xmFy8aM/8aPrv5f3tosSKRouFXz7Oz+h+MC5Vd/Ye0wxQYzZmQ20
         HQAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=28TlHk8bo9I7YbPmasiV7Mn70dkVHz5eAa8+RNM44zw=;
        b=Gv/zDFal/SQpIWikGkqS/rygjXwd0BvCZ4frle+bGk046Z3P9SmM9DNYdY9DneYue+
         7Jo/aEPhhIgxjROsHZRe33FBKsD5KEoKQIiWXXoPi6OZy+pVCXncFGOQkk5KkKeQ9Wnk
         cRS8NezA8XySOjpvQMvu0RfCdb3PpohjY3Nwv0q96/J/lC5XDBDs/oeVublNXDDIx/7h
         ao3x8SlI8WbKSIz5PkBHVTDAz2E7yps5tyFTabDV3JDC4odqmz48OmGIvuolpvw4jPCS
         EAlu+dtccxBQf3IBztjCCLUUBKHDbOkRKDylq3K7lsWiS0qsp8QnzHpGXcV5G8ssjW+/
         IHDw==
X-Gm-Message-State: ALyK8tKEVHI4MnCvKfUDvKQAaeQkrcjkMO+sibilxofuo8zLbzfSbHU5hkQL9OWlBjY7Qn01x5z7jWcDE29mGg==
X-Received: by 10.194.109.4 with SMTP id ho4mr5102191wjb.78.1465399511352;
 Wed, 08 Jun 2016 08:25:11 -0700 (PDT)
Received: by 10.194.148.146 with HTTP; Wed, 8 Jun 2016 08:25:10 -0700 (PDT)
In-Reply-To: <xmqqwpmu2do5.fsf@gitster.mtv.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/296804>

On Mon, May 16, 2016 at 6:03 PM, Junio C Hamano <gitster@pobox.com> wrote:
> Eric Sunshine <sunshine@sunshineco.com> writes:
>
>> On Wed, May 11, 2016 at 9:17 AM, Christian Couder
>> <christian.couder@gmail.com> wrote:
>>> To libify `git apply` functionality we must make 'struct apply_state'
>>> usable outside "builtin/apply.c".
>>
>> Why is this patch plopped right in the middle of a bunch of other
>> patches which are making functions return -1 rather than die()ing?
>> Seems out of place.
>
> Two possible places that would make more sense are (1) when it is
> introduced very early in the series, or (2) when it absorbed all the
> file-scope-static global states in the middle of the series.  I think
> either is fine.
>
> That would be a good place to end the first batch of the topic.
> Then the second batch would be "turn die() into error status that is
> propagated upwards".

I moved this patch at the beginning of second batch that I will send
hopefully soon...
