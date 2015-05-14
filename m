From: Konstantin Ryabitsev <konstantin@linuxfoundation.org>
Subject: Re: Clone hangs when done over http with --reference
Date: Thu, 14 May 2015 13:08:46 -0400
Organization: Linux Foundation
Message-ID: <5554D69E.20307@linuxfoundation.org>
References: <20150513210436.GA7407@gmail.com> <20150514004724.GA3059@peff.net>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="4qFXg9O7OgnQokubdGOkc58Ie1vVKqqRD"
Cc: git@vger.kernel.org
To: peff@peff.net
X-From: git-owner@vger.kernel.org Thu May 14 19:08:58 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Yswd0-0003ZL-5p
	for gcvg-git-2@plane.gmane.org; Thu, 14 May 2015 19:08:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933244AbbENRIy (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 14 May 2015 13:08:54 -0400
Received: from mail-ig0-f172.google.com ([209.85.213.172]:33197 "EHLO
	mail-ig0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933011AbbENRIw (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 14 May 2015 13:08:52 -0400
Received: by igbpi8 with SMTP id pi8so15633037igb.0
        for <git@vger.kernel.org>; Thu, 14 May 2015 10:08:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=message-id:date:from:organization:user-agent:mime-version:to:cc
         :subject:references:in-reply-to:content-type;
        bh=o9/aQhth20pQft6VPCWMHl8NIZc7zxLCEVT/g29BCSs=;
        b=Sb2taGuuDtwD13fE1wKrBc4J4p8sPeXcgPmpgzalgK2NgCMYzODgUzi34DzRmzKU1q
         6mcf7Va+yswAlTnEppCsjEZz0HpdqeJ66iMsf2yqXLF4s7a9k/2m57HD/+jOOB5W/7Ui
         WEnymS/e3w3ahPBNl7c2/wYXRLq9rLu/2IlWI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:message-id:date:from:organization:user-agent
         :mime-version:to:cc:subject:references:in-reply-to:content-type;
        bh=o9/aQhth20pQft6VPCWMHl8NIZc7zxLCEVT/g29BCSs=;
        b=X94Zdc0usjVfyulYk6KOhlcFtTBipnYTRPOOkB1qUDxjAr3UF5vlBFyUdVFfaalSb3
         YeoL53eooQ1I22x7MntpAqzlCXeTLq3UwIDGXHdrKDpJrbdqSYuLhiG8dE35RcyBlTWm
         mk+C1xqFs7WQFN5RdM6zBb1yrP9aPv3mbGCO9RFGlDUMD84hXBJBHkeao2RD5QLxmw7U
         ISdAfBUsF1Jh6IB6amzsheBjKCuery1x1VnaJ6WnapxTucAxeTEMbpBx1mrYudgHIXtZ
         bYN+9GpKqNJce65cu/KzC6NZHP/OsSaK+jAzwsmAq9EYeyzqzWjBKx2boSLRauteYY5E
         d+hA==
X-Gm-Message-State: ALoCoQmQ4w9aonpFbBDAda6LF+AkDNJKFOIEeVFonB/CpxV56m3gyV+iKdU5ZmWiO0yejsBY38DG
X-Received: by 10.50.43.194 with SMTP id y2mr14386050igl.35.1431623332283;
        Thu, 14 May 2015 10:08:52 -0700 (PDT)
Received: from ada.mricon.com (198-84-251-213.cpe.teksavvy.com. [198.84.251.213])
        by mx.google.com with ESMTPSA id v14sm6237297igd.12.2015.05.14.10.08.51
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 14 May 2015 10:08:51 -0700 (PDT)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:31.0) Gecko/20100101 Thunderbird/31.6.0
In-Reply-To: <20150514004724.GA3059@peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/269047>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--4qFXg9O7OgnQokubdGOkc58Ie1vVKqqRD
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 13/05/15 08:47 PM, Jeff King wrote:
> I don't know if there's a way to convince Apache to be more interactive=
=2E
> As a hacky workaround, we could basically spool all of the input into
> memory (or a tempfile) and work from that. Or the output. Either way
> would break the pipe deadlock. But we'd have to be sensitive to the typ=
e
> of request (it's probably OK to spool ref negotiation, but not OK to
> spool packfiles, which can be arbitrarily big).

Thanks for looking into this, Jeff.

Two questions:

1. Does this mean there are potential problems with other git operations
that involve ref negotiation, not just when doing git clone --reference?
Is there a chance to run in to this deadlock by doing an operation like
"git remote update"?

2. If we configure the webserver to serve some files directly, without
passing them to http-backend, e.g. doing the recommended apache magic:

> AliasMatch ^/git/(.*/objects/[0-9a-f]{2}/[0-9a-f]{38})$          /var/l=
ib/git/$1
> AliasMatch ^/git/(.*/objects/pack/pack-[0-9a-f]{40}.(pack|idx))$ /var/l=
ib/git/$1
> AliasMatch ^/git/(.*/refs/heads/.*)$                             /var/l=
ib/git/$1

Will that make the spooling less of a problem, since it won't involve
the super-huge files?

Best,
-Konstantin


--4qFXg9O7OgnQokubdGOkc58Ie1vVKqqRD
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEcBAEBCAAGBQJVVNaeAAoJEDZgaZyZ4FVXvYEIAMP6JtrjeccZFuOHKPeFbS09
/qG9YlSSWxkoXg9/V5viabDUkxLeE4Z3ciCvZxAy13vCPKmg2xOOX33P0+5EBqwb
SYH0LcM3pJJBi1Rh8YXog03MR4xnSgPwXbCe3cgv4ZvW2+Bf26F8b06u95SIDzCF
dP6/3DI8Vd4Yv7jmmndXOgPVQ68tkafhglDx/WwjYtix/0+U6zeb9zclE/Kipez6
psTwo7vex9ZhO7pucKyuxSoBEMeEV0G6ox3Z9ilMn1LQAESx3f5DOxeXltQ+XkPV
0evgfttnCanfdsGkmmF3jV8k1YdRzn1ZlRhpk7GLE35w1fk1vgiBtdJnAYF8ucY=
=Rtls
-----END PGP SIGNATURE-----

--4qFXg9O7OgnQokubdGOkc58Ie1vVKqqRD--
