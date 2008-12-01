From: "Giuseppe Bilotta" <giuseppe.bilotta@gmail.com>
Subject: Re: [PATCH 0/2] gitweb: patch view
Date: Mon, 1 Dec 2008 02:10:58 +0100
Message-ID: <cb7bb73a0811301710i383105b0j80b8dbf4563f93ca@mail.gmail.com>
References: <1227966071-11104-1-git-send-email-giuseppe.bilotta@gmail.com>
	 <200811300206.23240.jnareb@gmail.com>
	 <cb7bb73a0811291744t2bb9c8c1t1dac497705e2c3c2@mail.gmail.com>
	 <200812010145.36612.jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, "Petr Baudis" <pasky@suse.cz>,
	"Junio C Hamano" <gitster@pobox.com>
To: "Jakub Narebski" <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Mon Dec 01 02:12:38 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1L6xL1-0004vS-5o
	for gcvg-git-2@gmane.org; Mon, 01 Dec 2008 02:12:35 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756720AbYLABLB (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 30 Nov 2008 20:11:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756713AbYLABLB
	(ORCPT <rfc822;git-outgoing>); Sun, 30 Nov 2008 20:11:01 -0500
Received: from ey-out-2122.google.com ([74.125.78.26]:57457 "EHLO
	ey-out-2122.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756551AbYLABK7 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 30 Nov 2008 20:10:59 -0500
Received: by ey-out-2122.google.com with SMTP id 6so942603eyi.37
        for <git@vger.kernel.org>; Sun, 30 Nov 2008 17:10:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to
         :subject:cc:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:references;
        bh=BF4TPWTL4ldJOjkqr/2chOHT4wu/ahyiRRFbwTOd9uk=;
        b=jGu8cWtZXUgmS6iYAmq9YKjqdMJ58dERKoHtIFoQ8BIcF8rTvdhIvmPJzzrb+80/xn
         Qb3mHWKXlQzhsowOGTIm59u7mAdSXDHGhoN2TyRFbg4fUcnVLlCfFT7Bks8XSls19Gum
         wkF+3Cayd1nnPVqPB0gUE12j7IAeMc4wdx/Hs=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version
         :content-type:content-transfer-encoding:content-disposition
         :references;
        b=BN4E2Oj5hWwUzOW7DvGxa6VWU4N6uELxhjG9MUJjXMNn6BIpXAI5XdrzR4tXzBFb7q
         qRx7khDIiIwewfXzSOWxA1WR/K46yPK9AeRQAvWJOuSv/MXmoPVvSQZxGt7iQtMrA3d/
         N/OSwD9mK0ZMl/TzYd7VZxGH0V2my52UY3qZs=
Received: by 10.210.52.15 with SMTP id z15mr11963762ebz.42.1228093858677;
        Sun, 30 Nov 2008 17:10:58 -0800 (PST)
Received: by 10.210.79.12 with HTTP; Sun, 30 Nov 2008 17:10:58 -0800 (PST)
In-Reply-To: <200812010145.36612.jnareb@gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/101996>

On Mon, Dec 1, 2008 at 1:45 AM, Jakub Narebski <jnareb@gmail.com> wrote:
> On Sun, 30 Nov 2008, Giuseppe Bilotta wrote:
>> On Sun, Nov 30, 2008 at 2:06 AM, Jakub Narebski <jnareb@gmail.com> wrote:
>>> On Sat, 29 Nov 2008, Giuseppe Bilotta wrote:
>>
>>> By the way, we still might want to add somehow X-Git-Url and X-Git-Tag
>>> headers later to 'patch' ('patchset') output format.
>>
>> Yeah, I've been thinking about it, but I couldn't find an easy and
>> robust way to do it. Plus, should we add them for each patch, or just
>> once for the whole patchset?
>
> True, that is a complication. Perhaps they should be added only for
> single patch?

Although that's rather easy to implement technically, it also creates
some kind of inconsistency.

>> Considering I think commitdiff is ugly and long, you can guess my
>> opinion on format_patch 8-P. 'patchset' might be a good candidate,
>> considering it's what it does when both hash_parent and hash are
>> given.
>
> True, 'patchset' might be even better, especially that it hints
> what it does for a range a..b (not diff of endpoints, but series
> of patches).

Good, I'll rename it.

>> We can probably consider deprecating commitdiff(_plain) and have the
>> following three views:
>>
>> * commit(_plain): do what commitdiff(_plain) currently does for a single commit
>
> Equivalent of "git show" (and not merely "git cat-file -t commit").
>
>> * diff(_plain): do what commitdiff(_plain) currently does for
>> parent..hash views, modulo something to be discussed for commit
>> messages (a shortlog rather maybe?)
>
> Equivalent of "git diff" (or "git diff-tree").
>
> Diffstat, or dirstat might be a good idea. Shortlog... I am not sure.
> Diff is about endpoints, and they can be in reverse, too.
>
> There is a problem how to denote endpoints.

Hm? Doesn't parent..hash work? Or are you talking about something else?

>> * patch[set?][_plain?]: format-patch style output (maybe with option
>> for HTML stuff too)
>
> Equivalent of "git format-patch".
>
> Actually the HTML format would be more like "git log -p", so perhaps
> that could be handled simply as a version of 'log' view (perhaps via
> @extra_options aka 'opt' parameter).

This is starting to get complicated ... I'm not sure how far in this I
can go with this patchset, so for the time being I'll probably just
stick to refining the (plain) patchset feature.

>>> What 'patch' view does, what might be not obvious from this description
>>> and from first patch in series, is to show diffs for _series_ of
>>> commits. It means equivalent of "git log -p" or "git whatchanged".
>>> It might make more sense to have plain git-format-patch output, but it
>>> could be useful to have some kind of 'git log -p' HTML output.
>>>
>>> So even if 'commitdiff' / 'commitdiff_plain' is fixed, 'patch' whould
>>> still have its place.
>>
>> Nice to know. Do consider the current version more of a
>> proof-of-concept that some definitive code.
>
> Ah. O.K. It would be nice if this patch was marked as RFC (well, lack
> of signoff hints at this), or as WIP, or as PoC,...

Damn,  I always forget about that.

>>>> The second patch exposes it from commitdiff view (obviosly), but also
>>>> from shortlog view, when less than 16 patches are begin shown.
>>>
>>> Why this nonconfigurable limit?
>>
>> Because the patch was actually a quick hack for the proof of concept
>> 8-) I wasn't even sure the patch idea would have been worth it (as
>> opposed to email-izing commitdiff_plain).
>
> Ah.
>
> Well, we might want to impose some limit to avoid generating and sending
> patchset for a whole history. Perhaps to page size (100), or some similar
> number?

The reason why I chose 16 is that (1) it's a rather commonly used
'small' number across gitweb and (2) it's a rather acceptable
'universal' upper limit for patchsets. There _are_ a few patchbombs
that considerably overtake that limit, but observe that this limit is
not an arbitrary limit on patchsets generated by the 'patchset' view,
but only a condition for which a link is generated from shortlog view.

We may want to have TWO limits here: one is the absolute maximum limit
to the number of patches dumped in a patchset (to prevent DoS attacks
by repeated requests of the whole history), and the other one is the
limit for autogenerated patchset links.

BTW, autogenerated patchset links probably make sense taking some
previous branch name as point of reference. e.g., if I have branch1
within the history of branch2, we probably want some (semi)automatic
way of getting a patchset for branch1..branch2 --of course, we also
want to do a shortlog between them, so that's a more general feature
we should think about.


-- 
Giuseppe "Oblomov" Bilotta
