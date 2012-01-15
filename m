From: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
Subject: Re: [PATCH v3 1/3] Eliminate recursion in setting/clearing marks in
 commit list
Date: Sun, 15 Jan 2012 16:25:48 +0700
Message-ID: <CACsJy8B+MKsPRjeOx_4-MQudggPCGd_uZp9YRpau0Z+gX+A5pQ@mail.gmail.com>
References: <1326081546-29320-1-git-send-email-pclouds@gmail.com>
 <1326543595-28300-1-git-send-email-pclouds@gmail.com> <1326543595-28300-2-git-send-email-pclouds@gmail.com>
 <20120114152316.GA30986@m62s10.vlinux.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	"Shawn O. Pearce" <spearce@spearce.org>
To: Peter Baumann <waste.manager@gmx.de>
X-From: git-owner@vger.kernel.org Sun Jan 15 10:26:36 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RmMMF-0000s0-LZ
	for gcvg-git-2@lo.gmane.org; Sun, 15 Jan 2012 10:26:35 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751432Ab2AOJ0b convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 15 Jan 2012 04:26:31 -0500
Received: from mail-bk0-f46.google.com ([209.85.214.46]:50501 "EHLO
	mail-bk0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751377Ab2AOJ0V convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 15 Jan 2012 04:26:21 -0500
Received: by bkuw12 with SMTP id w12so913758bku.19
        for <git@vger.kernel.org>; Sun, 15 Jan 2012 01:26:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        bh=AIFRFDrkVWfG2R6E3w2yuzmtjHaWYKXQWaoXvThJbSM=;
        b=T2oJQAoZugHhXeWagHQbFoPerHW6EYx6m7lP7r4xw5KyMC+6lsUXRWcaWRo9pIB+Xg
         ib72zaon6/0S+N6fZTs/LYaHsp00bnMmvbB/QoCcDF8eLkAItBr3we+P03Kn4oAeget4
         NlgQCsCR5XaNfPLRm/KD+vwEx6AgE6hmRYh3Y=
Received: by 10.204.154.200 with SMTP id p8mr3061359bkw.4.1326619579181; Sun,
 15 Jan 2012 01:26:19 -0800 (PST)
Received: by 10.204.66.77 with HTTP; Sun, 15 Jan 2012 01:25:48 -0800 (PST)
In-Reply-To: <20120114152316.GA30986@m62s10.vlinux.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/188592>

2012/1/14 Peter Baumann <waste.manager@gmx.de>:
> On Sat, Jan 14, 2012 at 07:19:53PM +0700, Nguy=E1=BB=85n Th=C3=A1i Ng=
=E1=BB=8Dc Duy wrote:
>> Recursion in a DAG is generally a bad idea because it could be very
>> deep. Be defensive and avoid recursion in mark_parents_uninteresting=
()
>> and clear_commit_marks().
>>
>> mark_parents_uninteresting() learns a trick from clear_commit_marks(=
)
>> to avoid malloc() in (dorminant) single-parent case.
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0^^^^^^^^^
>
> I think you ment dominant here.

Yes I meant dominant.
--=20
Duy
