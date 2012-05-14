From: jaseem abid <jaseemabid@gmail.com>
Subject: Re: Arguments to git hooks
Date: Tue, 15 May 2012 02:04:19 +0530
Message-ID: <CAH-tXsBMYe2q6dZ6COyEH7N9n-mJh4yV8O50tgeZ1PeSEnZHvQ@mail.gmail.com>
References: <CAH-tXsB4PBS_YjW4DCjT6ORmNPomQ8XMPbKx3hxVNH=FyB2u3g@mail.gmail.com>
 <4FA84A0F.6060608@pileofstuff.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git mailing list <git@vger.kernel.org>
To: Andrew Sayers <andrew-git@pileofstuff.org>
X-From: git-owner@vger.kernel.org Mon May 14 22:35:12 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SU1z5-0003Uc-OC
	for gcvg-git-2@plane.gmane.org; Mon, 14 May 2012 22:35:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757721Ab2ENUfE (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 14 May 2012 16:35:04 -0400
Received: from mail-wg0-f44.google.com ([74.125.82.44]:33667 "EHLO
	mail-wg0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757178Ab2ENUfC (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 14 May 2012 16:35:02 -0400
Received: by wgbdr13 with SMTP id dr13so5074869wgb.1
        for <git@vger.kernel.org>; Mon, 14 May 2012 13:35:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=fFJHG+0kEk7gLlZfAtMpiVUtGsC3RLkle549AhlaXaM=;
        b=DwftD4G5RsLkphmUJkCyGPwhWO/2oo2cP6prnC64oNdOWT6OC/FnLbxBpE1mqFsFuc
         Q4KoF+Ok/qtI4iEMPPpPeXDycBIZQLcHX5uytj4jnt0LWcLbXJQDdNV+PwM41+/dCLm7
         ssvwDIQCPNoo0tyKvOljki+kYBsstajRDF2B7Yuw+D20S4HTjAGltLiTyPDq8k7jQPva
         4FcEj2GX/7gCCdA8dgBN01K32JZ43IV5rUyIpidC76n8dvh8oq7c3CG7kxqb7cnWWOIv
         nDOmgsy6ZPbly7l0HH9H0D2EU2NzkqmndrjvYM6gJ7SMRej1s8YxZRyj75zwKnrdisx8
         a93w==
Received: by 10.216.194.137 with SMTP id m9mr4990481wen.66.1337027701175; Mon,
 14 May 2012 13:35:01 -0700 (PDT)
Received: by 10.227.39.96 with HTTP; Mon, 14 May 2012 13:34:19 -0700 (PDT)
In-Reply-To: <4FA84A0F.6060608@pileofstuff.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/197808>

On Tue, May 8, 2012 at 3:47 AM, Andrew Sayers
<andrew-git@pileofstuff.org> wrote:
> On 06/05/12 19:35, jaseem abid wrote:
>> Hello all,
>>
>> I am trying to write a hook '.git/hooks/commit-msg' to be run before
>> every commit.
>>
>> How can I pass arguments to the script? Now by default the only arg I
>> am getting is `.git/COMMIT_EDITMSG'`. I would love to get the list of
>> files I tried to commit also into the script so that I can run a lint
>> program on it before committing it. How can I get this done?
>
> First, a standard warning - consider using a pre-receive hook instead of
> a pre-commit hook.

I am trying to get a lint, commit message spell checker, trailing
whitespace check in code etc work on my *local machine* before
committing. pre-receive works in the server right? Its also time I
need to seriously consider a pre-commit hook to "Reject commits made
between 4am and 7am with a note to go to bed."

> A lot of git's power comes from making commits as
> cheap as possible, so rules like "no committing until your code is
> pretty" tend to stifle people.

Its ok since I am the only one to use it because I want to make my
commits cleaner and better.  There is always --no-verify for skipping
hooks.

> The best solution I've found is a `git commit` wrapper that does
> something like `CHANGES="$(git commit $@ --dry-run -v)"` to get a
> reliable diff, then starts work from there.

Isn't `git commit $@ --dry-run --porcelain` better for parsing or am I
missing something ?

-- 
Jaseem Abid
http://jaseemabid.github.com
