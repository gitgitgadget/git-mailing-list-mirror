From: Karthik Nayak <karthik.188@gmail.com>
Subject: Re: [PATCH v13 11/12] tag.c: implement '--format' option
Date: Mon, 24 Aug 2015 20:51:54 +0530
Message-ID: <CAOLa=ZR6L1LjaD2pTsN1BCh5fHk7CvsE_9KeS3F4f1+RDDzrXw@mail.gmail.com>
References: <1440214788-1309-1-git-send-email-Karthik.188@gmail.com>
 <1440214788-1309-12-git-send-email-Karthik.188@gmail.com> <vpq37z9lqwp.fsf@anie.imag.fr>
 <CAOLa=ZR4LJSou5QqmZJm1M49tD74t4Besb64F+XOHefjnxo7xw@mail.gmail.com> <vpq37z8afci.fsf@anie.imag.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git <git@vger.kernel.org>,
	Christian Couder <christian.couder@gmail.com>,
	Junio C Hamano <gitster@pobox.com>
To: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
X-From: git-owner@vger.kernel.org Mon Aug 24 17:22:34 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZTtZt-0000ko-Nd
	for gcvg-git-2@plane.gmane.org; Mon, 24 Aug 2015 17:22:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754813AbbHXPWY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 24 Aug 2015 11:22:24 -0400
Received: from mail-oi0-f43.google.com ([209.85.218.43]:34187 "EHLO
	mail-oi0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754798AbbHXPWY (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 24 Aug 2015 11:22:24 -0400
Received: by oiey141 with SMTP id y141so82201396oie.1
        for <git@vger.kernel.org>; Mon, 24 Aug 2015 08:22:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=gcKnXtotTJ0GXsAYcQbEFh4+5+iOsUDV7l8Tw5Atc2g=;
        b=GagHqkJ5pHJGNWaJGRUTJ7oEHRhu2F44sLvfac3dNvjRQjemtHaXsE/bopQ203LRYa
         AMIGV2nlK8IJepRkaDv4b4zYMs4wVDVLXMe1MOqBHPIiZBlkO9cQqSXANizN7qbw0O0e
         5InVrhzj/XzhzB+AU+ZrRVMN/ztAoDx/PPRGac7e9SVLocchpoVJjaCqSBler4Ft+1qK
         vsa7T4ebLXThXYhmIOzlnDvoNpicHT8piATTbNlDtZ/uQUrgi+idiJ/bR8+3UC8/0VWe
         9CLQf7ALpvn7Bir8YL/cif1QTGvgqzzBLrYwS5dmSnfLJQpXl1AG1mAzSaZococisbg8
         DAPg==
X-Received: by 10.202.92.65 with SMTP id q62mr20302156oib.11.1440429743582;
 Mon, 24 Aug 2015 08:22:23 -0700 (PDT)
Received: by 10.182.59.102 with HTTP; Mon, 24 Aug 2015 08:21:54 -0700 (PDT)
In-Reply-To: <vpq37z8afci.fsf@anie.imag.fr>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/276454>

On Mon, Aug 24, 2015 at 8:44 PM, Matthieu Moy
<Matthieu.Moy@grenoble-inp.fr> wrote:
> Karthik Nayak <karthik.188@gmail.com> writes:
>
>> On Mon, Aug 24, 2015 at 1:26 AM, Matthieu Moy
>> <Matthieu.Moy@grenoble-inp.fr> wrote:
>>> Karthik Nayak <karthik.188@gmail.com> writes:
>>>
>>>> --- a/Documentation/git-tag.txt
>>>> +++ b/Documentation/git-tag.txt
>>>> @@ -13,7 +13,8 @@ SYNOPSIS
>>>>       <tagname> [<commit> | <object>]
>>>>  'git tag' -d <tagname>...
>>>>  'git tag' [-n[<num>]] -l [--contains <commit>] [--points-at <object>]
>>>> -     [--column[=<options>] | --no-column] [--create-reflog] [--sort=<key>] [<pattern>...]
>>>> +     [--column[=<options>] | --no-column] [--create-reflog] [--sort=<key>]
>>>> +     [--format=<format>] [<pattern>...]
>>>>  'git tag' -v <tagname>...
>>>>
>>>>  DESCRIPTION
>>>> @@ -158,6 +159,11 @@ This option is only applicable when listing tags without annotation lines.
>>>>       The object that the new tag will refer to, usually a commit.
>>>>       Defaults to HEAD.
>>>>
>>>> +<format>::
>>>
>>> Shouldn't this be --format <format>, not just <format>? We usually use
>>> the named argument in the SYNOPSIS for positional arguments, but not for
>>> arguments following an option.
>>
>> This is how it was in for-each-ref Documentation, hence to keep it similar I
>> just put <format>.
>
> "It's wrong in another place" sounds like an argument to fix the other
> place, not to get it wrong here too ;-).
>

Of course! That was just me justifying my action. I agree, it should
be corrected both places.

-- 
Regards,
Karthik Nayak
