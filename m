From: Sverre Rabbelier <srabbelier@gmail.com>
Subject: Re: [PATCH 17/19] transport-helper: export is no longer always the
 last command
Date: Thu, 9 Jun 2011 10:28:20 +0200
Message-ID: <BANLkTinuZAJtuGw4hOLLjqLx5pN9iDhh+w@mail.gmail.com>
References: <1307558930-16074-1-git-send-email-srabbelier@gmail.com>
 <1307558930-16074-18-git-send-email-srabbelier@gmail.com> <7vsjrjzubl.fsf@alter.siamese.dyndns.org>
 <BANLkTim1R=1SrUXgOOjmRioG45KKVity3Q@mail.gmail.com> <20110609075141.GA4885@elie>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
	Git List <git@vger.kernel.org>,
	Daniel Barkalow <barkalow@iabervon.org>,
	Ramkumar Ramachandra <artagnon@gmail.com>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Thu Jun 09 10:29:16 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QUac2-00037T-PL
	for gcvg-git-2@lo.gmane.org; Thu, 09 Jun 2011 10:29:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754815Ab1FII3D convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 9 Jun 2011 04:29:03 -0400
Received: from mail-qw0-f46.google.com ([209.85.216.46]:55225 "EHLO
	mail-qw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752827Ab1FII3B convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 9 Jun 2011 04:29:01 -0400
Received: by qwk3 with SMTP id 3so597422qwk.19
        for <git@vger.kernel.org>; Thu, 09 Jun 2011 01:29:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-type:content-transfer-encoding;
        bh=WBTmL9H3JxuOYNrkZKAyWYfjrPzaVpnLKkA97NwByHY=;
        b=Kp5wCrHX69hd4c0cYO1Jv/ZIxbeKtBXiAZ34nv1NiXYCAQU48ZE/IbJqkIYnytM0XS
         7luFNimazOdeS9PiojhnTfxz2PrXDTMM13pHfL1z/Sm/XNYL5/Gt3M/XT2eLMc/3FiFD
         IiKvv03lr6mHkEEShGAXGidu5Se0Q3QhMQcgs=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        b=WXEREbxcoqiHWJCF6rUJ2PgJ3jxJxezTJ6zQxeDIXQTeWsuo8E8v2oXyik/qCABtOU
         Gqd4wjU4fu3G3p03KumZaKpHPIox6iyTSdOIf/boPXWiLiGBllIrKoU3F2fSv9xL4XBG
         NcGGQ/JrFrZgUfpD/EoqISZBl/XP1xQ7taE/c=
Received: by 10.229.100.20 with SMTP id w20mr325702qcn.129.1307608140142; Thu,
 09 Jun 2011 01:29:00 -0700 (PDT)
Received: by 10.229.83.203 with HTTP; Thu, 9 Jun 2011 01:28:20 -0700 (PDT)
In-Reply-To: <20110609075141.GA4885@elie>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/175504>

Heya,

On Thu, Jun 9, 2011 at 09:51, Jonathan Nieder <jrnieder@gmail.com> wrot=
e:
> Yes, but I'm still missing something. =C2=A0What does the trailing \n=
 ever
> have to be written?
>
> "git log -Sdisconnect_helper -- transport-helper.c" doesn't give many
> clues. =C2=A0I imagine it's a way to check whether the child is still=
 alive
> and to warn it not to be alarmed when the output end of its input pip=
e
> closes.

Yes, the trailing \n is to signal to the helper that the connection is
about to close, allowing it to do whatever cleanup necessarily. It's
kind of like the "done" command for fast-import.

--=20
Cheers,

Sverre Rabbelier
