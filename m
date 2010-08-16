From: Miles Bader <miles@gnu.org>
Subject: Re: [PATCH] reset: Better warning message on git reset --mixed <paths>
Date: Mon, 16 Aug 2010 09:59:44 +0900
Message-ID: <AANLkTim=TM_3aXMSSN1-vovdc3z6QNR15KHujiJ-wH4_@mail.gmail.com>
References: <1281814499-11797-1-git-send-email-avarab@gmail.com>
 <20100814210505.GA2372@burratino> <7vvd7chcj4.fsf@alter.siamese.dyndns.org>
 <87tymwzjbk.fsf@catnip.gol.com> <AANLkTin3zyPvs3GjOt3=q6dOofFA2ba0sBAzt3=Ka1Wn@mail.gmail.com>
 <7vr5hzg1u1.fsf@alter.siamese.dyndns.org> <AANLkTik+yGn_0PR9uO2_EsZgQPW187P4qmZx4fJSbAWO@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	Jonathan Nieder <jrnieder@gmail.com>, git@vger.kernel.org,
	Ralf Ebert <info@ralfebert.de>
To: =?ISO-8859-1?Q?=C6var_Arnfj=F6r=F0_Bjarmason?= <avarab@gmail.com>
X-From: git-owner@vger.kernel.org Mon Aug 16 03:00:40 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Oko43-000385-1q
	for gcvg-git-2@lo.gmane.org; Mon, 16 Aug 2010 03:00:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751812Ab0HPBAG convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 15 Aug 2010 21:00:06 -0400
Received: from mail-iw0-f174.google.com ([209.85.214.174]:65472 "EHLO
	mail-iw0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751775Ab0HPBAF convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 15 Aug 2010 21:00:05 -0400
Received: by iwn7 with SMTP id 7so1110154iwn.19
        for <git@vger.kernel.org>; Sun, 15 Aug 2010 18:00:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:mime-version:sender:received
         :in-reply-to:references:from:date:x-google-sender-auth:message-id
         :subject:to:cc:content-type:content-transfer-encoding;
        bh=nCIFG2Vqlc+lSFVWJSrsLwKXA01F4pqNMMEUYggvwn8=;
        b=UcYM4Uw9w/JyZ/tuorrDl7tnCxSpgnnf+3VvYJkoZzaxo/WP1aqG1Po3ppQP80d/F9
         p04sv1oItk+3euhUWvKcLKecIvAnqcn623dhR2jZXoUxKdl9rFqcVZzW2t3Mcf7ItnsQ
         A3C/8RKwKAm761pGe4OcQZBwaS6nPIYrZMKYo=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:sender:in-reply-to:references:from:date
         :x-google-sender-auth:message-id:subject:to:cc:content-type
         :content-transfer-encoding;
        b=fAFIA3Wd13j6vulc6+DtGgsT7s16rKzF/L4dGUHbE/aLOVMIcrLhHXaB8iPyK3Yu7L
         KsPXGe2R9hsqtQVQcEOvF2+AUysUmzw5TD32GqJS80x+uciTrWjEllasLvsorI/+l5X8
         QkqZSlKUZ76JLdz4h4ax/uVOmsNEfvkUEOyjk=
Received: by 10.231.191.6 with SMTP id dk6mr5130562ibb.51.1281920404219; Sun,
 15 Aug 2010 18:00:04 -0700 (PDT)
Received: by 10.231.146.65 with HTTP; Sun, 15 Aug 2010 17:59:44 -0700 (PDT)
In-Reply-To: <AANLkTik+yGn_0PR9uO2_EsZgQPW187P4qmZx4fJSbAWO@mail.gmail.com>
X-Google-Sender-Auth: 6TQbRKUeU2qnUjUOYFLG_NGV5Vg
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/153635>

On Mon, Aug 16, 2010 at 5:51 AM, =C6var Arnfj=F6r=F0 Bjarmason
<avarab@gmail.com> wrote:
> So it's a question of whether git-reset should do all reset-y things
> without complaining, even when that infringes on git-checkout's
> domain.

Of course one question is:  why is this "git-checkout's domain" in the
first place?

=46rom a UI perspective this functionality doesn't seem to make any mor=
e
sense in checkout -- and perhaps _less_ -- than it does in git-reset.
"git-checkout <path>" seems like a tacked-on-to-make-cvs-users-happy
wart rather than a natural part of git-checkout.

I know that as a beginning git user, I always tried to use "git-reset
--hard <path>", because that sort of made sense in my mental model of
git commands, only to be confused when it didn't work.  The fact that
one actually needed to to do git-checkout instead was confusing.

-Miles

--=20
Do not taunt Happy Fun Ball.
