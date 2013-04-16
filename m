From: John Keeping <john@keeping.me.uk>
Subject: Re: [PATCH 1/3] fast-export: add --signed-tags=warn-strip mode
Date: Tue, 16 Apr 2013 09:42:52 +0100
Message-ID: <20130416084252.GK2278@serenity.lan>
References: <CAGdFq_g+kk-Fy1fcV6D5x4kroRXX63T8wjKNUqqfu39wUkSO6A@mail.gmail.com>
 <cover.1365936811.git.john@keeping.me.uk>
 <8716b887972b0eb1671afd2692416efd588f7d1d.1365936811.git.john@keeping.me.uk>
 <CAGdFq_jCO_+qj87rtcFyFG2tot8Ah2706X2dm82F6=GBV-g6nw@mail.gmail.com>
 <7vk3o3nktl.fsf@alter.siamese.dyndns.org>
 <CAGdFq_gCeE8gRxmRYkGkm+kn6_Vo22_8g7+eLMuj-+pKjJjPcA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>, Git List <git@vger.kernel.org>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Florian Achleitner <florian.achleitner.2.6.31@gmail.com>
To: Sverre Rabbelier <srabbelier@gmail.com>
X-From: git-owner@vger.kernel.org Tue Apr 16 10:43:15 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1US1Tr-0002mD-Oa
	for gcvg-git-2@plane.gmane.org; Tue, 16 Apr 2013 10:43:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755337Ab3DPInF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 16 Apr 2013 04:43:05 -0400
Received: from coyote.aluminati.org ([72.9.247.114]:36092 "EHLO
	coyote.aluminati.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754192Ab3DPInD (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 16 Apr 2013 04:43:03 -0400
Received: from localhost (localhost [127.0.0.1])
	by coyote.aluminati.org (Postfix) with ESMTP id 1ABB36064FC;
	Tue, 16 Apr 2013 09:43:02 +0100 (BST)
X-Virus-Scanned: Debian amavisd-new at caracal.aluminati.org
X-Spam-Flag: NO
X-Spam-Score: -12.899
X-Spam-Level: 
X-Spam-Status: No, score=-12.899 tagged_above=-9999 required=6.31
	tests=[ALL_TRUSTED=-1, ALUMINATI_LOCAL_TESTS=-10, BAYES_00=-1.9,
	URIBL_BLOCKED=0.001] autolearn=ham
Received: from coyote.aluminati.org ([127.0.0.1])
	by localhost (coyote.aluminati.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 1E-6Y779gswR; Tue, 16 Apr 2013 09:43:01 +0100 (BST)
Received: from serenity.lan (tg2.aluminati.org [10.0.7.178])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by coyote.aluminati.org (Postfix) with ESMTPSA id 842D16065AA;
	Tue, 16 Apr 2013 09:42:54 +0100 (BST)
Content-Disposition: inline
In-Reply-To: <CAGdFq_gCeE8gRxmRYkGkm+kn6_Vo22_8g7+eLMuj-+pKjJjPcA@mail.gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/221397>

On Mon, Apr 15, 2013 at 09:50:42PM -0700, Sverre Rabbelier wrote:
> On Mon, Apr 15, 2013 at 9:47 PM, Junio C Hamano <gitster@pobox.com> wrote:
> > When you see 78 in the output and you know you have 92 tags in the
> > repository, is that sufficient to let you go on, or do we also need
> > an easy way to tell which ones are those 78 that were stripped and
> > the remaining 14 were not stripped?
> >
> > There is no reason to worry about "some signed tags are stripped but
> > not others", so it feels that the number alone should be sufficient,
> > I guess.  If those remaining 14 weren't stripped, that is (at least
> > at the moment) by definition because they are unsigned, annotated
> > tags.
> 
> Or because they were not exported? Perhaps "78 tags stripped, 92
> exported in total".

I think I prefer Jonathan's suggestion to this one if we need to change
it.

The reason I didn't do this initially was that I assumed that from a
remote helper we would, in general, not be pushing any tags which
already exist, so the number of tags to push will be small.

Printing one message per tag also matches the current behaviour for
--signed-tags=warn.  I don't want to make the behaviour for "warn" and
"warn-strip" different, so should "warn" also print a summary message
instead of a message for each tag?
