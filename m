From: Mark Levedahl <mlevedahl@gmail.com>
Subject: Re: [PATCH 3/3] git-checkout.txt: a note about multiple checkout
 support for submodules
Date: Sun, 04 Jan 2015 22:43:39 -0500
Message-ID: <54AA086B.9070309@gmail.com>
References: <1420278087-14613-1-git-send-email-pclouds@gmail.com> <1420278087-14613-4-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>, Max Kirillov <max@max630.net>,
	Jens Lehmann <Jens.Lehmann@web.de>
To: =?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41jIER1eQ==?= 
	<pclouds@gmail.com>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Jan 05 04:43:50 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Y7ya6-0003CA-97
	for gcvg-git-2@plane.gmane.org; Mon, 05 Jan 2015 04:43:50 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752873AbbAEDnq convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 4 Jan 2015 22:43:46 -0500
Received: from mail-qc0-f174.google.com ([209.85.216.174]:56784 "EHLO
	mail-qc0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752827AbbAEDnp (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 4 Jan 2015 22:43:45 -0500
Received: by mail-qc0-f174.google.com with SMTP id c9so14830465qcz.19
        for <git@vger.kernel.org>; Sun, 04 Jan 2015 19:43:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-type:content-transfer-encoding;
        bh=Ve3rzHAPCRPXAKrkp/5bc4rAgLKpsvr5UuKdj4Xtg7A=;
        b=LAYMAz1Dfq5jLs1emyEfNSLw44Q63MdPBlR8VNopJStlRYIiSU31N0Pay9P/77v87I
         VEhhz7/s/tyUeJBU9mxBAEMaFImZczteNznutI2yleCj1nmgq0KKecu8v00CXm6R4r+R
         NAtcsdSCXDr/3wF4hNtM9T86KmI7Fkw3YY68BVpEvoe3tpuJanTRhrukFSE0YIn5h7Sc
         M3b9pk7dgF+BMCZdqCWLXuTNdToITl3a9us0xrJwJh+X9ux/xjeEiF0pcigj8ydTz7NE
         wFL1NxbR++hNNLFTqp9C1DgMplrjYDicVv5FXJM8xAlzVJc+6t9xIcVV0fXGeIuEk05l
         aSzw==
X-Received: by 10.224.55.145 with SMTP id u17mr141759114qag.12.1420429424733;
        Sun, 04 Jan 2015 19:43:44 -0800 (PST)
Received: from marklaptop.lan (pool-173-79-124-96.washdc.fios.verizon.net. [173.79.124.96])
        by mx.google.com with ESMTPSA id w63sm31367260qgd.44.2015.01.04.19.43.42
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 04 Jan 2015 19:43:43 -0800 (PST)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:31.0) Gecko/20100101 Thunderbird/31.3.0
In-Reply-To: <1420278087-14613-4-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/262014>

On 01/03/2015 04:41 AM, Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy wrote=
:
> The goal seems to be using multiple checkouts to reduce disk space.
> But we have not reached an agreement how things should be. There are =
a
> couple options.
>
>   - You may want to keep $SUB repos elsewhere (perhaps in a central
>     place) outside $SUPER. This is also true for nested submodules
>     where a superproject may be a submodule of another superproject.
>
>
This is my preference: I keep a tree of bare git repos outside of all=20
work areas, and use new-workdir to create trees of workdirs as needed. =
I=20
explored trying to keep $SUB repos in others (including mods to=20
submodule / new-workdir to manage this), found this really leads to too=
=20
much complication compared to just having a set of bare repos elsewhere=
=2E=20
This bare repo approach also has the advantage that no particular=20
workdir is special, all workdirs that point to the same gitdir are equa=
l.

Mark
