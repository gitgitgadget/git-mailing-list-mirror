From: Vitor Antunes <vitor.hda@gmail.com>
Subject: Re: [PATCH v0] fast-import: Add drop command
Date: Wed, 9 Nov 2011 00:24:38 +0000
Message-ID: <CAOpHH-X3bgJpRpiJMy-iDDpaFbUy8yZK+GFEwVB2vGHd-GpUiw@mail.gmail.com>
References: <1316878065-11782-1-git-send-email-vitor.hda@gmail.com>
 <1316878065-11782-2-git-send-email-vitor.hda@gmail.com> <20110924193733.GB10955@elie>
 <CA+gfSn8Z7Xn1hdpqNHiP3bd2KGRqcAc6O683Z4O+G=jNNYJtBA@mail.gmail.com>
 <CAOpHH-WSyD23GKtZ2nLiSsJfLU-+7ibyGhGccyvtAhKQ-jffBw@mail.gmail.com>
 <CAOpHH-WxhvEP58KkGhnJbATbzU6PDBeQB1_fhbQ+0fzDXznaYw@mail.gmail.com>
 <CAGdFq_heamPfKpK2sQ1RUvceaeGRVAwkv=KAn-ByPyPkNtoZBA@mail.gmail.com>
 <CAOpHH-VEhtOg6ai5p9VxWBKA3AFpG3meiJVGrWR4j68ffyQ6Bg@mail.gmail.com>
 <CAGdFq_iY92Gc=WLFVVMpi8w5JNZMo5bSk5=wjHyCmjXmP4RXrQ@mail.gmail.com>
 <CAOpHH-W30umoP6CuvrXgiSPBC2NjLvNWUX0uxhU4SU3kBB4H-A@mail.gmail.com> <CAGdFq_hSnywznK=3JgWBVigGZmS0ry_WHuuDww5tvPrcsPd7cQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Dmitry Ivankov <divanorama@gmail.com>,
	Jonathan Nieder <jrnieder@gmail.com>, git@vger.kernel.org,
	David Barr <davidbarr@google.com>
To: Sverre Rabbelier <srabbelier@gmail.com>
X-From: git-owner@vger.kernel.org Wed Nov 09 01:25:18 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RNvye-0000Lr-Fy
	for gcvg-git-2@lo.gmane.org; Wed, 09 Nov 2011 01:25:16 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933313Ab1KIAZK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 8 Nov 2011 19:25:10 -0500
Received: from mail-fx0-f46.google.com ([209.85.161.46]:42524 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756075Ab1KIAZJ (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 8 Nov 2011 19:25:09 -0500
Received: by faan17 with SMTP id n17so1110656faa.19
        for <git@vger.kernel.org>; Tue, 08 Nov 2011 16:25:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=hOldQHKoCwj/8Mx/fGQhsKaIO3aPOAFXH4yXOcf8fBg=;
        b=gOfZWCZ4ksrHUybKUGnbaPZ5OBnLK4GVdE4Vtt5Occ6EigR5yGHAEUUsV26GkAjmXN
         INZoU+AWt7xOTGNqkLWDDCSSMMkeHHSk3PwEFu+CjOUqp9UlchBIN7koY4jM1cu2tT5Y
         l+0RgeTpCnIfLnvpfR03N3aPChbB8xVk5gufk=
Received: by 10.152.102.148 with SMTP id fo20mr16726lab.51.1320798308072; Tue,
 08 Nov 2011 16:25:08 -0800 (PST)
Received: by 10.152.37.101 with HTTP; Tue, 8 Nov 2011 16:24:38 -0800 (PST)
In-Reply-To: <CAGdFq_hSnywznK=3JgWBVigGZmS0ry_WHuuDww5tvPrcsPd7cQ@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/185121>

Hi Sverre,

Sorry for the late reply.

On Thu, Oct 27, 2011 at 3:36 PM, Sverre Rabbelier <srabbelier@gmail.com> wrote:
> Ok, so the problem is that fast-import notices that a tree that was
> written out as part of a checkpoint is later removed and doesn't like
> that? Shouldn't we just teach the check about trees deleted by the
> drop command?

That was exactly my intention when I used release_tree_entry(). But I
guess I'm doing it wrong, because without the delete_ref() part this
does not work (just noticed there's a missing semicolon there...
sorry). Any advices/guidance, please? :)

-- 
Vitor Antunes
