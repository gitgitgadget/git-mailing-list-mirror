From: Vitor Antunes <vitor.hda@gmail.com>
Subject: Re: [PATCH v0] fast-import: Add drop command
Date: Wed, 9 Nov 2011 11:29:18 +0000
Message-ID: <CAOpHH-W8x2hAmH5hiRovQG+aV6NuX4MopGc2n3Lhqtv=7crW6A@mail.gmail.com>
References: <1316878065-11782-1-git-send-email-vitor.hda@gmail.com>
 <1316878065-11782-2-git-send-email-vitor.hda@gmail.com> <20110924193733.GB10955@elie>
 <CA+gfSn8Z7Xn1hdpqNHiP3bd2KGRqcAc6O683Z4O+G=jNNYJtBA@mail.gmail.com>
 <CAOpHH-WSyD23GKtZ2nLiSsJfLU-+7ibyGhGccyvtAhKQ-jffBw@mail.gmail.com>
 <CAOpHH-WxhvEP58KkGhnJbATbzU6PDBeQB1_fhbQ+0fzDXznaYw@mail.gmail.com>
 <CAGdFq_heamPfKpK2sQ1RUvceaeGRVAwkv=KAn-ByPyPkNtoZBA@mail.gmail.com>
 <CAOpHH-VEhtOg6ai5p9VxWBKA3AFpG3meiJVGrWR4j68ffyQ6Bg@mail.gmail.com>
 <CAGdFq_iY92Gc=WLFVVMpi8w5JNZMo5bSk5=wjHyCmjXmP4RXrQ@mail.gmail.com>
 <CAOpHH-W30umoP6CuvrXgiSPBC2NjLvNWUX0uxhU4SU3kBB4H-A@mail.gmail.com>
 <CAGdFq_hSnywznK=3JgWBVigGZmS0ry_WHuuDww5tvPrcsPd7cQ@mail.gmail.com>
 <CAOpHH-X3bgJpRpiJMy-iDDpaFbUy8yZK+GFEwVB2vGHd-GpUiw@mail.gmail.com> <CAGdFq_jPfSFidb59m-5Tsyusw3yQFRnxU9nqBVosVPuzbt86GA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Dmitry Ivankov <divanorama@gmail.com>,
	Jonathan Nieder <jrnieder@gmail.com>, git@vger.kernel.org,
	David Barr <davidbarr@google.com>
To: Sverre Rabbelier <srabbelier@gmail.com>
X-From: git-owner@vger.kernel.org Wed Nov 09 12:30:00 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RO6Lw-0007f9-17
	for gcvg-git-2@lo.gmane.org; Wed, 09 Nov 2011 12:30:00 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751277Ab1KIL3v (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 9 Nov 2011 06:29:51 -0500
Received: from mail-fx0-f46.google.com ([209.85.161.46]:46731 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751149Ab1KIL3u (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 9 Nov 2011 06:29:50 -0500
Received: by faan17 with SMTP id n17so1531083faa.19
        for <git@vger.kernel.org>; Wed, 09 Nov 2011 03:29:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=zGq1EEr0yO5Vbh60j6vNYzRqGdB04Cp2BEbRQ96k/04=;
        b=jZkcY/w06di7ZLZsIn22qqd9aCn5zhkQ2P4cl5GMg+NnXNfNQ0pr76Mf18/XQV6OSF
         nyfB2O7o20Dfh3smdfb/HfpdubBP6ArQv13yLfttCQMzIzEHKN6iSElGErzp2NkirCMG
         oRMWPU5mLXWRCymthiMXfvHZNxVN8FNyoe+tM=
Received: by 10.152.106.38 with SMTP id gr6mr1249631lab.35.1320838189101; Wed,
 09 Nov 2011 03:29:49 -0800 (PST)
Received: by 10.152.37.101 with HTTP; Wed, 9 Nov 2011 03:29:18 -0800 (PST)
In-Reply-To: <CAGdFq_jPfSFidb59m-5Tsyusw3yQFRnxU9nqBVosVPuzbt86GA@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/185152>

On Wed, Nov 9, 2011 at 12:27 AM, Sverre Rabbelier <srabbelier@gmail.com> wrote:
> Heya,
>
> On Wed, Nov 9, 2011 at 01:24, Vitor Antunes <vitor.hda@gmail.com> wrote:
>>
>> That was exactly my intention when I used release_tree_entry(). But I
>> guess I'm doing it wrong, because without the delete_ref() part this
>> does not work (just noticed there's a missing semicolon there...
>> sorry). Any advices/guidance, please? :)
>
> ENODATA. What do you mean with "does not work"? Can you run it through
> gdb and see what's going on?

Calm down! It's not that bad to require gdb :)

It just means that even using the drop() command from the patch I
posted before, I still get the "new tip ... does not contain
..." error from fast-import.

-- 
Vitor Antunes
