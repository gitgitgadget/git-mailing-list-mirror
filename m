From: Alex Riesen <raa.lkml@gmail.com>
Subject: Re: [PATCH 15/17] Add MSVC to Makefile
Date: Mon, 14 Sep 2009 16:06:34 +0200
Message-ID: <81b0412b0909140706s32e888ddwe4bbd668c3a7ccfd@mail.gmail.com>
References: <1b36d8e041c9c1a6dc68f9cc3919fcf91b7a9ac6.1252925290.git.mstormo@gmail.com>
	 <8da5dcea21ce49b3a57fd224c088785a9f98e867.1252925290.git.mstormo@gmail.com>
	 <a48108513bf13247ba9b42fd703ba679804e8d8a.1252925290.git.mstormo@gmail.com>
	 <aed24a7f9524c9872f8a2455cfc5dd8baf6c3c0b.1252925290.git.mstormo@gmail.com>
	 <4931b7ac3102ee259353fe6b3c5ceeb2a67c53ba.1252925290.git.mstormo@gmail.com>
	 <1b5c5e90392e813ffab4fd510b70e57903a451cc.1252925290.git.mstormo@gmail.com>
	 <9c5670f92cd0b3b8b74dd2204698e9c45ad03c90.1252925290.git.mstormo@gmail.com>
	 <cover.1252925290.git.mstormo@gmail.com>
	 <c95a367520435feec0833d2d0edc33d86cf939a8.1252925290.git.mstormo@gmail.com>
	 <abaa803c30801c570f4b8e1baf6648a482bf295d.1252925290.git.mstormo@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Johannes.Schindelin@gmx.de, msysgit@googlegroups.com,
	git@vger.kernel.org, lznuaa@gmail.com
To: Marius Storm-Olsen <mstormo@gmail.com>
X-From: git-owner@vger.kernel.org Mon Sep 14 16:07:14 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MnCD1-0005q4-E1
	for gcvg-git-2@lo.gmane.org; Mon, 14 Sep 2009 16:07:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755552AbZINOGf convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 14 Sep 2009 10:06:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755546AbZINOGf
	(ORCPT <rfc822;git-outgoing>); Mon, 14 Sep 2009 10:06:35 -0400
Received: from mail-bw0-f219.google.com ([209.85.218.219]:44220 "EHLO
	mail-bw0-f219.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755197AbZINOGe convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 14 Sep 2009 10:06:34 -0400
Received: by bwz19 with SMTP id 19so2098646bwz.37
        for <git@vger.kernel.org>; Mon, 14 Sep 2009 07:06:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=nCGuol+O3JjjXrSnVz+VxCzfXw6QkIgp8b/9E5Kyx9Y=;
        b=lIZSa/vBTOkKMkJcg3kGKl4AZph+qtQMbojIn8xAPmClituajR1qWHDZz0ZtxKXIqu
         2o20uHVZv9uqNdslf6hc2bAsMfIukBwZ3eaRl3GR8r/zfcF21VnugMe5ZzSPV1nOODZP
         lRAGtFsWujjapPlBjFxi9vqSi3CGxfszxrmlM=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=MBPfpEaicKtQwqmRQ4Q16sRo0Xeu8CkEU9XSsti1nlzNQXPEVal40d2bj0nqgkTgZ2
         qfCpM1TSYBupFWNdGzJ0TGeTb6ppwGyFXJPruNm5pVcv0vjdaWj1UtNJUp2YrnKeBf76
         Bnk+CCB3mU3YHd0dShhyZXT9BCWuJcQpm6rgw=
Received: by 10.204.21.4 with SMTP id h4mr5174302bkb.58.1252937196333; Mon, 14 
	Sep 2009 07:06:36 -0700 (PDT)
In-Reply-To: <abaa803c30801c570f4b8e1baf6648a482bf295d.1252925290.git.mstormo@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/128484>

On Mon, Sep 14, 2009 at 15:11, Marius Storm-Olsen <mstormo@gmail.com> w=
rote:
> @@ -1327,7 +1379,7 @@ strip: $(PROGRAMS) git$X
> =C2=A0git.o: git.c common-cmds.h GIT-CFLAGS
> =C2=A0 =C2=A0 =C2=A0 =C2=A0$(QUIET_CC)$(CC) -DGIT_VERSION=3D'"$(GIT_V=
ERSION)"' \
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0'-DGIT_HTML_PA=
TH=3D"$(htmldir_SQ)"' \
> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 $(ALL_CFLAGS) -c $=
(filter %.c,$^)
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 $(ALL_CFLAGS) -o g=
it.o -c $(filter %.c,$^)

Why do you use "-o git.o" instead of "-o $@"?
