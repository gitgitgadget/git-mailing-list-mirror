From: Piotr Krukowiecki <piotr.krukowiecki@gmail.com>
Subject: Re: pack-object poor performance (with large number of objects?)
Date: Tue, 4 Oct 2011 14:22:55 +0200
Message-ID: <CAA01CsodyUQJOnj5vV0LdVEWpkvwSW2TAONzyY9J82o9VwC6Ag@mail.gmail.com>
References: <CAA01CspZijOO_xbR=OcaRaesTeSy=6RM4DR01-07qimVzxvJZA@mail.gmail.com>
	<CAJo=hJtw+sYrP09zrDbZJNGHDYOeguQLkOe88FBYQDZrnaqsAw@mail.gmail.com>
	<CAA01CsppPf_6Zp5UPYBsxa1JEwLGF-FqacRa7kBJ45Ges2ujrw@mail.gmail.com>
	<7v62k5g988.fsf@alter.siamese.dyndns.org>
	<CAA01CsoSTsBLNcbv5o6Jx6YrjG4g8T=yodX811ymBLXg7sjDJQ@mail.gmail.com>
	<20111004110702.GA18599@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Junio C Hamano <gitster@pobox.com>,
	Shawn Pearce <spearce@spearce.org>,
	Git Mailing List <git@vger.kernel.org>,
	Ingo Molnar <mingo@elte.hu>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Tue Oct 04 14:23:03 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RB41W-0008G5-Hp
	for gcvg-git-2@lo.gmane.org; Tue, 04 Oct 2011 14:23:02 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756619Ab1JDMW5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 4 Oct 2011 08:22:57 -0400
Received: from mail-yx0-f174.google.com ([209.85.213.174]:36387 "EHLO
	mail-yx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756482Ab1JDMW4 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 4 Oct 2011 08:22:56 -0400
Received: by yxl31 with SMTP id 31so402901yxl.19
        for <git@vger.kernel.org>; Tue, 04 Oct 2011 05:22:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=o3b2Bteb8BihVCzrgUyaK6yCRsc4mgOAI4DfU/krxb0=;
        b=xRTYQweehZMElkzFH4Koo5PEXx67K5MBr/s8FJJwgMXm5tGv08bppk4nKeSUc7cDgO
         /JO4iNNE9AlwXIbVIi5FwM/yEsPkFnzM+2W7PKxnXS0Ub1E6ZgWhNxHHla651vKG/hNF
         bdLhftMsVyQTVxrfJ9LVGD52yXSt/fsl//ifA=
Received: by 10.150.138.2 with SMTP id l2mr1068602ybd.344.1317730975972; Tue,
 04 Oct 2011 05:22:55 -0700 (PDT)
Received: by 10.150.196.1 with HTTP; Tue, 4 Oct 2011 05:22:55 -0700 (PDT)
In-Reply-To: <20111004110702.GA18599@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/182766>

On Tue, Oct 4, 2011 at 1:07 PM, Jeff King <peff@peff.net> wrote:
> On Tue, Oct 04, 2011 at 09:59:08AM +0200, Piotr Krukowiecki wrote:
>
>> I've run the command and it took about 20 minutes in "Counting
>> objects" to count up to 500000 on idle machine and there's still 700MB
>> RAM free.
>> [...]
>> So it looks it's not a problem with git but rather with my disk/file
>> system/linux...
>
> You mentioned that git was in the 'D' state earlier. And it sounds like
> you have 1.7 million objects, _completely_ unpacked.

That's right - since I had auto-gc disabled at first it had not chance
to pack anything.


> So my guess is that it is simply taking an enormous amount of disk
> space, and git is mostly waiting on the disk to read in files. What does
> "du -sh .git/objects" say?

It isn't that big - it's 11G.
.git/objects/pack/ is 666MB currently.


-- 
Piotr Krukowiecki
