From: Christian Couder <christian.couder@gmail.com>
Subject: Re: [PATCH v2 00/94] libify apply and use lib in am
Date: Fri, 10 Jun 2016 22:31:32 +0200
Message-ID: <CAP8UFD1X6G4-C33PwZmV3LPb7e+-QQ60bcRbDA9gLaf9j6U+vw@mail.gmail.com>
References: <20160511131745.2914-1-chriscool@tuxfamily.org>
 <5734B805.8020504@kdbg.org> <CAP8UFD1ukOMi_VDKzZErwSu1OBU5h1hVOxd7mPu1ytzFr11VGA@mail.gmail.com>
 <5759DB31.2000106@kdbg.org> <alpine.DEB.2.20.1606100852550.3039@virtualbox>
 <CAP8UFD1zSAxyHfZgBbfoF=th0waZWEhvHP+4jUxxVO+rU9N9RA@mail.gmail.com>
 <alpine.DEB.2.20.1606101307080.3039@virtualbox> <575AF304.8070407@kdbg.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	git <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
	=?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
	Nguyen Thai Ngoc Duy <pclouds@gmail.com>,
	Stefan Beller <sbeller@google.com>,
	Eric Sunshine <sunshine@sunshineco.com>,
	Ramsay Jones <ramsay@ramsayjones.plus.com>,
	Jeff King <peff@peff.net>,
	Karsten Blees <karsten.blees@gmail.com>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
	Christian Couder <chriscool@tuxfamily.org>
To: Johannes Sixt <j6t@kdbg.org>
X-From: git-owner@vger.kernel.org Fri Jun 10 22:31:40 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1bBT5f-0000RO-Gm
	for gcvg-git-2@plane.gmane.org; Fri, 10 Jun 2016 22:31:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752608AbcFJUbg (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 10 Jun 2016 16:31:36 -0400
Received: from mail-wm0-f68.google.com ([74.125.82.68]:33002 "EHLO
	mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751440AbcFJUbf (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 10 Jun 2016 16:31:35 -0400
Received: by mail-wm0-f68.google.com with SMTP id r5so1156983wmr.0
        for <git@vger.kernel.org>; Fri, 10 Jun 2016 13:31:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=xI2wv2+zyk0TS052LfjNtAtLekE4K2wk9gb8WvgZVSs=;
        b=ovHQSirPGd1+lLDL0sKB2ETtHx5M1iYhXcTLJrjBVHaBMjEZNvkrUT7P2g7L60Y1Uh
         AB64+gfTL52Hw5LKNzKNq1P1w4I+PvZeRdc1kSjIQ99wJsxYYkZ34k+0iX9+4UCCI804
         hWBhii28FUXmipEMQP66zx69tQC8gNkFMUn14HqwDeLhWFohcS+O2uIXQ879NP90zAv7
         zeFlnfgrxi34vpdGJJ7G5D+U0mB2s+8dO+kkPMkDn5nWW8y84cQ3ihUdE4DL76VKSLTF
         2m0dlrLRpA8ysSqB8vZ4YtTsAvklt0C93Yzk87ZFJsOqlWZF/bLgcrJFxx01pIkHoUbv
         V6kA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=xI2wv2+zyk0TS052LfjNtAtLekE4K2wk9gb8WvgZVSs=;
        b=UTch/HGdJ8+z9a6bsstlKAAeQiK5tn6mssvYHTDyNyKDUMo9N70Lj4jsJZvRwDg402
         I8OvVDmhPYgs93k7uEfiZManX5CuwNcmTwa7e9WURaKqNWR/hhAt0oNCEXhmwcKJCOaJ
         QIIXWp8bJ72nOgXenlXpHjy7emo9GBwgf5HqCnILRe734SowYlVTJ5PV4kvGoGN92ZVb
         6t0HSxVHdIWIXS+/SSN5INY5qbKD13MvEIEIaGVhoBEt9/Yw0MZmmtwVhvRI/hpOVuRW
         bdPXh7tlGf6hacg/4nXI21blW9HfMKcSEAnj4tM39xwOiufBYSPH7UccdGqWf/QEbvyl
         LqHQ==
X-Gm-Message-State: ALyK8tJd4YvL0rPhxDsYjPoFZuBCYc1zC6Ok05fJtbWREcTcwXVbqeEB1bHiwMwz+xYKl/Slv/NnCybC33VZwQ==
X-Received: by 10.28.95.196 with SMTP id t187mr699887wmb.89.1465590693803;
 Fri, 10 Jun 2016 13:31:33 -0700 (PDT)
Received: by 10.194.25.197 with HTTP; Fri, 10 Jun 2016 13:31:32 -0700 (PDT)
In-Reply-To: <575AF304.8070407@kdbg.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/297069>

On Fri, Jun 10, 2016 at 7:04 PM, Johannes Sixt <j6t@kdbg.org> wrote:
> Am 10.06.2016 um 13:11 schrieb Johannes Schindelin:
>>
>> Not really. The reply (which I had not quite connected with my mail
>> because they were over a week apart) says this:
>>
>>> I fixed this by moving the "close(fd)" call just after the
>>> "apply_patch()" call.
>
> This bug in v1 was discovered by the test suite and fixed in v2.
>
>> and this:
>>
>>> I will have another look at the 2 other places where there are
>>> open()/close() or fopen()/fclose() calls.
>>
>> but nothing about a careful, systematic investigation of all error code
>> paths. As a consequence, I fully expect to encounter test failures as soon
>> as I test your patch series again, simply because resources are still in
>> use when they should no longer be used. In other words, my expectations
>> are now lower than they have been before, my concerns are not at all
>> addressed.
>
> Do you trust the test suite to some degree? It passes after the above bug
> was fixed in v2. In addition, haven't found any problems so far during daily
> use.
>
>>> This is the newest iteration:
>>>
>>> https://github.com/chriscool/git/commits/libify-apply-use-in-am65
>>
>> And that cute 65 in the name is the revision.
>
> Yeah, that number is painful. I would appreciate an unversioned branch name,
> too.

Ok, you can use
https://github.com/chriscool/git/commits/libify-apply-use-in-am then.

Thanks,
Christian.
