From: Avery Pennarun <apenwarr@gmail.com>
Subject: Re: [PATCH (v2) 2/2] rebase -i: teach --onto A...B syntax
Date: Fri, 8 Jan 2010 15:31:41 -0500
Message-ID: <32541b131001081231x1b6ac8c1k30084e4abf8cc896@mail.gmail.com>
References: <7vljgei7rs.fsf@alter.siamese.dyndns.org> <7vskal5c11.fsf@alter.siamese.dyndns.org> 
	<20100106191825.6117@nanako3.lavabit.com> <alpine.DEB.1.00.1001061219180.11013@intel-tinevez-2-302> 
	<7vocl7yxef.fsf@alter.siamese.dyndns.org> <20100107200509.6117@nanako3.lavabit.com> 
	<7vtyux3bx1.fsf@alter.siamese.dyndns.org> <32541b131001081216p27d7e29bu269755db895128@mail.gmail.com> 
	<fabb9a1e1001081222q7122872bu72cea4e393f272ac@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	Nanako Shiraishi <nanako3@lavabit.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	git@vger.kernel.org
To: Sverre Rabbelier <srabbelier@gmail.com>
X-From: git-owner@vger.kernel.org Fri Jan 08 21:32:13 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NTLVD-00027O-E0
	for gcvg-git-2@lo.gmane.org; Fri, 08 Jan 2010 21:32:11 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752804Ab0AHUcF convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 8 Jan 2010 15:32:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752783Ab0AHUcF
	(ORCPT <rfc822;git-outgoing>); Fri, 8 Jan 2010 15:32:05 -0500
Received: from mail-yw0-f176.google.com ([209.85.211.176]:52894 "EHLO
	mail-yw0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752542Ab0AHUcB convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 8 Jan 2010 15:32:01 -0500
Received: by ywh6 with SMTP id 6so19831556ywh.4
        for <git@vger.kernel.org>; Fri, 08 Jan 2010 12:32:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :from:date:message-id:subject:to:cc:content-type
         :content-transfer-encoding;
        bh=IJyvQrSAqtvFo5fO6Sw8SK40Fxw5JLng/uHB1dBeAKI=;
        b=G8/HWqef1WwPsIsPCr3qwOJxIwUiKd58s+MvBplU844a5Sg4bkcT34XNlro+BfGEIY
         xAdLF92R/2nYijdng6eIE+3Lj2+UCkJuuHE3CXdAKZ4IYTKvWPq2Exu5xp7DfkvG0/nD
         1yZY/UMm6WXd0Otc46JQAa6goSnaTNpa+NkLI=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        b=U3UP3FvxvflJnXykVYPpNJ75C0K5NYITt4LuQHK9lXLZqXs9bOrnoWimpwbjNGRpyp
         68PtTYMTWrWBeHnNm/H+qUkTTQcqe3Yjb5nga2UVuBKy7NCnq+yXPl//PN74o38UBQmt
         MCmPigaN4KRnNFl3FhNWRPFvlD7Afm4YqB094=
Received: by 10.150.105.27 with SMTP id d27mr26619749ybc.195.1262982721074; 
	Fri, 08 Jan 2010 12:32:01 -0800 (PST)
In-Reply-To: <fabb9a1e1001081222q7122872bu72cea4e393f272ac@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/136472>

On Fri, Jan 8, 2010 at 3:22 PM, Sverre Rabbelier <srabbelier@gmail.com>=
 wrote:
> On Fri, Jan 8, 2010 at 15:16, Avery Pennarun <apenwarr@gmail.com> wro=
te:
>> This would resolve any other inconsistencies between the two as well=
,
>> notably that non-interactive rebase sometimes refuses to do the reba=
se
>> I requested because "Current branch master is up to date," while
>> interactive rebase is willing to do it. =A0(Personally I prefer the
>> latter behaviour, since I don't like tools that think they're smarte=
r
>> than me :))
>
> I taught rebase the -f|--force-rebase flag a little while back, you
> could use that :).

Thanks, I didn't know about that one.  But my general point is still:
we seem to have two implementations when the functionality of one is
actually a superset of the other.  As far as I can see, anyway.  So
the obvious way to reduce the duplicated code is to simply eliminate
the less-featureful implementation.

Avery
