From: Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH 5/6] t1500: avoid setting environment variables outside of tests
Date: Tue, 10 May 2016 17:19:19 -0400
Message-ID: <CAPig+cRhaum3V0YPUFKBwySANr060GwtRUzfRV9fuQaN60pMgw@mail.gmail.com>
References: <20160510052055.32924-1-sunshine@sunshineco.com>
	<20160510052055.32924-6-sunshine@sunshineco.com>
	<20160510183955.GA16211@sigill.intra.peff.net>
	<CAPig+cRR49iJOkaLfynkvch4zUHVkpcJwVah0rvaEOeR7aY2Nw@mail.gmail.com>
	<CAPig+cTtU9_3=2eu0boaPbXKXh2gngEe7byDpJuSFAR4rcbrMA@mail.gmail.com>
	<20160510230111.Horde.JpLRouwWbSCYp7yuvqhy5SS@webmail.informatik.kit.edu>
	<xmqqtwi5mxeh.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?Q?SZEDER_G=C3=A1bor?= <szeder@ira.uka.de>,
	Jeff King <peff@peff.net>, Git List <git@vger.kernel.org>,
	Michael Rappazzo <rappazzo@gmail.com>,
	Duy Nguyen <pclouds@gmail.com>,
	Johannes Sixt <j.sixt@viscovery.net>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue May 10 23:19:28 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1b0F3w-0006RW-63
	for gcvg-git-2@plane.gmane.org; Tue, 10 May 2016 23:19:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751479AbcEJVTU convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 10 May 2016 17:19:20 -0400
Received: from mail-io0-f195.google.com ([209.85.223.195]:34146 "EHLO
	mail-io0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751262AbcEJVTU convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 10 May 2016 17:19:20 -0400
Received: by mail-io0-f195.google.com with SMTP id d62so3237606iof.1
        for <git@vger.kernel.org>; Tue, 10 May 2016 14:19:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc:content-transfer-encoding;
        bh=Qc5hfXuJ/r4VQB8SqZLLspQSh/OxW4zt34r8vDksnCk=;
        b=IBnfcDJ2KQju6HCn+OPtIJ19CRLEkbc339Xejg4r0D+dnNM8Iw8WqM+xFhRY7tBuy1
         bzaojAVe3KXE/aNpr3uA2mEEOurhCotHnsbxbwjClP3+2/7NfPMOOOYO/VfASGW/37aB
         OPRu2L1os4A+JlnYC4KHerSPJAdtUsrR7bxWT97re0OsLRgciJHGaV8u+Q1CoUU0/aKM
         QGnrxenJyg7cuQoUTfUB0NwGXZbUe4FWOLvREOx3JYFKjLLOuTPnSLeZEldYXr0WXcyC
         fbCisnyHymRPA7W8rJ086UADF2sNYCqLx1Vz64po0ySkC16kXI3DbAvVNiI2EIq7HNaA
         i7sw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-transfer-encoding;
        bh=Qc5hfXuJ/r4VQB8SqZLLspQSh/OxW4zt34r8vDksnCk=;
        b=gDyvr0jDwD5PbTnrzfagd3H0qtuCLdzwnHHVNKSn675i7H2K2mMlCT1UfsdeHpSnui
         0iJfspFbpirtTAe5bV/DV6jeoFzxutimSdYag9Ghf5xLYKYrdFnmmpJN4+wrgOKbIJeC
         /ap0f14Npos2R7BmtJMjOMYHhFPWaYdjHphNb+38eK0bGS3Jm4Yal84/rB/zZJ7oH/ko
         t8h8RYTncT9yZddRpUSVOgG/5kILTDftp5dTcZ1a38K4fnuSaR1aBZlHHfEgAIR0UTiS
         MFGbx+qA36ccqSjXwISPOuOEG3EwZcEDGZyvsN98T1dnyVoMcgln3012WpJ+Nahw2aBU
         xztw==
X-Gm-Message-State: AOPr4FU5Y14lpnqYB36i/AvZvJHrydGLQZ7DKtdPZ2XOeFdLmPp1pf9xNZLvlJ9s5xoh+xmiIkHtbctVPuXB2g==
X-Received: by 10.36.55.144 with SMTP id r138mr2500889itr.73.1462915159102;
 Tue, 10 May 2016 14:19:19 -0700 (PDT)
Received: by 10.79.139.4 with HTTP; Tue, 10 May 2016 14:19:19 -0700 (PDT)
In-Reply-To: <xmqqtwi5mxeh.fsf@gitster.mtv.corp.google.com>
X-Google-Sender-Auth: gXzPlebNjA3ocSPflCzAOvho-oM
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/294196>

On Tue, May 10, 2016 at 5:11 PM, Junio C Hamano <gitster@pobox.com> wro=
te:
> SZEDER G=C3=A1bor <szeder@ira.uka.de> writes:
>> I wonder if is it really necessary to specify the path to the .git
>> directory via $GIT_DIR.  Would 'git --git-dir=3D/over/there' be just=
 as
>> good?
>
> Then you are testing two different things that may go through
> different codepaths.
>
> Adding yet another test to check "git --git-dir=3D" in addition is
> fine, but that is not a replacement.  We do want to make sure that
> "GIT_DIR=3Dthere git" form keeps giving us the expected outcome.

When working on this, I did test with --git-dir=3D in place of GIT_DIR
and some tests failed, but I didn't follow through to see what the
actual problem was, partly because the code was in flux and I may have
messed up something else, but primarily for the reason Junio gives
above: I wanted this modernization series to be faithful to the
original; additional testing can be added later.
