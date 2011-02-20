From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH 01/72] gettext.h: add no-op _() and N_() wrappers
Date: Sun, 20 Feb 2011 16:03:11 -0600
Message-ID: <20110220220311.GC32142@elie>
References: <1298143495-3681-1-git-send-email-avarab@gmail.com>
 <1298143495-3681-2-git-send-email-avarab@gmail.com>
 <20110220020130.GA17225@elie>
 <AANLkTinZSpz=H9dt6kRDhOtght_YB4qVpw5WENEYmaQZ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
To: =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
X-From: git-owner@vger.kernel.org Sun Feb 20 23:03:25 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PrHNC-0005mM-IH
	for gcvg-git-2@lo.gmane.org; Sun, 20 Feb 2011 23:03:22 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754722Ab1BTWDR convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 20 Feb 2011 17:03:17 -0500
Received: from mail-gx0-f174.google.com ([209.85.161.174]:59051 "EHLO
	mail-gx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751757Ab1BTWDQ convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 20 Feb 2011 17:03:16 -0500
Received: by gxk8 with SMTP id 8so249249gxk.19
        for <git@vger.kernel.org>; Sun, 20 Feb 2011 14:03:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:date:from:to:cc:subject:message-id:references
         :mime-version:content-type:content-disposition
         :content-transfer-encoding:in-reply-to:user-agent;
        bh=vlm0uTB36Q7FZ6pc5YqevP4dOZp9jwIfakUgCoOZ+90=;
        b=A7ENbSP4s0xN3Ojd2+2/zOK3mtLsxc3szUUmaEB/axk/40+E2bq6cnAOS8+5xvRIB0
         0Ii6poIjidDtzicL3+nZrwkRm/CplkWWUS62jnWSLdh+NxMPlopvyneOa6Vk3kvEtXvt
         cN0O9/PwtaI2v3EHpVzNPYgSph4TprR3wcVIk=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        b=cyFCSWuQ6+xqxcJIMIF91/do0cFMHFUYBQftEowWrEp9QmruKWHc9YgE0kAFECV8eQ
         xEJvidWOTO+//PmRww3pfzdXRcvUKKNU4ECwdIhu30Gi+AkyNbm/suCoNwaWIfbX8w3Y
         /HsDMPZsFCr+GScYPbfTNNmuU37UR09obqsLM=
Received: by 10.150.185.5 with SMTP id i5mr852653ybf.271.1298239395570;
        Sun, 20 Feb 2011 14:03:15 -0800 (PST)
Received: from elie (adsl-69-209-53-52.dsl.chcgil.sbcglobal.net [69.209.53.52])
        by mx.google.com with ESMTPS id v39sm2823238yba.18.2011.02.20.14.03.13
        (version=SSLv3 cipher=OTHER);
        Sun, 20 Feb 2011 14:03:14 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <AANLkTinZSpz=H9dt6kRDhOtght_YB4qVpw5WENEYmaQZ@mail.gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/167430>

=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason wrote:

> Thanks for this. This was raised earlier in the discussion for this
> series (by you, IIRC). I've considered it, and while I see your point
> (type safety =3D good) I think I like my way of doing it better.
>
> The _() macro/function is usually a macro and not a function. The goo=
d
> thing about this is that I can prove that it's a no-op on all
> compilers, whereas if it's an inline function (stupid) compilers will
> actually make it into a function, which'll result in overhead,
> which'll mean I can't advertise this series as a "no-op" anymore.

I hope we don't support (meaning "worry about") such stupid compilers?

At least I haven't seen this being a consideration in deciding whether
to split out inline functions in the past.  Perl is much more portable
than git, and that seems perfectly fine to me.

> So that's why I didn't do it. But if everyone else feels strongly
> about it I'll change my mind, I don't care *that* much about it, but
> I'd prefer a macro.

I think it's perfectly possible there's some aesthetic or functional
reason to make this a macro instead of a function, and that would be
fine with me.  On the other hand, if there's no reason, then I do feel
strongly about it, fwiw.  New code should set a good example.

Thanks for your thoughtfulness.
Jonathan
