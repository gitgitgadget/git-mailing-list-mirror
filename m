From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: [PATCH v3 08/10] remote-hg: update bookmarks when pulling
Date: Tue, 14 May 2013 17:14:48 -0500
Message-ID: <CAMP44s0Wd4VEc_mwr=xguVAnXvn+YVz24u8eS4Nyy0HCjwJ+dw@mail.gmail.com>
References: <1368486720-2716-1-git-send-email-felipe.contreras@gmail.com>
	<1368486720-2716-9-git-send-email-felipe.contreras@gmail.com>
	<51929dfa8122e_13a8f89e182115@nysa.mail>
	<7vzjvxfck2.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git@vger.kernel.org, Jeff King <peff@peff.net>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed May 15 00:14:56 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UcNUk-0002MQ-CS
	for gcvg-git-2@plane.gmane.org; Wed, 15 May 2013 00:14:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758437Ab3ENWOu (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 14 May 2013 18:14:50 -0400
Received: from mail-lb0-f178.google.com ([209.85.217.178]:47733 "EHLO
	mail-lb0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758222Ab3ENWOu (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 14 May 2013 18:14:50 -0400
Received: by mail-lb0-f178.google.com with SMTP id p10so1172826lbv.23
        for <git@vger.kernel.org>; Tue, 14 May 2013 15:14:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:x-received:in-reply-to:references:date:message-id
         :subject:from:to:cc:content-type;
        bh=rnCS8tqVo+4XZfCGNhWRdkBWI7rE/mskfmiLOxijLC8=;
        b=oNei0HrDgXTqMg3oUsivJ1Xwo9pvA9nqtxBG0I4vMj80KRJM42GL/oVjo/I+bzAw+u
         iPEXUt567+BkThrOGhxMVjNr6LDWzgw/+uI4ff4f/SkGAOF+V/rMzKLPW4OwtjOFjQb0
         W+CRbPhiNR9ODphzGxFgMLNXYywaPq6uaSiSAQWCd9zuUkA1HSmPdVX3kki9Tsd5HzKd
         2JiIMhXYD5T83RgZiOcGw1q0mwYu8F5i0JiF5txB6BDvO/mTWiP6eqjnHDUi4k7tz1oR
         nDFAkvC17oUvvqGVAmTfWXDnfGtUblMo5R2rS2YkSTweNSRG6zbWvrazIq1OvO6YpcqY
         K85Q==
X-Received: by 10.112.163.71 with SMTP id yg7mr6812741lbb.8.1368569688487;
 Tue, 14 May 2013 15:14:48 -0700 (PDT)
Received: by 10.114.184.3 with HTTP; Tue, 14 May 2013 15:14:48 -0700 (PDT)
In-Reply-To: <7vzjvxfck2.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/224357>

On Tue, May 14, 2013 at 4:59 PM, Junio C Hamano <gitster@pobox.com> wrote:
> Felipe Contreras <felipe.contreras@gmail.com> writes:
>
>> Without this fix, the user would never ever see new bookmarks, only the ones
>> that (s)he initially cloned.
>
> Now, think again and realize how long it took you (the original
> author) to discover issues and come up with these fixes and
> explanation since the series was merged before -rc0.

This issue has *always* been there, it's not a regression.

> Are we giving the users enough time to discover and complain issues
> that these 10 patches may introduce before the final release?

Yes, because the time needed is *zero*.

> "You
> can see these patches are so trivially correct" is not a valid
> argument. The original patches would also have been looked correct
> when they were sent to the list. Things take time and actual use by
> the users to mature.

There was no original patches that introduced this regression, because
it's not a regression.

When I say these are trivially correct, I mean it; the regressions you
talk about were on patches that were marked as *not* trivially
correct, and potentially dangerous.

> Having said that, the impression I am getting is that whatever we
> pushed out in 1.8.2 and 1.8.3-rc0 was far from ready for real use,
> and with your explanations (by the way, I found that many of them
> deserve to be in the log message), the end result of applying these
> patches, up to 8/10, will still not be as it is very likely that you
> and users will discover issues at a similar rate, but at least it
> will be much closer to be ready than they currently are.

Define "ready". It's probably more "ready" than any other bridge tool out there.

> In other words, it still seems to be in "something is better than
> nothing, newer is better than older" stage before stabilization.

remote-hg is already stable, this patch has nothing to do with
stabilization, neither do any of the 47 patches I sent to the list.

> And that is to be expected for a contrib/ material; nothing for us
> to be ashamed of.  So I changed my mind.  As long as it is clearly
> marked as "still experimental, possibly with rough edges", I think
> it is better to ship 1.8.3 with these 8 patches than without.
>
> I am unhappy with 3/10, though.  It is spreading existing mistake by
> adding another configuration variable with dash in its name, which
> goes against the recommended practice, and making it more cumbersome
> to eventually fix them, because we would need to break end user's
> configuration.

It's not adding any configuration; remote-hg.track-branches is already
present, even in v1.8.2.

> Things like 1/10 and 2/10 that can be characterized as:
>
>> This is a trivial cleanup, cannot cause regressions.
>
> may probably be a good clean-up to build the next development cycle
> on top, but are not at all urgent for it to deserve to be included
> in the upcoming release.  But it seems that 3-8 textually depend on
> at least 2, so I'll queue the first eight for 1.8.3 and exclude the
> rest for now.  If these are identical to the early part of the
> 47-patch series (I didn't check; they are for the next cycle), it
> would make the next cycle shorter by 8 patches.

Indeed, they are exactly the same as the first 10 patches of the
47-patch series.

I think this makes sense.

-- 
Felipe Contreras
