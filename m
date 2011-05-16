From: =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Subject: Re: Bikeshedding advice on the ab/i18n-scripts series
Date: Mon, 16 May 2011 23:32:55 +0200
Message-ID: <BANLkTi=FLWFzMFG5DgQiaN9kYW3pozJ6HQ@mail.gmail.com>
References: <BANLkTi==pxyy7OeZT0mn33iJHrc5R7vHBw@mail.gmail.com>
	<7vboz2l6h1.fsf@alter.siamese.dyndns.org>
	<7v62pal5v7.fsf@alter.siamese.dyndns.org>
	<BANLkTimuA6-jLAUAMuhVf6FfJ2eNp8ROZw@mail.gmail.com>
	<20110516212641.GB15150@elie>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	Erik Faye-Lund <kusmabite@gmail.com>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Mon May 16 23:33:05 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QM5PS-00086Y-Je
	for gcvg-git-2@lo.gmane.org; Mon, 16 May 2011 23:33:02 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756506Ab1EPVc5 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 16 May 2011 17:32:57 -0400
Received: from mail-fx0-f46.google.com ([209.85.161.46]:50675 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756301Ab1EPVc4 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 16 May 2011 17:32:56 -0400
Received: by fxm17 with SMTP id 17so3386437fxm.19
        for <git@vger.kernel.org>; Mon, 16 May 2011 14:32:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=jZHrBp/5tDSyVEa9di0E5nJCqE4qpqc4IrtWdoAwY9w=;
        b=ANmHO1Cv+6v94CTZM//pBwbgygf6wBNr4wP9VIIqCnf08ZDaqOkNhDalYti5TGS4Zu
         40wkPzopArXp1jIQJXPWEYLgDsdfDJ2TucPrqKXThk7vx+VULcwOa5L/gUTIUtXCaIP0
         7r8Jjen2z8oXqoiDB/oSHKs/z3/vpY9SB6geo=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=pX8iueHP88oRUpMaIxYeOSSskD9py1Gr8d0WrE7aar/YOHiYGWpctsEEzNmF4r8+hg
         GpcNh/09pcRdSN4tODZ1gu9TSPMjCv6WM54eSbaiUhEkNKUujCFA8g+m74Nv2QmE7IAd
         efVSqNSb959psO6T4SxKhlWwd8Pc1hFlKdVZ8=
Received: by 10.223.77.92 with SMTP id f28mr1973381fak.37.1305581575750; Mon,
 16 May 2011 14:32:55 -0700 (PDT)
Received: by 10.223.117.72 with HTTP; Mon, 16 May 2011 14:32:55 -0700 (PDT)
In-Reply-To: <20110516212641.GB15150@elie>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/173764>

On Mon, May 16, 2011 at 23:26, Jonathan Nieder <jrnieder@gmail.com> wro=
te:
> =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason wrote:
>
>> That would require us to start extracting strings from all "say"
>> functions. The reason we have only "gettext" and "eval_gettext" is s=
o
>> xgettext can extract them.
>
> Isn't that what the xgettext -k parameter is for?

I'm not saying we can't use xgettext to extract these things. I'm
saying I don't think it's a good idea.

    $ git --no-pager grep say git-submodule.sh
    git-submodule.sh:                       say "$(eval_gettext
"Entering '\$prefix\$path'")"
    git-submodule.sh:               say "$(eval_gettext "Submodule
'\$name' (\$url) registered for path '\$path'")"
    git-submodule.sh:                       say "$(eval_gettext
"Submodule path '\$path' not initialized
    git-submodule.sh:
say_msg=3D"$(eval_gettext "Submodule path '\$path': rebased into
'\$sha1'")"
    git-submodule.sh:
say_msg=3D"$(eval_gettext "Submodule path '\$path': merged in
'\$sha1'")"
    git-submodule.sh:
say_msg=3D"$(eval_gettext "Submodule path '\$path': checked out
'\$sha1'")"
    git-submodule.sh:                       say $say_msg
    git-submodule.sh:                       say "U$sha1 $displaypath"
    git-submodule.sh:                       say "-$sha1 $displaypath"
    git-submodule.sh:                       say " $sha1 $displaypath$re=
vname"
    git-submodule.sh:                       say "+$sha1 $displaypath$re=
vname"
    git-submodule.sh:               say "$(eval_gettext "Synchronizing
submodule url for '\$name'")"

I want to mark *some* of these *manually* as translatable, I don't
want to go and extract strings from all invocations to functions like
printf & die, instead I want to add a printf(_()) wrapper to
everything.
