From: Duy Nguyen <pclouds@gmail.com>
Subject: Re: [PATCH] Trick to force setup of a specific configured E-Mail per repo
Date: Wed, 3 Feb 2016 12:26:36 +0700
Message-ID: <CACsJy8CbnPGz40Bb+u-_QJCRT0r2p1FUQo1Ywu5F9cz+szUGtw@mail.gmail.com>
References: <1454442861-4879-1-git-send-email-alonid@gmail.com>
 <20160203035648.GA20732@sigill.intra.peff.net> <CACsJy8BHem_8OcnT9KYhKZVhNcQbK91VDOJPLm9awfWJtpsi=g@mail.gmail.com>
 <20160203052209.GA22336@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Dan Aloni <alonid@gmail.com>,
	Git Mailing List <git@vger.kernel.org>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Wed Feb 03 06:27:15 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aQpyD-0000Vz-I9
	for gcvg-git-2@plane.gmane.org; Wed, 03 Feb 2016 06:27:13 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751840AbcBCF1J (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 3 Feb 2016 00:27:09 -0500
Received: from mail-lf0-f45.google.com ([209.85.215.45]:33797 "EHLO
	mail-lf0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751116AbcBCF1H (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 3 Feb 2016 00:27:07 -0500
Received: by mail-lf0-f45.google.com with SMTP id j78so6335502lfb.1
        for <git@vger.kernel.org>; Tue, 02 Feb 2016 21:27:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=K0uGAd+dyA8PvIOIIP7Tr9OuGKlbYf4TAHNl0OLr73s=;
        b=jfQ2cits2EZgDNldmQP21odjX1IaOOHTQYtsSH1fMLgTvVEQiZbHyh0GeSRo7ShjvZ
         67YmQBvi5ucejZEpv+a5zdPY5JA0A9xLqraw2wZipqvYzNXf9qTtMLsK6F8E0bDolkoW
         IvVYjVzLJF8+O8H4NvKVGeu+PwVphkOwZNEU+a23+ALSzptTPZvrPNKu+JBvIhuy33kg
         NljzJmZ6jzwqhw78FdOKYhs1fp9f8/3cPhb83gen9Dn7tVggehIqRFxycwi66B+G22zt
         H3aH/uPdqQgOX73W7e8h0IOSJelCSgAASLYEWenNZoOuesem0j79QngpqjQ7ZTkxXOgi
         wdtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-type;
        bh=K0uGAd+dyA8PvIOIIP7Tr9OuGKlbYf4TAHNl0OLr73s=;
        b=WZcx1/HkMD06MbmcBradgJL+iyw/D5Ki9q7puuAvZPeGblHZ5ccp8PGxIsGoqAMj/A
         lK51OotpuDKTRZze6KAxNpO7Wo+Ex2JRvtE3PmW6JRzgdnqAoMj/GbGQBldFcbLxAJ3e
         4sv+8bxVL2u/Dfjob8Y9mo/SZtc+c6UaWE3+9Zxy6yIt3gUaQsaDvY6HZtv4MqGjLAPp
         eWOssETGEMirIZi8lQoLYlbKrZWKZSE6MT24HQvdH3FYASZBDYNSel9IGgyr7xmWnC+n
         qfa/efaqpODrrd7oGL+5PTz8lopw0k6k5IeW0Cqeg9NxfyQC0DvXYjkq7ikrGx0hPs+2
         kebA==
X-Gm-Message-State: AG10YOR3yb1vO2l5wZ7TVaxzCr/CyQ8Gbf/aKv3N7tE5N7wCiQxCgSbr97w2jEtF09k389jPQuqk2DaJJ9oezg==
X-Received: by 10.25.161.144 with SMTP id k138mr13072534lfe.83.1454477226413;
 Tue, 02 Feb 2016 21:27:06 -0800 (PST)
Received: by 10.112.97.72 with HTTP; Tue, 2 Feb 2016 21:26:36 -0800 (PST)
In-Reply-To: <20160203052209.GA22336@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/285332>

On Wed, Feb 3, 2016 at 12:22 PM, Jeff King <peff@peff.net> wrote:
> On Wed, Feb 03, 2016 at 12:19:20PM +0700, Duy Nguyen wrote:
>
>> On Wed, Feb 3, 2016 at 10:56 AM, Jeff King <peff@peff.net> wrote:
>> > I find it disappointing that we go back to looking for magic sequences
>> > in the string. Could we perhaps do this more cleanly with a new config
>> > option? Like a "user.guessIdent" which defaults to true, but people can
>> > set to false. And without that, we do not do any automagic at all; we
>> > get the values from the GIT_COMMITTER_* environment or the
>> > user.{name,email} config variables, or we die().
>> >
>> > I think that should allow your use case (and extend the same feature to
>> > user.name). It wouldn't work on older versions of git, but nor would
>> > your fix here (the only way to do that is to re-instate "(none)" as
>> > magical).
>>
>> Should we generalize this use case, i.e. define a list of
>> configuration variables that must be (re-)defined per-repo? Maybe not
>> worth it, I don't know. I can't think of any other variable that
>> should behave this way off the top of my head.
>
> That's an interesting thought, but I'm not sure how it would work. The
> ident variables are special in that people are often unhappy with the
> fallback. What would it mean for somebody to say "do not proceed if
> diff.renameLimit is not set", and where would we enforce that?

Enforcing it at git-init and git-clone, interactively asking the
values of these variables,  may be too much. If only we can catch if a
variable is used, then we probably can catch it there. But that may
require some more changes in config api.
-- 
Duy
