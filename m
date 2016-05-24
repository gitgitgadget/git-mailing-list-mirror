From: Christian Couder <christian.couder@gmail.com>
Subject: Re: Git reset --hard with staged changes
Date: Tue, 24 May 2016 08:20:18 +0200
Message-ID: <CAP8UFD0yB8XjUi0f2OTUrW9W1UPC_ekY3+8--CC5rk_5RciYAA@mail.gmail.com>
References: <loom.20160523T023140-975@post.gmane.org>
	<CAP8UFD0dQGmfhPuHjEGRZjEZHwUHR_XzAASwq+87Obf26yi+BQ@mail.gmail.com>
	<xmqqeg8s8og8.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Yotam Gingold <yotam@yotamgingold.com>, git <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue May 24 08:20:30 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1b55hd-0007jk-FD
	for gcvg-git-2@plane.gmane.org; Tue, 24 May 2016 08:20:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753490AbcEXGUV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 24 May 2016 02:20:21 -0400
Received: from mail-wm0-f52.google.com ([74.125.82.52]:35435 "EHLO
	mail-wm0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753318AbcEXGUU (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 24 May 2016 02:20:20 -0400
Received: by mail-wm0-f52.google.com with SMTP id a136so55224459wme.0
        for <git@vger.kernel.org>; Mon, 23 May 2016 23:20:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc;
        bh=XOdqF/0CR4bC4MNq1vU7T48wgWWQFiTasK1d7MuaLQE=;
        b=se9sk/qX3OJ+pL3DPO8IVaccQYBbtgc6XKKoqg86IeYeFGdq/AZsSw8m6qBveihoVW
         e5Xlmk/8we1CNgO62KEI2xcmRmvMwvY9c7rp1VTnpiCysYPAfWHDHwbRf99U4/wmsEa/
         FTV6oLqO7fk3qUw+DuWFeAhWHsbDpsOD+p650OFNYiZPOcjfWb5+mRAID5+zKs1n43kI
         1593hRFVHMiAsEACBLAW6Yg6XbCdpMDA3rrtatVftOOGawIkU2ZNH5TAbrJqa/0RyxZv
         vqrUe+vTBvdHFdUQs5K17xeCKx2cDiKyP4PpaKW6YgMvCS4KymqKxeYRQ6ITOjRGotHI
         6kKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc;
        bh=XOdqF/0CR4bC4MNq1vU7T48wgWWQFiTasK1d7MuaLQE=;
        b=GbvWuRKRTg7UoQ7g0vTH17qqj4zm09JyZyVkvI3pA58/aUE5Umm+vHx4Zjs4KRFraq
         U9T6W+S9gWOKxk3814YbaQcL5MO2Emg7wDNru5GtgJl9+w8mWRoeBQCmgRP3PlQCaRcy
         bDcPM19Y8iSgXfhvU4r2/CWKuSPEvCc761YjIqqoa8+nBYgC1D0/SyRrD+krXydJLKGJ
         hAJKTbb/0XhWCtSba4v0VFxNll+jvpA0a/GSnD/L/Htn8Q7Qx1nTUQ8XltFlsGvUzNbH
         uJBj9JVkzRIe0Q91TMzWP4NXzK03Ewqz+QRhaQTfvXRlK6LJem5FEQ1K1eWbcoJuEz6Y
         Wl6Q==
X-Gm-Message-State: ALyK8tJ4HkiUpuLqZHurNuf5x0YACrBzfB42cXck91UM56d/vI3wsOoQIsAGagQdqKg4xkuY/mHZ73c+Lauq/A==
X-Received: by 10.28.23.143 with SMTP id 137mr332182wmx.89.1464070818714; Mon,
 23 May 2016 23:20:18 -0700 (PDT)
Received: by 10.194.148.146 with HTTP; Mon, 23 May 2016 23:20:18 -0700 (PDT)
In-Reply-To: <xmqqeg8s8og8.fsf@gitster.mtv.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/295418>

On Mon, May 23, 2016 at 11:16 PM, Junio C Hamano <gitster@pobox.com> wrote:
> Christian Couder <christian.couder@gmail.com> writes:
>
>>> This should be clarified to define what a tracked file is. I propose appending:
>>>
>>>     A file is considered tracked if it exists in a prior commit or in the
>>>     staging area. Note that a newly added file not in any prior commit will be
>>>     removed.
>>
>> Would you like to send a patch with something like the above?
>
> I am not sure if that is a good addition, though.

I am not sure either, but at least if something like that is added,
people may complain less.

>> I don't know if something about why it is like this, or why it is the
>> right thing to do, at least for recovering from merges, should be
>> added though.
>
> I excuse you as it seems that you haven't read my response ;-)
>
>>> I would also like to propose that the staging area's tree object be saved,
>>> ..
>> Yeah, it might be a good idea.
>
> Two issues with that "proposal" is that
>
>  1. the index may not be writable as a tree (think: during a
>     conflict resolution); and
>
>  2. the sole point of "reset --hard" is to "discard the changes".
>     If you want to instead save them away, there is another command
>     that was designed to do just that.
>
> It wasn't all that surprising that those on stackoverflow would
> think such a proposal is a good idea, but I somehow was hoping you
> have been around here long enough to know "git stash" ;-)

Yeah, we can try to teach people about git stash and git reset --keep
instead, but I doubt that it will be very effective.
