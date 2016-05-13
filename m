From: KellerFuchs <KellerFuchs@hashbang.sh>
Subject: Re: [PATCH] Documentation: clarify signature verification v2
Date: Fri, 13 May 2016 09:37:02 +0000
Message-ID: <20160513093702.GA23963@hashbang.sh>
References: <20160512065022.GA32387@hashbang.sh>
 <CAFZEwPOJg=njvhtK7ZQf_-3DUVjMpFBEV_0m1NHAE1UL7eM5ng@mail.gmail.com>
 <xmqq4ma3grj0.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Pranit Bauva <pranit.bauva@gmail.com>,
	Git List <git@vger.kernel.org>,
	"Michael J. Gruber" <git@drmicha.warpmail.net>,
	"Brian M. Carlson" <sandals@crustytoothpaste.ath.cx>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri May 13 11:37:29 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1b19XD-0007IQ-Qe
	for gcvg-git-2@plane.gmane.org; Fri, 13 May 2016 11:37:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751369AbcEMJhX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 13 May 2016 05:37:23 -0400
Received: from mail.hashbang.sh ([104.236.230.244]:53430 "EHLO
	mail.hashbang.sh" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751272AbcEMJhW (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 13 May 2016 05:37:22 -0400
Received: from to1.hashbang.sh (to1.hashbang.sh [104.245.37.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.hashbang.sh (Postfix) with ESMTPS id 52BCDA48D;
	Fri, 13 May 2016 09:37:21 +0000 (UTC)
Received: by to1.hashbang.sh (Postfix, from userid 3412)
	id 8C037E00BE; Fri, 13 May 2016 09:37:02 +0000 (UTC)
Content-Disposition: inline
In-Reply-To: <xmqq4ma3grj0.fsf@gitster.mtv.corp.google.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/294517>

Thanks a lot for the feedback.

I read Documentation/SubmittingPatches before sending the original patch,
  but it seems not everything had sunk in.
  (And I definitely should have read it again before sending v2...)


I will resubmit the patch, then.

On Thu, May 12, 2016 at 09:38:59AM -0700, Junio C Hamano wrote:
> Pranit Bauva <pranit.bauva@gmail.com> writes:
> 
> > Seems like Junio was waiting for someone to point this out[2].
> 
> Thanks. I think you covered most of them correctly; I only have one
> thing to add.
> 
> >  * Comments are put after ---. So your paragraph
> >       "Clarify which commits need to be signed.
> >
> >         Uniformise the vocabulary used wrt. key/signature validity with OpenPGP
> >          - a signature is valid if made by a key with a valid uid;
> >          - in the default trust-model, a uid is valid if signed by a
> > trusted key;
> >          - a key is trusted if the (local) user set a trust level for it.
> >
> >            Thanks to Junio C Hamano <gitster@pobox.com> for reviewing
> >            the first attempt at this patch."
> >
> >     is actually treated as a comment.
> 
> This is half-true, I think. The message you are responding to had
> only two dashes, not three.
> 
> The usual way to do what the original wanted to do is like this:
> 
> 	... e-mail headers like From:, Subject:, ...
> 
> 	Hi,
> 
>         Here is a second attempt.
> 
>         -- >8 --
>         Subject: Documentation: clarify --verify signature
> 
> 	Clarify that only the signature of the commit at the tip of
> 	the branch being merged is checked.  Also align the
> 	vocabulary to describe key & signature validity with those
> 	used by OpenPGP, namely:
> 
>          - a signature is valid if ...
>          ...
>          - a key is trusted if ...
> 
> 	Signed-off-by: A U Thor <au@thor.xz>
>         ---
>          Documentation/merge-options.txt | ... diffstat comes here
>         
> Notice the "-- >8 --" (cut here) line.  "am" will notice it, discard
> what it has read so far and restart from there.
> 
