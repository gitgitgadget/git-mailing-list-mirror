From: Chris Packham <judge.packham@gmail.com>
Subject: Re: Adding Beyond Compare as a merge tool, was: Re: What's cooking
 in git.git (Feb 2011, #05; Wed, 23)
Date: Sun, 27 Feb 2011 18:38:29 +1300
Message-ID: <4D69E355.7010104@gmail.com>
References: <7v1v2y5o3p.fsf@alter.siamese.dyndns.org> <4D68D4FA.7090500@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: Sebastian Schuberth <sschuberth@gmail.com>,
	Junio C Hamano <gitster@pobox.com>, charles@hashpling.org
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Feb 27 06:37:28 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PtZJw-0007bb-2u
	for gcvg-git-2@lo.gmane.org; Sun, 27 Feb 2011 06:37:28 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750824Ab1B0FhX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 27 Feb 2011 00:37:23 -0500
Received: from mail-px0-f174.google.com ([209.85.212.174]:56290 "EHLO
	mail-px0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750810Ab1B0FhW (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 27 Feb 2011 00:37:22 -0500
Received: by pxi15 with SMTP id 15so464308pxi.19
        for <git@vger.kernel.org>; Sat, 26 Feb 2011 21:37:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:message-id:date:from:user-agent:mime-version:to
         :cc:subject:references:in-reply-to:content-type
         :content-transfer-encoding;
        bh=VoHw47nQnexLU3jKK8fc+TlkfJBuV3ShA30Li/ZMDtI=;
        b=G5RMcQEmtl8AOX9/gncfQDdWXqdlbW5njkqo0GrWPvm5pbL+jmqF5MhOijMarirAo0
         K5qpTQS0hWyiihdgMtB9FQBoyNR6xl5sgZl48U+pjQb/a/4Y7M3QP4OYb3zcNPp3KJZN
         09atzlOoTmL48xdRJNvD1JPrffO/MibIAyF4w=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-type:content-transfer-encoding;
        b=HTEU0zg5QWipplshtcPzL36qVGIlRQ10DYoy7FwASzxcBlmSHDpOx0W5iZ9rpz4wPd
         M+Ckiq3qo26mlVQEqtz53qLzW1UccvAMzoISRI94O6gLZviFIYfs8mB7ciNgl4fKpCzK
         EdeJkEOjzVr2m6wVymJJMYBCZzToP6n4n5Bew=
Received: by 10.142.231.3 with SMTP id d3mr3099553wfh.255.1298785040331;
        Sat, 26 Feb 2011 21:37:20 -0800 (PST)
Received: from laptop.site (115-188-15-163.jetstream.xtra.co.nz [115.188.15.163])
        by mx.google.com with ESMTPS id m10sm3755486wfl.23.2011.02.26.21.37.16
        (version=SSLv3 cipher=OTHER);
        Sat, 26 Feb 2011 21:37:18 -0800 (PST)
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-GB; rv:1.9.1.16) Gecko/20101125 SUSE/3.0.11 Thunderbird/3.0.11
In-Reply-To: <4D68D4FA.7090500@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/168008>

On 26/02/11 23:24, Sebastian Schuberth wrote:
> On 24.02.2011 00:26, Junio C Hamano wrote:
> 
>> * cp/mergetool-beyondcompare (2011-02-18) 1 commit
>>   - mergetool--lib: add support for beyond compare
> 
> Sorry for not responding earlier to this, but problems at my news
> provider seem to have swallowed mails from several days, including the
> original post of
> 
> http://marc.info/?l=git&m=129801656713478&w=2
> 
> A while ago, I had already proposed
> 
> http://marc.info/?l=git&m=129007741814521&w=2
> 
> I'm not entirely sure why it was ignored in the end, probably I did not
> report back to have tested it in Linux.

Sorry that I missed it (I didn't really look too hard).

> 
> A few things that I like better in my patch than in Chris':
> 
> - Beyond Compare is added as "bc3" instead of "bcompare", which is both
> shorter and indicates that only version 3, not version 2, is supported.

v2 isn't natively available for linux, although it works quite well
under wine. Either way you're quite correct that v2 is not much use as a
3-way merge tool. Trying to indicate v3 only make sense to me (at least
until they release a v4 :)

> - Chris seems to be missing the patch to git-gui/lib/mergetool.tcl

Didn't know to add it, thanks for pointing it out. If my patch get's
picked up I'll include it in the next round.

> - To the best of my knownledge, the Beyond Compare executable is called
> "BCompare" (note the case), that means even with the merge tool named
> "bcompare" a translation step in git-mergetool--lib.sh should by
> required (as done in my patch). Chris, as you seem to have tested ion
> Linux, could you shed a light on  this?

In linux it's bcompare, although BCompare is the eventual executable

chrisp@laptop:~> rpm -q --filesbypkg bcompare
bcompare                  /usr/bin/bcompare
bcompare                  /usr/lib/beyondcompare/BCompare

Unfortunately /usr/bin/bcompare is a little more involved than a symlink
so for linux we need to call bcompare. Do we have a nice way of handling
this? We could just treat them completely separate but that seems a but
like sweeping the problem under the carpet.

> - Using dashes for the options to Beyond Compare is fine on Windows,

Good to hear. I was meaning to fire up a vbox windows XP image to double
check but you've saved me the hassle.

> however, I believe the order of the files is wrong, although that might
> be a bit subjective. For a 3-way merge the syntax is
> 
> BCompare.exe C:\Left.ext C:\Right.ext C:\Center.ext
> 
> So the file that should go to the center panel is specified last. AFAIK,
> all other merge tools are called such that $BASE goes to the center.
> This is why my patch specifies $BASE last.

I actually prefer base on the left a-la kdiff3 and araxis (and from my
previous life as a clearcase user). I've since found that with beyond
compare it is a pain to take changes from the center version so I agree
with your suggestion. We should probably make use of the -title options
to remove ambiguity.

> Any more opinions? Chris, in case you'd agree to prefer my patch, I'd be
> very grateful if you could test it on Linux.
> 
> For your convenience, I've rebased onto the current master and attached
> the patch files.

I'll give it a whirl when I get a chance. I suspect I'll need to handle
the BCompare/bcompare thing but that's not a huge issue.
