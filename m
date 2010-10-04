From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCHv6 16/16] Introduce portable_unset and use it to ensure
 proper && chaining
Date: Sun, 3 Oct 2010 23:44:02 -0500
Message-ID: <20101004044402.GF24884@burratino>
References: <1286136014-7728-1-git-send-email-newren@gmail.com>
 <1286136014-7728-17-git-send-email-newren@gmail.com>
 <AANLkTinU_fv7pJqw_ghM4RoF6dsiV8PFM3GgCqD-hh7L@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Elijah Newren <newren@gmail.com>, git@vger.kernel.org,
	gitster@pobox.com, Sverre Rabbelier <srabbelier@gmail.com>
To: =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
X-From: git-owner@vger.kernel.org Mon Oct 04 06:47:33 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1P2cxY-000256-Lk
	for gcvg-git-2@lo.gmane.org; Mon, 04 Oct 2010 06:47:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751514Ab0JDErT convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 4 Oct 2010 00:47:19 -0400
Received: from mail-yx0-f174.google.com ([209.85.213.174]:43853 "EHLO
	mail-yx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751341Ab0JDErT convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 4 Oct 2010 00:47:19 -0400
Received: by yxp4 with SMTP id 4so1550848yxp.19
        for <git@vger.kernel.org>; Sun, 03 Oct 2010 21:47:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :content-transfer-encoding:in-reply-to:user-agent;
        bh=dfvHg5dn6TuCxhoiYotVQqmgIdldtMcZA8dddjmgdYc=;
        b=fnsD0uvdgL4nasdvelyhFVOQ/jzAKPoLriUGL9KPD377jUTQsxf6LPNq3JNS2w6eKh
         a8abr+p+AZq6KVJWk8rUGq8RG+PXDpu4gtfBTXtq1X/gO4P9zCeHSJ9a/0G9Z+tURZwR
         m6RmmFWvoKK8SLMe/FEFnCNKxFiD4D3yKi5Hk=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        b=mhZR/tfW9fsytD/5SSsPJYOlyoGpUW4NuiW4BfWW4Rl0q7Q+Ey/Fon3Jy2mKMOIHlv
         pZXXpx5R7AGwPXWxOJ2rAOlsKs2iXTUcfxK/nTjSGP880gk4oF0O2mGoZ7pwgIKAACqR
         9S1dAgZEHE0Wsln9RzUgeDbH2jzN9zoVSyFwM=
Received: by 10.100.127.1 with SMTP id z1mr4932902anc.41.1286167636529;
        Sun, 03 Oct 2010 21:47:16 -0700 (PDT)
Received: from burratino ([68.255.106.176])
        by mx.google.com with ESMTPS id k11sm8396004ani.10.2010.10.03.21.47.15
        (version=SSLv3 cipher=RC4-MD5);
        Sun, 03 Oct 2010 21:47:15 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <AANLkTinU_fv7pJqw_ghM4RoF6dsiV8PFM3GgCqD-hh7L@mail.gmail.com>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/157975>

=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason wrote:

>                         I don't know if we came to an agreement on
> using test_might_fail for non-builtins

Non-builtins: okay.
Non-git commands: no.

That's just my take, though; if the project consensus is different,
who am I to resist it?

> but the docs on do's & dont's
> should mention how to do that

Is it common to need to do

	{
		grep dontknowifitwillmatch file >result ||
		true
	}

for commands other than unset?  If so, then I guess we should adopt
Sverre's cmd_might_fail to make it less noisy, anyway.

> and portable_unset should be documented
> in a new section in "Test harness library".

Yes, that sounds good.
