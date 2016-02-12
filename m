From: =?iso-8859-1?Q?V=EDt_Novotn=FD?= <witiko@gmail.com>
Subject: Re: `.git` symlink makes `git submodule add` fail
Date: Fri, 12 Feb 2016 19:36:47 +0100
Message-ID: <20160212183646.GA6261@witiko>
References: <20160212164853.GA6888@witiko>
 <xmqqio1tvlzu.fsf@gitster.mtv.corp.google.com>
 <xmqq60xtvlj9.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Feb 12 19:36:57 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aUIaO-0008NB-E0
	for gcvg-git-2@plane.gmane.org; Fri, 12 Feb 2016 19:36:56 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752612AbcBLSgw convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 12 Feb 2016 13:36:52 -0500
Received: from mail-wm0-f50.google.com ([74.125.82.50]:34185 "EHLO
	mail-wm0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752511AbcBLSgv (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 12 Feb 2016 13:36:51 -0500
Received: by mail-wm0-f50.google.com with SMTP id 128so73595179wmz.1
        for <git@vger.kernel.org>; Fri, 12 Feb 2016 10:36:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=wEdpK/DH78Lyina4wO2D1kS3O4Jq8ux2xosug7bmnEs=;
        b=tkkpwspm/E+ifVdsQGqEvOnxMgxpfB5rM3AJ63ouC59rxCrjApVAPZW24CBpu5H+MB
         hg/Xy0CgVhS0nGLCwi/yyrnbd75ZophNRVP0nrEfDkyljK41vU9qvJ5xQbr45XJrBJla
         XsvdWz47ivUQuduqp2V08JhqbFyhDpPgJjW3776OZH72+tPv/KAe6nDEfo3SQrkDD+mO
         /APZ36mKd03PWbPq99PpL10jAaLcWAROQUh+wtOAGcSuE+teIH+BZ4Y2msJGLmTfNH7i
         3MVUcvyUExhIb2cBtRI9GYoG9bIZzs3aMvuWL+guHGX77Z6XNLC7L47X03p0SlRLFNOU
         GKLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-type:content-disposition
         :content-transfer-encoding:in-reply-to:user-agent;
        bh=wEdpK/DH78Lyina4wO2D1kS3O4Jq8ux2xosug7bmnEs=;
        b=NzVjpHtcpanXvQXPQYX9vqYWKvl3N1J2ncq9VcNwsUTZqjZaYzNnTGQfmYEO9NdZQR
         HqUUMos4dLRFZBpo/xXO42t3fqmDgQ5FFR8s+F/eJ7FP7m4Fxy0qHSuk4O7B5Pr3F/Tw
         6D2qcoVjFgdCbzkYEuwF8DHXws8Jl6X7WVfCneh1KiWuZENqobzpRB2oRzkH8W3iEerX
         q1N2EP2JJ2I9n4Y8o49bN1qulmPsGJ/kIlv6jihb4AP6gBZOgeTxE9HM4stpeJ7k/KPX
         sWS1TDHiNTCI3uzDg2JLkNwCAXoBcKwfFwkqvawHCk335BQABcZOkRJzK2QRgqbBYAnG
         GmgA==
X-Gm-Message-State: AG10YOQnjwDZy/XECZbUAfg+5XOxr0sTzCaVhjHD6vjQ0DkDwN1IhkIqOHL1lEik0N5siQ==
X-Received: by 10.194.61.42 with SMTP id m10mr3215806wjr.126.1455302210591;
        Fri, 12 Feb 2016 10:36:50 -0800 (PST)
Received: from witiko (dynamic-2a00-1028-8d1c-ac1a-021f-3cff-fe2d-27ad.ipv6.broadband.iol.cz. [2a00:1028:8d1c:ac1a:21f:3cff:fe2d:27ad])
        by smtp.gmail.com with ESMTPSA id os7sm13257010wjc.18.2016.02.12.10.36.49
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 12 Feb 2016 10:36:49 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <xmqq60xtvlj9.fsf@gitster.mtv.corp.google.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/286065>

On Fri, Feb 12, 2016 at 10:19:38AM -0800, Junio C Hamano wrote:
> Junio C Hamano <gitster@pobox.com> writes:
>=20
> > V=EDt Novotn=FD <witiko@gmail.com> writes:
> >
> >> Is this a bug, or is the ability to symlink `.git` just a happy co=
incidence?
> >
> > It has never been supported.
>=20
> Oops, hit "send" too early.
>=20
> We have support for a "gitdir:" facility that would work even on a
> filesystem that cannot do symlinks (see gitrepository-layout(5)),
> and both the higher-level submodule Porcelain and the more recent
> "worktree" experimental code do use it.
>=20

That sounds ideal, thank you for letting me know. Still, I believe that
well-behaved applications should be indifferent to symlinks, unless the
distinction is significant. Would there be any objections, if I
submitted a patch / series of patches that would add proper symlink
support?
