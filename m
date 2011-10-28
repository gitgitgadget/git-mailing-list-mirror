From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [RFC/PATCH] define the way new representation types are encoded in the pack
Date: Fri, 28 Oct 2011 06:41:57 -0700 (PDT)
Message-ID: <m3wrbp44kr.fsf@localhost.localdomain>
References: <7v62j9veh3.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-4
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Nicolas Pitre <nico@fluxnic.net>,
	"Shawn O. Pearce" <spearce@spearce.org>, Jeff King <peff@peff.net>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Oct 28 15:42:10 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RJmhF-0005tj-EN
	for gcvg-git-2@lo.gmane.org; Fri, 28 Oct 2011 15:42:09 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754000Ab1J1NmA convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 28 Oct 2011 09:42:00 -0400
Received: from mail-ey0-f174.google.com ([209.85.215.174]:52875 "EHLO
	mail-ey0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751578Ab1J1Nl7 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 28 Oct 2011 09:41:59 -0400
Received: by eye27 with SMTP id 27so3526860eye.19
        for <git@vger.kernel.org>; Fri, 28 Oct 2011 06:41:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=x-authentication-warning:to:cc:subject:references:from:date
         :in-reply-to:message-id:lines:user-agent:mime-version:content-type
         :content-transfer-encoding;
        bh=XE4h1xGcWptOnhK8knSlg3jxksewcL3EmwzCe3K0Zms=;
        b=ncyExNLRW8f/rdQ9Cj+zLdr8oLDmSuCbEjjZjwcMlW0i8GKVJ+MEJm6A3fFg/dRz3U
         5S6UwPb6lRiPV9AMxJV05fSinqTbX0bhRwNklU6PLx87lZIw0tkJcxu1vkKrUVlfmzia
         WBY8eTr0fWUCu2liykwEylNYUsukXeCCAVldI=
Received: by 10.14.17.155 with SMTP id j27mr274388eej.195.1319809318523;
        Fri, 28 Oct 2011 06:41:58 -0700 (PDT)
Received: from localhost.localdomain (abvy192.neoplus.adsl.tpnet.pl. [83.8.222.192])
        by mx.google.com with ESMTPS id z58sm24814050eea.3.2011.10.28.06.41.56
        (version=TLSv1/SSLv3 cipher=OTHER);
        Fri, 28 Oct 2011 06:41:57 -0700 (PDT)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by localhost.localdomain (8.13.4/8.13.4) with ESMTP id p9SDf9B8032387;
	Fri, 28 Oct 2011 15:41:19 +0200
Received: (from jnareb@localhost)
	by localhost.localdomain (8.13.4/8.13.4/Submit) id p9SDea70032376;
	Fri, 28 Oct 2011 15:40:36 +0200
X-Authentication-Warning: localhost.localdomain: jnareb set sender to jnareb@gmail.com using -f
In-Reply-To: <7v62j9veh3.fsf@alter.siamese.dyndns.org>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/184409>

Junio C Hamano <gitster@pobox.com> writes:

> When bit 4-6 encodes type 5, the first byte is used this way:
>=20
>  - Bit 0-3 denotes the real "extended" representation type. Because t=
ypes
>    0-7 can already be encoded without using the extended format, we c=
an
>    offset the type by 8 (i.e. if bit 0-3 says 3, it means representat=
ion
>    type 11 =3D 3 + 8);

Why not use third byte for that instead?

--=20
Jakub Nar=EAbski
