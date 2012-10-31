From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: [PATCH v4 00/13] New remote-hg helper
Date: Wed, 31 Oct 2012 19:41:28 +0100
Message-ID: <CAMP44s2y-co4TELg28==axRmbF7xq3Qp7U8wjg6XtGAUMgf40w@mail.gmail.com>
References: <20121029085045.GA5023@sigill.intra.peff.net>
	<CAMP44s0RVe6i4DpNmaV_n7_5KO_aq2WxCPVafjsTukExRSR5Jw@mail.gmail.com>
	<20121029212643.GA20513@sigill.intra.peff.net>
	<CAMP44s3L0ycSQFU9s157V7e-GryUdojtQ3Vk_-d2wtPf9NFtbg@mail.gmail.com>
	<20121029215631.GF20513@sigill.intra.peff.net>
	<alpine.DEB.1.00.1210301809060.7256@s15462909.onlinehome-server.info>
	<CAMP44s3CEGqUav-ijnzm7osD70LsjRLyOEeV3bF-LWYTCEPCSQ@mail.gmail.com>
	<alpine.DEB.1.00.1210302027410.7256@s15462909.onlinehome-server.info>
	<CAMP44s0akZ7_Nd1Q1AaZJuXnyTJv2MzNqDus76Y82y4LbWVO+Q@mail.gmail.com>
	<5090EFCA.7070606@drmicha.warpmail.net>
	<20121031102712.GB30879@sigill.intra.peff.net>
	<alpine.DEB.1.00.1210311900450.7256@s15462909.onlinehome-server.info>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Jeff King <peff@peff.net>, git@vger.kernel.org,
	Michael J Gruber <git@drmicha.warpmail.net>,
	Junio C Hamano <gitster@pobox.com>,
	Sverre Rabbelier <srabbelier@gmail.com>,
	Ilari Liusvaara <ilari.liusvaara@elisanet.fi>,
	Daniel Barkalow <barkalow@iabervon.org>
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Wed Oct 31 19:41:43 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TTdEU-0007h9-Ce
	for gcvg-git-2@plane.gmane.org; Wed, 31 Oct 2012 19:41:42 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758654Ab2JaSl3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 31 Oct 2012 14:41:29 -0400
Received: from mail-oa0-f46.google.com ([209.85.219.46]:59003 "EHLO
	mail-oa0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755386Ab2JaSl2 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 31 Oct 2012 14:41:28 -0400
Received: by mail-oa0-f46.google.com with SMTP id h16so1769875oag.19
        for <git@vger.kernel.org>; Wed, 31 Oct 2012 11:41:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=KlEQ4iSQv3JPdcB2sIJMsmvgScYa65a60JVllsPAWDI=;
        b=toMClIH2Z1K5Uh52Db7p+uyEOkHsN/nXhlTMaWl6cb2sn8DqCUukdsU5ctmdlaKOB1
         aATb8auk9jX3UyvKBuNQ1Fzlx510E+xVzWuTGPA0S1nf3BZdhvMRuP1csPfz0OJ/rE4g
         xVLuOREJvpeObYBNz1bPupheovyV2aBhYyYB+Cgdj4U4fQAZ1yiOxjLkj1TtYhOC10bc
         joYhPleS76A9JPmGjYnuAvS0pyO+28xmdI4TcR70Pu0Yn9FwOMNpFvkT4831qKT7Anwz
         AWfDpCREN2M0U8a58j8BRQDfmTyl5taM7sX2VMsELn7ofTZJLE6SejxIb/7UQr/i49Px
         B/lQ==
Received: by 10.60.22.228 with SMTP id h4mr31909466oef.30.1351708888182; Wed,
 31 Oct 2012 11:41:28 -0700 (PDT)
Received: by 10.60.4.74 with HTTP; Wed, 31 Oct 2012 11:41:28 -0700 (PDT)
In-Reply-To: <alpine.DEB.1.00.1210311900450.7256@s15462909.onlinehome-server.info>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/208848>

Hi,

On Wed, Oct 31, 2012 at 7:20 PM, Johannes Schindelin
<Johannes.Schindelin@gmx.de> wrote:

>>   - What disadvantages? If this implementation goes into git.git,
>>     the msysgit one is likely to wane in popularity. What will we be
>>     losing by doing so? If the answer is not "nothing", how hard would
>>     it be to port over the missing bits?
>
> The biggest advantage msysGit's series has is that it had a fix for a
> fundamental flaw in fast-export. Fast-export was intended to work
> incrementally, so the incantation "git branch blub master && git
> fast-export ^master blub" is expected to update the ref "blub" properly.
>
> I just tested this with junio/next and it seems this issue is still
> unfixed: instead of
>
>         reset refs/heads/blub
>         from e7510461b7db54b181d07acced0ed3b1ada072c8
>
> I get
>
>         reset refs/heads/blub
>         from :0
>
> when running "git fast-export ^master blub".

That is not a problem. It has been discussed extensively, and the
consensus seems to be that such command should throw nothing:

http://article.gmane.org/gmane.comp.version-control.git/208729

But that doesn't affect remote helpers, what we _really_ want is for
this to work:

git fast-export --import-marks=tmp-marks \
  --export-marks=tmp-marks master > /dev/null &&
git fast-export --import-marks=tmp-marks \
  --export-marks=tmp-marks blub > actual &&

And that's fixed in this patch: (for which the consensus seems to be
that it's also OK)

http://article.gmane.org/gmane.comp.version-control.git/208730

But none of these patches are *required* for remote-hg (any of them) to work.

Cheers.

--
Felipe Contreras
