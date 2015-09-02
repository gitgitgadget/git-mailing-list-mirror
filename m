From: Karthik Nayak <karthik.188@gmail.com>
Subject: Re: [PATCH v15 06/13] ref-filter: add option to filter out tags,
 branches and remotes
Date: Wed, 2 Sep 2015 18:18:35 +0530
Message-ID: <CAOLa=ZSRZHWMRh759dGVd4hHebpnnCA60TZoXoY-iqPa=t-e0Q@mail.gmail.com>
References: <1441131994-13508-1-git-send-email-Karthik.188@gmail.com>
 <1441131994-13508-7-git-send-email-Karthik.188@gmail.com> <xmqqa8t5rfng.fsf@gitster.mtv.corp.google.com>
 <CAOLa=ZQQia58_9c+KDh9mZ_UdcpUn96yuPOdABYvs1gno04CmQ@mail.gmail.com> <xmqqoahlpibt.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git <git@vger.kernel.org>,
	Christian Couder <christian.couder@gmail.com>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Sep 02 14:49:13 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZX7TU-00069o-Bp
	for gcvg-git-2@plane.gmane.org; Wed, 02 Sep 2015 14:49:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754644AbbIBMtI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 2 Sep 2015 08:49:08 -0400
Received: from mail-ob0-f182.google.com ([209.85.214.182]:35221 "EHLO
	mail-ob0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754426AbbIBMtG (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 2 Sep 2015 08:49:06 -0400
Received: by obuk4 with SMTP id k4so6754011obu.2
        for <git@vger.kernel.org>; Wed, 02 Sep 2015 05:49:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=xdFE7fLNmImBP2q70DTBSuPKTKztqv8cFieYwmxxW2k=;
        b=xye6DsTs2nFBdZyc+PYFFijljfX1q+9fzZ6Q975jD6VSO4pRB1gGO10MSlLwxQ3ChY
         TaR+z8wG5u4OA7Y/Ab/B/K/FPhT228d5PBYafCly3KXHoOLmJibrzMP8XDNAyPLdDpP4
         rgMvbULAVILPByZwVGOaeDiLAW5cOWXYBYa/bFn4XFybNfWe5iQd1w9n5sRz7I4uMVr6
         3ccTGi2U5u0fHLJi6R/z1J8Knvyz3wGW3F/0zlbcBkiRtwyWw88eRxZj0B9pZxbmYhxD
         0hJ3l0SB5lG7+zX9sG6B9Np3MAF80EbqjCQkOl0dFHOYAbo68F1KADvRot0N+2UW1RSr
         354g==
X-Received: by 10.182.33.39 with SMTP id o7mr19895204obi.42.1441198145316;
 Wed, 02 Sep 2015 05:49:05 -0700 (PDT)
Received: by 10.182.59.102 with HTTP; Wed, 2 Sep 2015 05:48:35 -0700 (PDT)
In-Reply-To: <xmqqoahlpibt.fsf@gitster.mtv.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/277087>

On Wed, Sep 2, 2015 at 9:45 AM, Junio C Hamano <gitster@pobox.com> wrote:
> Karthik Nayak <karthik.188@gmail.com> writes:
>
>>>> +             if (filter->kind == FILTER_REFS_BRANCHES)
>>>> + ret = for_each_fullref_in("refs/heads/", ref_filter_handler,
>>>> &ref_cbdata, broken);
>>>> +             else if (filter->kind == FILTER_REFS_REMOTES)
>>>> + ret = for_each_fullref_in("refs/remotes/", ref_filter_handler,
>>>> &ref_cbdata, broken);
>>>> +             else if (filter->kind == FILTER_REFS_TAGS)
>>>> + ret = for_each_fullref_in("refs/tags/", ref_filter_handler,
>>>> &ref_cbdata, broken);
>>>> +             else if (filter->kind & FILTER_REFS_ALL)
>>>> + ret = for_each_fullref_in("", ref_filter_handler, &ref_cbdata,
>>>> broken);
>>>
>>> This if/else if/else if/ cascade and ...
>>
>> Did you notice the "==" for others and "&" for the ALL?
>
> I didn't.  Thanks for pointing it out.
>
> So the point of the earlier part of the cascade is to optimize for
> common cases?  If that is the case, it probably deserves some
> commenting.  I also suspect that a table-based control might be
> easier to maintain, but that kind of change might fall into the
> category of premature optimization.

Yes, thats the point.
Will add a comment, thanks :)

-- 
Regards,
Karthik Nayak
