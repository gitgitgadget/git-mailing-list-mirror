From: Sverre Rabbelier <srabbelier@gmail.com>
Subject: Re: [PATCH 1/3] t9350: point out that refs are not updated correctly
Date: Thu, 25 Oct 2012 00:43:03 -0700
Message-ID: <CAGdFq_j5sWsHwJY-rWP-XJ6cMF6uwSq=9beFe9ZuZyixBa1fVA@mail.gmail.com>
References: <20121024191149.GA3120@elie.Belkin> <CAMP44s2kjv9fHbruXv7NyVm9m+FjFnYDryuPZQ-RQXN9Nj6MAw@mail.gmail.com>
 <20121025042731.GA11243@elie.Belkin> <CAMP44s1Pe8Ef6-GRbmSs7rY7gWyaPCN+jWGysyttZp3drSDoZg@mail.gmail.com>
 <20121025052823.GB11243@elie.Belkin> <CAGdFq_gg3gPvCADje9ibz8xHgPOLF+=79EqksVzG2JeTOfHocw@mail.gmail.com>
 <CAMP44s3kBxzJbyoxPqWbRMWmpX9sNPGjdRy_KrTeRoVmGC-+Hg@mail.gmail.com>
 <CAGdFq_jfiX9apPyq6pba4S4iCQLGLmDvSrLaujSB5rO0i+fzfg@mail.gmail.com>
 <CAMP44s1cRg_we5nXeRG1WcWz7YUOBrauJigeNna1YETcno9p=A@mail.gmail.com>
 <CAGdFq_hgYPF5eeCB9hSsjVfUyEhkBNJAtzoNuNqs5N6V-+w9Hg@mail.gmail.com> <20121025073454.GB15790@elie.Belkin>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Felipe Contreras <felipe.contreras@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	Jeff King <peff@peff.net>, Git List <git@vger.kernel.org>,
	Daniel Barkalow <barkalow@iabervon.org>,
	Ramkumar Ramachandra <artagnon@gmail.com>,
	Dmitry Ivankov <divanorama@gmail.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	=?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= <avarab@gmail.com>,
	Eric Herman <eric@freesa.org>,
	Fernando Vezzosi <buccia@repnz.net>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Thu Oct 25 09:44:00 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TRI6g-0006x9-3h
	for gcvg-git-2@plane.gmane.org; Thu, 25 Oct 2012 09:43:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758443Ab2JYHnp (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 25 Oct 2012 03:43:45 -0400
Received: from mail-qc0-f174.google.com ([209.85.216.174]:51496 "EHLO
	mail-qc0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756493Ab2JYHno (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 25 Oct 2012 03:43:44 -0400
Received: by mail-qc0-f174.google.com with SMTP id o22so544155qcr.19
        for <git@vger.kernel.org>; Thu, 25 Oct 2012 00:43:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=+NNPaDBTPwQsywr8VVovF5tcrgD2V4sIfHNbZJJMStY=;
        b=AQmRfeTh/emo8DOcOK00u7bBxxNcOoYckoXM5VGSCwU9WqSf4A8iDdvAGj7TfUnwsY
         KJPTAQB5IfFSWUObGkC8N4tkQtezsZ3oiUOrjyMqPNLivmJ51S/FR7Y+OTOczk9w3esY
         oy1YDH8Id2qgqtNrxZcri1og5pMgjBZSzxMG0hSGws8h6zenPtvYB1ae3NE3o1XefiDK
         fZlBU8kzWoU9u6Ys3uvVVYWBz9PpkkDdgPU9EMTh2liX4tes55h384BOIqFovT236RjY
         /ENlJ8wnffDXbts0a/+1HfKTkXBTmVO1n19u1MKLJuB5D9XwH2Fz6vtyblH3f6tFdQUP
         ++Lg==
Received: by 10.229.205.38 with SMTP id fo38mr2166579qcb.92.1351151024033;
 Thu, 25 Oct 2012 00:43:44 -0700 (PDT)
Received: by 10.49.36.195 with HTTP; Thu, 25 Oct 2012 00:43:03 -0700 (PDT)
In-Reply-To: <20121025073454.GB15790@elie.Belkin>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/208358>

On Thu, Oct 25, 2012 at 12:34 AM, Jonathan Nieder <jrnieder@gmail.com> wrote:
> If I remember right, '^foo1' is (whence == REV_CMD_REV) with (flags ==
> UNINTERESTING).  That's why sequencer.c checks for unadorned revs like
> this:
>
>         if (opts->revs->cmdline.nr == 1 &&
>             opts->revs->cmdline.rev->whence == REV_CMD_REV &&
>             opts->revs->no_walk &&
>             !opts->revs->cmdline.rev->flags) {
>
> Maybe
>
>         if (elem->flags & UNINTERESTING)
>                 continue;
>         if (elem->whence == REV_CMD_PARENTS_ONLY)       /* foo^@ */
>                 continue;
>
> would work well here?  That would handle bizarre cases like "--not
> next..master" (and ordinary cases like "master...next") better, by
> focusing on the semantics instead of syntax.

I know there was a reason why using UNINTERESTING didn't work
(otherwise we could've used that to start with, instead of needing
Junio's whence solution). I think all refs ended up being marked as
UNINTERESTING or somesuch.

-- 
Cheers,

Sverre Rabbelier
