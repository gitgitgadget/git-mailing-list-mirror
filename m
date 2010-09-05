From: Pascal Obry <pascal.obry@gmail.com>
Subject: Re: [PATCH v2 3/3] New send-email option smtpserveroption.
Date: Sun, 05 Sep 2010 09:15:23 +0200
Organization: Home - http://www.obry.net
Message-ID: <4C83438B.4010701@obry.net>
References: <1283630128-3472-1-git-send-email-pascal@obry.net>	<1283630128-3472-4-git-send-email-pascal@obry.net> <AANLkTinvos_65kb2uO9bTpRAaCeN+N63-KsMmARadt=3@mail.gmail.com>
Reply-To: pascal@obry.net
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
X-From: git-owner@vger.kernel.org Sun Sep 05 09:15:10 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Os9RW-0007sq-Dd
	for gcvg-git-2@lo.gmane.org; Sun, 05 Sep 2010 09:15:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752644Ab0IEHPD convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 5 Sep 2010 03:15:03 -0400
Received: from mail-wy0-f174.google.com ([74.125.82.174]:46923 "EHLO
	mail-wy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752467Ab0IEHPB (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 5 Sep 2010 03:15:01 -0400
Received: by wyf22 with SMTP id 22so1749278wyf.19
        for <git@vger.kernel.org>; Sun, 05 Sep 2010 00:15:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:reply-to
         :organization:user-agent:mime-version:to:cc:subject:references
         :in-reply-to:x-enigmail-version:content-type
         :content-transfer-encoding;
        bh=K7EQ2jLHDzlB4lf8nd9k780lmAnj34iy5V+gZEuGki0=;
        b=NWZdT6ALz6DqwNSiQM/Aazh7LewbnxjHf7y0bkKhi/KsA10MPC/FWblCzEM2vUg9hl
         nW00le6XPpzezTs/INBtBWShPSLUd0k4DMgAA/eVfbC18a0dLlcgZDwcRT/Bq6deLuJ0
         RdXQ6p8nWGrbbw1cXVjiIh1gSzvOR2HMsxvQA=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:reply-to:organization:user-agent:mime-version
         :to:cc:subject:references:in-reply-to:x-enigmail-version
         :content-type:content-transfer-encoding;
        b=iQITLLYwsSSgV+/RCtAP52d9qvnaVagYO/jJ4ZaV1w+TM9DfkEjYkiLeTji9NpKzDN
         Q3HHILv/t5qtlBfbI+aEW/R/PWxdQt7DKKZSDYMZKxPFPgoLkTIznRHyIBmfj3/Ns5rK
         EumkIqAIz2mefCSn1KhHOP9E0npDrC7agJFbo=
Received: by 10.216.6.195 with SMTP id 45mr1786060wen.86.1283670900027;
        Sun, 05 Sep 2010 00:15:00 -0700 (PDT)
Received: from [192.168.0.100] (AVelizy-154-1-100-4.w90-2.abo.wanadoo.fr [90.2.58.4])
        by mx.google.com with ESMTPS id p82sm2441052weq.3.2010.09.05.00.14.58
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sun, 05 Sep 2010 00:14:59 -0700 (PDT)
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 6.0; fr-FR; rv:1.8.1.22) Gecko/20090605 Thunderbird/2.0.0.22 Mnenhy/0.7.5.0
In-Reply-To: <AANLkTinvos_65kb2uO9bTpRAaCeN+N63-KsMmARadt=3@mail.gmail.com>
X-Enigmail-Version: 1.1.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/155447>

=C3=86var,

>> +       unshift (@sendmail_parameters, @smtp_server_options);
>> +
>=20
> It just seems iffy to not be able to provide options without having
> the sendmail_parameters. Or maybe all usecases for this involve a
> program that takes sendmail-like arguments, so this isn't an issue.

As far as I understand sendmail_parameters is always used and set:

	my @sendmail_parameters =3D ('-i', @recipients);

This is even documented:

--smtp-server=3D<host>::
	If set, specifies the outgoing SMTP server to use (e.g.
	`smtp.example.com` or a raw IP address).  Alternatively it can
	specify a full pathname of a sendmail-like program instead;
	the program must support the `-i` option.  Default value can
	be specified by the 'sendemail.smtpserver' configuration
	option; the built-in default is `/usr/sbin/sendmail` or
	`/usr/lib/sendmail` if such program is available, or
	`localhost` otherwise.

--=20

--|------------------------------------------------------
--| Pascal Obry                           Team-Ada Member
--| 45, rue Gabriel Peri - 78114 Magny Les Hameaux FRANCE
--|------------------------------------------------------
--|    http://www.obry.net  -  http://v2p.fr.eu.org
--| "The best way to travel is by means of imagination"
--|
--| gpg --keyserver keys.gnupg.net --recv-key F949BD3B
