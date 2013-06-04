From: Janusz Harkot <janusz.harkot@gmail.com>
Subject: Re: SNI (SSL virtual hosts)
Date: Tue, 4 Jun 2013 23:26:51 +0200
Message-ID: <630928524B6441DC907D7AFF34389010@gmail.com>
References: <DC851F5EA18E478DACB62178624BF5B7@gmail.com>
 <97F8F367D27D4B3E93439FF8D0F121FA@gmail.com>
 <alpine.DEB.2.00.1306041142200.16303@tvnag.unkk.fr>
 <8B7A2C3A8CC346D6B34D153F591F878F@gmail.com>
 <alpine.DEB.2.00.1306041349290.32021@tvnag.unkk.fr>
 <CEC3E2C7A86A477DAC658432461A60BC@gmail.com>
 <alpine.DEB.2.00.1306042305300.2878@tvnag.unkk.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Daniel Stenberg <daniel@haxx.se>
X-From: git-owner@vger.kernel.org Tue Jun 04 23:27:01 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ujyku-0006NR-1z
	for gcvg-git-2@plane.gmane.org; Tue, 04 Jun 2013 23:27:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750919Ab3FDV05 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 4 Jun 2013 17:26:57 -0400
Received: from mail-ea0-f173.google.com ([209.85.215.173]:48681 "EHLO
	mail-ea0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750819Ab3FDV0z convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 4 Jun 2013 17:26:55 -0400
Received: by mail-ea0-f173.google.com with SMTP id g15so445031eak.32
        for <git@vger.kernel.org>; Tue, 04 Jun 2013 14:26:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:message-id:in-reply-to:references:subject:x-mailer
         :mime-version:content-type:content-transfer-encoding
         :content-disposition;
        bh=tfX/lvjsY5iv96E1uS2Yuev9veOEx06WCxcB1sUZ7g8=;
        b=OgUWOyEGoV6oerXPszmFlCL+cDXpRg03JRwSAG7fKFNZUuU/xv1FszuzOioktDVtR6
         KQJFwbFD9DHv9wtAW7Raqu05Zc9xqIfIqSqIEXi7Vs65D/blNgqCQHtAj5ZL6CRD1pbu
         zgp3SCSBWjTWGxwtWi2lTA8gwKB+CM6r9e/jyeH2YLM2VqBdrwnLEa3bGuL9Kus0riIg
         BDJyA4zJAdBXoMYFJx7Z07uA4ugG/Xah0TEai94Ce70A0O1qMAs7MJr4i13nOJejjPor
         H+Mcin/BAm5S5MLWf660lKzBIqmsjD++cxkuZIxQt0rsk2tzwgE3hgUxdSYVcZPXOzvU
         N3zA==
X-Received: by 10.15.91.66 with SMTP id r42mr27617455eez.48.1370381214273;
        Tue, 04 Jun 2013 14:26:54 -0700 (PDT)
Received: from [10.0.1.200] (77-252-124-82.ip.netia.com.pl. [77.252.124.82])
        by mx.google.com with ESMTPSA id y44sm12875964eel.10.2013.06.04.14.26.53
        for <multiple recipients>
        (version=TLSv1 cipher=RC4-SHA bits=128/128);
        Tue, 04 Jun 2013 14:26:53 -0700 (PDT)
In-Reply-To: <alpine.DEB.2.00.1306042305300.2878@tvnag.unkk.fr>
X-Mailer: sparrow 1.6.4 (build 1178)
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/226412>

valid point, but from what you can find on the web, the only solution p=
rovided everywhere was to
disable certificate checking=E2=80=A6 so maybe that's not me, but this =
is first time someone spent
some time to check whats going on :)

at least there will be something, maybe this will help someone=E2=80=A6

thanks Daniel!


best!
Janusz








On Tuesday, 4 June 2013 at 23:18, Daniel Stenberg wrote:

> On Tue, 4 Jun 2013, Janusz Harkot wrote:
> =20
> > > What makes you suggest that's what's happening? Sure, if it would=
've sent no
> > > or the wrong host name it would probably have that effect.
> > =20
> > =20
> > =20
> > line:
> > =20
> > [36] * Re-using existing connection! (#0) with host (nil)
> =20
> Ah that. Yes, that's a stupid line to show (that bug has been fixed s=
ince). =20
> But if you look further down your log you see that the connection whi=
ch is =20
> re-used according to that log line gets closed anyway.
> =20
> > it looks like it is working
> =20
> Awesome!
> =20
> > So, the question is still why it is not working with openssl 0.9.8r=
 - this =20
> > version supports SNI by default. This looks like an error in openss=
l (maybe: =20
> > Only allow one SGC handshake restart for SSL/TLS.)
> =20
> =20
> =20
> Right. As you can see in the libcurl code it activates SNI for OpenSS=
L the =20
> exact same way independently of what version that's used.
> =20
> > Now is the question, shall this be handled by curl or left alone? (=
handling =20
> > older version of openssl, and force new ssl session?)
> =20
> =20
> =20
> I'm not even completely convinced this is "just" an old-OpenSSL-probl=
em. If =20
> that version you're using is the one Apple has provided, there's the =
risk that =20
> the problem is rather caused by their changes!
> =20
> I'm reluctant to globally switch off session-id caching for OpenSSL 0=
=2E9.8 =20
> users since that feature has been used for over 8 years in the code a=
nd you're =20
> the first to have a problem with it! =3D-/
> =20
> -- =20
> =20
> / daniel.haxx.se (http://daniel.haxx.se)
> --
> To unsubscribe from this list: send the line "unsubscribe git" in
> the body of a message to majordomo@vger.kernel.org (mailto:majordomo@=
vger.kernel.org)
> More majordomo info at http://vger.kernel.org/majordomo-info.html
