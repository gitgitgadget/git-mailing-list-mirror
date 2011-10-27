From: Sverre Rabbelier <srabbelier@gmail.com>
Subject: Re: [PATCH v0] fast-import: Add drop command
Date: Thu, 27 Oct 2011 13:06:19 +0200
Message-ID: <CAGdFq_iY92Gc=WLFVVMpi8w5JNZMo5bSk5=wjHyCmjXmP4RXrQ@mail.gmail.com>
References: <1316878065-11782-1-git-send-email-vitor.hda@gmail.com>
 <1316878065-11782-2-git-send-email-vitor.hda@gmail.com> <20110924193733.GB10955@elie>
 <CA+gfSn8Z7Xn1hdpqNHiP3bd2KGRqcAc6O683Z4O+G=jNNYJtBA@mail.gmail.com>
 <CAOpHH-WSyD23GKtZ2nLiSsJfLU-+7ibyGhGccyvtAhKQ-jffBw@mail.gmail.com>
 <CAOpHH-WxhvEP58KkGhnJbATbzU6PDBeQB1_fhbQ+0fzDXznaYw@mail.gmail.com>
 <CAGdFq_heamPfKpK2sQ1RUvceaeGRVAwkv=KAn-ByPyPkNtoZBA@mail.gmail.com> <CAOpHH-VEhtOg6ai5p9VxWBKA3AFpG3meiJVGrWR4j68ffyQ6Bg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Dmitry Ivankov <divanorama@gmail.com>,
	Jonathan Nieder <jrnieder@gmail.com>, git@vger.kernel.org,
	David Barr <davidbarr@google.com>
To: Vitor Antunes <vitor.hda@gmail.com>
X-From: git-owner@vger.kernel.org Thu Oct 27 13:10:17 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RJNqg-0002XP-1J
	for gcvg-git-2@lo.gmane.org; Thu, 27 Oct 2011 13:10:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755168Ab1J0LHA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 27 Oct 2011 07:07:00 -0400
Received: from mail-vx0-f174.google.com ([209.85.220.174]:44025 "EHLO
	mail-vx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754021Ab1J0LHA (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 27 Oct 2011 07:07:00 -0400
Received: by vcge1 with SMTP id e1so2276330vcg.19
        for <git@vger.kernel.org>; Thu, 27 Oct 2011 04:06:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=ALYipmjCE/l4D+S+x48HxgW9SUCuQBfU7DfOACCunmU=;
        b=J2wNk5fXVhL6qA7CiiYkaMj1mnFlP1LLZCQakyUyAcRxuAyHbrQ7FDlXwwhBU1FgE8
         7EdWXs04a1QIzYaFLZCYJ78Fmic0NLsVg+so9VgQc7t5Ca1K+7FSNFfaUAfiuyv+GGVe
         uaqiC6m51L8LcNAjtvWyGivwYV1Z3mC1pFXs0=
Received: by 10.182.111.70 with SMTP id ig6mr6258004obb.6.1319713619142; Thu,
 27 Oct 2011 04:06:59 -0700 (PDT)
Received: by 10.182.52.3 with HTTP; Thu, 27 Oct 2011 04:06:19 -0700 (PDT)
In-Reply-To: <CAOpHH-VEhtOg6ai5p9VxWBKA3AFpG3meiJVGrWR4j68ffyQ6Bg@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/184293>

Heya,

On Tue, Oct 25, 2011 at 11:56, Vitor Antunes <vitor.hda@gmail.com> wrote:
> On Mon, Oct 24, 2011 at 7:01 PM, Sverre Rabbelier <srabbelier@gmail.com> wrote:
>> I for one welcome our new branch deleting overlords :).
>>
>> You mention that checkpointing solves some of the concerns raised by
>> others in this thread, would automatic checkpointing be way to make
>> sure everything is as it should be?
>
> Apparently I did not explain myself correctly. Let me try again :)
>
> This is what I am doing:
>
> 1) import topic
> 2) checkpoint
> 3) diff-tree and processing
> 4) exit if processing returns ok
> 5) reset topic to another HEAD
> 6) goto 1)
>
> In this scenario it is the checkpoint that "breaks" everything because
> it will write the original tree to disk. When fast-import exits it will
> find the old tree on disk but not within "topic" tree.

I'm afraid I don't understand why it's a bad thing that fast-import
will find the old tree on disk, won't it just be gc-ed if it is no
longer used?

-- 
Cheers,

Sverre Rabbelier
