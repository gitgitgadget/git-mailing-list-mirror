From: "Giuseppe Bilotta" <giuseppe.bilotta@gmail.com>
Subject: Re: [PATCH 0/2] gitweb: patch view
Date: Wed, 3 Dec 2008 10:25:22 +0100
Message-ID: <cb7bb73a0812030125h3456d4d6occe6b6509b8d21c9@mail.gmail.com>
References: <1227966071-11104-1-git-send-email-giuseppe.bilotta@gmail.com>
	 <200812010145.36612.jnareb@gmail.com>
	 <cb7bb73a0811301710i383105b0j80b8dbf4563f93ca@mail.gmail.com>
	 <200812011202.41300.jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, "Petr Baudis" <pasky@suse.cz>,
	"Junio C Hamano" <gitster@pobox.com>
To: "Jakub Narebski" <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Wed Dec 03 10:26:55 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1L7o0T-0005b1-1R
	for gcvg-git-2@gmane.org; Wed, 03 Dec 2008 10:26:53 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750758AbYLCJZ3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 3 Dec 2008 04:25:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750740AbYLCJZ2
	(ORCPT <rfc822;git-outgoing>); Wed, 3 Dec 2008 04:25:28 -0500
Received: from ey-out-2122.google.com ([74.125.78.24]:32673 "EHLO
	ey-out-2122.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750718AbYLCJZY (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 3 Dec 2008 04:25:24 -0500
Received: by ey-out-2122.google.com with SMTP id 6so1457489eyi.37
        for <git@vger.kernel.org>; Wed, 03 Dec 2008 01:25:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to
         :subject:cc:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:references;
        bh=eunv/ub0QXVzXDDYu++SicfFvwyj845kDC5ysHGZHqI=;
        b=d859UWKf5CqYCmMS4R0M+oOi4nZd3XVyRxS8BuYI62nT5C22JyJNFhjvmUGFs81yzD
         IcLLjEBpZDFwlp+GvcHgB9gh7Bz8LxIrZpp7IeuZgDMNclyScPnBqXWxcvxPaAevAUE4
         hP1L8GzqaHrj9do5WlJvNo/GKaPd38Oaq8Afc=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version
         :content-type:content-transfer-encoding:content-disposition
         :references;
        b=NjdOcu7BdqQD3XeUq4AyDf6QCJwCuKcvdubT9UAqDEd9SgxVK6+TmmmW1IRWEo3brs
         Ax3xnuNhLVkoBEGtbi/Fk534QKc959k9J1ZyevIcUWuWGCZzLTLrPRFyCt/vh3qcClfJ
         Ii/kcGRMB/DuJCM3q52mk3YY5whg/EedAuDYo=
Received: by 10.210.125.13 with SMTP id x13mr15130109ebc.198.1228296322336;
        Wed, 03 Dec 2008 01:25:22 -0800 (PST)
Received: by 10.210.79.12 with HTTP; Wed, 3 Dec 2008 01:25:22 -0800 (PST)
In-Reply-To: <200812011202.41300.jnareb@gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/102232>

On Mon, Dec 1, 2008 at 12:02 PM, Jakub Narebski <jnareb@gmail.com> wrote:
> On Mon, 1 December 2008, Giuseppe Bilotta wrote:
>> On Mon, Dec 1, 2008 at 1:45 AM, Jakub Narebski <jnareb@gmail.com> wrote:
>>> On Sun, 30 Nov 2008, Giuseppe Bilotta wrote:
>>>> On Sun, Nov 30, 2008 at 2:06 AM, Jakub Narebski <jnareb@gmail.com> wrote:
>>>>> On Sat, 29 Nov 2008, Giuseppe Bilotta wrote:
>>>>
>>>>> By the way, we still might want to add somehow X-Git-Url and X-Git-Tag
>>>>> headers later to 'patch' ('patchset') output format.
>>>>
>>>> Yeah, I've been thinking about it, but I couldn't find an easy and
>>>> robust way to do it. Plus, should we add them for each patch, or just
>>>> once for the whole patchset?
>>>
>>> True, that is a complication. Perhaps they should be added only for
>>> single patch?
>>
>> Although that's rather easy to implement technically, it also creates
>> some kind of inconsistency.
>
> Well, it is problem also from technical point of view. Currently we can
> just stream (dump) git-format-patch output to browser (not forgetting
> adding '--encoding=utf8' if it is not used already), and do not need
> to have markers between commits. It is very simple code, which is its
> own advantage.
>
> From theoretical point of view corrected X-Git-Tag functioning as
> a kind of ref marker but for the raw (text/plain) output could be added
> for each end every patch, so there would be no inconsistency for _this_
> extra header.
>
> I don't know what can be done about X-Git-URL.

I'm thinking that the best way to achieve these results would be to
have some way to specify extra headers to git format-patch from the
command line and not just from a config file. Plus, we want to make
them 'dynamic' in the sense that we want to be able to put hash or ref
names etc in them. For the moment I'll mark this 'TODO' in the file.

>>>> Considering I think commitdiff is ugly and long, you can guess my
>>>> opinion on format_patch 8-P. 'patchset' might be a good candidate,
>>>> considering it's what it does when both hash_parent and hash are
>>>> given.
>>>
>>> True, 'patchset' might be even better, especially that it hints
>>> what it does for a range a..b (not diff of endpoints, but series
>>> of patches).
>>
>> Good, I'll rename it.
>
> I just don't know if it would be best name. Perhaps 'patches' would
> be better?

The only thing I don't like about 'patches' is that if you ask for a
single commit you get a single patch. I'd rather stick to 'patch'
then, maybe make 'patches' a synonym?

>>>> * diff(_plain): do what commitdiff(_plain) currently does for
>>>> parent..hash views, modulo something to be discussed for commit
>>>> messages (a shortlog rather maybe?)
>>>
>>> Equivalent of "git diff" (or "git diff-tree").
>>>
>>> Diffstat, or dirstat might be a good idea. Shortlog... I am not sure.
>>> Diff is about endpoints, and they can be in reverse, too.
>>>
>>> There is a problem how to denote endpoints.
>>
>> Hm? Doesn't parent..hash work? Or are you talking about something else?
>
> Errr... I meant here for the user, not for gitweb. To somehow denote
> before patch itself the endpoints. Just like for diff _for_ a commit
> we have commit message denoting :-).

Ah, in the sense that you have to specify parent..hash manually in the
URL presently? I've seen some patches to non-main gitweb doing this
kind of thing. If it got merged with upstream we could use that as
well.

>>>> * patch[set?][_plain?]: format-patch style output (maybe with option
>>>> for HTML stuff too)
>>>
>>> Equivalent of "git format-patch".
>>>
>>> Actually the HTML format would be more like "git log -p", so perhaps
>>> that could be handled simply as a version of 'log' view (perhaps via
>>> @extra_options aka 'opt' parameter).
>>
>> This is starting to get complicated ... I'm not sure how far in this I
>> can go with this patchset, so for the time being I'll probably just
>> stick to refining the (plain) patchset feature.
>
> What I meant here is that it would be IMHO enough to have 'patch' view
> (or whatever it ends up named) be raw format / plain/text format only,
> and leave HTML equivalent for extra options/extra format to 'log' view.

Ah, ok. I'll resubmit a cleaned up version of these two patches for
the time being then.

>>>>>> The second patch exposes it from commitdiff view (obviosly), but also
>>>>>> from shortlog view, when less than 16 patches are begin shown.
>>>>>
>>>>> Why this nonconfigurable limit?
>>>>
>>>> Because the patch was actually a quick hack for the proof of concept
>>>> 8-) I wasn't even sure the patch idea would have been worth it (as
>>>> opposed to email-izing commitdiff_plain).
>>>
>>> Ah.
>>>
>>> Well, we might want to impose some limit to avoid generating and sending
>>> patchset for a whole history. Perhaps to page size (100), or some similar
>>> number?
>>
>> The reason why I chose 16 is that (1) it's a rather commonly used
>> 'small' number across gitweb and (2) it's a rather acceptable
>> 'universal' upper limit for patchsets. There _are_ a few patchbombs
>> that considerably overtake that limit, but observe that this limit is
>> not an arbitrary limit on patchsets generated by the 'patchset' view,
>> but only a condition for which a link is generated from shortlog view.
>
> I see.
>
>> We may want to have TWO limits here: one is the absolute maximum limit
>> to the number of patches dumped in a patchset (to prevent DoS attacks
>> by repeated requests of the whole history), and the other one is the
>> limit for autogenerated patchset links.
>
> A pageful (100 commits) as hard limit against DoS attacks?

I suspect 100 is too hight already, but I guess we can tune it later.

-- 
Giuseppe "Oblomov" Bilotta
