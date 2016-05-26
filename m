From: Stefan Beller <sbeller@google.com>
Subject: Re: [PATCH 2/2] submodule update: learn `--[no-]recommend-shallow` option
Date: Thu, 26 May 2016 10:29:07 -0700
Message-ID: <CAGZ79kY1yWp0r1XzRUVxnFC3jee1w3LtXUkx5NUjNoBWbbXMhg@mail.gmail.com>
References: <20160526000633.27223-1-sbeller@google.com> <20160526000633.27223-3-sbeller@google.com>
 <135840520.44198.1464253655936.JavaMail.zimbra@ensimag.grenoble-inp.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: "git@vger.kernel.org" <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Jens Lehmann <Jens.Lehmann@web.de>
To: Remi Galan Alfonso <remi.galan-alfonso@ensimag.grenoble-inp.fr>
X-From: git-owner@vger.kernel.org Thu May 26 19:29:14 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1b5z5u-0003gF-3m
	for gcvg-git-2@plane.gmane.org; Thu, 26 May 2016 19:29:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754774AbcEZR3J convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 26 May 2016 13:29:09 -0400
Received: from mail-io0-f171.google.com ([209.85.223.171]:35840 "EHLO
	mail-io0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754714AbcEZR3I convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 26 May 2016 13:29:08 -0400
Received: by mail-io0-f171.google.com with SMTP id f8so57204933ioe.3
        for <git@vger.kernel.org>; Thu, 26 May 2016 10:29:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=GML6xiaKRyvYo9Ytqnof3N+D5MFc0SkW/HZOLJrGz2c=;
        b=AUgYh0xL18gjna0tevXokUw1qUpFbIAqah9rGDmRVsYnbZeZHKt6giA5qHxlGNCxMd
         N3Sk9D7EMaf0xpu4cL9yVlAPLHEaPxHcjpgIwFwTXs4V6RY/QXHgGQe2L6m+H1NRioLq
         N24uxfbhxBP/UPT0oMNcChLL0EqAgAvxCIz83cvl4vZMnsGsSS/lVtNXdDeGGvte5MAB
         +S+v8M+Kiz0l2gMH/f6Y06s1lDbaMksDlpAJdK4wQdyh7YsJm9TUA2ZeNW1xc3VFwOPt
         7Zg/6uQHt47TulFDGkE1f28V6HvCSCvnNh9FaEl6SodGg1csnYW5nZrmIWvh5Ymn/7vQ
         sNAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=GML6xiaKRyvYo9Ytqnof3N+D5MFc0SkW/HZOLJrGz2c=;
        b=C+q/kRKMXlDEdFNCxF9tz4q0e4HN3U+0BeI1bYZEVSFfM6SFNN6ply/+M3UJvgAjPS
         h9VHZypNVJoAurY2CrvwtgYib99SyFna0//r5+teJiVtkPlmVeBg+4eNYv9XTo3WE12o
         aoodiXpOZdMXPUbWvmhKR4tdZQW4vbksuXb3uzYy33/Px7SFQeXbWSMG/qlqvCtHRA4q
         vmvAcH1Wxktt7NMHWkX84KvxMG1+poEaLWBRrWHUaG+LSyEvqsWvDCRo9yo/g7/YR/kM
         xSUXcFefrreB1xqPuzfejztyY2ynP01z1uFFMs6WS8qnQ/uYwHJ28UyCbFZHdZSuGCmb
         dfPg==
X-Gm-Message-State: ALyK8tJiKOTcQGl8Y9MI1FNHzgLg4f6Fqi/Us0WkKBWzByter2RfOoyryepkxoR8NSgmGJNFSLmYhlY6MX6LZYU0
X-Received: by 10.107.53.162 with SMTP id k34mr9376008ioo.174.1464283747469;
 Thu, 26 May 2016 10:29:07 -0700 (PDT)
Received: by 10.107.136.19 with HTTP; Thu, 26 May 2016 10:29:07 -0700 (PDT)
In-Reply-To: <135840520.44198.1464253655936.JavaMail.zimbra@ensimag.grenoble-inp.fr>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/295678>

On Thu, May 26, 2016 at 2:07 AM, Remi Galan Alfonso
<remi.galan-alfonso@ensimag.grenoble-inp.fr> wrote:
> You forgot to update from recommend-depth to recommend-shallow
>
> Stefan Beller <sbeller@google.com> writes:
>> [...]
>>  'git submodule' [--quiet] init [--] [<path>...]
>>  'git submodule' [--quiet] deinit [-f|--force] (--all|[--] <path>...=
)
>>  'git submodule' [--quiet] update [--init] [--remote] [-N|--no-fetch=
]
>> -              [-f|--force] [--rebase|--merge] [--reference <reposit=
ory>]
>> -              [--depth <depth>] [--recursive] [--jobs <n>] [--] [<p=
ath>...]
>> +              [--[no-]recommended-depth] [-f|--force] [--rebase|--m=
erge]
>
> Here...
>
>> +--[no-]recommended-depth::
>> +        This option is only valid for the update command.
>> +        The initial clone of a submodule will use the recommended
>> +        `submodule.<name>.depth` as provided by the .gitmodules fil=
e.
>> +
>
> ... and here.
>
> Thanks,
> R=C3=A9mi

Thanks for the review,
these will be fixed in a reroll.

Thanks,
Stefan
