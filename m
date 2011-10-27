From: Sverre Rabbelier <srabbelier@gmail.com>
Subject: Re: [PATCH v0] fast-import: Add drop command
Date: Thu, 27 Oct 2011 16:36:58 +0200
Message-ID: <CAGdFq_hSnywznK=3JgWBVigGZmS0ry_WHuuDww5tvPrcsPd7cQ@mail.gmail.com>
References: <1316878065-11782-1-git-send-email-vitor.hda@gmail.com>
 <1316878065-11782-2-git-send-email-vitor.hda@gmail.com> <20110924193733.GB10955@elie>
 <CA+gfSn8Z7Xn1hdpqNHiP3bd2KGRqcAc6O683Z4O+G=jNNYJtBA@mail.gmail.com>
 <CAOpHH-WSyD23GKtZ2nLiSsJfLU-+7ibyGhGccyvtAhKQ-jffBw@mail.gmail.com>
 <CAOpHH-WxhvEP58KkGhnJbATbzU6PDBeQB1_fhbQ+0fzDXznaYw@mail.gmail.com>
 <CAGdFq_heamPfKpK2sQ1RUvceaeGRVAwkv=KAn-ByPyPkNtoZBA@mail.gmail.com>
 <CAOpHH-VEhtOg6ai5p9VxWBKA3AFpG3meiJVGrWR4j68ffyQ6Bg@mail.gmail.com>
 <CAGdFq_iY92Gc=WLFVVMpi8w5JNZMo5bSk5=wjHyCmjXmP4RXrQ@mail.gmail.com> <CAOpHH-W30umoP6CuvrXgiSPBC2NjLvNWUX0uxhU4SU3kBB4H-A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Dmitry Ivankov <divanorama@gmail.com>,
	Jonathan Nieder <jrnieder@gmail.com>, git@vger.kernel.org,
	David Barr <davidbarr@google.com>
To: Vitor Antunes <vitor.hda@gmail.com>
X-From: git-owner@vger.kernel.org Thu Oct 27 16:37:46 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RJR5U-0005dn-Os
	for gcvg-git-2@lo.gmane.org; Thu, 27 Oct 2011 16:37:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754203Ab1J0Ohk (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 27 Oct 2011 10:37:40 -0400
Received: from mail-vw0-f46.google.com ([209.85.212.46]:49255 "EHLO
	mail-vw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750883Ab1J0Ohj (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 27 Oct 2011 10:37:39 -0400
Received: by vws1 with SMTP id 1so2482108vws.19
        for <git@vger.kernel.org>; Thu, 27 Oct 2011 07:37:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=zSk9ih9wgSLw/QRSm7Zs0vntrAjit6jxQmsbRueO0y0=;
        b=WNzIdvoKc1IbciXXVR+Ueo3LZVM2Q7gaxVveCmFw4YsBvbgZ7PYnTVpfizI1herXHX
         HPurDf77lEH9vRuVsIqr4zoinkUi85ZXsXqL/MS2A+1czPVS99rLVUwM5UiLXzRhLe7K
         H1khqLaJbB1xfQayYNp8EtM5X4b9o9qaH3sgk=
Received: by 10.182.7.100 with SMTP id i4mr6414345oba.66.1319726258514; Thu,
 27 Oct 2011 07:37:38 -0700 (PDT)
Received: by 10.182.52.3 with HTTP; Thu, 27 Oct 2011 07:36:58 -0700 (PDT)
In-Reply-To: <CAOpHH-W30umoP6CuvrXgiSPBC2NjLvNWUX0uxhU4SU3kBB4H-A@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/184295>

Heya,

On Thu, Oct 27, 2011 at 13:22, Vitor Antunes <vitor.hda@gmail.com> wrote:
> On Thu, Oct 27, 2011 at 12:06 PM, Sverre Rabbelier <srabbelier@gmail.com> wrote:
>> I'm afraid I don't understand why it's a bad thing that fast-import
>> will find the old tree on disk, won't it just be gc-ed if it is no
>> longer used?
>
> No, because fast-import actively checks this to make sure the frontend
> script did not do anything wrong during the import. I think the check
> makes sense and may help debugging a corner case the frontend script
> does not support. So, using "--force" is also not a solution because it
> ignores everything and not only the specific commits I want to leave
> behind.

Ok, so the problem is that fast-import notices that a tree that was
written out as part of a checkpoint is later removed and doesn't like
that? Shouldn't we just teach the check about trees deleted by the
drop command?

-- 
Cheers,

Sverre Rabbelier
