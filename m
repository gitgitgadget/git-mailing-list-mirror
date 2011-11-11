From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [RFC/PATCH] remote: add new sync command
Date: Fri, 11 Nov 2011 02:35:19 -0800 (PST)
Message-ID: <m3wrb7lzg8.fsf@localhost.localdomain>
References: <1320682032-12698-1-git-send-email-felipe.contreras@gmail.com>
	<20111107172218.GB3621@sigill.intra.peff.net>
	<CAMP44s358k4EsCg+K6MeLEU4eLbb4mWyX9AdAf4P9CHvf9Lrwg@mail.gmail.com>
	<20111107183938.GA5155@sigill.intra.peff.net>
	<CAMP44s0M-qnZeHCUadSJJCYO=t881sUOi11G3fCG2vaAakPyBQ@mail.gmail.com>
	<20111107210134.GA7380@sigill.intra.peff.net>
	<7vhb2f1v7g.fsf@alter.siamese.dyndns.org>
	<CAMP44s0vsQ5sfx8arrRDo+-g9Zff_MmCz5t+yghwCMx_pL4Xzg@mail.gmail.com>
	<7vvcquy05c.fsf@alter.siamese.dyndns.org>
	<CAMP44s0bm+bydNnMWPHpz8B8wMf6XN9LTiiCD-nrYSHGAV5c5Q@mail.gmail.com>
	<7vobwmvuei.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-4
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Felipe Contreras <felipe.contreras@gmail.com>,
	Jeff King <peff@peff.net>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Nov 11 11:35:27 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ROoSE-0003Rz-PZ
	for gcvg-git-2@lo.gmane.org; Fri, 11 Nov 2011 11:35:27 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752616Ab1KKKfW convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 11 Nov 2011 05:35:22 -0500
Received: from mail-fx0-f46.google.com ([209.85.161.46]:46956 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750971Ab1KKKfV convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 11 Nov 2011 05:35:21 -0500
Received: by fagn18 with SMTP id n18so1575893fag.19
        for <git@vger.kernel.org>; Fri, 11 Nov 2011 02:35:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=x-authentication-warning:to:cc:subject:references:from:date
         :in-reply-to:message-id:lines:user-agent:mime-version:content-type
         :content-transfer-encoding;
        bh=2f17DB8V8bZRwHqcQgxb/TGTeHdB242rDbzKtYDttZI=;
        b=sh2PEuzR5CPb2qVNZAIBBUZoIEPFMd/N3UMaWIiH6B/bKL720udhcdXzizv+jhDpPO
         s0bf1q7kDZOInLyQe9anlGfaRm6OEzoiy340VdbzyIbOLvvVaI9sOtN2X1eHR9hdgpqC
         HLSBqUOcoRE7vGmZn+QyzHkK1uarntI7sF0Gk=
Received: by 10.223.7.14 with SMTP id b14mr18700335fab.10.1321007719908;
        Fri, 11 Nov 2011 02:35:19 -0800 (PST)
Received: from localhost.localdomain (abvw113.neoplus.adsl.tpnet.pl. [83.8.220.113])
        by mx.google.com with ESMTPS id l18sm15070226fab.9.2011.11.11.02.35.18
        (version=TLSv1/SSLv3 cipher=OTHER);
        Fri, 11 Nov 2011 02:35:19 -0800 (PST)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by localhost.localdomain (8.13.4/8.13.4) with ESMTP id pABAZ96x009069;
	Fri, 11 Nov 2011 11:35:09 +0100
Received: (from jnareb@localhost)
	by localhost.localdomain (8.13.4/8.13.4/Submit) id pABAYl6E009059;
	Fri, 11 Nov 2011 11:34:47 +0100
X-Authentication-Warning: localhost.localdomain: jnareb set sender to jnareb@gmail.com using -f
In-Reply-To: <7vobwmvuei.fsf@alter.siamese.dyndns.org>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/185263>

Junio C Hamano <gitster@pobox.com> writes:
> Felipe Contreras <felipe.contreras@gmail.com> writes:
>=20
> > Perhaps these 'git remote' commands should be removed in 1.8 then.
>=20
> It is true that it was a long-term goal to deprecate many parts of th=
e
> "git remote" script that started as a hack to scratch itches "git fet=
ch"
> in the older days did not directly scratch for people, e.g. fetching =
from
> multiple remotes in one go.
>=20
> I do not think 1.7.X series to 1.8 is a big enough jump to remove
> duplicated features, though.
=20
I am using "git remote update" to fetch a _subset_ of remotes;
does "git fetch" offers such feature already?

--=20
Jakub Nar=EAbski
