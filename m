From: Giuseppe Bilotta <giuseppe.bilotta@gmail.com>
Subject: Re: [PATCH/RESEND] gitweb: Fix snapshots requested via PATH_INFO
Date: Wed, 15 Apr 2009 13:29:27 +0200
Message-ID: <cb7bb73a0904150429l7c9910aer847464add60ee345@mail.gmail.com>
References: <20090414104648.GA36554444@CIS.FU-Berlin.DE>
	 <7vvdp6xvv3.fsf@gitster.siamese.dyndns.org>
	 <cb7bb73a0904150233wfa72b1fn85692f81880f6848@mail.gmail.com>
	 <20090415100955.GA33221014@CIS.FU-Berlin.DE>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: Giuseppe Bilotta <giuseppe.bilotta@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	Jakub Narebski <jnareb@gmail.com>,
	Git List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Wed Apr 15 13:31:12 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Lu3Ka-0007AS-UR
	for gcvg-git-2@gmane.org; Wed, 15 Apr 2009 13:31:05 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754253AbZDOL3c convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 15 Apr 2009 07:29:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753003AbZDOL3b
	(ORCPT <rfc822;git-outgoing>); Wed, 15 Apr 2009 07:29:31 -0400
Received: from mail-ew0-f165.google.com ([209.85.219.165]:58640 "EHLO
	mail-ew0-f165.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752841AbZDOL33 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 15 Apr 2009 07:29:29 -0400
Received: by ewy9 with SMTP id 9so3162925ewy.37
        for <git@vger.kernel.org>; Wed, 15 Apr 2009 04:29:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:content-type
         :content-transfer-encoding;
        bh=2ouexYlFNzmV5RKuYxmmMOuh1ahck+HOF42xJ4wftq8=;
        b=G0bJZUAnA+2lcX1IYneSjIZDI4Wu0Z35rvdFp1QoM4aJeb+5NkGWAqsEZw6UdFCKlt
         FjofuzmYL7epu2cKGFdnSS2eWb+hkl5BNCoa/vdhvLnwfLP/Sm43EH67U1rd4mq64eTR
         l91VMgKxwvPYThS4Im9LbGIMsnA7cP3/yoPSY=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :content-type:content-transfer-encoding;
        b=ZG8rusKgzlJxTPOUNn6KXRRZJjLZLSoNHCkFagwXMCftWGos7NC7YIaYSSdivvfdSl
         XCmwxfvOuge72FAUmLs16QRszX+twSRNYturqMwu+IookWn6LvyOO51r2J5RIaS5ZUuL
         2TFEtHGKxxyetwJ9SgMVTIGeEDAK3EDjdRzAY=
Received: by 10.210.111.5 with SMTP id j5mr97371ebc.97.1239794967261; Wed, 15 
	Apr 2009 04:29:27 -0700 (PDT)
In-Reply-To: <20090415100955.GA33221014@CIS.FU-Berlin.DE>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/116603>

2009/4/15 Holger Wei=DF <holger@zedat.fu-berlin.de>:
> * Giuseppe Bilotta <giuseppe.bilotta@gmail.com> [2009-04-15 11:33]:

>> My gitweb over at http://git.oblomov.eu/ supports snapshots with
>> PATH_INFO just fine even without the need for this patch.
>
> Really? =A0If I try to download a snapshot from your site, I get an e=
mpty
> tarball (and the server appends an additional ".tar.gz" suffix to the
> filename within the "Content-disposition" header). =A0For example:
>
> $ wget -q -O - http://git.oblomov.eu/git/snapshot/v1.6.2.3.tar.gz | g=
zip -d | tar -t | wc -l
> 0
>
> That's the bug which is fixed by my patch.

This gets weirder and weirder. I'm seeing the same behaviour with your
patch. I think I busted something the upgrade I was running this
morning. Even git archive on the command line gives me an empty tar.

I have no idea what happened. I rebuilt and reinstalled git and now
it's working again, and I see the problem too, and yes your patch
fixes it.

--=20
Giuseppe "Oblomov" Bilotta
