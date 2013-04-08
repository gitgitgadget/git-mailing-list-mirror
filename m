From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: Re: [RFC/PATCH 0/7] Rework git core for native submodules
Date: Tue, 9 Apr 2013 03:29:09 +0530
Message-ID: <CALkWK0njP+fpVVvzs4BH4nR=ddQg-9bvQd-nry4gZnpqt2wQrA@mail.gmail.com>
References: <CALkWK0n=vtPT7aFn9+T+bRxUpfXG+mYvV29YKC=_OAampQXJSA@mail.gmail.com>
 <5161BC33.8060707@web.de> <CALkWK0mBW63P0i6OhuujmAYO99pxLsS=ffFeqw8gBcBDgUpOPg@mail.gmail.com>
 <5161D3C5.9060804@web.de> <CALkWK0k_vmXZr-x8=ZctouWbuVgv-1sptC0WX2aJ+yYD-T8cxA@mail.gmail.com>
 <20130407212342.GA19857@elie.Belkin> <CALkWK0=Q-P-fGLmkoiV3_CJ43MNmFzpfkvFjNUwxB+zOsqTxmg@mail.gmail.com>
 <5162763D.5030708@web.de> <CALkWK0m5iN8h0J1EkbMTJoXy6QHHzyTjRfPnhL3XMgi=NAi2eg@mail.gmail.com>
 <20130408081959.GD20159@elie.Belkin> <CALkWK0nz878Xh9BFSCrtBGT=g3fys3uBy7QQs9cdWaFtoS8Rsg@mail.gmail.com>
 <CACsJy8CAW1h4rAOK_2+EAFEL28CKeqf4vqROsLByjZaMU3D-ow@mail.gmail.com>
 <CALkWK0mLG78anjbcVRF7Zpj-hMmts1pshF=XhLh--MCYV66Gng@mail.gmail.com>
 <CACsJy8D-M3xMkO7CPmOzeMxRV0Bv6MtCjH5eCr_vguxPF2N0vg@mail.gmail.com>
 <CALkWK0m93ZzWVJVUxgVQGUTK8t2pTEaDAPs7vW-tcgiewjOLwA@mail.gmail.com>
 <7v1ual12pj.fsf@alter.siamese.dyndns.org> <CALkWK0=2T5BA8+dro8U7bcp3ODsuQAj78mEPnxs=ERqf9FhSBQ@mail.gmail.com>
 <7va9p8yjuf.fsf@alter.siamese.dyndns.org> <CALkWK0m4o=F=bh_mt9NGDfXKExgVtLhaZ7uxA_XFhpF5AN5-Fg@mail.gmail.com>
 <7vk3ocx0qq.fsf@alter.siamese.dyndns.org> <CALkWK0npHgsf_TyjrMRJdcT-twg_jRXOHtoNpmX+2XNeLq=ZAQ@mail.gmail.com>
 <7v8v4swysv.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Duy Nguyen <pclouds@gmail.com>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Jens Lehmann <Jens.Lehmann@web.de>,
	John Keeping <john@keeping.me.uk>,
	Git List <git@vger.kernel.org>,
	Linus Torvalds <torvalds@linux-foundation.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Apr 08 23:59:56 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UPK6V-0005gx-8m
	for gcvg-git-2@plane.gmane.org; Mon, 08 Apr 2013 23:59:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S936420Ab3DHV7v (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 8 Apr 2013 17:59:51 -0400
Received: from mail-ie0-f177.google.com ([209.85.223.177]:41516 "EHLO
	mail-ie0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S936374Ab3DHV7u (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 8 Apr 2013 17:59:50 -0400
Received: by mail-ie0-f177.google.com with SMTP id tp5so7665673ieb.22
        for <git@vger.kernel.org>; Mon, 08 Apr 2013 14:59:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:mime-version:in-reply-to:references:from:date:message-id
         :subject:to:cc:content-type;
        bh=thE0V0+oCFdI/sy09/+KdmmHMpFA7P+xux8KsSar65M=;
        b=S3HLsBsYBwMEKOq+i7Oot3ROgZ4NMgIJF3Q1MpNoaLHdE+D0brTGSmpH1iPIygiQub
         3bUlbn2QhfnJO5Ear8lishOYedjtCNPDRI+0nuZ3Ad0z55VxwFw7op+hv15ohb+qhpEB
         FpPZs4CNanouwXMAamcNiHp6tL+NIKQH9NeB73WQdndHJZ0FC29LPZQmPz7gPQTzVFM0
         BXZEqEGKaz/bEgfYqujG/LPGwyaoZLRtgpngp2uP8DVPOnf7fMDXfgNiGce1Bu/7AQ+R
         r1cDV+xNwnwoMxLhLZwsJKpo2nAWtl+erd18srH3x7jYafkUc11uR30ZivcLHgsNJGhD
         77Ug==
X-Received: by 10.50.119.102 with SMTP id kt6mr8771504igb.12.1365458389946;
 Mon, 08 Apr 2013 14:59:49 -0700 (PDT)
Received: by 10.64.34.80 with HTTP; Mon, 8 Apr 2013 14:59:09 -0700 (PDT)
In-Reply-To: <7v8v4swysv.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/220530>

Junio C Hamano wrote:
> If all of your argument starts from "I think .gitmodules is ugly
> because it is not an object of a separate type stored at the path of
> the submodule, and here are the reasons why I think it is ugly", I
> have nothing more to say to you.

_This_ is how you summarize the seven points and the follow-up emails
I wrote out for you?  Seriously?

I enjoy good debate, and would've loved to be beaten in argument.  But
that's not what happened here.  I was just too frustrated with your
stupidity to continue.
