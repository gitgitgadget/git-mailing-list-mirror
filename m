From: Marc Branchaud <marcnarc@xiplink.com>
Subject: Re: [git patches] libata updates, GPG signed (but see admin notes)
Date: Thu, 10 Nov 2011 10:23:05 -0500
Message-ID: <4EBBEC59.3020502@xiplink.com>
References: <CA+55aFwL_s=DcT46dprcYVWEAm_=WkuTV6K9dAn3wc_bDQU8vA@mail.gmail.com>  <7vwrbjlj5r.fsf@alter.siamese.dyndns.org>  <CA+55aFx_rAA6TJkZn1Zvu6u9UjxnmTVt0HpMnvaE_q9Sx-jzPg@mail.gmail.com>  <7vk47jld5s.fsf@alter.siamese.dyndns.org>  <CA+55aFz7TeQQH3D4Tpp31cZYZoQKeK37jouo+2Kh61Wa07knfw@mail.gmail.com>  <CAJo=hJv5nAKH_ptYSWfMvFQv0Dj+naPXK35wSzKYkfPOYsWkxg@mail.gmail.com>  <CA+55aFx0oCd6-sh0psYxho-s=sHAK0RHXJHfLewRuUcdXzxZbg@mail.gmail.com>  <CA+55aFwXu=+HdQ5nW11Ts5p-V=KgpxjyagKqB+Xv+qBOEEWXvQ@mail.gmail.com>  <CAJo=hJsXvSyB65KBp8sfciT=h5uZSqSUdxkpWtZJRtr4hXAh5A@mail.gmail.com>  <CA+55aFyXg32mko8TOGCfGHpr3jHBEgcKiK7HdVwq0Wez0fAs9A@mail.gmail.com>  <20111103032205.GA25888@pompeji.miese-zwerge.org>  <CA+55aFyG4VuiRN3kcyDVF4sw7b89m-2bOBeQLOGWTcd9o3akzQ@mail.gmail.com> <1320933118.17392.23.c
 amel@i7.infradead.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
	Jochen Striepe <jochen@tolot.escape.de>,
	Shawn Pearce <spearce@spearce.org>,
	Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	James Bottomley <James.Bottomley@hansenpartnership.com>,
	Jeff Garzik <jeff@garzik.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	linux-ide@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>
To: David Woodhouse <dwmw2@infradead.org>
X-From: git-owner@vger.kernel.org Thu Nov 10 16:23:19 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ROWTE-0002ZA-8a
	for gcvg-git-2@lo.gmane.org; Thu, 10 Nov 2011 16:23:16 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S934112Ab1KJPXL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 10 Nov 2011 10:23:11 -0500
Received: from smtp162.iad.emailsrvr.com ([207.97.245.162]:60685 "EHLO
	smtp162.iad.emailsrvr.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757634Ab1KJPXK (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 10 Nov 2011 10:23:10 -0500
Received: from localhost (localhost.localdomain [127.0.0.1])
	by smtp26.relay.iad1a.emailsrvr.com (SMTP Server) with ESMTP id 7A6B6A854B;
	Thu, 10 Nov 2011 10:23:09 -0500 (EST)
X-Virus-Scanned: OK
Received: by smtp26.relay.iad1a.emailsrvr.com (Authenticated sender: mbranchaud-AT-xiplink.com) with ESMTPSA id F1B91A87B5;
	Thu, 10 Nov 2011 10:23:08 -0500 (EST)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:7.0.1) Gecko/20110929 Thunderbird/7.0.1
In-Reply-To: <1320933118.17392.23.camel@i7.infradead.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/185234>

On 11-11-10 08:51 AM, David Woodhouse wrote:
> On Wed, 2011-11-02 at 21:13 -0700, Linus Torvalds wrote:
>> No, my main objection to saving the data is that it's ugly and it's
>> redundant. Sure, in practice you can check the signatures later fine
>> (with the rare exceptions you mention), but even when you can do it,
>> what's the big upside? 
> 
> Another objection (although it may not be insurmountable) is that it's
> not necessarily *entirely* clear what's being signed.

I think this is a non-issue as far as the implementation is concerned.  That
is, the question exists regardless of what actual bits get (hashed and)
encrypted by a private key.  Furthermore, the answer will depend on who's
using the signatures and in what context, and it's not appropriate for the
git tool to make assumptions about those things.

> In the simple case where I clone your tree, make a few commits with my
> Signed-off-by:, sign a tag and then ask you to pull, that's easy enough.
> I'm vouching for what I committed, and not for everything that was in
> your tree beforehand.
> 
> But what if I'm working on top of someone else's published git tree?
> Does a signed tag at the top of *my* work imply that I'm vouching for
> all of theirs too?

<philosophy>

It all depends on what you mean by "vouch for".

You obviously thought that the 3rd-party repo was good for something,
otherwise why did you base your work on it in the first place?  So maybe
you're just vouching for the 3rd-party repo being good enough for what you're
trying to do.

Or, maybe you've done a thorough analysis of the 3rd-party code and are ready
to certify it as completely memory-leak-free or something.

Or or, maybe you're only making a statement about the commits that you've
authored yourself.  (You probably want to individually sign each of those
commits in this case.)

These sorts of issues have been debated on PKI mailing lists ad nauseum.  I
think the best approach is that if you want your signature to have a
particular meaning, then put that into some text that's part of what's being
signed.  Let other humans read that text and make their own decisions.

</philosophy>

And whatever the case, the software that makes and validates the signatures
shouldn't make any assertions about how to interpret good or bad signatures.
 (Yes, other software could interpret meanings according to some criteria,
and that software could exist alongside or be incorporated into the basic
digital signature software, but the interpretation software is doing a
different job.)

		M.
