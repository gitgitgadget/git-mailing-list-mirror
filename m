From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: [PATCH v3 08/10] remote-hg: update bookmarks when pulling
Date: Tue, 14 May 2013 18:11:51 -0500
Message-ID: <CAMP44s32KkJY3OxifDEmqp0ZkhQiRQCVwxYvSNGgqTnwC3DLEw@mail.gmail.com>
References: <1368486720-2716-1-git-send-email-felipe.contreras@gmail.com>
	<1368486720-2716-9-git-send-email-felipe.contreras@gmail.com>
	<51929dfa8122e_13a8f89e182115@nysa.mail>
	<7vzjvxfck2.fsf@alter.siamese.dyndns.org>
	<CAMP44s0Wd4VEc_mwr=xguVAnXvn+YVz24u8eS4Nyy0HCjwJ+dw@mail.gmail.com>
	<7vbo8dfbbr.fsf@alter.siamese.dyndns.org>
	<CAMP44s0u0WPNneM-GoiqCkWTC-CT_Xa2z3on=smRiFJdd9ffeQ@mail.gmail.com>
	<7v38tpfa7u.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git@vger.kernel.org, Jeff King <peff@peff.net>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed May 15 01:12:13 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UcOOC-00017f-9n
	for gcvg-git-2@plane.gmane.org; Wed, 15 May 2013 01:12:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758613Ab3ENXLy (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 14 May 2013 19:11:54 -0400
Received: from mail-la0-f52.google.com ([209.85.215.52]:61602 "EHLO
	mail-la0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758432Ab3ENXLx (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 14 May 2013 19:11:53 -0400
Received: by mail-la0-f52.google.com with SMTP id fo13so1116787lab.25
        for <git@vger.kernel.org>; Tue, 14 May 2013 16:11:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:x-received:in-reply-to:references:date:message-id
         :subject:from:to:cc:content-type;
        bh=H1uANXCvaAlf0NdO7lBqSAeQi4LFIQJkZcs25BoUYEE=;
        b=f1a8SSgKCx59cfqg+NcB8AOLAFPwFcoHalXJPCZpxJRVfITDegS+qX2A+9hyTdSWIE
         2fmBmiSspmMXXUSpGZl9gZGa7CvJIslAGlbTTsQDWyp2Ambe8j91egxaVJGmsdmYGAsJ
         zICxIeqDFyRGL/NvZ0y84oTAPalktC87+eCE8QB1q4oiTh8WdOtC/XUldpw8I7jP00I5
         4HK19bRYikEBgM9awATDwXHjx6Q4vj2VyvqXKAAklZg3L7xWDEaqlNdhq14I8xbVDvtZ
         1g3KbMANboPQ6E7a+XzYXMsUYisetfZI+idDEiPJ2pIEvb8cUZU2Cooaw/y8uyhQboxP
         20rQ==
X-Received: by 10.112.125.130 with SMTP id mq2mr16162728lbb.103.1368573112027;
 Tue, 14 May 2013 16:11:52 -0700 (PDT)
Received: by 10.114.184.3 with HTTP; Tue, 14 May 2013 16:11:51 -0700 (PDT)
In-Reply-To: <7v38tpfa7u.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/224367>

On Tue, May 14, 2013 at 5:49 PM, Junio C Hamano <gitster@pobox.com> wrote:
> Felipe Contreras <felipe.contreras@gmail.com> writes:
>
>> The reason for the "only regression" period is to avoid more
>> regressions. If you show me how any of the fixes I sent in this series
>> could potentially cause a regression,
>
> I already said that "You can see these patches are so trivially
> correct" is not a valid argument.

You can say so, it doesn't make it so.

> The original patches would also
> have been looked correct when they were sent to the list.

No, they didn't look correct, and I made it clear when I sent the
patches to be *tested*.

> Things
> take time and actual use by the users to mature.

Some things, not all things. That's a hasty generalization fallacy.

>>> You cannot be both.  Which is it?
>>
>> I marked the patch that fix a regression as such, I marked the patches
>> that are obvious fixes with no possibility of regressions as such, and
>> I marked the trivial cleanups with no possibility of regressions as
>> such.
>
> I think you mean 6/10 by "the patch that fix a regression", but if
> that is the case, please send only the regression fix that cleanly
> apply to the tip of 'master', without any other dependencies, with a
> proper description of what breaks and how it fixes.

I did that for v2, but you didn't merge that.

> We know you can do better than "certain" and "might".
>
>> In certain situations we might end up pushing garbage revisions (e.g. in
>> a rebase), and the patches to deal with that haven't been merged yet.
>>
>> So let's disable forced pushes by default.

I have done more than enough. I'm not going to write tests for this,
and I'm not going to find out for sure. There is a *potential* that
there's a regression, and that's reason enough to apply this patch as
it is.

I have done way more than my fair share already. I'm 98% certain that
this patch series as it is would not introduce a regression for
v1.8.3, and that's good enough for me. If anybody has any problem with
that, they can pick this series and do whatever they want with them.

If I'm supposed to be the owner of contrib/remote-helpers, it
certainly doesn't feel that way. If I am the owner, but you are
worried, why don't you let me make the decision, and if something
blows in v1.8.3, you can tell me; "see? you are not ready to have the
full maintainership of this". After all, this is in the contrib area,
so if there's a time for a possible future maintainer of a core part
of git to make mistakes, it would be now. But of course, this would
*not* happen, because the patches are obviously correct and I stand by
that claim.

As things currently stand, v1.8.3 *might* introduce a regression.

-- 
Felipe Contreras
