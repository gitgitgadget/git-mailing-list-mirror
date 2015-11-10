From: Stefan Beller <sbeller@google.com>
Subject: Re: Allow git alias to override existing Git commands
Date: Tue, 10 Nov 2015 12:22:56 -0800
Message-ID: <CAGZ79kZ9zw+Lf4P7EFxZ6Q7PK7GrTFZokPgtEJ-Gcdp3pHkurA@mail.gmail.com>
References: <56421BD9.5060501@game-point.net>
	<CAGZ79kZxQWVMe3N1ti8npyp9_4DUPAVy9Uk5a75Jwh3Eud2eZQ@mail.gmail.com>
	<56424DDE.2030808@game-point.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: "git@vger.kernel.org" <git@vger.kernel.org>
To: Jeremy Morton <admin@game-point.net>
X-From: git-owner@vger.kernel.org Tue Nov 10 21:23:04 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZwFRV-0006XF-Rt
	for gcvg-git-2@plane.gmane.org; Tue, 10 Nov 2015 21:23:02 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751306AbbKJUW6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 10 Nov 2015 15:22:58 -0500
Received: from mail-yk0-f174.google.com ([209.85.160.174]:33013 "EHLO
	mail-yk0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751028AbbKJUW5 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 10 Nov 2015 15:22:57 -0500
Received: by ykdv3 with SMTP id v3so14505389ykd.0
        for <git@vger.kernel.org>; Tue, 10 Nov 2015 12:22:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=fIDK5rp9VUJTNRAghcL27+lKr4kKUPrDXJzgyioISus=;
        b=gWKNzY2iVxUJt6AR3q0yISkZqBin7rtvQl8dUlagaEFtubbPfry3PCZTFy/PnjGOwz
         8XcJjdsMPEAzHb7Qzds5C6Q5GwJenGzJBLSIFUXWrziokWZ66RuX4kuPhH9ziEcBm3ay
         ReRshOrhaGQDjF2eVpM1zQCSVXiki2eWX84Aau2s/gOeS2l61SZSN6kO4TRSlr5GvYXa
         pt1u2pMc9QGs9S17usEON7R5JGvjkxD5KF61gkT2cOBSltM6FySNgc3mARK1Tl8ew5um
         wB1jJSQhzKQ2VOKraClmLiv7Q6Tiu3uxT14CaSTNDkmvLfgq/Q6k8jRvlgSrGvfq1Jrx
         xTLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type;
        bh=fIDK5rp9VUJTNRAghcL27+lKr4kKUPrDXJzgyioISus=;
        b=HrXZWJvWEvTWPAm6aAUZitNJsE2tSc9+yCo8+H4VLPHK/8v+GXymns6LCcl4GN52i8
         1weT2CALIwniE4Lq4EmE66azoq3Qf7XblV3IeO3Cp1UuE+657CpBjslIlacIRCmb+nKC
         PwqzytWZT2U19Wn/r63dCIvkyzrwPA6mpbBgGm8gpY1SoU5M9rEYNlzHf07azBP3BLNr
         TBr+4yug0cFVVfe5B/VYpFz9f7C4Yw8KwMqVB588eX+cUtYTvjq6YXYptkYyzmY/Km5y
         lls2Dp02WcSV6AX0XXrbe2v/rBXZNoO2SM6RklJt/dUGqdcs0HbZNLLxhllejfM+wubi
         1RjA==
X-Gm-Message-State: ALoCoQmoTn8SmMsS7xidDkatzzzxFiGUHeoYBpeTEVpASHNPP3oKoHWSiThDoqzd0QQ0EqKY/gE2
X-Received: by 10.13.210.4 with SMTP id u4mr5128895ywd.68.1447186976408; Tue,
 10 Nov 2015 12:22:56 -0800 (PST)
Received: by 10.37.196.70 with HTTP; Tue, 10 Nov 2015 12:22:56 -0800 (PST)
In-Reply-To: <56424DDE.2030808@game-point.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/281132>

On Tue, Nov 10, 2015 at 12:04 PM, Jeremy Morton <admin@game-point.net> wrote:
> On 10/11/2015 18:12, Stefan Beller wrote:
>>
>> On Tue, Nov 10, 2015 at 8:31 AM, Jeremy Morton<admin@game-point.net>
>> wrote:
>>>
>>> It's recently come to my attention that the "git alias" config
>>> functionality
>>> ignores all aliases that would override existing Git commands.  This
>>> seems
>>> like a bad idea to me.
>>
>>
>> This ensures that the plumbing commands always work as expected.
>> As scripts *should* only use plumbing commands, the scripts should
>> work with high probability despite all the crazy user
>> configuration/aliases.
>>
>
> I just disagree with this.  If a user chooses to override their Git
> commands, it's their problem.  Why should Git care about this?

Because we still have some Git commands (i.e. git submodule) as scripts,
which would break if the user aliases plumbing commands. This is unexpected,
so should be avoided. Maybe we could allow aliasing porcelain commands though,
but that is extra effort, which nobody looked into yet.

> It should
> provide the user with the option to do this, and if the user ruins scripts
> because of their aliases, it is not Git's problem.  What you are doing is
> taking away power from users to use git aliases to their full potential.

Yeah, no user asked for that power I guess, you're the first. :)

As from your initial email, I think before trying to overriding 'clone'
to 'clone --recurse' you'd rather want to have a globally configured
option to recurse by default on invocation of 'clone'.
That sounds saner to me at least.

Stefan
