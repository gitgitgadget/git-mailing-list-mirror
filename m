From: James Bottomley <James.Bottomley@HansenPartnership.com>
Subject: Re: [git patches] libata updates, GPG signed (but see admin notes)
Date: Tue, 01 Nov 2011 09:39:01 +0400
Message-ID: <1320125941.7701.14.camel@dabdike>
References: <20111026202235.GA20928@havoc.gtf.org>
	 <1319969101.5215.20.camel@dabdike>
	 <CA+55aFx1NGWfNJAKDTvZfsHDDKiEtS4t4RydSgHurBeyGPyhXg@mail.gmail.com>
	 <1320049150.8283.19.camel@dabdike>
	 <CA+55aFz3=cbciRfTYodNhdEetXYxTARGTfpP9GL9RZK222XmKQ@mail.gmail.com>
	 <7vy5w1ow90.fsf@alter.siamese.dyndns.org>
	 <CA+55aFwL_s=DcT46dprcYVWEAm_=WkuTV6K9dAn3wc_bDQU8vA@mail.gmail.com>
	 <4EAF1F40.3030907@zytor.com>
	 <CA+55aFxprv9JR4gtt_UDXheHR5G8PrUA3-Mj0CPsU6E5EzNYeg@mail.gmail.com>
	 <4EAF2245.90308@zytor.com> <7vzkggok6u.fsf@alter.siamese.dyndns.org>
	 <CA+55aFwnVZ-mK3FChvFn778Z-cT107f4v-h0CDmwkP88=Z9aHA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>,
	"H. Peter Anvin" <hpa@zytor.com>, git@vger.kernel.org,
	Jeff Garzik <jeff@garzik.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	linux-ide@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
X-From: linux-ide-owner@vger.kernel.org Tue Nov 01 06:39:21 2011
Return-path: <linux-ide-owner@vger.kernel.org>
Envelope-to: lnx-linux-ide@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <linux-ide-owner@vger.kernel.org>)
	id 1RL74C-00073D-Pe
	for lnx-linux-ide@lo.gmane.org; Tue, 01 Nov 2011 06:39:21 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750817Ab1KAFjI (ORCPT <rfc822;lnx-linux-ide@m.gmane.org>);
	Tue, 1 Nov 2011 01:39:08 -0400
Received: from bedivere.hansenpartnership.com ([66.63.167.143]:36477 "EHLO
	bedivere.hansenpartnership.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750742Ab1KAFjH (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 1 Nov 2011 01:39:07 -0400
Received: from localhost (localhost [127.0.0.1])
	by bedivere.hansenpartnership.com (Postfix) with ESMTP id 137648EE0D8;
	Mon, 31 Oct 2011 22:39:07 -0700 (PDT)
Received: from bedivere.hansenpartnership.com ([127.0.0.1])
	by localhost (bedivere.hansenpartnership.com [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id dAVloe6kw6+X; Mon, 31 Oct 2011 22:39:06 -0700 (PDT)
Received: from [10.0.0.38] (unknown [194.186.187.194])
	by bedivere.hansenpartnership.com (Postfix) with ESMTPSA id AB4368EE0A4;
	Mon, 31 Oct 2011 22:39:04 -0700 (PDT)
In-Reply-To: <CA+55aFwnVZ-mK3FChvFn778Z-cT107f4v-h0CDmwkP88=Z9aHA@mail.gmail.com>
X-Mailer: Evolution 2.32.1 
Sender: linux-ide-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/184557>

On Mon, 2011-10-31 at 15:52 -0700, Linus Torvalds wrote:
> On Mon, Oct 31, 2011 at 3:44 PM, Junio C Hamano <gitster@pobox.com> wrote:
> >
> > So nobody is worried about this (quoting from my earlier message)?
> 
> No, because you haven't been reading what we write.
> 
> The tag is useless.

It's not useless to people who want to verify the tree after it's been
released by you (say for forensics or something).  As Peter said, we can
put it in a normally invisible namespace, but having a flag to make it
visible allows tools like git describe --contains to tell me which
signed tag was used to send a particular commit.

> The information *in* the tag is not. But it shouldn't be saved in the
> tag (or note, or whatever). Because that's just an annoying place for
> it to be, with no upside.
> 
> Save it in the commit we generate. BAM! Useful, readable, permanent,
> and independently verifiable.
> 
> And the advantage is that we can make that same mechanism add
> "maintainer notes" to the merge message too. Right now some
> maintainers write good notes about what the merge will bring in, but
> they are basically lost, because git is so good at merging and doesn't
> even stop to ask people to edit the merge message.

A signed empty commit containing the merge message as a comment also
looks fine to me.  We'd need extra tooling to say which signed merge
corresponds to this patch, but I'd say its workable.  The only slightly
counter intuitive thing is that for a non-trivial merge, my signed merge
description will have to be the next commit below rather than in the
actual merge you do (because we can't alter a cryptographically signed
commit).

James


