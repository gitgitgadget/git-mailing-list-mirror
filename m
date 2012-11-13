From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: [PATCH] send-email: add proper default sender
Date: Tue, 13 Nov 2012 04:55:25 +0100
Message-ID: <CAMP44s0SDHVzSd-8Rq7Z1sbiQ6m0pxX+2pgx16_DoWnHeyNsNQ@mail.gmail.com>
References: <1352653610-2090-1-git-send-email-felipe.contreras@gmail.com>
	<20121112233546.GG10531@sigill.intra.peff.net>
	<CAMP44s0emar-C27SX-FDsUVB6Sevuy4fBFHuO2OD6xELCEjmGg@mail.gmail.com>
	<20121113000217.GH10531@sigill.intra.peff.net>
	<CAMP44s16y9WSmnTdb04EMSzXVgzfYP7pSMo6qZi0HY0bjouA0w@mail.gmail.com>
	<20121113032727.GA8387@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git@vger.kernel.org, Thomas Rast <trast@student.ethz.ch>,
	Junio C Hamano <gitster@pobox.com>,
	Jonathan Nieder <jrnieder@gmail.com>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Tue Nov 13 04:55:41 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TY7bA-0007VU-RR
	for gcvg-git-2@plane.gmane.org; Tue, 13 Nov 2012 04:55:41 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753816Ab2KMDz1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 12 Nov 2012 22:55:27 -0500
Received: from mail-oa0-f46.google.com ([209.85.219.46]:40418 "EHLO
	mail-oa0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753253Ab2KMDz0 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 12 Nov 2012 22:55:26 -0500
Received: by mail-oa0-f46.google.com with SMTP id h16so7014983oag.19
        for <git@vger.kernel.org>; Mon, 12 Nov 2012 19:55:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=7qs+lzc92m7nge4C3FgB2iZQDJOrm4kCYPSTJElssYM=;
        b=bG9k0P59iK6QoQAJwn69AYxM6I0gPpRderD8NNTBfIlR8phQe+7awzfZg8600G06qX
         hMwdThliJRlwPnubqNvCKIYk3Ivkqh84djNha8l2L7ku/joERTxloijcxOucx8wBLAoa
         Hlr9kFBvrhXScnnl/FwxocSdOTS2bGraf82dUkn0ZTpCQPWnk1IIoRQwApdaRqVYfeMr
         zP5mOytosbzK4GPijAKXPhpHyJBzgcR2ameeT6dTmi4x++sWwaqq8IWKczMIAlfoUbLC
         TppiX+YX3Kjao6kptPn1t9gTB8PLjTC1QICqh+WjUcdTcWef1UQC6LuP4f5Cxw/y24oS
         Merw==
Received: by 10.182.10.6 with SMTP id e6mr16900724obb.16.1352778925814; Mon,
 12 Nov 2012 19:55:25 -0800 (PST)
Received: by 10.60.4.74 with HTTP; Mon, 12 Nov 2012 19:55:25 -0800 (PST)
In-Reply-To: <20121113032727.GA8387@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/209567>

On Tue, Nov 13, 2012 at 4:27 AM, Jeff King <peff@peff.net> wrote:
> On Tue, Nov 13, 2012 at 01:54:59AM +0100, Felipe Contreras wrote:
>
>> > But we use the environment to default the field, so the distinction
>> > doesn't make much sense to me.  Plus, it has always been the case that
>> > you can use git without setting user.*, but instead only using the
>> > environment. I don't see any reason not to follow that principle here,
>> > too.
>>
>> And that's why a lot of commits end up like michael
>> <michael@michael-laptop.(none)>.
>
> No, it's not. Those broken names do not come from the environment, but
> from our last-resort guess of the hostname.

That depends how you define environment, but fine, the point is that it happens.

> We long ago switched to
> printing the name as a warning when we have made such a guess (bb1ae3f),
> then more recently started rejecting them outright (8c5b1ae).

Right, but these would still happen:

michael <michael@michael-laptop.michael.org>

>> Probably. But what I really want is to stop 'git send-email' from
>> asking. I think the one next step further can be done later.
>
> But in the meantime you are causing a regression for anybody who expects
> GIT_AUTHOR_NAME to override user.email when running git-send-email (and
> you have taken away the prompt that they could have used to notice and
> correct it).

I think they can survive. If anybody like this exists.

-- 
Felipe Contreras
