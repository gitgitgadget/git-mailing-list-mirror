From: Christian Couder <christian.couder@gmail.com>
Subject: Re: [PATCH v7 03/12] for-each-ref: change comment in ref_sort
Date: Fri, 12 Jun 2015 21:49:26 +0200
Message-ID: <CAP8UFD3nsxX0XEVwxdMBRR8OQDu=ary6Bm2AD7wprAU0BC8tXA@mail.gmail.com>
References: <5579B253.4020804@gmail.com>
	<1434039003-10928-1-git-send-email-karthik.188@gmail.com>
	<1434039003-10928-3-git-send-email-karthik.188@gmail.com>
	<xmqqy4joddul.fsf@gitster.dls.corp.google.com>
	<557B1B60.9020002@gmail.com>
	<xmqqpp50dcqy.fsf@gitster.dls.corp.google.com>
	<557B2516.7020609@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Junio C Hamano <gitster@pobox.com>, git <git@vger.kernel.org>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
To: Karthik Nayak <karthik.188@gmail.com>
X-From: git-owner@vger.kernel.org Fri Jun 12 21:49:35 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Z3UxJ-0000Bu-En
	for gcvg-git-2@plane.gmane.org; Fri, 12 Jun 2015 21:49:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751252AbbFLTt2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 12 Jun 2015 15:49:28 -0400
Received: from mail-wi0-f181.google.com ([209.85.212.181]:35981 "EHLO
	mail-wi0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750698AbbFLTt1 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 12 Jun 2015 15:49:27 -0400
Received: by wigg3 with SMTP id g3so25411045wig.1
        for <git@vger.kernel.org>; Fri, 12 Jun 2015 12:49:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=N6VdlcUtlXocPdDF5fZN05+Jv7hYZ3/S6EhY8BWM9hI=;
        b=GZIJCfuzvH98BMY67SspUM8jOms3gSqW+xsLGcR+N5Bf6/IZ/oa3RWmBAsvr0HpRpb
         DEXv16heelZVEdLo3uY/1INNexovAKH8tI+HzeEgjAvQpY1GJ5RmgiyxPJJ3wEuO+BUd
         wBjznn9QhXvgY5ZVXPl65AF6P2ragyFdw/Nxh3NHIBzHelGKuAIdDT7Hb3vWQOv+gxXv
         irkpOy7LUP5sMc33mFk5QoQej8+2yYpoWljv2/+i24EVod6EHusdH/MdzmkhtPtRoqtE
         U8Z4I+awHhzGHD/rDNDGo0s/7Zom0yMnh16fgMVYI8frvbdXPKseJsJCPl8R9e1h7lDd
         ThJA==
X-Received: by 10.181.25.234 with SMTP id it10mr10008850wid.41.1434138566727;
 Fri, 12 Jun 2015 12:49:26 -0700 (PDT)
Received: by 10.194.40.8 with HTTP; Fri, 12 Jun 2015 12:49:26 -0700 (PDT)
In-Reply-To: <557B2516.7020609@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/271516>

On Fri, Jun 12, 2015 at 8:29 PM, Karthik Nayak <karthik.188@gmail.com> wrote:
> On 06/12/2015 11:34 PM, Junio C Hamano wrote:
>>
>> Karthik Nayak <karthik.188@gmail.com> writes:
>>
>>>> What change since 9f613dd do you have in mind, exactly, though?
>>>
>>>
>>> Well initially the atoms were indexed into used_atom array, which
>>> later was removed. Hence the comment becomes obsolete.
>>
>>
>> Later in which commit?  In builtin/for-each-ref.c in the version
>> after applying patches 1-3 of this series on top of master, I still
>> see used_atom[] array there, so...?
>>
>
> Uh! My bad.
> Ignore this! I think I got confused, On having a look now that patch is
> not needed. Sorry.

I think it is needed later when "struct ref_sort" is moved into
ref-filter.h, because then the used_atom[] array is not moved.

So either:

1) you update the comment when you move "struct ref_sort" into
ref-filter.h, but then the downside is that there is not only code
movement in the patch that moves "struct ref_sort" into ref-filter.h,
or

2) you explain that, as "struct ref_sort" will be moved later while
the used_atom[] array will not be moved, the direct connection between
the comment and used_atom[] will be broken, and you need to prepare
for that because you want to avoid solution 1) as you want only code
movement when moving "struct ref_sort" into ref-filter.h.

Hope this helps,
Christian.
