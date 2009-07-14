From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [PATCH 2/3] gitweb: Use "previous" header of git-blame -p in 'blame' view
Date: Tue, 14 Jul 2009 21:21:29 +0200
Message-ID: <200907142121.31012.jnareb@gmail.com>
References: <200907102354.43232.jnareb@gmail.com> <200907102357.43475.jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-2
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Luben Tuikov <ltuikov@yahoo.com>,
	Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jul 14 21:21:53 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MQnZR-0004eU-MZ
	for gcvg-git-2@gmane.org; Tue, 14 Jul 2009 21:21:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755956AbZGNTVi convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 14 Jul 2009 15:21:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755642AbZGNTVh
	(ORCPT <rfc822;git-outgoing>); Tue, 14 Jul 2009 15:21:37 -0400
Received: from mail-bw0-f228.google.com ([209.85.218.228]:53192 "EHLO
	mail-bw0-f228.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754355AbZGNTVh (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 14 Jul 2009 15:21:37 -0400
Received: by bwz28 with SMTP id 28so983140bwz.37
        for <git@vger.kernel.org>; Tue, 14 Jul 2009 12:21:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:subject:date
         :user-agent:cc:references:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:message-id;
        bh=DtfqpgfcLhqQT3O2Ov9hRtEnX9RUEWDOsPRjrcwdZ44=;
        b=wxKNEPFMp8saRZ750mJFjMj3WXnVp9nI8bbJ/2CH+K81OxpRBvMUJm72F371emHaCy
         hvcJbZ8EACNEv2bxVXEuQqCpl3UyevZhAIRoDLhIify5toa8eoJl4OO8U+RGK6rJuz1C
         dutK7jRLu3VLBY0gNiV58xTU3jo2rCs75Tqis=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:subject:date:user-agent:cc:references:in-reply-to
         :mime-version:content-type:content-transfer-encoding
         :content-disposition:message-id;
        b=nEDJ1GZvPLISqgKp0MN6XMI1psWb0RIZ/C0aNHr9GZOyE82yeNNv/bV97q8gY2TyaR
         p/x6pamgL8dJvy19mEkJSqpRp4GjWID9ApPAB2y7U1m/f03gRt/lNep9pa5O7NJIWbwT
         38VEV7Dm66Osy9A6NbOJL1dFza3LPJmKLD1sQ=
Received: by 10.103.168.12 with SMTP id v12mr3611698muo.45.1247599294897;
        Tue, 14 Jul 2009 12:21:34 -0700 (PDT)
Received: from ?192.168.1.13? (abvk144.neoplus.adsl.tpnet.pl [83.8.208.144])
        by mx.google.com with ESMTPS id y6sm11403039mug.40.2009.07.14.12.21.33
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Tue, 14 Jul 2009 12:21:33 -0700 (PDT)
User-Agent: KMail/1.9.3
In-Reply-To: <200907102357.43475.jnareb@gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/123268>

On Fri, 10 July 2009, Jakub Narebski wrote:

> +# if filename is surrounded in double quotes, it need to be unquoted
> +sub unquote_maybe {
> +=A0=A0=A0=A0=A0=A0=A0my $str =3D shift;
> +
> +=A0=A0=A0=A0=A0=A0=A0if ($str =3D~ /^"(.*)"$/) {
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0return unquote($1);
> +=A0=A0=A0=A0=A0=A0=A0}
> +=A0=A0=A0=A0=A0=A0=A0return $str;
> +}

I'm sorry about that, but this is totally unnecessary, as=20
unquote =3D=3D unquote_maybe (unquotes only when necessary).

--=20
Jakub Narebski
Poland
