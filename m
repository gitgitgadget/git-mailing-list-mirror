From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: [PATCH v4 00/13] New remote-hg helper
Date: Mon, 29 Oct 2012 23:02:31 +0100
Message-ID: <CAMP44s1SLpNpbjRXF6QHrOTO=_1=wjPo1_kV3jZV-HXOYXPbnQ@mail.gmail.com>
References: <1351396453-29042-1-git-send-email-felipe.contreras@gmail.com>
	<20121029085045.GA5023@sigill.intra.peff.net>
	<CAMP44s0RVe6i4DpNmaV_n7_5KO_aq2WxCPVafjsTukExRSR5Jw@mail.gmail.com>
	<20121029212643.GA20513@sigill.intra.peff.net>
	<CAMP44s3L0ycSQFU9s157V7e-GryUdojtQ3Vk_-d2wtPf9NFtbg@mail.gmail.com>
	<20121029215631.GF20513@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	Sverre Rabbelier <srabbelier@gmail.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Ilari Liusvaara <ilari.liusvaara@elisanet.fi>,
	Daniel Barkalow <barkalow@iabervon.org>,
	Michael J Gruber <git@drmicha.warpmail.net>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Mon Oct 29 23:02:47 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TSxPw-0000dH-Pq
	for gcvg-git-2@plane.gmane.org; Mon, 29 Oct 2012 23:02:45 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933365Ab2J2WCe (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 29 Oct 2012 18:02:34 -0400
Received: from mail-oa0-f46.google.com ([209.85.219.46]:33324 "EHLO
	mail-oa0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933363Ab2J2WCb (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 29 Oct 2012 18:02:31 -0400
Received: by mail-oa0-f46.google.com with SMTP id h16so5202837oag.19
        for <git@vger.kernel.org>; Mon, 29 Oct 2012 15:02:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=Tr07GBsaXFh6pZK3/LTjGnOehiJyGVtXrL25jeOAb6Q=;
        b=FfF+glp41uP5kRBO1zUPF0Wdxb+TDFXYWRAod0F7a3zssav6L72kL0ZkjifHIH03/M
         zslX3xHNB2au9YddAZzqC0SMbY047co0SUx9fAfV1Wbkv4cwSnzeEEndJDLj6ictUNHN
         h6qXgSaUUYeVX1zTse9OYw7B3Dvoea88Qqm70kBVGXDKx5LKSL2IY8iz6Be7LQqczvj0
         YnHUk3P+sxGM65gcTcmhrIv3VlqCN7CQlPhDn6FXPhChwR1XUtRyFONu5igYYfIoR4qa
         6Dc7m5BQmyiGpv99cnC+leI8tKPA1BgTD4DtJ9l6pUE+FOa2zys5LoiePX8tE0g5b7Dm
         PEhQ==
Received: by 10.60.1.164 with SMTP id 4mr9898090oen.96.1351548151238; Mon, 29
 Oct 2012 15:02:31 -0700 (PDT)
Received: by 10.60.4.74 with HTTP; Mon, 29 Oct 2012 15:02:31 -0700 (PDT)
In-Reply-To: <20121029215631.GF20513@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/208647>

On Mon, Oct 29, 2012 at 10:56 PM, Jeff King <peff@peff.net> wrote:
> On Mon, Oct 29, 2012 at 10:47:04PM +0100, Felipe Contreras wrote:
>
>> >> Yeah, the test script is not ready for merging, it needs to check for
>> >> python, hg, and hg-git.
>> >>
>> >> Do you have hg-git installed?
>> >
>> > No. But it's important that it fail gracefully; I can't even take it in
>> > pu if I can't run the test suite in a sane way.
>>
>> The contrib part is fine for 'pu'. The tests aren't even meant to
>> exercise stuff in 'contrib', right? There might be some exceptions,
>> but either way, there's plenty of stuff in 'contrib' without any
>> tests. The tests I'm providing are simply a little sugar.
>
> Yeah, contrib is a bit of a wildcard. Most things do not have tests.
> Completion tests run as part of the main test suite (which to me means
> that completion should arguably be promoted out of contrib).

I agree, I didn't think of that when I wrote the completion tests, but
now it seems appropriate, specially since there's discussion about
moving the prompt out of contrib.

> If remote-hg is going to live in contrib, it probably makes sense to
> have its tests live there, too, like subtree.

Probably, I'll check that option.

But eventually I think it should be installed by default, unless
somebody can come up for a reason not to. For now contrib might be OK.

> It means less test
> exposure, but the robustness of the tests does not have to be as high.
> You could also have no tests, but since you have them, it seems silly
> not to include them. People know that items in contrib/ may not be as
> mature as the rest of git.

Yeah, it's only a matter of figuring out how to run them.

Cheers.

-- 
Felipe Contreras
