From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: [PATCH 0/3] Reject non-ff pulls by default
Date: Mon, 9 Sep 2013 18:02:35 -0500
Message-ID: <CAMP44s0y-cpEWuPTQSwC-Hyp-RNcwdyDRTbAsUewH5bAPPMXuQ@mail.gmail.com>
References: <CAMP44s3Vaqe-POwQb30AGdarf=ObdPUay3QEMqxHV3NKiPAouA@mail.gmail.com>
	<20130908041805.GB14019@sigill.intra.peff.net>
	<CAMP44s01LL2JCKzqa0Qc5MfBz9zfMXR4H8jZdauLOi-D0JVHpw@mail.gmail.com>
	<20130908172605.GF5359@vauxhall.crustytoothpaste.net>
	<CAMP44s0SLoD7ptgiYOg_vq+Jpo5uhWvzFC8Bd76JHo5zbjf8fg@mail.gmail.com>
	<20130909000153.GG5359@vauxhall.crustytoothpaste.net>
	<CAMP44s2seqO_0o=G2PjoL77HNSNcjTe4s6ZYj90_wsUT30pW8A@mail.gmail.com>
	<vpqr4cy4g5q.fsf@anie.imag.fr>
	<xmqq1u4x4yst.fsf@gitster.dls.corp.google.com>
	<20130909195231.GA14021@sigill.intra.peff.net>
	<20130909202435.GJ2582@serenity.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
	"brian m. carlson" <sandals@crustytoothpaste.net>,
	git@vger.kernel.org, Andreas Krey <a.krey@gmx.de>
To: John Keeping <john@keeping.me.uk>
X-From: git-owner@vger.kernel.org Tue Sep 10 01:02:54 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VJATr-0007tx-Vn
	for gcvg-git-2@plane.gmane.org; Tue, 10 Sep 2013 01:02:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756161Ab3IIXCi (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 9 Sep 2013 19:02:38 -0400
Received: from mail-lb0-f170.google.com ([209.85.217.170]:44284 "EHLO
	mail-lb0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756075Ab3IIXCg (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 9 Sep 2013 19:02:36 -0400
Received: by mail-lb0-f170.google.com with SMTP id w7so5563386lbi.15
        for <git@vger.kernel.org>; Mon, 09 Sep 2013 16:02:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=0NwJHd39WUQXyHhA3a/SmKdhkAN8bKZB7Dz58KS9ALw=;
        b=fvFKR86eFqL9aGru6BKipNzeXPgZNPLDXA4wXzL5SD7M60hV5XF5TspxMauZgde4XG
         iwGYSLG8GydEZhk40u0pTP+0s99lW5e9/qhV2TLvmNfi58ESPpdOEwlZDTnny/7hEcLr
         d4yshwysQAb5rbZ0nAV8pURDn38cvufPWKJaOxtVOPdo0oTwDHVZ54sIuL0d7vGIDA5K
         FnfHJelDfNLcrNB0qA6JYnQbRRl24uIRAzCepf9fpqN7SEz/g4HhrFk6TGMJ2jycLPT3
         6XuUVDFEMQHyuGT5BXFKM2DtTHBH7TW5jb3Wqdztlgn9y/VZULiYW0LFJ9YgZfWjuYoi
         DQ4Q==
X-Received: by 10.112.156.166 with SMTP id wf6mr18116432lbb.13.1378767755496;
 Mon, 09 Sep 2013 16:02:35 -0700 (PDT)
Received: by 10.114.91.169 with HTTP; Mon, 9 Sep 2013 16:02:35 -0700 (PDT)
In-Reply-To: <20130909202435.GJ2582@serenity.lan>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/234398>

On Mon, Sep 9, 2013 at 3:24 PM, John Keeping <john@keeping.me.uk> wrote:
> On Mon, Sep 09, 2013 at 03:52:31PM -0400, Jeff King wrote:
>> On Mon, Sep 09, 2013 at 11:47:45AM -0700, Junio C Hamano wrote:
>>
>> > You are in favor of an _option_ to allow people to forbid a pull in
>> > a non-ff situation, and I think other people are also in
>> > agreement. So perhaps:
>> >
>> >  - drop jc/pull-training-wheel and revert its merge from 'next';
>> >
>> >  - update Felipe's series with a bit of tweak to make it less
>> >    impactful by demoting error into warning and advice.
>> >
>> > would be a good way forward?
>>
>> I think that would address the concern I raised, because it does not
>> create a roadblock to new users accomplishing their task. They can
>> ignore the warning, or choose "merge" as the default to shut up the
>> warning (and it is easy to choose that if you are confused, because it
>> is what git is doing by default alongside the warning).
>
> I think we need to make sure that we give instructions for how to go
> back if the default hasn't done what you wanted.  Something like this:
>
>     Your pull did not fast-forward, so Git has merged '$upstream' into
>     your branch, which may not be correct for your project.  If you
>     would rather rebase your changes, run
>
>         git rebase
>
>     See "pull.mode" in git-config(1) to suppress this message in the
>     future.

And you propose to show that every single time the user does a 'git
pull'' that results in a non-fast-forward merge? Isn't that what 'git
pull --help' is for?

-- 
Felipe Contreras
