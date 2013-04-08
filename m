From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: Re: [RFC/PATCH 0/7] Rework git core for native submodules
Date: Tue, 9 Apr 2013 02:33:11 +0530
Message-ID: <CALkWK0mG6FFd_K1Ei-r--58i0j94or5240k1hEVbed8kJ+ZURw@mail.gmail.com>
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
X-From: git-owner@vger.kernel.org Mon Apr 08 23:04:01 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UPJEM-0006yM-7L
	for gcvg-git-2@plane.gmane.org; Mon, 08 Apr 2013 23:03:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964941Ab3DHVDx (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 8 Apr 2013 17:03:53 -0400
Received: from mail-ie0-f176.google.com ([209.85.223.176]:40380 "EHLO
	mail-ie0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1762166Ab3DHVDw (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 8 Apr 2013 17:03:52 -0400
Received: by mail-ie0-f176.google.com with SMTP id x14so7544862ief.21
        for <git@vger.kernel.org>; Mon, 08 Apr 2013 14:03:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:mime-version:in-reply-to:references:from:date:message-id
         :subject:to:cc:content-type;
        bh=qo4YKAeb2PtHw4/3ZQD5menA6yabQOoY26lt5bx6ndk=;
        b=uKaUDMUz3yZWGh2HFpGIgcNoUrP4Udzad91MLfSG3YBq7ZoQkUFc+TRs6Z/EJvcgQD
         5ro2R4wLg8cHKHZSvIERtBt44LGM8LPSO6tWIiPa/w2CJHTeZtDJcvamXPy0S2PXiWkH
         97g9s31kJbXsxlMiMRD61jTHrYOIcSR5fQNfPczZmgycSRqehm7m0wZBg/eOmA9Bi5cr
         p9NwSe26tWGxTKyy9OKaAhEmKmh/L4s3q90WpxY4kfh+Htf+hnneW+6H0J+i36hvNHnz
         5FrSooR6DAS0ySGq5Nfi+a26XyfCU8yDG4JZ3/c63Aw9z1Ic9jIhYZNLi2L0siFq6PYh
         jFNw==
X-Received: by 10.50.119.102 with SMTP id kt6mr8642622igb.12.1365455032178;
 Mon, 08 Apr 2013 14:03:52 -0700 (PDT)
Received: by 10.64.34.80 with HTTP; Mon, 8 Apr 2013 14:03:11 -0700 (PDT)
In-Reply-To: <7v8v4swysv.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/220514>

This is going nowhere.  You're stuck at making the current submodule
system work, not answering my questions, diverting conversation,
repeatedly asking the same stupid questions, labelling everything that
I say "subjective", and refusing to look at the objective counterpart
(aka, the code).  It's clear to me that no matter how many more emails
I write, you're not going to concede.

I'm not interested in wasting any more of my time with this nonsense.

I give up.
