From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 1/3] sequencer: export commit_list_append()
Date: Wed, 25 Apr 2012 15:03:37 -0700
Message-ID: <xmqqobqfbhae.fsf@junio.mtv.corp.google.com>
References: <CANV9Rr_ev+34Wd030cps0UbgjRYD0=L2DQhbrCOkBVWG-2xaug@mail.gmail.com>
	<20120425111435.GA21579@sigill.intra.peff.net>
	<4F985D0A.9020100@lsrfire.ath.cx> <4F98600F.6000404@lsrfire.ath.cx>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Jeff King <peff@peff.net>,
	Michael Mueller <mmueller@vigilantsw.com>,
	Ramkumar Ramachandra <artagnon@gmail.com>,
	Junio C Hamano <gitster@pobox.com>
To: =?utf-8?Q?Ren=C3=A9?= Scharfe <rene.scharfe@lsrfire.ath.cx>
X-From: git-owner@vger.kernel.org Thu Apr 26 00:03:45 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SNAJL-00082E-GM
	for gcvg-git-2@plane.gmane.org; Thu, 26 Apr 2012 00:03:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757691Ab2DYWDj convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 25 Apr 2012 18:03:39 -0400
Received: from mail-qc0-f202.google.com ([209.85.216.202]:41572 "EHLO
	mail-qc0-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750742Ab2DYWDi convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 25 Apr 2012 18:03:38 -0400
Received: by qcsp5 with SMTP id p5so80208qcs.1
        for <git@vger.kernel.org>; Wed, 25 Apr 2012 15:03:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-type:content-transfer-encoding
         :x-gm-message-state;
        bh=mO5/e+IjcL5u8ZXOq+/VGCTX5AsvsmTTYx7XMjCnkfc=;
        b=Gpu9Zt3EUWSziVNollQYy5VGG5+pbtnZns8WPHUWrF+IFx53Mh9Oo4GzgCbSNyVMkr
         Qd114tTtP+sRi/gngvJp1IWSkHVPHJG3mkOk3LeRbDvPZ4jMQk5rVyLNbspJzf4Mep0q
         4PulhGrHgQUIDCORJEWQXF6jYaz/3AnqU8qQWgEsqqhNNH64rmVxjTOVbShg1HwpbPXp
         KSKWLuMwVvN0BQ9lJTR8VbU4MLL4F4qijpyKbHV7w2Y42CcZYeK6XoHReSDI9u3vPF6o
         F9lhPrIQvLyDijsc5Z8Jn6n9Qr0cherasIj2oja2mnk60L9GNiw1v1eXIHLolusw/ECI
         y4FA==
Received: by 10.101.136.30 with SMTP id o30mr1669217ann.14.1335391417689;
        Wed, 25 Apr 2012 15:03:37 -0700 (PDT)
Received: by 10.101.136.30 with SMTP id o30mr1669198ann.14.1335391417556;
        Wed, 25 Apr 2012 15:03:37 -0700 (PDT)
Received: from wpzn3.hot.corp.google.com (216-239-44-65.google.com [216.239.44.65])
        by gmr-mx.google.com with ESMTPS id z48si951756yhn.7.2012.04.25.15.03.37
        (version=TLSv1/SSLv3 cipher=AES128-SHA);
        Wed, 25 Apr 2012 15:03:37 -0700 (PDT)
Received: from junio.mtv.corp.google.com (junio.mtv.corp.google.com [172.27.69.24])
	by wpzn3.hot.corp.google.com (Postfix) with ESMTP id 7249510049D;
	Wed, 25 Apr 2012 15:03:37 -0700 (PDT)
Received: by junio.mtv.corp.google.com (Postfix, from userid 110493)
	id 21D1BE125C; Wed, 25 Apr 2012 15:03:37 -0700 (PDT)
In-Reply-To: <4F98600F.6000404@lsrfire.ath.cx> (=?utf-8?Q?=22Ren=C3=A9?=
 Scharfe"'s message of
	"Wed, 25 Apr 2012 22:35:27 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.1 (gnu/linux)
X-Gm-Message-State: ALoCoQk6sOxlREBGkyrCUXyfFvSOZkDbCZVmJAU4osms/0a0HCgZtWzGwSYa77Dz7Z90h5qDZ2t4yi5mIvnwI158j3O6lN+gdWP7IoiNiaOUNL54NVrWrMVg1x4i7loS1vfQn6anxF0rX/i6fvC1KCHMxUdpCWoGwi++HOqTjRpxS7plVs1LDCU=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/196341>

Ren=C3=A9 Scharfe <rene.scharfe@lsrfire.ath.cx> writes:

> This function can be used in other parts of git.  Give it a new home
> in commit.c.
>
> Signed-off-by: Rene Scharfe <rene.scharfe@lsrfire.ath.cx>

This makes sense.  I got confused every time I had to "append to tail"
and had to draw boxes-and-arrows picture to make sure I understand how
to use "\(.*\) =3D &commit_list_insert(something, \1)->next" correctly.

There probably are tons of places that can use this thing.

    $ git grep -c -e '\&commit_list_insert(.*)->next'
    builtin/commit.c:4
    builtin/diff-tree.c:1
    builtin/merge.c:3
    commit.c:4
    revision.c:5

I however wonder if we can name "next" a bit better, but cannot come up
with a good name.  It is the location that holds the pointer to the new
tail element if we append one.  Some places may call it "tail" but that
gives a wrong impression that it points at the element at the end.
