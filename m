From: Andi Kleen <andi@firstfloor.org>
Subject: Re: [PATCH 2/3] Add a lot of dummy returns to avoid warnings with NO_NORETURN
Date: Mon, 20 Jun 2011 23:30:01 +0200
Message-ID: <20110620213001.GB32765@one.firstfloor.org>
References: <1308445625-30667-1-git-send-email-andi@firstfloor.org> <1308445625-30667-2-git-send-email-andi@firstfloor.org> <7vsjr4b3tf.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Andi Kleen <andi@firstfloor.org>, git@vger.kernel.org,
	Andi Kleen <ak@linux.intel.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Jun 20 23:30:15 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QYm2v-00053r-S0
	for gcvg-git-2@lo.gmane.org; Mon, 20 Jun 2011 23:30:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755804Ab1FTVaG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 20 Jun 2011 17:30:06 -0400
Received: from one.firstfloor.org ([213.235.205.2]:56192 "EHLO
	one.firstfloor.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755587Ab1FTVaF (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 20 Jun 2011 17:30:05 -0400
Received: by one.firstfloor.org (Postfix, from userid 503)
	id 82E8F1A980FA; Mon, 20 Jun 2011 23:30:01 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <7vsjr4b3tf.fsf@alter.siamese.dyndns.org>
User-Agent: Mutt/1.4.2.2i
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/176094>

On Mon, Jun 20, 2011 at 02:17:32PM -0700, Junio C Hamano wrote:
> Andi Kleen <andi@firstfloor.org> writes:
> 
> > From: Andi Kleen <ak@linux.intel.com>
> >
> > Add a lot of dummy returns to silence "control flow reaches
> > end of non void function" warnings with disabled noreturn.
> >
> > If NO_NORETURN is not disabled they will be all optimized away.
> 
> I think this is probably a bad move, given that the previous patch is a

This is basically the patch you suggested. Do you have some other suggestion 
now?

FWIW I preferred my original minimal patch and I can go back to that one.

> temporary workaround until gcc 4.6 is fixed. With -Wunreachable-code on,

gcc mainline (and possibly 4.6.2) has it already fixed, but it's reasonable 
to assume 4.6.0 will be in use for a long time. There's nothing
"temporary" about compiler workarounds, unless you wait 10 years
or so.

> these will introduce noise for build without NO_NORETURN (either when
> profile feedback is not used, or when profile feedback build is in use and
> it no longer requires the NO_NORETURN workaround).

I fixed the noise in a followon patch. 

-Andi

-- 
ak@linux.intel.com -- Speaking for myself only.
