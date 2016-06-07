From: Christian Couder <christian.couder@gmail.com>
Subject: Re: [PATCH v2 4/4] bundle v3: the beginning
Date: Tue, 7 Jun 2016 16:49:05 +0200
Message-ID: <CAP8UFD0+0EYUNy6sQWjHAqfTU8yx9-GmOVV+JtqzWkbO1S1G2g@mail.gmail.com>
References: <xmqqfuw84uhb.fsf@gitster.mtv.corp.google.com> <1456950761-19759-1-git-send-email-gitster@pobox.com>
 <1456950761-19759-5-git-send-email-gitster@pobox.com> <CAP8UFD1xqRMFE2Wzntu=XevCyj+acGLEO-cTq1fqn+NMe3x0vg@mail.gmail.com>
 <CACsJy8Dr_Z886Jb-O8gbAv_vzBLicNH6bPPpKwb9HWZTKQ9muw@mail.gmail.com>
 <CAP8UFD3jPQFk2deSk5JXC3PTz5yWcvXJ4=Qjam5Qw6P9SrLzFQ@mail.gmail.com> <CACsJy8AxPKuDUZzWdaWg8tfcWBhqJBADc=ia-Y8cM+zyJ1NFTQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Junio C Hamano <gitster@pobox.com>, git <git@vger.kernel.org>,
	Jeff King <peff@peff.net>
To: Duy Nguyen <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Tue Jun 07 16:49:14 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1bAIJd-0004Ia-UT
	for gcvg-git-2@plane.gmane.org; Tue, 07 Jun 2016 16:49:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754203AbcFGOtJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 7 Jun 2016 10:49:09 -0400
Received: from mail-wm0-f51.google.com ([74.125.82.51]:37450 "EHLO
	mail-wm0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751475AbcFGOtI (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 7 Jun 2016 10:49:08 -0400
Received: by mail-wm0-f51.google.com with SMTP id k204so72749700wmk.0
        for <git@vger.kernel.org>; Tue, 07 Jun 2016 07:49:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=dWDxvA1mAesk7ijqVaK/WMPC9xzHbkJ2rl8ZGb4zH8o=;
        b=HkOMMVLIUTpY4MIj9s0RCwXo2Y1zDnTKdwB4ykO70lASt+vdBpOAOCydeD1rmpxMWf
         g/IRCs6eWB5+IxUhKRifTji+Iy7Ih2aX/5j7rcuDI4MD2GM2jNr7w9gozdtIefvidckf
         THo+rxiVBSJ2OGWst4Qh/UkaqAyEREeLmCzEC/j6PMrI3ONEHzo7gwO5Xp02Hdyqi4fa
         xRC4+Euf3zeV48np/ZyMAcXfsF5aej/CnE+0roOTRNwr5x0quhKlciS7CSzVqFMIoA5I
         xhrCZUFPY0AmKSiz+sN/7Q7twMvLRPySNDC+xGV5LdQP+EA3Q9YhRA8W7IkTWxuHoJJx
         Gm3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=dWDxvA1mAesk7ijqVaK/WMPC9xzHbkJ2rl8ZGb4zH8o=;
        b=Seyz4Jo4HYhSeednJ4eqFLfSByROM7LpvEdtuTMg/ct5fPw11xMxHb/0dPJ1aOQcgH
         jlCMWrxBAp5SS20FLmDIKQ0RMORRpyEa39qzg/YX97gYf1dGLle3fUwxviGYE6ZC4NoD
         EV7ckw5s6dsissuoXX6zfmVNN1EwviOyKg4wirT4jD/F4hHA1HW041hMHd4U5w3X3XNK
         kYqeapnIdCQYQ5mv6AwPlcH+LQUaFXCWoJLllmxJ3tpn1FEWv1ykYQOBW9lQ9oCDH/+f
         s40/ZaZ/c8k9MOIWCIkxRItq+9GeWUcmsgsgREv5vDpd4v98x+27gH03K64j10oWB1cO
         w1Yg==
X-Gm-Message-State: ALyK8tIPL6fhOuEXvaxndrAeWN08s1AuAMUm89yPjWCRI5t+SYiDcCh9hQyZ7H1dGs6b8g1oE4ZHvEXoYFfs0w==
X-Received: by 10.195.17.166 with SMTP id gf6mr20849481wjd.124.1465310946457;
 Tue, 07 Jun 2016 07:49:06 -0700 (PDT)
Received: by 10.194.148.146 with HTTP; Tue, 7 Jun 2016 07:49:05 -0700 (PDT)
In-Reply-To: <CACsJy8AxPKuDUZzWdaWg8tfcWBhqJBADc=ia-Y8cM+zyJ1NFTQ@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/296687>

On Wed, Jun 1, 2016 at 3:37 PM, Duy Nguyen <pclouds@gmail.com> wrote:
> On Tue, May 31, 2016 at 8:18 PM, Christian Couder
> <christian.couder@gmail.com> wrote:
>>>> I wonder if this mechanism could also be used or extended to clone and
>>>> fetch an alternate object database.
>>>>
>>>> In [1], [2] and [3], and this was also discussed during the
>>>> Contributor Summit last month, Peff says that he started working on
>>>> alternate object database support a long time ago, and that the hard
>>>> part is a protocol extension to tell remotes that you can access some
>>>> objects in a different way.
>>>>
>>>> If a Git client would download a "$name.bndl" v3 bundle file that
>>>> would have a "data: $URL/alt-odb-$name.odb" extended header, the Git
>>>> client would just need to download "$URL/alt-odb-$name.odb" and use
>>>> the alternate object database support on this file.
>>>
>>> What does this file contain exactly? A list of SHA-1 that can be
>>> retrieved from this remote/alternate odb?
>>
>> It would depend on the external odb. Git could support different
>> external odb that have different trade-offs.
>>
>>> I wonder if we could just
>>> git-replace for this marking. The replaced content could contain the
>>> uri pointing to the alt odb.
>>
>> Yeah, interesting!
>> That's indeed another possibility that might not need the transfer of
>> any external odb.
>>
>> But in this case it might be cleaner to just have a separate ref hierarchy like:
>>
>> refs/external-odbs/my-ext-odb/<sha1>
>>
>> instead of using the replace one.
>>
>> Or maybe:
>>
>> refs/replace/external-odbs/my-ext-odb/<sha1>
>>
>> if we really want to use the replace hierarchy.
>
> Yep. replace hierarchy crossed my mind. But then I thought about
> performance degradation when there are more than one pack (we have to
> search through them all for every SHA-1) and discarded it because we
> would need to do the same linear search here. I guess we will most
> likely have one or two name spaces so it probably won't matter.

Yeah.

>>> We could optionally contact alt odb to
>>> retrieve real content, or just show the replaced/fake data when alt
>>> odb is out of reach.
>>
>> Yeah, I wonder if that really needs the replace mechanism.
>
> Replace mechanism provides good hook point. But it really depends how
> invasive this remote odb is. If a fake content is enough to avoid
> breakages up high, git-replace is enough. If you really need to pass
> remote odb info up so higher levels can do something more fancy, then
> it's insufficient.
>
>> By the way this makes me wonder if we could implement resumable clone
>> using some kind of replace ref.
>>
>> The client while cloning nearly as usual would download one or more
>> special replace refs that would points to objects with links to
>> download bundles using standard protocols.
>> Just after the clone, the client would read these objects and download
>> the bundles from these objects.
>> And then it would clone from these bundles.
>
> I thought we have settled on resumable clone, just waiting for an
> implementation :) Doing it your way, you would need to download these
> special objects too (in a pack?) and come back download some more
> bundles. It would be more efficient to show the bundle uri early and
> go download the bundle on the side while you go on to get the
> addition/smaller pack that contains the rest.

Yeah, something like the bundle v3 mechanism is probably more efficient.

Thanks,
Christian.
