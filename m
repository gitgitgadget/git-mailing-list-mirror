From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [PATCH 0/2] gitweb: patch view
Date: Mon, 1 Dec 2008 12:02:39 +0100
Message-ID: <200812011202.41300.jnareb@gmail.com>
References: <1227966071-11104-1-git-send-email-giuseppe.bilotta@gmail.com> <200812010145.36612.jnareb@gmail.com> <cb7bb73a0811301710i383105b0j80b8dbf4563f93ca@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: git@vger.kernel.org, "Petr Baudis" <pasky@suse.cz>,
	"Junio C Hamano" <gitster@pobox.com>
To: "Giuseppe Bilotta" <giuseppe.bilotta@gmail.com>
X-From: git-owner@vger.kernel.org Mon Dec 01 12:04:16 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1L76Za-0005jV-UK
	for gcvg-git-2@gmane.org; Mon, 01 Dec 2008 12:04:15 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751211AbYLALC5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 1 Dec 2008 06:02:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751155AbYLALC5
	(ORCPT <rfc822;git-outgoing>); Mon, 1 Dec 2008 06:02:57 -0500
Received: from nf-out-0910.google.com ([64.233.182.190]:52393 "EHLO
	nf-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751124AbYLALC4 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 1 Dec 2008 06:02:56 -0500
Received: by nf-out-0910.google.com with SMTP id d3so1257268nfc.21
        for <git@vger.kernel.org>; Mon, 01 Dec 2008 03:02:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:subject:date
         :user-agent:cc:references:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:message-id;
        bh=Uu2yJbKT73A4n8GZ7D7ZxTZWkvqhgbEHx1Vd0ABcguc=;
        b=F1VbiiaMN+vgb8MnqGcLKvedNZeT7rOQSTsuYBi7u7QZ2PmM6d/R9hCi7uVfAriq4e
         Cr+ADH3Qwv/GBAtY/zSHZUYp3hASCNd4kzVjQDjSIRS999jOZTkAauGUqz/fMAPljLLb
         7PpRGCo6lbHQmY2eWU8de4ZJtjvMaoUCakZpw=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:subject:date:user-agent:cc:references:in-reply-to
         :mime-version:content-type:content-transfer-encoding
         :content-disposition:message-id;
        b=SEhRYO9X/isx8A/cxeudCoPllW+H2PYds1O2Gn2JpkFVtROPc5zZzNwmdkZYEkz/GK
         DPAmxBL9ki+iA72TVCVeWv6x7rnflEGLJ5wkSNFvz8bhBOAtv+Dhey3FKhshkh8WDPTn
         e5DAbglV2wTP8GkQ0nNLvJKSl8NS0uBFaTV/o=
Received: by 10.210.71.11 with SMTP id t11mr12426054eba.57.1228129374449;
        Mon, 01 Dec 2008 03:02:54 -0800 (PST)
Received: from ?192.168.1.11? (abwt156.neoplus.adsl.tpnet.pl [83.8.243.156])
        by mx.google.com with ESMTPS id 10sm5907153eyd.43.2008.12.01.03.02.52
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Mon, 01 Dec 2008 03:02:53 -0800 (PST)
User-Agent: KMail/1.9.3
In-Reply-To: <cb7bb73a0811301710i383105b0j80b8dbf4563f93ca@mail.gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/102018>

On Mon, 1 December 2008, Giuseppe Bilotta wrote:
> On Mon, Dec 1, 2008 at 1:45 AM, Jakub Narebski <jnareb@gmail.com> wrote:
>> On Sun, 30 Nov 2008, Giuseppe Bilotta wrote:
>>> On Sun, Nov 30, 2008 at 2:06 AM, Jakub Narebski <jnareb@gmail.com> wrote:
>>>> On Sat, 29 Nov 2008, Giuseppe Bilotta wrote:
>>>
>>>> By the way, we still might want to add somehow X-Git-Url and X-Git-Tag
>>>> headers later to 'patch' ('patchset') output format.
>>>
>>> Yeah, I've been thinking about it, but I couldn't find an easy and
>>> robust way to do it. Plus, should we add them for each patch, or just
>>> once for the whole patchset?
>>
>> True, that is a complication. Perhaps they should be added only for
>> single patch?
> 
> Although that's rather easy to implement technically, it also creates
> some kind of inconsistency.

Well, it is problem also from technical point of view. Currently we can
just stream (dump) git-format-patch output to browser (not forgetting
adding '--encoding=utf8' if it is not used already), and do not need
to have markers between commits. It is very simple code, which is its
own advantage.

>From theoretical point of view corrected X-Git-Tag functioning as
a kind of ref marker but for the raw (text/plain) output could be added
for each end every patch, so there would be no inconsistency for _this_
extra header.

I don't know what can be done about X-Git-URL.

>>> Considering I think commitdiff is ugly and long, you can guess my
>>> opinion on format_patch 8-P. 'patchset' might be a good candidate,
>>> considering it's what it does when both hash_parent and hash are
>>> given.
>>
>> True, 'patchset' might be even better, especially that it hints
>> what it does for a range a..b (not diff of endpoints, but series
>> of patches).
> 
> Good, I'll rename it.

I just don't know if it would be best name. Perhaps 'patches' would
be better?

[...]
>>> * diff(_plain): do what commitdiff(_plain) currently does for
>>> parent..hash views, modulo something to be discussed for commit
>>> messages (a shortlog rather maybe?)
>>
>> Equivalent of "git diff" (or "git diff-tree").
>>
>> Diffstat, or dirstat might be a good idea. Shortlog... I am not sure.
>> Diff is about endpoints, and they can be in reverse, too.
>>
>> There is a problem how to denote endpoints.
> 
> Hm? Doesn't parent..hash work? Or are you talking about something else?

Errr... I meant here for the user, not for gitweb. To somehow denote
before patch itself the endpoints. Just like for diff _for_ a commit
we have commit message denoting :-).

>>> * patch[set?][_plain?]: format-patch style output (maybe with option
>>> for HTML stuff too)
>>
>> Equivalent of "git format-patch".
>>
>> Actually the HTML format would be more like "git log -p", so perhaps
>> that could be handled simply as a version of 'log' view (perhaps via
>> @extra_options aka 'opt' parameter).
> 
> This is starting to get complicated ... I'm not sure how far in this I
> can go with this patchset, so for the time being I'll probably just
> stick to refining the (plain) patchset feature.

What I meant here is that it would be IMHO enough to have 'patch' view
(or whatever it ends up named) be raw format / plain/text format only,
and leave HTML equivalent for extra options/extra format to 'log' view.

[...]
>>>>> The second patch exposes it from commitdiff view (obviosly), but also
>>>>> from shortlog view, when less than 16 patches are begin shown.
>>>>
>>>> Why this nonconfigurable limit?
>>>
>>> Because the patch was actually a quick hack for the proof of concept
>>> 8-) I wasn't even sure the patch idea would have been worth it (as
>>> opposed to email-izing commitdiff_plain).
>>
>> Ah.
>>
>> Well, we might want to impose some limit to avoid generating and sending
>> patchset for a whole history. Perhaps to page size (100), or some similar
>> number?
> 
> The reason why I chose 16 is that (1) it's a rather commonly used
> 'small' number across gitweb and (2) it's a rather acceptable
> 'universal' upper limit for patchsets. There _are_ a few patchbombs
> that considerably overtake that limit, but observe that this limit is
> not an arbitrary limit on patchsets generated by the 'patchset' view,
> but only a condition for which a link is generated from shortlog view.

I see.

> We may want to have TWO limits here: one is the absolute maximum limit
> to the number of patches dumped in a patchset (to prevent DoS attacks
> by repeated requests of the whole history), and the other one is the
> limit for autogenerated patchset links.

A pageful (100 commits) as hard limit against DoS attacks?

[...]
-- 
Jakub Narebski
Poland
