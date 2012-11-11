From: bruce <bruce.e.robertson@intel.com>
Subject: Re: orphan blob or what?
Date: Sat, 10 Nov 2012 16:32:02 -0800
Message-ID: <871ug1kmil.fsf@intel.com>
References: <87a9urlj23.fsf@intel.com> <1352423287-ner-8337@calvin>
	<87625elg9r.fsf@intel.com> <1352497275-ner-6808@calvin>
Mime-Version: 1.0
Content-Type: text/plain
Cc: <git@vger.kernel.org>
To: Tomas Carnecky <tomas.carnecky@gmail.com>
X-From: git-owner@vger.kernel.org Sun Nov 11 01:35:16 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TXLW6-0000XV-U5
	for gcvg-git-2@plane.gmane.org; Sun, 11 Nov 2012 01:35:15 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751363Ab2KKAcJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 10 Nov 2012 19:32:09 -0500
Received: from mga02.intel.com ([134.134.136.20]:52816 "EHLO mga02.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751317Ab2KKAcH (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 10 Nov 2012 19:32:07 -0500
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga101.jf.intel.com with ESMTP; 10 Nov 2012 16:32:02 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="4.80,754,1344236400"; 
   d="scan'208";a="217772366"
Received: from brucer42-desktop.jf.intel.com (HELO brucer42-desktop) ([10.7.197.86])
  by orsmga001.jf.intel.com with ESMTP; 10 Nov 2012 16:32:02 -0800
In-Reply-To: <1352497275-ner-6808@calvin> (Tomas Carnecky's message of "Fri, 9
	Nov 2012 21:41:15 +0000")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.1 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/209317>

Tomas Carnecky <tomas.carnecky@gmail.com> writes:

> On Fri, 09 Nov 2012 11:37:04 -0800, bruce <bruce.e.robertson@intel.com> wrote:
>> Tomas Carnecky <tomas.carnecky@gmail.com> writes:
>> 
>> Just idiocy on my part. Thanks.
>> 
>> > On Thu, 08 Nov 2012 16:24:36 -0800, bruce <bruce.e.robertson@intel.com> wrote:
>> >> In today's and older clones of https://github.com/mirrors/linux.git I
>> >> find this object, 6fa98ea0ae40f9a38256f11e5dc270363f785aee, that I can't
>> >> figure out how to eliminate^h^h^h^h^h^h^h^h^hget rid of. I don't see it
>> >> in 'git fsck', 'git gc --aggressive --prune' doesn't seem to prune it,
>> >> can't see it via 'git log'. And yet
>> >> 
>> >> linux/.git/objects/pack$ git verify-pack -v *.idx | grep 6fa98ea0ae40f9a38256f11e5dc270363f785aee
>> >> 6fa98ea0ae40f9a38256f11e5dc270363f785aee blob   1519697 124840 515299673
>> >> 8231eaa31ce1107c1463deb6ec33f61618aedbb9 blob   67 63 515424513 1 6fa98ea0ae40f9a38256f11e5dc270363f785aee
>> >> f21a8c1b9d47736fa4e27def66f04b9fe2b4bc53 blob   90 83 515424576 1 6fa98ea0ae40f9a38256f11e5dc270363f785aee
>> >
>> > Commit dee0bb9 (ASoC: Mark WM8962 Additional Control 4 register as volatile,
>> > 2010-09-29) references this blob.
>
> It wasn't easy to find the commit. First I figured out at which path that file
> was stored. Using git log -S'wm8962_reg[WM8962_MAX_REGISTER + 1]' I quickly
> determined that the file was somewhere in sound/, more specifically
> sound/soc/codecs/wm8962-tables.c. However a 'git log --
> sound/soc/codecs/wm8962-tables.c' did not show any commit. That was strange,
> because 'git log -S'WM8962_MAX_REGISTER + 1' --name-status --
> sound/soc/codecs/' clearly shows that the file existed at some point in the
> past. The commit is hidden from a simple 'git log' due to 'History
> Simplification'. See the git-log man page. I added --full-history -p to the log
> command, and searched in the pager for '6fa98e'. That revealed the commit which
> references that blob:
>
>     git log --full-history -p -- sound/soc/codecs/wm8962-tables.c

Thanks very much for the elucidation. I really must RTFMs. Only 44.786
Kib lines. Porcelain (mostly) first. I just can't eliminate the reading
I need to do.

FWIW, I was somewhat perplexed by searching for
c969f19f8fd17e600a16fe91aab66d86936cce0a in 'gitk -all'. It doesn't find
it BUT if I use --select-commit=c969f19f8fd17e600a16fe91aab66d86936cce0a
then positions to it. If I position away again it again can't find
it. Bother!

BTW, this was all occasioned by looking for unused large packed blobs as
an educational exercise.

Thanks again,
Bruce
