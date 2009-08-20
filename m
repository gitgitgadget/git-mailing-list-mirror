From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [RFC PATCH v4 00/19] Sparse checkout
Date: Thu, 20 Aug 2009 08:21:03 -0700 (PDT)
Message-ID: <m3ocqamrz6.fsf@localhost.localdomain>
References: <1250776033-12395-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-16be
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: =?utf-8?b?Tmd1eeG7hW4gVGjDoWkgTmfhu40=?= =?utf-8?b?YyBEdXk=?= 
	<pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Thu Aug 20 17:24:01 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Me9UX-0005Fu-Mv
	for gcvg-git-2@lo.gmane.org; Thu, 20 Aug 2009 17:23:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754840AbZHTPVJ convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 20 Aug 2009 11:21:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754772AbZHTPVH
	(ORCPT <rfc822;git-outgoing>); Thu, 20 Aug 2009 11:21:07 -0400
Received: from mail-fx0-f217.google.com ([209.85.220.217]:44618 "EHLO
	mail-fx0-f217.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754835AbZHTPVD convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 20 Aug 2009 11:21:03 -0400
Received: by mail-fx0-f217.google.com with SMTP id 17so511941fxm.37
        for <git@vger.kernel.org>; Thu, 20 Aug 2009 08:21:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:received
         :x-authentication-warning:to:cc:subject:references:from:date
         :in-reply-to:message-id:lines:user-agent:mime-version:content-type
         :content-transfer-encoding;
        bh=2hO2dpxfnoZRo0mXWwVPbVJGM/91pDNSBJwg5QG9GbI=;
        b=vxldgnwrjQt2CpzOakRHJtgE1/V9QrwCFWM328XdWNI7zh+QcWwSBLzpFJ0oohann+
         rJSRRx2GFYxaLaU6ogNcyp79pLkxlV+zYWAz/IPkW9meKi1j39kH6IMwkQKlX9u4cf9R
         Lcz7hnG4nrxinRb0gjtSK7qxWNkoUjPEqab8s=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=x-authentication-warning:to:cc:subject:references:from:date
         :in-reply-to:message-id:lines:user-agent:mime-version:content-type
         :content-transfer-encoding;
        b=kDS9wve0LzVbYiSyRGuVa11qDCAq331+3SzTsGYnGbf+FqO0oU513/gJ0Y8zhYnvP1
         DDWJ3PzkxqU455oHfW+V2dBFPxN/TEVC8DFe01bYx8WJNBiXhsNDtVHeFx9P1HGAKyJN
         rzt8vBJxlMe8WrLDygFpZ+1I2MbrkLbUl6gG8=
Received: by 10.103.64.16 with SMTP id r16mr3092031muk.90.1250781664134;
        Thu, 20 Aug 2009 08:21:04 -0700 (PDT)
Received: from localhost.localdomain (abwr82.neoplus.adsl.tpnet.pl [83.8.241.82])
        by mx.google.com with ESMTPS id j6sm5518609mue.31.2009.08.20.08.21.02
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Thu, 20 Aug 2009 08:21:03 -0700 (PDT)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by localhost.localdomain (8.13.4/8.13.4) with ESMTP id n7KFL2E5031009;
	Thu, 20 Aug 2009 17:21:02 +0200
Received: (from jnareb@localhost)
	by localhost.localdomain (8.13.4/8.13.4/Submit) id n7KFL1vD031006;
	Thu, 20 Aug 2009 17:21:01 +0200
X-Authentication-Warning: localhost.localdomain: jnareb set sender to jnareb@gmail.com using -f
In-Reply-To: <1250776033-12395-1-git-send-email-pclouds@gmail.com>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/126646>

Nguy=FE=FF=1E=C5n Th=FE=FF
> Welcome to the fourth round of sparse checkout this year, dubbed "The
> mummy^W^W^W^W^Wno-checkout returns", although the bit now comes under
> a new name "skip-worktree" [1]. This series has two parts: sparse
> worktree and sparse checkout. Details will be given below.
>=20
> For brave users of this series: I have pushed it to my sparse-checkou=
t
> branch [2] so you can just clone it and test away. Visible changes:
>=20
>  - the spec is now .git/info/sparse-checkout
>  - the spec is positive matching, that is it matches what _is_ in
>    worktree, not what is out of worktree like the last series
>  - you need to set core.sparsecheckout no additional command argument
>    is needed.
[...]

> [1] There are a few reasons behind this rename:
>  - there is nothing about "checkout" in the first part, it's about
>    "sparse worktree"
>  - the double negation issue with "no-" part of "no-checkout"
>  - new name makes cache.h diff align beautifully

Well, on one hand side it is more clear what is checked out,=20
and perhaps more common case of checking out only selected files
is simpler.

On the other hand if it was .git/info/no-checkout or checkout-exclude,
or worktree-exclude, empty file or lack of such file would mean full
checkout.  Then core.sparsecheckout (or core.sparsefile) would be
needed only for performance reasons (no need to examine
checkout-exclude file) even if we decide to ship example file with
comments describing its syntax, in templates/info--checkout-exclude

But that is just bikeshedding, don't let it distract you from the real
issue of this series...

--=20
Jakub Nar=FE=FF=01=19bski

In related news: there is really no question that bike sheds should be
painted red. Really. =20
(Johannes Schindelin, on git mailing list)
