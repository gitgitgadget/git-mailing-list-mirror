From: Renato Botelho <garga@FreeBSD.org>
Subject: Re: Conditionally define vars to improve portability
Date: Tue, 8 Sep 2015 05:19:19 -0300
Message-ID: <36F51AF9-44A7-492B-9EFA-79962B79ADC4@FreeBSD.org>
References: <81961DE1-FA30-4E55-8818-9FCA3BC59B81@FreeBSD.org> <20150908063034.GF26331@sigill.intra.peff.net>
Mime-Version: 1.0 (Mac OS X Mail 8.2 \(2104\))
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Tue Sep 08 10:19:31 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZZE7m-0004lM-4x
	for gcvg-git-2@plane.gmane.org; Tue, 08 Sep 2015 10:19:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753095AbbIHIT0 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 8 Sep 2015 04:19:26 -0400
Received: from mail-qg0-f49.google.com ([209.85.192.49]:33480 "EHLO
	mail-qg0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751952AbbIHITY convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 8 Sep 2015 04:19:24 -0400
Received: by qgev79 with SMTP id v79so76343191qge.0
        for <git@vger.kernel.org>; Tue, 08 Sep 2015 01:19:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:content-type:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=2SKKFOpjXZscZ3sfZaofhpO+S9Xs7v7XHXZSR3MylJw=;
        b=spVGDU1S5KUZj47cm2IiSpfIdhEVP2qXyPHp71dz+oJd68UeMqRykWGul57kq8j3Po
         J1qyIEkqGLXbFPfWeIlxhER0gP7L7LRpFjbxEH5qUiM+w03uoL+1itJ0BXlOVwnAQ5VC
         Yp+hQk+EBFLnM49lxcZy3X2PJsAiFgAOWPupAzG4a+C20JIIfikUvfbhy0WYoph3AisX
         vUcKBNazYtI3BNZnelxguXN6hgoWgoqJjkhX8hXL31rknCzXYPAsVMBgGiigtjdp0/N+
         K5XIsp25SD2LqhQ4yj4y9iylGjt1qIk8tZ3F2sSccTVTFGjcpWRxI5IXWAtenn+4Sk7Y
         JkUg==
X-Received: by 10.140.86.70 with SMTP id o64mr32759972qgd.52.1441700363734;
        Tue, 08 Sep 2015 01:19:23 -0700 (PDT)
Received: from mbp.home (179-125-137-171.desktop.com.br. [179.125.137.171])
        by smtp.gmail.com with ESMTPSA id y63sm1408926qgy.2.2015.09.08.01.19.22
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Tue, 08 Sep 2015 01:19:23 -0700 (PDT)
In-Reply-To: <20150908063034.GF26331@sigill.intra.peff.net>
X-Mailer: Apple Mail (2.2104)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/277496>

> On Sep 8, 2015, at 03:30, Jeff King <peff@peff.net> wrote:
>=20
> On Mon, Sep 07, 2015 at 02:51:42PM -0300, Renato Botelho wrote:
>=20
>> Default variables used to build are set using =3D on Makefile, (e.g.=
 CC,
>> INSTALL, CFLAGS, =E2=80=A6). GNU make overwrite these values if it=E2=
=80=99s passed as
>> an argument (make CC=3Dclang) and it works as expected.
>>=20
>> Default method of passing arguments for make operations on FreeBSD
>> ports tree is using environment variables instead of make arguments,
>> then we have CC set on env before call gmake. Today these values are
>> ignored by git Makefile, and we ended up patching Makefile replacing=
 =3D
>> by ?=3D on variable assignments [1].
>=20
> Hmm. I can't really think of a downside to doing so, unless we expect
> users to have things like CC set in the environment and _not_ want th=
em
> to bleed through to our build.
>=20
> But doesn't "gmake -e" solve your problem without a patch?

Good idea, let me try it=E2=80=A6 :)

--
Renato Botelho
