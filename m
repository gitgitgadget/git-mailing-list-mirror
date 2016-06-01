From: Duy Nguyen <pclouds@gmail.com>
Subject: Re: [PATCH v2 4/4] bundle v3: the beginning
Date: Wed, 1 Jun 2016 20:37:32 +0700
Message-ID: <CACsJy8AxPKuDUZzWdaWg8tfcWBhqJBADc=ia-Y8cM+zyJ1NFTQ@mail.gmail.com>
References: <xmqqfuw84uhb.fsf@gitster.mtv.corp.google.com> <1456950761-19759-1-git-send-email-gitster@pobox.com>
 <1456950761-19759-5-git-send-email-gitster@pobox.com> <CAP8UFD1xqRMFE2Wzntu=XevCyj+acGLEO-cTq1fqn+NMe3x0vg@mail.gmail.com>
 <CACsJy8Dr_Z886Jb-O8gbAv_vzBLicNH6bPPpKwb9HWZTKQ9muw@mail.gmail.com> <CAP8UFD3jPQFk2deSk5JXC3PTz5yWcvXJ4=Qjam5Qw6P9SrLzFQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Junio C Hamano <gitster@pobox.com>, git <git@vger.kernel.org>,
	Jeff King <peff@peff.net>
To: Christian Couder <christian.couder@gmail.com>
X-From: git-owner@vger.kernel.org Wed Jun 01 15:38:18 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1b86Le-0005lJ-V5
	for gcvg-git-2@plane.gmane.org; Wed, 01 Jun 2016 15:38:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752221AbcFANiK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 1 Jun 2016 09:38:10 -0400
Received: from mail-io0-f175.google.com ([209.85.223.175]:33165 "EHLO
	mail-io0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751116AbcFANiJ (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 1 Jun 2016 09:38:09 -0400
Received: by mail-io0-f175.google.com with SMTP id t40so21052211ioi.0
        for <git@vger.kernel.org>; Wed, 01 Jun 2016 06:38:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=jzI8C5GjlIlNTI8mjxzS/BC0wQuFWcLJwcscpEyfVvE=;
        b=wJ2rzzefiFIyuhRpJvsavz/AMD4/ctJHs5RsFekhlE4oq6aI7Ir6mHg34X3HDNZ0Zg
         lHB+zI11V8M7QKDu+d2TA8tmeOjGfanAow35LyCS0OcozlPb6MqmcCD63EHWUBPT4OUs
         dUOq+WYr/ukxMFwBfUMeWjavubh8v7X/pR2bUahd0wbqurQim+DH5PKycON0pu7oSTp5
         tY6iLsQiBASg0qqt1nJK0aXmlqIjNgOjgtZYkrR8wrBGYF596wjx56JDs7mNPrGOYFGG
         d4jArSfSKwh0Wj50afVoDwUPvDJZopErdAr1P5wnbra9SmAj3zfr71c1DN4mAVTFHu0c
         ic5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=jzI8C5GjlIlNTI8mjxzS/BC0wQuFWcLJwcscpEyfVvE=;
        b=A3bqMemKICKhZ0WXBTEqLPMJzLVDuBOLRBFprP3XpXv0Ac2GJ63o/XH5TnUp8XSbAU
         CLTNGtI8B84K7FvvnvjPZYexympXGARr9fDK9QfDsgHHCRbHe3Eohh/mhWafNhusSDzu
         +TPbCu9YOEXJ3uI+KF25Dbcdy9cG4Q5C954JXgJmIP+7PY0Subwqh0PCI5HxTdprM005
         PE8+ulSaFuY8Dl9K3XiuLMIuLvLV5E9859TsR/2XTsoxIr3axof+y5iA3mEgDpBVYDke
         3rlThy2MhgI3YjpBJxCHGRhRyA58mqAUYr6m0GmQ0FgKOiH0T1RmMHbxspIZAmkiGqqZ
         GBOw==
X-Gm-Message-State: ALyK8tKRFDKlN+/Z5JuITXxGSdr89jbHgrT/Zc6xmnx3ItAhPjSt6P7hrKalOaPCJZS3QP6NDeUTwDW9dqdaxw==
X-Received: by 10.107.159.84 with SMTP id i81mr5332021ioe.29.1464788282834;
 Wed, 01 Jun 2016 06:38:02 -0700 (PDT)
Received: by 10.64.2.106 with HTTP; Wed, 1 Jun 2016 06:37:32 -0700 (PDT)
In-Reply-To: <CAP8UFD3jPQFk2deSk5JXC3PTz5yWcvXJ4=Qjam5Qw6P9SrLzFQ@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/296085>

On Tue, May 31, 2016 at 8:18 PM, Christian Couder
<christian.couder@gmail.com> wrote:
>>> I wonder if this mechanism could also be used or extended to clone and
>>> fetch an alternate object database.
>>>
>>> In [1], [2] and [3], and this was also discussed during the
>>> Contributor Summit last month, Peff says that he started working on
>>> alternate object database support a long time ago, and that the hard
>>> part is a protocol extension to tell remotes that you can access some
>>> objects in a different way.
>>>
>>> If a Git client would download a "$name.bndl" v3 bundle file that
>>> would have a "data: $URL/alt-odb-$name.odb" extended header, the Git
>>> client would just need to download "$URL/alt-odb-$name.odb" and use
>>> the alternate object database support on this file.
>>
>> What does this file contain exactly? A list of SHA-1 that can be
>> retrieved from this remote/alternate odb?
>
> It would depend on the external odb. Git could support different
> external odb that have different trade-offs.
>
>> I wonder if we could just
>> git-replace for this marking. The replaced content could contain the
>> uri pointing to the alt odb.
>
> Yeah, interesting!
> That's indeed another possibility that might not need the transfer of
> any external odb.
>
> But in this case it might be cleaner to just have a separate ref hierarchy like:
>
> refs/external-odbs/my-ext-odb/<sha1>
>
> instead of using the replace one.
>
> Or maybe:
>
> refs/replace/external-odbs/my-ext-odb/<sha1>
>
> if we really want to use the replace hierarchy.

Yep. replace hierarchy crossed my mind. But then I thought about
performance degradation when there are more than one pack (we have to
search through them all for every SHA-1) and discarded it because we
would need to do the same linear search here. I guess we will most
likely have one or two name spaces so it probably won't matter.

>> We could optionally contact alt odb to
>> retrieve real content, or just show the replaced/fake data when alt
>> odb is out of reach.
>
> Yeah, I wonder if that really needs the replace mechanism.

Replace mechanism provides good hook point. But it really depends how
invasive this remote odb is. If a fake content is enough to avoid
breakages up high, git-replace is enough. If you really need to pass
remote odb info up so higher levels can do something more fancy, then
it's insufficient.

> By the way this makes me wonder if we could implement resumable clone
> using some kind of replace ref.
>
> The client while cloning nearly as usual would download one or more
> special replace refs that would points to objects with links to
> download bundles using standard protocols.
> Just after the clone, the client would read these objects and download
> the bundles from these objects.
> And then it would clone from these bundles.

I thought we have settled on resumable clone, just waiting for an
implementation :) Doing it your way, you would need to download these
special objects too (in a pack?) and come back download some more
bundles. It would be more efficient to show the bundle uri early and
go download the bundle on the side while you go on to get the
addition/smaller pack that contains the rest.
-- 
Duy
