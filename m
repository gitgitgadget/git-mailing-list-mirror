From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: Re: [RFC/PATCH 0/7] Rework git core for native submodules
Date: Mon, 8 Apr 2013 17:23:14 +0530
Message-ID: <CALkWK0m93ZzWVJVUxgVQGUTK8t2pTEaDAPs7vW-tcgiewjOLwA@mail.gmail.com>
References: <CALkWK0n=vtPT7aFn9+T+bRxUpfXG+mYvV29YKC=_OAampQXJSA@mail.gmail.com>
 <20130407182112.GJ2222@serenity.lan> <5161BC33.8060707@web.de>
 <CALkWK0mBW63P0i6OhuujmAYO99pxLsS=ffFeqw8gBcBDgUpOPg@mail.gmail.com>
 <5161D3C5.9060804@web.de> <CALkWK0k_vmXZr-x8=ZctouWbuVgv-1sptC0WX2aJ+yYD-T8cxA@mail.gmail.com>
 <20130407212342.GA19857@elie.Belkin> <CALkWK0=Q-P-fGLmkoiV3_CJ43MNmFzpfkvFjNUwxB+zOsqTxmg@mail.gmail.com>
 <5162763D.5030708@web.de> <CALkWK0m5iN8h0J1EkbMTJoXy6QHHzyTjRfPnhL3XMgi=NAi2eg@mail.gmail.com>
 <20130408081959.GD20159@elie.Belkin> <CALkWK0nz878Xh9BFSCrtBGT=g3fys3uBy7QQs9cdWaFtoS8Rsg@mail.gmail.com>
 <CACsJy8CAW1h4rAOK_2+EAFEL28CKeqf4vqROsLByjZaMU3D-ow@mail.gmail.com>
 <CALkWK0mLG78anjbcVRF7Zpj-hMmts1pshF=XhLh--MCYV66Gng@mail.gmail.com> <CACsJy8D-M3xMkO7CPmOzeMxRV0Bv6MtCjH5eCr_vguxPF2N0vg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Jonathan Nieder <jrnieder@gmail.com>,
	Jens Lehmann <Jens.Lehmann@web.de>,
	John Keeping <john@keeping.me.uk>,
	Junio C Hamano <gitster@pobox.com>,
	Git List <git@vger.kernel.org>,
	Linus Torvalds <torvalds@linux-foundation.org>
To: Duy Nguyen <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Mon Apr 08 18:29:58 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UPEwL-0003oz-4X
	for gcvg-git-2@plane.gmane.org; Mon, 08 Apr 2013 18:29:05 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S935308Ab3DHLx5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 8 Apr 2013 07:53:57 -0400
Received: from mail-ie0-f175.google.com ([209.85.223.175]:44924 "EHLO
	mail-ie0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S935305Ab3DHLxz (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 8 Apr 2013 07:53:55 -0400
Received: by mail-ie0-f175.google.com with SMTP id c12so6810921ieb.34
        for <git@vger.kernel.org>; Mon, 08 Apr 2013 04:53:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:mime-version:in-reply-to:references:from:date:message-id
         :subject:to:cc:content-type;
        bh=jIBQGxNXWyRR94R+86lGpNokak5CrfBX38vx9tivyFc=;
        b=OKt0AeHdS8TCH56rdv6WIJ6hmWci1w6JP42e61yVCstDUbGb0De5y++BvBI4WywAnd
         w+yn9sdj3VHzvpSANsesxgqmEjiVV6LX4BUjDs71JvarmjcFPKLHPKC+H697ZHnSSxrd
         eTGYFeWIq/r77py3/YPqGFTkjWF3ox05QlfzWuqlorVS1YRcuLiaant6f6wZMGL9MyZg
         ne960s3Epq8fEng5IXgrKs2r91HAmt3tp/34zIhhOA5ezhoEhl2mW30C1IKnT9xnI89B
         XfX/ehEI1vuJbEtM669Z1qsY5ohUaTcBypAkV0J31h8g1JHBCHCkepqMSQXezfq+07dw
         USDQ==
X-Received: by 10.50.119.102 with SMTP id kt6mr6794910igb.12.1365422035290;
 Mon, 08 Apr 2013 04:53:55 -0700 (PDT)
Received: by 10.64.34.80 with HTTP; Mon, 8 Apr 2013 04:53:14 -0700 (PDT)
In-Reply-To: <CACsJy8D-M3xMkO7CPmOzeMxRV0Bv6MtCjH5eCr_vguxPF2N0vg@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/220422>

Duy Nguyen wrote:
> Good luck. Bug such a big work usually requires more than one
> volunteer. If you haven't convinced (*) the community it's right,
> maybe you should take a few days thinking about it again before
> implementing.

Yes, I'm thinking about it before rushing in to implement it.

There will always be resistance to change, especially when it involves
a change that breaks a working implementation.  If anything, the
resistance is only going to get worse with time, as people pile more
and more hacks on top of the current submodule implementation.  I say:
do it now, before we lose steam.

As far as I can tell, I'm completely unbiased: I have no vested
interests in either implementation, and I just want to see the best
implementation win.  My conviction in the new approach has only
strengthened after discussions on this thread: there must be some
reason for that, no?

Frankly, I was hoping that atleast one or two people on the thread
would take my side of the argument (or atleast tell me that I'm not
deranged), but that hasn't happened.  Nevertheless, I hope to convince
more people by doing more work and posting a beautifully working
implementation.

I'm already prepared for the worst case: I'll be forced to dump all my
work and be disappointed with the git community.
