From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [PATCHv2 00/10] gitweb: 'blame' view improvements
Date: Sat, 25 Jul 2009 02:10:42 +0200
Message-ID: <200907250210.45225.jnareb@gmail.com>
References: <1248475450-5668-1-git-send-email-jnareb@gmail.com> <7vskgl4p9t.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-2
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Petr Baudis <pasky@suse.cz>,
	Fredrik Kuivinen <frekui@gmail.com>,
	Giuseppe Bilotta <giuseppe.bilotta@gmail.com>,
	Luben Tuikov <ltuikov@yahoo.com>,
	Martin Koegler <mkoegler@auto.tuwien.ac.at>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Jul 25 02:11:04 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MUUqr-00089R-41
	for gcvg-git-2@gmane.org; Sat, 25 Jul 2009 02:11:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754680AbZGYAKw convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 24 Jul 2009 20:10:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754563AbZGYAKw
	(ORCPT <rfc822;git-outgoing>); Fri, 24 Jul 2009 20:10:52 -0400
Received: from mail-bw0-f228.google.com ([209.85.218.228]:34813 "EHLO
	mail-bw0-f228.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754399AbZGYAKv (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 24 Jul 2009 20:10:51 -0400
Received: by bwz28 with SMTP id 28so1698174bwz.37
        for <git@vger.kernel.org>; Fri, 24 Jul 2009 17:10:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:subject:date
         :user-agent:cc:references:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:message-id;
        bh=scaCxe9hdxGUcXjH4HZHdWVnQuaU82dD6QHAjbYLjxY=;
        b=QAIVH0bJ/P+pBoCadtbj9DtoDR2Q4nWiC6bVsr2zDGjFYXsgRFXQn3B08XpxDQMSF+
         DyAou09wK6R1QsbwgfaS5CYJCj6tjUC2dEyOHgtaXVHhS51oI6Jj2CavBQYbTCrv+Zhi
         YQlIk2/tNEMz5PaqClqJoEEfgeVId7UL6RtZc=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:subject:date:user-agent:cc:references:in-reply-to
         :mime-version:content-type:content-transfer-encoding
         :content-disposition:message-id;
        b=llaVgh/VFzyYlOzbCiCKR2IRBs6gWjRWy1CWSBxM/fyjHW+blI+CyhlulFuclNt9XO
         NEe2X+0jyuFQ68iorhCV82bdv98bf1f0MuYsCensa9Snq2+YxBdg+ONUPFbnhmJMIhtC
         i1gcN3C+l128tsl4oPtP97YOClAMGCaXf5Eek=
Received: by 10.204.123.83 with SMTP id o19mr324011bkr.12.1248480650384;
        Fri, 24 Jul 2009 17:10:50 -0700 (PDT)
Received: from ?192.168.1.13? (abwq33.neoplus.adsl.tpnet.pl [83.8.240.33])
        by mx.google.com with ESMTPS id c28sm6153405fka.19.2009.07.24.17.10.49
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Fri, 24 Jul 2009 17:10:49 -0700 (PDT)
User-Agent: KMail/1.9.3
In-Reply-To: <7vskgl4p9t.fsf@alter.siamese.dyndns.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/123982>

Dnia sobota 25. lipca 2009 01:47, Junio C Hamano napisa=B3:
> Jakub Narebski <jnareb@gmail.com> writes:
>=20
> > This is second version of my improvements to gitweb's 'blame' view,
> >   Subject: [PATCH 0/3] gitweb: 'blame' view improvements
> >   Message-Id: <200907102354.43232.jnareb@gmail.com>
> >   http://article.gmane.org/gmane.comp.version-control.git/123085
> >
> > including some further improvements, and this time including
> > preparation and AJAX-y 'blame_incremental' view in series proper.
> > It also finally creates 'blame_incremental' links (last patch in
> > series).
>=20
> I understand that this series replaces the four-patch series between
> "git log --oneline a6be48b^..3643cc0"---am I correct?

Yes, it does.  In particular it fixes my mistake about need for in=20
unquote_maybe in "gitweb: Use "previous" header of git-blame -p in=20
'blame' view".  And that is the only change (except extending commit=20
message) in a6be48b^..3643cc0.

I see that I forgot to mark "gitweb: Add -partial_query option to href(=
)=20
subroutine" as RFC; it isn't I think strictly necessary.  But that is=20
why I put it in separate commit: to easy delete it or revert if deemed=20
not needed.

--=20
Jakub Narebski
Poland
