From: Duy Nguyen <pclouds@gmail.com>
Subject: Re: [PATCH 09/19] documentation: add documentation for the bitmap format
Date: Fri, 25 Oct 2013 10:28:11 +0700
Message-ID: <CACsJy8D=3L73xQSZ-=DD+u57toKqZ=smKW0TDskfAcB1T7fkag@mail.gmail.com>
References: <20131024175915.GA23398@sigill.intra.peff.net> <20131024180347.GI24180@sigill.intra.peff.net>
 <CACsJy8DFisnZZiPOWjktuMC2J289AYGtgefZob=4YFAJAxBc6w@mail.gmail.com> <20131025032144.GB26283@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: "Shawn O. Pearce" <spearce@spearce.org>,
	Git Mailing List <git@vger.kernel.org>,
	Vicent Marti <vicent@github.com>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Fri Oct 25 05:28:47 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VZY4s-0000V8-Kg
	for gcvg-git-2@plane.gmane.org; Fri, 25 Oct 2013 05:28:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755876Ab3JYD2n (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 24 Oct 2013 23:28:43 -0400
Received: from mail-qa0-f48.google.com ([209.85.216.48]:36538 "EHLO
	mail-qa0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755383Ab3JYD2m (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 24 Oct 2013 23:28:42 -0400
Received: by mail-qa0-f48.google.com with SMTP id k4so291477qaq.0
        for <git@vger.kernel.org>; Thu, 24 Oct 2013 20:28:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=MBrtKjcm+oAZeKuxDACkJhQZ/nyo+DuZpfQHQo/gMQg=;
        b=IsY20muijf+LoF1tjFbwzPnwQWpKVyfpJjlmVRfLNYbMMub80z4niEPTSSPzAjin5E
         yG5fm1uXmqdPOG6t5HZwZSbNF55w99GrLukxLCdSFjrL/g2OS4BVP6IPptSLfs9TDmj9
         YxK16tsHsfaSzOzCn1lPpso7yVZ+WGYwOrpOVfO+ZWih+8W3OUVmVq/RxrdExDvWsIAI
         1KY5hzPvMD8iho5+XkyWKvLWBMQP2A7JqFfhW0JzVlTnqqAWZe0i/SLduVWPxYGCELPl
         F/lqQSxhz6CG9YJRVeiqBvEV+Xonj5I9vkSIJk/TBQFGmdcxBlBGaLKzwE6waXF16Ozr
         ymsw==
X-Received: by 10.49.86.35 with SMTP id m3mr7809259qez.7.1382671721577; Thu,
 24 Oct 2013 20:28:41 -0700 (PDT)
Received: by 10.96.27.202 with HTTP; Thu, 24 Oct 2013 20:28:11 -0700 (PDT)
In-Reply-To: <20131025032144.GB26283@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/236649>

On Fri, Oct 25, 2013 at 10:21 AM, Jeff King <peff@peff.net> wrote:
> But if you want to simply add extra
> data that would be ignored by an existing implementation, it would be OK
> to add the data and mark it with a flag:
>
>> > +               2-byte flags (network byte order)
>> > +
>> > +                       The following flags are supported:
>> [...]
>
> That's how we added the name-hash cache in the final patch.
>
> That being said, JGit is _not_ happy with that, and complains when any
> flags besides OPT_FULL are used.  Whether that is because I am
> misinterpreting the intent of the flags field, or because JGit is being
> overly strict is up for debate.

Might be a good idea to support two classes of flags like how
extensions are handled in the index: ignore unrecognized uppercase
extension names, barf on unrecongized lowercase names. We could
partition the flag bit space more or less the same way.
-- 
Duy
