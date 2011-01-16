From: Sam Vilain <sam@vilain.net>
Subject: Re: Resumable clone/Gittorrent (again)
Date: Sun, 16 Jan 2011 15:11:36 +1300
Message-ID: <4D3253D8.8030302@vilain.net>
References: <AANLkTinUV9Z_w85Gz13J+bm8xqnxJ9jBJXJm9bn5Y2ec@mail.gmail.com> <alpine.LFD.2.00.1101061956470.22191@xanadu.home> <AANLkTikKn1+2OX1KPy+9US_yX=E6+CiaCTTB6yqnAWwW@mail.gmail.com> <AANLkTimgn2_BWYjbGKbGoeGJ=erKundX4umfy=s16dB1@mail.gmail.com> <AANLkTim2A4=y=XcuPuPiYGDGZyKAUEk-yv2cZVEGhQ3C@mail.gmail.com> <AANLkTi=KPVMEviQhyJeWHynPa2q6NJpQ2VyAhbRcmQ1D@mail.gmail.com> <AANLkTinwb8orMBjcQjK0ogXd6rMEtRwT8SV41k8D3AXL@mail.gmail.com> <AANLkTimkDYCL7+N-Rno1-0p3Gy6o0wYrnuStV_n5k4Hk@mail.gmail.com> <AANLkTi=3ikJ2UNNCW582CT7LQ7o2DBZ1hXJhPfMUNbKk@mail.gmail.com> <4D2F8D7E.6030305@vilain.net> <AANLkTi=8s4mjreC1yiJi4R5Y3G6_kErmBfk0B9ALcBO8@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: Nguyen Thai Ngoc Duy <pclouds@gmail.com>,
	Nicolas Pitre <nico@fluxnic.net>,
	Git Mailing List <git@vger.kernel.org>
To: Luke Kenneth Casson Leighton <luke.leighton@gmail.com>
X-From: git-owner@vger.kernel.org Sun Jan 16 03:16:30 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PeIAP-0001au-CU
	for gcvg-git-2@lo.gmane.org; Sun, 16 Jan 2011 03:16:29 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754330Ab1APCLn (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 15 Jan 2011 21:11:43 -0500
Received: from mx6.orcon.net.nz ([219.88.242.56]:51574 "EHLO mx6.orcon.net.nz"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754285Ab1APCLm (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 15 Jan 2011 21:11:42 -0500
Received: from Debian-exim by mx6.orcon.net.nz with local (Exim 4.69)
	(envelope-from <sam@vilain.net>)
	id 1PeI5k-0003Z5-Ie
	for git@vger.kernel.org; Sun, 16 Jan 2011 15:11:40 +1300
Received: from [60.234.254.246] (helo=mail.utsl.gen.nz)
	by mx6.orcon.net.nz with esmtp (Exim 4.69)
	(envelope-from <sam@vilain.net>)
	id 1PeI5k-0003Yy-7U
	for git@vger.kernel.org; Sun, 16 Jan 2011 15:11:40 +1300
Received: by mail.utsl.gen.nz (Postfix, from userid 1004)
	id 1B61F2E09D; Sun, 16 Jan 2011 15:11:40 +1300 (NZDT)
X-Spam-Checker-Version: SpamAssassin 3.3.1 (2010-03-16) on naos.lan
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=5.0 tests=ALL_TRUSTED,BAYES_00
	autolearn=unavailable version=3.3.1
Received: from [192.168.1.83] (arcturus.lan [192.168.1.83])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.utsl.gen.nz (Postfix) with ESMTPSA id 6A6202E094;
	Sun, 16 Jan 2011 15:11:36 +1300 (NZDT)
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.9.2.12) Gecko/20101027 Thunderbird/3.1.6
In-Reply-To: <AANLkTi=8s4mjreC1yiJi4R5Y3G6_kErmBfk0B9ALcBO8@mail.gmail.com>
X-Enigmail-Version: 1.1.2
X-DSPAM-Check: by mx6.orcon.net.nz on Sun, 16 Jan 2011 15:11:40 +1300
X-DSPAM-Result: Innocent
X-DSPAM-Processed: Sun Jan 16 15:11:40 2011
X-DSPAM-Confidence: 0.7622
X-DSPAM-Probability: 0.0000
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/165153>

On 15/01/11 03:26, Luke Kenneth Casson Leighton wrote:
>>> and change that graph?  are you _certain_ that you can write an
>>> algorithm which is capable of generating exactly the same mapping,
>>> even as more commits are added to the repository being mirrored, or,
>>> does that situation not matter?
>> For a given set of start and end points, and a given sort algorithm,
>> walking the commit tree can yield deterministic results.
>  excellent.  out of curiosity, is it as efficient as git pack-objects
> for the same start and end points?

That isn't a sensible question; walking the revision tree is something
that many commands, including git pack-objects, do internally.

>> Did you look at any of the previous research I linked to before?
>  i've been following this since you first originally started it, sam
> :)  it would have been be nice if it was a completed implementation
> that i could test and see "for real" what you're referring to (above)
> - the fact that it's in perl and has "TODO" at some of the critical
> points, after trying to work with it for several days i stopped and
> went "i'm not getting anywhere with this" and focussed on bittorrent
> "as a black box" instead.
>
>  if i recall, the original gittorrent work that you did (mirror-sync),
> the primary aim was to rely solely and exclusively on a one-to-one
> direct link between one machine and another.  in other words, whilst
> syncing, if that peer went "offline", you're screwed - you have to
> start again.  is that a fair assessment?  please do correct any
> assumptions that i've made.

Ok.  Well, first off - I didn't start gittorrent; that was Jonas
Fonseca, it was his Masters thesis.  Criticism about not having a
completed implementation to work with is therefore shared between him
and people who have come along since such as myself.

I don't know why you got the idea that the protocol is one to one.  It's
one to one just like BitTorrent is - every communication is between two
nodes who share information about what they have and what they need,
before transferring data.  It is supposed to be restartable and it is
not supposed to matter which node data is exchanged with.  In that way,
you could in principle download from multiple nodes at once, or you
could have restartable transfers.  If you lose connectivity then the
most that should have to be re-transferred are incomplete blocks.

>  because on the basis _of_ that assumption, i decided not to proceed
> with mirror-sync, instead to pursue a "cache git pack-objects"
> approach and to use bittorrent "black-box-style".  which i
> demonstrated (minus the cacheing) works perfectly well, several months
> back.

Right, but as others have noted, there are significant drawbacks with
this approach.  For a start, to participate in such a network, you need
to get the particular exact pack that is currently being torrented; just
having a clone is not enough.  This is because the result of git
pack-objects is not repeatable.

That being said for many projects that would be an acceptable compromise
for the advantages of a restartable clone.  That is why I suggest that a
torrent transfer, treated as a mirror which is infrequently updated, may
be a better approach than trying to overly automate everything.

>  as well, after nicolas and others went to all the trouble to explain
> what git pack-objects is, how it works, and how damn efficient it is,
> i'm pretty much convinced that an approach to uniquely identify, then
> pick and cache the *best* git pack-object made [by all the peers
> requested to provide a particular commit range], is the best, most
> efficient - and importantly simplest and easiest to understand -
> approach so far that i've heard.  perhaps that's because i came up
> with it, i dunno :)  but the important thing is that i can _show_ that
> it works (http://gitorious.org/python-libbittorrent/pybtlib - go back
> a few revisions)

That's great.  If you want to continue this simple approach and ignore
the gittorrent/mirror-sync path altogether, that's fine too.

Trying to determine the "best" pack-object may be counter-productive. 
Here's a simple approach which allows the repository owner to easily
arrange for efficient torrenting of essential object files:

Add to the .torrent manifest just these files:

  .git/objects/pack/pack-*.pack - just the files with .keep files
  .git/packed-refs - just the references which are completely available
via the .keep packs

In that way, a repository owner can periodically re-pack their repo,
mark the new pack files as .keep, then re-generate the .torrent file. 
All nodes will just have to transfer the new packs, not everything.

>  so - perhaps it would help if mirrorsync was revived, so that it can
> be used to demonstrate what you mean (there aren't any instructions on
> how to set up mirrorsync, for example).  that would then allow people
> to do a comparative analysis of the approaches being taken.

Ok, that sounds like a good plan - I'll see if I can devote some time to
an explanatory series with working examples with reference to the
existing code etc over the coming months.

Cheers,
Sam
