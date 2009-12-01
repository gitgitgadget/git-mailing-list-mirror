From: Bert Wesarg <bert.wesarg@googlemail.com>
Subject: Re: [PATCH] get_ref_states: strdup entries and free util in stale 
	list
Date: Tue, 1 Dec 2009 19:14:30 +0100
Message-ID: <36ca99e90912011014sd7372d0yc234873a26c2ae43@mail.gmail.com>
References: <0458f16c6ce906997aaf357c0c7368841ae83c36.1259625072.git.bert.wesarg@googlemail.com>
	 <7viqcrbl22.fsf@alter.siamese.dyndns.org>
	 <36ca99e90911302249r5f77f031o73cc7bb13dc375cf@mail.gmail.com>
	 <7vy6ln2llw.fsf@alter.siamese.dyndns.org>
	 <36ca99e90912010132iee0d42fo933aeb12833ad1ad@mail.gmail.com>
	 <7v8wdm1ui1.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Jay Soffian <jaysoffian@gmail.com>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Dec 01 19:14:53 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NFXFQ-0008Op-4O
	for gcvg-git-2@lo.gmane.org; Tue, 01 Dec 2009 19:14:48 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753105AbZLASOZ convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 1 Dec 2009 13:14:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753027AbZLASOZ
	(ORCPT <rfc822;git-outgoing>); Tue, 1 Dec 2009 13:14:25 -0500
Received: from mail-fx0-f213.google.com ([209.85.220.213]:50891 "EHLO
	mail-fx0-f213.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753087AbZLASOY convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 1 Dec 2009 13:14:24 -0500
Received: by fxm5 with SMTP id 5so5215459fxm.28
        for <git@vger.kernel.org>; Tue, 01 Dec 2009 10:14:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=c20vygu88i8bpchTmOfqg4NA20+7Br5395KTEa9ojvA=;
        b=GYTQD3aass5wATLg9QvY+Cwkw72l+/rXXnZn3eCqpppX6OwM8I+kd/nbhD1B7z1ucT
         GmUfG46pnb8r0Mv1tPfxwkmBBsdCy3I6vyBGT8/58HeSOh+HLa/Xn8HRWFOoucelgEo2
         K2ONEG1PcfFDHJldVW5aQss5o03NhOPpZQEak=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=googlemail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=ln/HEfXXYzf9moFpvf1lWeuL02uq9Oh6NuuBiO+R2nnApCzEbNeBm5/A/kEnxTEOaA
         FLnBuAxF+4RsTpJHNB+iGXXBmerSjCnxC7jFjGHlZJGFdc0r/r8oKX9luQK4BT2z5VY9
         TZwzECRcnvHe1VhchLFFJBlOn64N8VHcykkDc=
Received: by 10.223.127.195 with SMTP id h3mr1003726fas.57.1259691270167; Tue, 
	01 Dec 2009 10:14:30 -0800 (PST)
In-Reply-To: <7v8wdm1ui1.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/134239>

On Tue, Dec 1, 2009 at 18:20, Junio C Hamano <gitster@pobox.com> wrote:
> Bert Wesarg <bert.wesarg@googlemail.com> writes:
>
>>> =C2=A0- The ref abbrev_branch() is called and the address of whose =
substring is
>>> =C2=A0 taken to be used as "name" in handle_one_branch() is refspec=
=2Esrc, but
>>> =C2=A0 what goes to .util is refname that is refspec.dst---they are=
 different
>>> =C2=A0 strings and one is not a substring of the other.
>> I don't see you point here.
>
> Of course you don't ;-) because we were looking at different versions=
=2E
>
> I wanted to apply the same fix to both maint and master. =C2=A0For th=
e code in
> 'master' your observation is 100% correct.
A quick test with my use case does not show errors in the maint
branch. So it should not be needed (except the memory leak fix of the
=2Eutil member). And valgrind confirms this.

Bert

>
