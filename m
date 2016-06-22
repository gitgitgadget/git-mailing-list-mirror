Return-Path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6CAB62018B
	for <e@80x24.org>; Wed, 22 Jun 2016 19:00:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751432AbcFVTAB (ORCPT <rfc822;e@80x24.org>);
	Wed, 22 Jun 2016 15:00:01 -0400
Received: from mail-yw0-f195.google.com ([209.85.161.195]:36282 "EHLO
	mail-yw0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750957AbcFVTAA (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 22 Jun 2016 15:00:00 -0400
Received: by mail-yw0-f195.google.com with SMTP id f75so7556602ywb.3
        for <git@vger.kernel.org>; Wed, 22 Jun 2016 12:00:00 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc;
        bh=rYaaqgOL++obukyodnzZBErgOEvDceGYyykwQDk1X6s=;
        b=Lyo4NVsY5GvOjpllUYVXOOw3wEHSMw/xqiihzVPRB8Jy86Ai+jy7wsAhPB75Ab2zfV
         Dxskae8WGDoRYw8wvhsX/bcOjOH99/TSK8Cg3iSVZBXUqG9znMv/4ltgBM6vZcGY8F+R
         jSS0kzSRFvXW4dBNO6wEjnWzX034ywdRvBXYwnS6QqISucAVUuVSQCqV1ptCUEDRMpAG
         YmEtqqa8uT9P9RptxIqKTKOrBHYHUJzalYMK8715ol81Qu2omIDtJ3DJuqUv52wg/brV
         nrPpDZ8UoavOwy5z8siX2BkJLh4KOHjRiCFLZuFidky9C1xPty/Y99jL6sjCExsvSCjC
         939w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:from
         :date:message-id:subject:to:cc;
        bh=rYaaqgOL++obukyodnzZBErgOEvDceGYyykwQDk1X6s=;
        b=GGow21FlrYDn5LwH/n6D7CvAfAXQ9xJCgsKffcEMNXBM4IcmobpfU8dhbdKqXQVzYt
         9vYf7ZUZ9BQdvkEKIH/6bXGViahCdm1gmEJtk5pwfLe4qJdBIPzMvoDuwdKfK5Rswdxl
         bGp2gvlfnIxoMfjZXiaCBi13IPd+Z/VLTrm8nYoBee9EuGwRALFjYhLA9vhQ4eCR3QWo
         azlE7aT7HhfpoWH0e2S+4Z1OqX1kAL6ynZbHjiCm86K7VjQL1CpbOejgMzfT+IFyTHgq
         +SX5TzypGyxlpKTWHvQldJ/CYz1zwXrF/Gu8DP64qv+GASGgKJAKl+vG5mL575mn6DDr
         tcLg==
X-Gm-Message-State: ALyK8tJFUJ7phptBsf/ACB9Dwy6eUQRj9tIJL3TdFrRTYjgoO+YeBBLKpp08KIgYOfvgF2OGCjN5n2HPwvEwBg==
X-Received: by 10.13.229.69 with SMTP id o66mr16748816ywe.69.1466621999391;
 Wed, 22 Jun 2016 11:59:59 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.13.251.71 with HTTP; Wed, 22 Jun 2016 11:59:40 -0700 (PDT)
In-Reply-To: <CACsJy8BMCjjX7_d73LX8+SiYWA4UUFyU3GGzxSVXMK4xubsKNg@mail.gmail.com>
References: <1453982183-24124-1-git-send-email-pclouds@gmail.com>
 <1454724190-14063-1-git-send-email-pclouds@gmail.com> <xmqq4m8rz9qr.fsf@gitster.mtv.corp.google.com>
 <CACsJy8CSVvZfwjG+zAEpG6tAWYAWVkrkz4RP32Hrr9O1A_8ZMg@mail.gmail.com>
 <CACsJy8BQxAkpoT7GVNgtM-0n1pMZeV5TRCiSn6TsYeATWeU=EA@mail.gmail.com>
 <CAPc5daWEoK4Gp138VPstqwCAX+2K=_gSW98brHjmJYNWK4dkZw@mail.gmail.com> <CACsJy8BMCjjX7_d73LX8+SiYWA4UUFyU3GGzxSVXMK4xubsKNg@mail.gmail.com>
From:	Junio C Hamano <gitster@pobox.com>
Date:	Wed, 22 Jun 2016 11:59:40 -0700
X-Google-Sender-Auth: FfdWbDtzapGy0KXOwND_nCXV1G4
Message-ID: <CAPc5daU4K85a883sR0u87fTObakCvv6Z41qxx1WOT2=QdDjZeA@mail.gmail.com>
Subject: Re: [PATCH v6 00/11] Fix icase grep on non-ascii
To:	Duy Nguyen <pclouds@gmail.com>
Cc:	Git Mailing List <git@vger.kernel.org>,
	Eric Sunshine <sunshine@sunshineco.com>
Content-Type: text/plain; charset=UTF-8
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

On Wed, Jun 22, 2016 at 11:41 AM, Duy Nguyen <pclouds@gmail.com> wrote:
> On Wed, Jun 22, 2016 at 8:36 PM, Junio C Hamano <gitster@pobox.com> wrote:
>> On Wed, Jun 22, 2016 at 11:29 AM, Duy Nguyen <pclouds@gmail.com> wrote:
>>>
>>> Can any shell wizards explain this to me? With this code
>>>
>>> BS=\\
>>> echo ${BS}${BS}
>>>
>>> Debian's dash returns a single backslash while bash returns two
>>> backslashes. Section 2.2.1 [1] does not say anything about one
>>> backslash (hidden behind a variable!) after escaping the following one
>>> and still eats the one after that..
>>>
>>> [1] http://pubs.opengroup.org/onlinepubs/009604499/utilities/xcu_chap02.html
>>
>> I am not a wizard, but is the difference between the shell syntax, or just their
>> implementation of builtin-echo?  IOW, how do these three compare?
>>
>> printf "%s\n" "${BS}${BS}"
>> echo "${BS}${BS}"
>> echo ${BS}$BS}
>
> Great! printf shows two backslashes while both echo'es show one.
> printf "\\\\" behaves like echo though. Doesn't matter, at least I
> should be able to make the tests work on Debian dash.

I think somebody's implementation of "echo" is not POSIX kosher. According to

http://pubs.opengroup.org/onlinepubs/9699919799/utilities/echo.html

you should expect a single backslash. If a script depends on seeing two, the
script is buggy.
