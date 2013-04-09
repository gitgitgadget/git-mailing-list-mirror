From: =?UTF-8?B?SmFrdWIgTmFyxJlic2tp?= <jnareb@gmail.com>
Subject: Re: [PATCH] t3700 (add): add failing test for add with submodules
Date: Tue, 09 Apr 2013 13:43:16 +0200
Message-ID: <5163FED4.8070403@gmail.com>
References: <CACsJy8BAQUms9sgNh5_VFOx0_9LkobytjDk33VB+U_J-S44o_A@mail.gmail.com> <1365416809-4396-1-git-send-email-artagnon@gmail.com> <20130408213006.GD9649@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Ramkumar Ramachandra <artagnon@gmail.com>,
	Duy Nguyen <pclouds@gmail.com>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Git List <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>,
	Linus Torvalds <torvalds@linux-foundation.org>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Tue Apr 09 13:43:37 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UPWxa-0007iC-81
	for gcvg-git-2@plane.gmane.org; Tue, 09 Apr 2013 13:43:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S936614Ab3DILnY convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 9 Apr 2013 07:43:24 -0400
Received: from mail-ea0-f177.google.com ([209.85.215.177]:58248 "EHLO
	mail-ea0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758623Ab3DILnW (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 9 Apr 2013 07:43:22 -0400
Received: by mail-ea0-f177.google.com with SMTP id q14so2752123eaj.22
        for <git@vger.kernel.org>; Tue, 09 Apr 2013 04:43:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:message-id:date:from:user-agent:mime-version:to:cc
         :subject:references:in-reply-to:content-type
         :content-transfer-encoding;
        bh=VXlPJcU1wLu0quMtF9mxAmhBW9HP+LHRX+fyGr4HlNQ=;
        b=ndtHGs3aTKXbtF/Z61g+69VkefRJDQ8GkHa+DzjC/ZpAxCLmOnMzC+Zi5Z9rBls5Fm
         Qvt95xtAaHiOB8XVccG7ZbayU9eERf+rrj/4A4xULzbPF8j9sVV4PGwSF1hLB4TzAWqO
         CUCrZP0v7ti1F6vxoVwEI/NTJOf4K+GzzkgzDIP7oD7NZ4+OOlEfOJczonXSyFhJ8StQ
         27FjFjWwXV76RMOFrPDiog83kGkoFsqiiguMVZHtbH4ba3fiJRaMb/UfgSfsLrcDp/xE
         AGNawv7FAlRaAIZEJeR4Ib8Z4J7lbBWbBnyjVb3RSwCGkK1SIT8LfH7rp3FLIs8N8K/b
         4E3g==
X-Received: by 10.14.214.65 with SMTP id b41mr641187eep.37.1365507801532;
        Tue, 09 Apr 2013 04:43:21 -0700 (PDT)
Received: from [192.168.1.14] (eio154.neoplus.adsl.tpnet.pl. [83.21.130.154])
        by mx.google.com with ESMTPS id d47sm37502226eem.9.2013.04.09.04.43.18
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Tue, 09 Apr 2013 04:43:20 -0700 (PDT)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:17.0) Gecko/20130308 Thunderbird/17.0.4
In-Reply-To: <20130408213006.GD9649@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/220562>

W dniu 08.04.2013 23:30, Jeff King pisze:
> On Mon, Apr 08, 2013 at 03:56:49PM +0530, Ramkumar Ramachandra wrote:
>=20
>> git add currently goes past submodule boundaries.  Document this bug=
=2E
>=20
> It's not just submodules, but we should not recurse into any
> sub-repository. If I have an unrelated Meta/ repository, I should not=
 be
> able to "git add Meta/foo", whether I have used "git submodule" or no=
t.
>=20
> This topic came about 2 years ago, and I had a quick-and-dirty patch:
>=20
>   http://thread.gmane.org/gmane.comp.version-control.git/170937/focus=
=3D171040
>=20
> I do not recall anything about the patch at this point (i.e., whether=
 it
> was the right thing), but maybe it is a good starting point for someb=
ody
> to look into it.

Hmmm... I used to do (and still do) such not-recommended thing,
i.e. keeping git/gitweb/TODO etc. in git/gitweb/.git repository,
while having git/gitweb/gitweb.perl in git/.git repository.

So my (admittedly strange) setup will stop working?

--=20
Jakub Nar=C4=99bski
