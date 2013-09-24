From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: [PATCH 1/2] fetch: add missing documentation
Date: Tue, 24 Sep 2013 00:57:36 -0500
Message-ID: <CAMP44s3QfkvXjgmhWPXN7qonbEPpvJFyVm82EBOMSjX7ng3OQg@mail.gmail.com>
References: <1379772563-11000-1-git-send-email-felipe.contreras@gmail.com>
	<1379772563-11000-2-git-send-email-felipe.contreras@gmail.com>
	<20130924050343.GF2766@sigill.intra.peff.net>
	<CAMP44s1FFTS=wOcWBfqg3zt3TO-aM83oXHcGwBcwvt_HnXrn8g@mail.gmail.com>
	<20130924053023.GA5875@sigill.intra.peff.net>
	<CAMP44s1ezYMSuQRMp_SY1HqLiuyuf0tjuf3Fn6fXF2drODZ_iw@mail.gmail.com>
	<20130924054053.GA6192@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Tue Sep 24 07:57:42 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VOLcz-00005Z-VJ
	for gcvg-git-2@plane.gmane.org; Tue, 24 Sep 2013 07:57:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750720Ab3IXF5i (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 24 Sep 2013 01:57:38 -0400
Received: from mail-lb0-f169.google.com ([209.85.217.169]:57967 "EHLO
	mail-lb0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750706Ab3IXF5h (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 24 Sep 2013 01:57:37 -0400
Received: by mail-lb0-f169.google.com with SMTP id z5so3423908lbh.14
        for <git@vger.kernel.org>; Mon, 23 Sep 2013 22:57:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=WP7O1Xuk1nc7fXjjli3BgoXEcD+piw+BfHhNXt/nOA8=;
        b=kvR5QgN97L6QNzpzwlvteHxIUVT5va0y48Ii+Lo7/U2l6Ke9nvV7h5U2woeKJFb/0y
         AKRtEXYVLBpiMiQxT11cJnQvCm5XEF1po5GMMS8Zb2whoS0iaMr+IHtMWTGv8TiMCVTd
         OnJk+KvSQt8tAVmjF3bNtKoLrzX/VVA+6rW72ixXKGBMtFpG2p+Ve/8YfJZ5hnyx1BU+
         NNS370EYS6/IxtnkSTaZBcRCkRd9akga09HP2jVwLy7voz6R3FKYGqsO/GpTBWlyS+Qp
         RspBt6c7VQZ6N8VrhRLiv2qcis28iZe11PhC4TJuEUF8oj03jFCYwGICoxgtQzpWZ8CT
         HL7w==
X-Received: by 10.112.28.109 with SMTP id a13mr23160362lbh.3.1380002256499;
 Mon, 23 Sep 2013 22:57:36 -0700 (PDT)
Received: by 10.114.91.230 with HTTP; Mon, 23 Sep 2013 22:57:36 -0700 (PDT)
In-Reply-To: <20130924054053.GA6192@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/235271>

On Tue, Sep 24, 2013 at 12:40 AM, Jeff King <peff@peff.net> wrote:
> On Tue, Sep 24, 2013 at 12:36:38AM -0500, Felipe Contreras wrote:
>
>> > Yeah, it's not a term we use elsewhere, so it's not great. Probably
>> > "default remote" would be better, or even just say "branch.*.remote for
>> > the current branch" or something.
>>
>> Yeah, general users don't know what you are talking about when you say that.
>
> Right, I understand your complaint and agree that those terms are
> potentially confusing.
>
>> > I dunno. I don't particularly like any of those, but I really dislike
>> > the imprecision of "upstream branch" in this case.
>>
>> For most users it's the remote configured by:
>>
>> % git branch --set-upstream-to foo
>> % git checkout -b foo origin/foo
>> % git checkout -t -b foo bar
>>
>> So when they read "upstream branch" they know from where it got configured.
>
> Yes, but it is also wrong, in the sense that the upstream branch is
> unrelated. You are giving breadcrumbs to users who know "upstream
> branch" as a concept and nothing else, but you are misleading users who
> know that branch.*.remote exists.

No, I'm not. The users that know branch.*.remote exists know why it
exists. The part where it is explained, 'git config --help', is
perfectly clear: "When on branch <name>, it tells 'git fetch' and 'git
push' which remote to fetch from/push to.". So what does
branch.<name>.remote does, if not precisely what the documentation
says?

This is not a rhetorical question, I'm actually expecting you to
answer, if a user knows that branch.<name>.remote exists, how would
the above confuse him?

> I was hoping you might suggest something that can help both users by
> being both precise and giving the appropriate breadcrumbs.

This is documentation for a Git porcelain command,
branch.<name>.remote is an implementation detail, and it's irrelevant
in the documentation at this level.

-- 
Felipe Contreras
