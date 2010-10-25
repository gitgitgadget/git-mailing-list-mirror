From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [PATCHv6 02/10] gitweb: git_get_heads_list accepts an optional list of refs.
Date: Mon, 25 Oct 2010 23:56:37 +0200
Message-ID: <201010252356.37472.jnareb@gmail.com>
References: <1287917136-26103-1-git-send-email-giuseppe.bilotta@gmail.com> <1287917136-26103-3-git-send-email-giuseppe.bilotta@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-2
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Giuseppe Bilotta <giuseppe.bilotta@gmail.com>
X-From: git-owner@vger.kernel.org Mon Oct 25 23:56:50 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PAV2A-0005E4-7W
	for gcvg-git-2@lo.gmane.org; Mon, 25 Oct 2010 23:56:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756727Ab0JYV4p convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 25 Oct 2010 17:56:45 -0400
Received: from mail-fx0-f46.google.com ([209.85.161.46]:55048 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753373Ab0JYV4o (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 25 Oct 2010 17:56:44 -0400
Received: by fxm16 with SMTP id 16so3413152fxm.19
        for <git@vger.kernel.org>; Mon, 25 Oct 2010 14:56:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:subject:date
         :user-agent:cc:references:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:message-id;
        bh=THcdWRgaIC4VhuRdUImGZekon+LcabJxtK5uN5yUTkk=;
        b=vYoix+ejYQFGJN+9Vdcv70x12wMjELkmosUEtHFPkcAwTTm+dRbLXyEniiqRqsYnQC
         Ks6ptoafOlEuDN8mHWfqPmRdItnmbqLepx5amkRB2qpqnm2mJZ2VwaceRq84cR96b4Ul
         ThkwImYe1jfE3m/4Yx15p6CrWgqIt3yPRaRh4=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:subject:date:user-agent:cc:references:in-reply-to
         :mime-version:content-type:content-transfer-encoding
         :content-disposition:message-id;
        b=h6UFutZdgbQXHB58zFy63suvzpmTT4ubeeVeUb2tZ0aCvId8H/+6gdl3I7L0uRkXdn
         UqXh3WNAkBBHVhJxp+pYUUNTpF0AA724CEK9kY0s7Tmk81A4lowa430EDmTeUDvFHqdP
         XRCuW/PAAc7EZUljIkR8p1jczXiLNfcg9J2Ig=
Received: by 10.223.79.71 with SMTP id o7mr149879fak.116.1288043802909;
        Mon, 25 Oct 2010 14:56:42 -0700 (PDT)
Received: from [192.168.1.13] (abwi90.neoplus.adsl.tpnet.pl [83.8.232.90])
        by mx.google.com with ESMTPS id r22sm3209661fax.21.2010.10.25.14.56.41
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Mon, 25 Oct 2010 14:56:41 -0700 (PDT)
User-Agent: KMail/1.9.3
In-Reply-To: <1287917136-26103-3-git-send-email-giuseppe.bilotta@gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/159972>

On Sun, 24 Sep 2010, Giuseppe Bilotta wrote:

> =A0sub git_get_heads_list {
> -=A0=A0=A0=A0=A0=A0=A0my $limit =3D shift;
> +=A0=A0=A0=A0=A0=A0=A0my ($limit, @classes) =3D @_;
> +=A0=A0=A0=A0=A0=A0=A0unless (defined @classes) {
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0my $remote_heads =3D gi=
tweb_check_feature('remote_heads');
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0@classes =3D ('heads', =
$remote_heads ? 'remotes' : ());
> +=A0=A0=A0=A0=A0=A0=A0}

defined(@array) is deprecated at t/../gitweb/gitweb.perl line 3221.

Should be simply 'unless (@classes)', or 'unless (scalar @classes)' but
conditionals provide boolean context, which is scalar context.

I'm sorry about missing it earlier.
--=20
Jakub Narebski
Poland
