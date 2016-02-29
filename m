From: Luke Diamand <luke@diamand.org>
Subject: Re: [PATCH] git-p4.py: Make submit working on bare repository
Date: Mon, 29 Feb 2016 15:29:02 +0000
Message-ID: <CAE5ih7-q_PwF-T6nsu=FyyN9wO6o0Jcfkg=gKy5mhOXRGFZ+VA@mail.gmail.com>
References: <CAPig+cQA4sJ2RneG8zRsUx+bDPAMYVtmhFjZx5SOGDqnsKNUaQ@mail.gmail.com>
	<1455919074-5683-1-git-send-email-aidecoe@aidecoe.name>
	<xmqq7fi0b9rt.fsf@gitster.mtv.corp.google.com>
	<87fuwnd4u7.fsf@freja.aidecoe.name>
	<xmqqbn7aa522.fsf@gitster.mtv.corp.google.com>
	<877fhwd1g0.fsf@freja.aidecoe.name>
	<xmqqegc33oal.fsf@gitster.mtv.corp.google.com>
	<CAE5ih7_vBMsi+zRZRTCaO56VrOYZUR0NQ0CSSE+Do48xkJ_BwA@mail.gmail.com>
	<871t83cfi7.fsf@freja.aidecoe.name>
	<CAE5ih7-rBuipoAGEnK60iidi1nYA9xWZQV6jRMHTVQe6f=cQag@mail.gmail.com>
	<87si0cpnpn.fsf@freja.aidecoe.name>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>, Git Users <git@vger.kernel.org>
To: =?UTF-8?B?QW1hZGV1c3ogxbtvxYJub3dza2k=?= <aidecoe@aidecoe.name>
X-From: git-owner@vger.kernel.org Mon Feb 29 16:29:11 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aaPl0-0001IB-KS
	for gcvg-git-2@plane.gmane.org; Mon, 29 Feb 2016 16:29:10 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755073AbcB2P3H convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 29 Feb 2016 10:29:07 -0500
Received: from mail-ob0-f171.google.com ([209.85.214.171]:34443 "EHLO
	mail-ob0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751390AbcB2P3E convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 29 Feb 2016 10:29:04 -0500
Received: by mail-ob0-f171.google.com with SMTP id ts10so137423495obc.1
        for <git@vger.kernel.org>; Mon, 29 Feb 2016 07:29:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=diamand.org; s=google;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-transfer-encoding;
        bh=DxBYDr6Zysv95GIYwHTxDW+LP0uj6l8pLf2kCb7pZGY=;
        b=FbTPq1FC7RcY217fTZ/7grRmxhxoAorqcL7g/ZIcU+748fTxJleOobZ5CUu300mpV6
         Lta+TALbGa6ecg4caMx/Bqkk5XrRHv9wGOWwqAx+p6go+xsxABNJvpX93l0AQtzlXEGC
         srM7CL4sTm312opTXPp8kwX94+InUOV+1SUL8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-transfer-encoding;
        bh=DxBYDr6Zysv95GIYwHTxDW+LP0uj6l8pLf2kCb7pZGY=;
        b=g4SUbXF3TdbYPwYYLn3lsuquHuQGZHQzCDnjjmqyA4Lm60xUoEtiAOWn72ib2y26/p
         Pw5E+DLezZD3H1Xh/aJ2wN/y0iU+Kc8JR/VKPZTZ/EA9eiC+H4Stz5Fi6+K1SW85XdXH
         C+dEiIpJA1xoqNTZ8xYl1qL+zc0LKCYYEgx9/ufY5dP3m52/QwH5R10Ev8zeyZkcab7m
         uUhLAghI1P6dxoWrXma9ciujkN7/2wAUUcPEGe7x0JSFTmVLNU6IDkRZ4wNwXFcF5TMR
         spywr0Rp343DShMIkj/jhQLfQ3tw+KJUcDQj/wZTjze73GKcOg2rsxhukL/393EhehGp
         Kixg==
X-Gm-Message-State: AD7BkJILsgBfK0k5Yqc9nH9ZOv4Mu+QqeeT3LIuZjt+Us15pMHmAqbovYog4Z8aaC6uZLPXj89+teMllf2kdog==
X-Received: by 10.182.186.105 with SMTP id fj9mr12100725obc.17.1456759742431;
 Mon, 29 Feb 2016 07:29:02 -0800 (PST)
Received: by 10.202.172.132 with HTTP; Mon, 29 Feb 2016 07:29:02 -0800 (PST)
In-Reply-To: <87si0cpnpn.fsf@freja.aidecoe.name>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/287844>

On 28 February 2016 at 20:46, Amadeusz =C5=BBo=C5=82nowski <aidecoe@aid=
ecoe.name> wrote:

>
> True. For now I have these cases covered by wrapper scripts. The mini=
mum
> I need from git-p4 is just not to fail on git submit from bare
> repository which is covered by patch I have submitted. If I get my
> solution enough testing, I'd think of transforming it into patch for
> git-p4.py as well.

Could you change the patch to add a command-line option to suppress
the rebase? I think this would be a bit more obvious: instead of
having some special magical behaviour kick-in on a bare repo, git-p4
just does what it's told on the command-line.

It means that if we find another situation where we don't want to
rebase, we don't have an ever-growing list of special-case
circumstances, which could become hard to make sense of in future.
Instead, the user (who hopefully knows better) just tells git-p4 what
to do.

Thanks!
Luke
