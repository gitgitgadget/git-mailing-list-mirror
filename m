From: Pete/Piet Delaney <pete@bluelane.com>
Subject: Re: How to Import a bitkeeper repo into git
Date: Mon, 15 Oct 2007 20:45:55 -0700
Organization: Bluelane
Message-ID: <471433F3.40606@bluelane.com>
References: <598689.78740.qm@web56015.mail.re3.yahoo.com> <20070709173720.GS29994@genesis.frugalware.org> <alpine.LFD.0.999.0707091049080.31544@woody.linux-foundation.org> <4713FA4A.5090501@bluelane.com> <alpine.LFD.0.999.0710151711280.6887@woody.linux-foundation.org>
Reply-To: pete@bluelane.com
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: VMiklos <vmiklos@frugalware.org>,
	free cycle <freecycler23@yahoo.com>, git@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Tue Oct 16 05:46:15 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IhdNm-0007Jy-VL
	for gcvg-git-2@gmane.org; Tue, 16 Oct 2007 05:46:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758496AbXJPDqD (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 15 Oct 2007 23:46:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758274AbXJPDqD
	(ORCPT <rfc822;git-outgoing>); Mon, 15 Oct 2007 23:46:03 -0400
Received: from outbound.mse2.exchange.ms ([69.25.50.247]:56878 "EHLO
	mse2fe1.mse2.exchange.ms" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1754064AbXJPDqA (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 15 Oct 2007 23:46:00 -0400
Received: from piet2.bluelane.com ([64.95.123.130]) by mse2fe1.mse2.exchange.ms with Microsoft SMTPSVC(6.0.3790.1830);
	 Mon, 15 Oct 2007 23:45:59 -0400
User-Agent: Thunderbird 2.0.0.6 (X11/20070728)
In-Reply-To: <alpine.LFD.0.999.0710151711280.6887@woody.linux-foundation.org>
X-Enigmail-Version: 0.95.3
X-OriginalArrivalTime: 16 Oct 2007 03:45:59.0580 (UTC) FILETIME=[10CBB5C0:01C80FA7]
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/61069>

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Linus Torvalds wrote:
> 
> On Mon, 15 Oct 2007, Pete/Piet Delaney wrote:
>> I imported the CVS repository to git and it worked great. Since all
>> of our other repository are in bitkeeper the management would like to
>> stick with CVS. With git apparently still being weak in the area of
>> supporting difftool on different version that seems somewhat reasonable
>> for the time being.
> 
> I can't see how bk's difftool could possibly have any relevance to the 
> "reasonable to stick with CVS" decision, but hey, I'm always surprised by 
> peoples inventiveness in rationalizing their decisions ;)
> 
> I don't know what difftool does that a simple
> 
> 	git diff -U99 | viewdiff -

Sigh, no help for git diff.

> 
> wouldn't do, but in all honesty, I don't think I ever used difftool (I 
> found the other tools in bk much more useful - eg mergetool, renametool)

Wondering if adding a file dimension to gitk might help and adding the
ability to diff different version of a file git gitk by doing something
like holding down the shift key and/or adding a new view pull down.


> 
> I don't actually know of any sane programs to view unified diffs, but you 
> can script one with little trouble. Here's a really hacky one I just came 
> up with:
> 
> 	#!/bin/sh
> 	cat "$@" > /tmp/diff
> 	grep '^[ -]' /tmp/diff > /tmp/orig
> 	grep '^[ +]' /tmp/diff > /tmp/result
> 	meld /tmp/orig /tmp/result
> 
> which fools 'meld' into showing a unified diff in a nice graphical manner.

I just download 'meld', looks interesting, I didn't know about it or
'kompare'. Linking either one into gitk would be a pleasant graphical
'bling'.

> 
> [ Quite frankly, I don't understand why tools like meld and kdiff3 can't 
>   just take the unified diff directly - they have *all* the logic, it 
>   should be trivial to do, and very useful to view diffs for those people 
>   who like that graphical bling. ]
> 
>> The folks at bitmover are converting you kernels to bk and it's
>> maintaining the branch history and I'd like to do the same. So far
>> they haven't help us convert the git repository to bk. Do you happen
>> to know of someone else that might now how to do this in case the
>> folks at bitmover can't provide the scripts to convert this git
>> repository to bk?
> 
> Hmm. Converting from git to bk should not be that hard at least 
> conceptually, but no, I have no idea how to script it sanely and 
> efficiently. The obvious solutions all would want to have multiple active 
> heads of development open at the same time (Larry calls them "LOD's" not 
> branches), and would also require some way to set the result of a merge. 
> Neither of which I would know how to do in BK (I created a lot of merges 
> in BK, but I always let BK do the merging - I wouldn't know how to specify 
> the merge result by hand).

Hmm, actually I'm only seeing rev topology up to 2.6.13,
later version seem to be linear and when I try to use a larger
time window something seems to crashing, the gui goes away,
and 'bk revtool' returns. Sigh.

I'll try keeping it real simple and just import our release branch
and hope for the best. Hopefully Johnannes, or perhaps folks more
involved with gitk can add a bit more graphical bling soon to the
cheetah release. BTW, is this the right mailing list for discussing
gitk as well as git?

- -piet

> 
> 		Linus
> -
> To unsubscribe from this list: send the line "unsubscribe git" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.7 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFHFDPyJICwm/rv3hoRAsU0AJ9o6rHtu5rkiUeNlheRNUpwd4bfagCdHEK8
hDeVvRCyD8Xf8INbdMpuDDU=
=XB2c
-----END PGP SIGNATURE-----
