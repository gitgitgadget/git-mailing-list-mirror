From: Bert Wesarg <bert.wesarg@googlemail.com>
Subject: Re: [PATCH] topgit tg push feature
Date: Thu, 7 May 2009 11:50:27 +0200
Message-ID: <36ca99e90905070250l656f8879g87eb27c09db2cd42@mail.gmail.com>
References: <20090425161300.GD19142@gmx.de> <20090425163447.GE19142@gmx.de>
	 <20090505093448.GC16524@gmx.de> <20090507045904.GA2068@gmx.de>
	 <36ca99e90905062245w1ec78828ice5ed18161b6ec43@mail.gmail.com>
	 <20090507084355.GA11680@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Marc Weber <marco-oweber@gmx.de>, git@vger.kernel.org
To: =?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig?= 
	<u.kleine-koenig@pengutronix.de>
X-From: git-owner@vger.kernel.org Thu May 07 11:50:41 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1M20FU-0001fC-Hv
	for gcvg-git-2@gmane.org; Thu, 07 May 2009 11:50:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756603AbZEGJua convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 7 May 2009 05:50:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756223AbZEGJua
	(ORCPT <rfc822;git-outgoing>); Thu, 7 May 2009 05:50:30 -0400
Received: from fk-out-0910.google.com ([209.85.128.189]:30718 "EHLO
	fk-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755991AbZEGJu3 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 7 May 2009 05:50:29 -0400
Received: by fk-out-0910.google.com with SMTP id 18so363949fkq.5
        for <git@vger.kernel.org>; Thu, 07 May 2009 02:50:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=4zPLjhgvICnlftpT875CIbVx1SvjfhdlC1fuAV2xZKA=;
        b=ZyTltbPKNE+rXdEaRrjsxrL5jQsDwIeCQutVF/FuMT+J4wysLMuGqfI/nn+f/3baQ7
         ISYzM0FEZCfKzIh4Y3Xx0M5uNKr+lnkc6YewZmTS7dSbZw3hxqBAeXtTXByVbeWrd+C7
         hzSA1yPnRDHeOQg68Bf3FAtxEFT+FPMDGFYag=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=googlemail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=PYNMVBezJNmkdjlHw8b/3faA5nmUDK5ps3xZSgQhXu5kdQbtYqqWPBRzOtHbyX2CKQ
         vR/w5zeu8VIO+Dj4EGy0n9vGJbhrLkKOfagQXbjuYt+223E0w3p/PpK61ILHMjtJ6Bjm
         +otKaYtAWV7GJBMdxvPwTdzu7LkVymI7b19yQ=
Received: by 10.223.126.66 with SMTP id b2mr1464331fas.67.1241689827597; Thu, 
	07 May 2009 02:50:27 -0700 (PDT)
In-Reply-To: <20090507084355.GA11680@pengutronix.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/118459>

2009/5/7 Uwe Kleine-K=C3=B6nig <u.kleine-koenig@pengutronix.de>:
> Hi Marc, hi Bert,
>> > + =C2=A0 =C2=A0 =C2=A0 # if so desired omit non tgish deps
>> > + =C2=A0 =C2=A0 =C2=A0 [ -z "$tgish_deps_only" ] || [ -n "$_dep_is=
_tgish" ] || return 0
> I've always problems to understand these constructs. =C2=A0Are these =
any
> better than
>
> =C2=A0 =C2=A0 =C2=A0 =C2=A0if test ...; then
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return 0
> =C2=A0 =C2=A0 =C2=A0 =C2=A0fi
>
> ? =C2=A0And I think it's more readable to use
>
> =C2=A0 =C2=A0 =C2=A0 =C2=A0tgish_deps_only=3Dfalse
>
> =C2=A0 =C2=A0 =C2=A0 =C2=A0...
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0--tgish-only)
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0tgish_deps_only=3Dtrue;;
>
> =C2=A0 =C2=A0 =C2=A0 =C2=A0...
>
> =C2=A0 =C2=A0 =C2=A0 =C2=A0if $tgish_deps_only; then
>
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0...
>
> =C2=A0 =C2=A0 =C2=A0 =C2=A0fi
>
> . =C2=A0(OK, I have to admit, that these constructs are used everywhe=
re in
> topgit, but I'm not happy with these either.)
I also like the true/false style, its also useable with the current 'sc=
heme':

       $tgish_deps_only && ...
