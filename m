From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: SSL certificate password storage?
Date: Sat, 24 Sep 2011 10:51:30 -0700 (PDT)
Message-ID: <m3aa9trfr2.fsf@localhost.localdomain>
References: <CAEsSSh2MDPgcFtrwYJ7uCDHBHPEfo35deE4dsWrb7Ukp7b310A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-2
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git <git@vger.kernel.org>
To: James B <coderer@gmail.com>
X-From: git-owner@vger.kernel.org Sat Sep 24 19:51:39 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1R7WO3-00037M-9V
	for gcvg-git-2@lo.gmane.org; Sat, 24 Sep 2011 19:51:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752074Ab1IXRvd convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 24 Sep 2011 13:51:33 -0400
Received: from mail-ey0-f174.google.com ([209.85.215.174]:47863 "EHLO
	mail-ey0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752022Ab1IXRvc convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 24 Sep 2011 13:51:32 -0400
Received: by eya28 with SMTP id 28so2829626eya.19
        for <git@vger.kernel.org>; Sat, 24 Sep 2011 10:51:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=x-authentication-warning:to:cc:subject:references:from:date
         :in-reply-to:message-id:lines:user-agent:mime-version:content-type
         :content-transfer-encoding;
        bh=u45HNy/3nPZbf+hYSzVd51iK1eg6UFDzG28u9p6O31I=;
        b=F6lSbvamvaO/rvI7BkyvxEzOdXFz97ZWjOj4KhjTZcPEOmoCuOtQY5fWKsS0I9Pc7h
         MQ23b65FwybQ7WHg2FuqHUfb1FFFXN+PXNtOjy71HjuA9fFtf4QuRcMZfp9Vohv8uWHd
         neBRA4ytxWzJqACqW5Q/61pcRJUPPmQ684AEs=
Received: by 10.14.18.207 with SMTP id l55mr1176991eel.42.1316886691613;
        Sat, 24 Sep 2011 10:51:31 -0700 (PDT)
Received: from localhost.localdomain (abvl230.neoplus.adsl.tpnet.pl. [83.8.209.230])
        by mx.google.com with ESMTPS id a14sm15502647eeg.6.2011.09.24.10.51.28
        (version=TLSv1/SSLv3 cipher=OTHER);
        Sat, 24 Sep 2011 10:51:30 -0700 (PDT)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by localhost.localdomain (8.13.4/8.13.4) with ESMTP id p8OHp8gn009541;
	Sat, 24 Sep 2011 19:51:18 +0200
Received: (from jnareb@localhost)
	by localhost.localdomain (8.13.4/8.13.4/Submit) id p8OHovvn009531;
	Sat, 24 Sep 2011 19:50:57 +0200
X-Authentication-Warning: localhost.localdomain: jnareb set sender to jnareb@gmail.com using -f
In-Reply-To: <CAEsSSh2MDPgcFtrwYJ7uCDHBHPEfo35deE4dsWrb7Ukp7b310A@mail.gmail.com>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/182035>

James B <coderer@gmail.com> writes:

> I'm accessing a Git repository over an HTTPS transport, where client
> certificates are required.  My certificate requires a password to use=
,
> and Git prompts me for this every time I use it -- it's starting to
> get a little old.  I've got Subversion set up to use Gnome-Keyring fo=
r
> credentials, so I only have to unlock that once per session.  Is ther=
e
> something similar for Git?  Is it planned?  If not, is there a good
> place to make feature requests?

There is "credential helper" series:
 * infrastructure and simple example implementations,
   like in-memory cache by Jeff King
 * credential helper for MacOS X keychain from Jay Soffian
 * credential helper for KDE (KWallet) from Lukas Sandstr=F6m
 * simple credential helper for Windows by Erik Faye-Lund

In 'next' there is only sample implemetations (credentia-cache and
credential-store).  Some of the rest you can find in 'pu', others only
on git mailing list.

Currently there are no credentials helper for GNOME.  Perhaps you can
write one?

--=20
Jakub Nar=EAbski
