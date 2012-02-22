From: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
Subject: Re: git status: small difference between stating whole repository and
 small subdirectory
Date: Wed, 22 Feb 2012 19:54:03 +0700
Message-ID: <CACsJy8BZyokLSpbA=C6YEO1JajyemT9vLG=C9W4E4coA5OfszQ@mail.gmail.com>
References: <20120215190318.GA5992@sigill.intra.peff.net> <CAA01Cso5y23UMguEe0vwOc6kR3-DjuC8-LTMDsMeeOKU4rVGvg@mail.gmail.com>
 <20120216192001.GB4348@sigill.intra.peff.net> <CAA01Csq6vSekW=Fa236bB0H3LVtN43Gb2aLMVE+A1wVyUqYJ7A@mail.gmail.com>
 <20120217203755.GA30114@sigill.intra.peff.net> <7vaa4hrtbe.fsf@alter.siamese.dyndns.org>
 <20120217222912.GC31830@sigill.intra.peff.net> <CAA01CsozANwtox06iihKBL8iii175FHAhChmNhG1B0ofGKWcEA@mail.gmail.com>
 <20120220140653.GC5131@sigill.intra.peff.net> <87ty2l38ay.fsf@thomas.inf.ethz.ch>
 <20120220143644.GA13938@do> <CACsJy8DE86qzA1=GiKZFRCt5aH8X4iMyDvfrhnqwmbq52szhHg@mail.gmail.com>
 <7v8vjwgfoq.fsf@alter.siamese.dyndns.org> <CACsJy8C3Myqs4=GvURWqCTxGp0R1RWotdiHGnnvBSaxyTteujw@mail.gmail.com>
 <7v7gzfefw1.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Thomas Rast <trast@inf.ethz.ch>, Jeff King <peff@peff.net>,
	Piotr Krukowiecki <piotr.krukowiecki@gmail.com>,
	Git Mailing List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Feb 22 13:54:41 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1S0BiR-0002gY-Eu
	for gcvg-git-2@plane.gmane.org; Wed, 22 Feb 2012 13:54:39 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751862Ab2BVMyf (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 22 Feb 2012 07:54:35 -0500
Received: from mail-we0-f174.google.com ([74.125.82.174]:38345 "EHLO
	mail-we0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750975Ab2BVMye (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 22 Feb 2012 07:54:34 -0500
Received: by werb13 with SMTP id b13so4472507wer.19
        for <git@vger.kernel.org>; Wed, 22 Feb 2012 04:54:33 -0800 (PST)
Received-SPF: pass (google.com: domain of pclouds@gmail.com designates 10.180.109.198 as permitted sender) client-ip=10.180.109.198;
Authentication-Results: mr.google.com; spf=pass (google.com: domain of pclouds@gmail.com designates 10.180.109.198 as permitted sender) smtp.mail=pclouds@gmail.com; dkim=pass header.i=pclouds@gmail.com
Received: from mr.google.com ([10.180.109.198])
        by 10.180.109.198 with SMTP id hu6mr36208862wib.16.1329915273413 (num_hops = 1);
        Wed, 22 Feb 2012 04:54:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=ceww1OFH70ilanLJRfmthW3I4HdNk7nLcRGQfBX9ckA=;
        b=KisUJRisEkL4Nqy0OBc2t1RyzuuNmpjRo+BKylL02PXS/PfoQ0+6aMqCMt/DpOFZ8O
         JtxjkzJM3rtvh9rBo4w6D8C063lQbzNCuNH6tBeJrJtQWZK7enwbNZXYSkeQbsyucShU
         SYP6ZqBn3iYkDZTd5Nc+osXze9MuXqlDtF04I=
Received: by 10.180.109.198 with SMTP id hu6mr30008278wib.16.1329915273275;
 Wed, 22 Feb 2012 04:54:33 -0800 (PST)
Received: by 10.223.13.5 with HTTP; Wed, 22 Feb 2012 04:54:03 -0800 (PST)
In-Reply-To: <7v7gzfefw1.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/191254>

On Wed, Feb 22, 2012 at 9:55 AM, Junio C Hamano <gitster@pobox.com> wrote:
> Nguyen Thai Ngoc Duy <pclouds@gmail.com> writes:
>
>> That makes me think if "diff --cached" can take advantage of
>> cache-tree to avoid walking down valid cached trees and do tree-tree
>> diff in those cases instead. Not sure if it gains us anything but code
>> complexity.
>
> Why do I have this funny feeling that we saw that comment in this thread
> already?

Simple. You wrote it and I missed it.

On Sat, Feb 18, 2012 at 5:25 AM, Junio C Hamano <gitster@pobox.com> wrote:
> Jeff King <peff@peff.net> writes:
>
>> That being said, we do have an index extension to store the tree sha1 of
>> whole directories (i.e., we populate it when we write a whole tree or
>> subtree into the index from the object db, and it becomes invalidated
>> when a file becomes modified). This optimization is used by things like
>> "git commit" to avoid having to recreate the same sub-trees over and
>> over when creating tree objects from the index. But we could also use it
>> here to avoid having to even read the sub-tree objects from the object
>> db.
>
> Like b65982b (Optimize "diff-index --cached" using cache-tree, 2009-05-20)
> perhaps?

This optimizes the case when a cached tree matches entirely.I wonder
whether it's faster if we switch to tree-tree diff whenever we find
valid cached trees. If cache-tree is fully valid, "git diff --cached
foo" would be equivalent to "git diff HEAD foo".

I tried "git diff --raw HEAD HEAD~100" (where HEAD was
v3.1-rc1-272-g73e0881 on linux-2.6) and "git diff --cached --raw
HEAD~100" with no cache-tree. The former is a little bit faster than
the latter (177ms vs 275ms). On gentoo-x86, 70k worktree files, it's
4.33s vs 4.45s. But in tree-tree diff we pay high in cold cache case
for loading trees from "HEAD". So no, probably not worth more code
changes. Your optimization is good enough.
-- 
Duy
