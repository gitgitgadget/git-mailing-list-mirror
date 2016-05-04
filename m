From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCHv4] submodule deinit: require '--all' instead of '.' for
 all submodules
Date: Wed, 4 May 2016 16:59:14 -0700
Message-ID: <20160504235914.GD395@google.com>
References: <1462401603-2067-1-git-send-email-sbeller@google.com>
 <20160504232642.GC395@google.com>
 <CAGZ79kbeCCcmGh57zUdQ=BzFOWUiwj8-3nM4dbK9yONbrmLaPw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>,
	"git@vger.kernel.org" <git@vger.kernel.org>,
	Jens Lehmann <Jens.Lehmann@web.de>
To: Stefan Beller <sbeller@google.com>
X-From: git-owner@vger.kernel.org Thu May 05 01:59:25 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ay6hQ-0000r2-23
	for gcvg-git-2@plane.gmane.org; Thu, 05 May 2016 01:59:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754904AbcEDX7T (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 4 May 2016 19:59:19 -0400
Received: from mail-pf0-f176.google.com ([209.85.192.176]:35854 "EHLO
	mail-pf0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754519AbcEDX7S (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 4 May 2016 19:59:18 -0400
Received: by mail-pf0-f176.google.com with SMTP id c189so31806079pfb.3
        for <git@vger.kernel.org>; Wed, 04 May 2016 16:59:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=BjcNjhTRC5wSTVeZQMeKeMj45s+Jx/lecMxYQLdWoNo=;
        b=qurpKmN2Cv5y02Ce9hFIUvVxzx+xeQUVgzwpiNcvpKQ/TAHaSjSjmejqbNFvfEcjZK
         HrkpRWBVAOqIXnnCCjEde7kMR24535EzN5nRB/pfj5GQPP+ElDQ3TthA1E4jadSpi43d
         Lw0nJpTtjUVSaKv5L2Ii/0YuO5JJwo5XjwwSFBy+PTC+HiXKvL3q33oP66nXdp6grW8n
         mdoq//8790pi+uumYp8N2FhILL1ySEERoWE4ijsHxL7G83KhKXYvKnkMNzpjHsuMYBlW
         1pSyUnIA+XsvfjSVrkORfsOz2gisk6rKfXCpi9y04J6KQD5fuFQ7sjX6wEj08IRV69qD
         8fJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=BjcNjhTRC5wSTVeZQMeKeMj45s+Jx/lecMxYQLdWoNo=;
        b=EuFtRRad9B/9vCPpCDrcqOERFBXF4f1pJJmSJgiJ/lufzBv0BWaXFaEY6XkrDGDJQD
         5rODtpe7BLA1KJToMb3eNTGUrAIJYtJ7Kk/qVjGEW0TN6Ri9YoRWIHv4HdfEvd2j44js
         PI1Lug/NDRWMvkVJspLpaCwqvi3NZGJgpHb7WH9yPK3Z+PSgpteMv/OSMBuq7ksfavR4
         en7TfjTGWe2ZUWpD5qshYQaTg5z3A7Nqkg8iMZxJdVcWFO+mMcMzXe5ANVv/nECY/2Pe
         LW/G22S/Oe4ijVEzIiOoz3tpA1sXTsYDBAQKawMYYItHZHJ8ZMH5UbI1Cm0bnlrBrrRn
         8EQQ==
X-Gm-Message-State: AOPr4FX93TYmqeT+9+MpFqKvwv+Fobfv0ZPdDBpCuxNicM1Uy2Al0GTMARNWBHyaP2rk2w==
X-Received: by 10.98.84.65 with SMTP id i62mr16135633pfb.97.1462406357524;
        Wed, 04 May 2016 16:59:17 -0700 (PDT)
Received: from google.com ([2620:0:1000:5b00:2402:f378:bbc1:db8f])
        by smtp.gmail.com with ESMTPSA id s64sm8603159pfi.77.2016.05.04.16.59.16
        (version=TLSv1/SSLv3 cipher=OTHER);
        Wed, 04 May 2016 16:59:16 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <CAGZ79kbeCCcmGh57zUdQ=BzFOWUiwj8-3nM4dbK9yONbrmLaPw@mail.gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/293629>

Stefan Beller wrote:
> On Wed, May 4, 2016 at 4:26 PM, Jonathan Nieder <jrnieder@gmail.com> wrote:

>> I think this paragraph could be removed.  --all is explained lower
>> down and the error message points it out to users who need it.
>
> When we want to keep supporting '.' forever, I would remove this section.

Yes, please.  We can't remove something like that without a deprecation
process that I don't think is worth it here.

[...]
>>> +-a::
>>> +--all::
>>> +     This option is only valid for the deinit command. Unregister all
>>> +     submodules in the working tree.
>>
>> This could use an explanation of why I'd want to use it.  E.g.
>>
>>         This option is only valid for the deinit command. Unregister all
>>         submodules. Scripts should use this option instead of passing '.'
>>         to deinit because it works even in an empty repository with no
>>         submodules present.
>
> I would not want to mention '.' in the documentation. this can read:
>
>     As a user I am fine to use '.' and then I wonder when it breaks.

Sorry for the lack of clarity.  By referencing scripts I was referring
to "callers that want to be able to run the same command in all
situations, even the edge case of no files present".  I agree with you
that humans should care just as much as scripts about things that will
break and that we shouldn't break them. :)

[...]
>>> @@ -257,8 +270,8 @@ OPTIONS
>>>  --force::
>>>       This option is only valid for add, deinit and update commands.
>>>       When running add, allow adding an otherwise ignored submodule path.
>>> -     When running deinit the submodule work trees will be removed even if
>>> -     they contain local changes.
>>> +     When running deinit the submodule working trees will be removed even
>>> +     if they contain local changes.
>>
>> Unrelated change?
>
> It's close enough for deinit to squash it in here, no?

My preference would be to have a separate patch since its commit message
can explain the purpose.  I don't care much --- it was just something I
noticed while reviewing the rest.

[...]
>>> +     if test -n "$deinit_all" && test "$#" -ne 0
>>> +     then
>>> +             die "$(eval_gettext "--all and pathspec are incompatible")"
>>
>> This message still feels too low-level to me, but I might be swimming
>> uphill here.
>>
>> Another option would be to call 'usage' and be done.
>
> I had that idea as well, but I think pointing out the low level is better
> than giving the high level again, so the user immediately sees what's wrong.

I mean low level as in implementation detail.  The human user would
wonder "what is incompatible about them?  Why are you stopping me from
what I am trying to do?"  Most likely the user was trying to do
something other than specify a path, since they also passed --all.  If
I run something like

	git submodule deinit force --all

and the output tells me that --all and pathspec are incompatible then
I just scratch my head more.

We can do

	USAGE="$dashless [--quiet] deinit [-f|--force] (--all | [--] <path>...)"
	usage

to print the subcommand's usage.  git commandline tools don't
translate any usage strings today, so not getting translation here
wouldn't feel out of place.

[...]
>> In the context of the original motivation: this patch improves the
>> advice printed by plain "git submodule deinit" but doesn't help with
>> existing callers that might have run "git submodule deinit .".  It might
>> make sense to handle '.' as a historical special case in a separate
>> patch.
>
> Once we change how '.' is handled we can do that?

It's harmless even before then.  Anyway, I meant "as a preparatory step
before such a change that would otherwise be backward incompatible."

Thanks,
Jonathan
