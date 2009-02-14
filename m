From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: [PATCH] config: Use parseopt.
Date: Sat, 14 Feb 2009 23:24:03 +0200
Message-ID: <94a0d4530902141324w1cea462ex99a698e5a702d85a@mail.gmail.com>
References: <1234577142-22965-1-git-send-email-felipe.contreras@gmail.com>
	 <7vab8pweod.fsf@gitster.siamese.dyndns.org>
	 <94a0d4530902140237o7d26ff4j1c7350d926d12c1a@mail.gmail.com>
	 <7vhc2wu8a0.fsf@gitster.siamese.dyndns.org>
	 <94a0d4530902141209j7a3a9976l80355bee526852ed@mail.gmail.com>
	 <7vtz6wrahg.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Feb 14 22:25:42 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LYS13-0006bf-QV
	for gcvg-git-2@gmane.org; Sat, 14 Feb 2009 22:25:38 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752300AbZBNVYK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 14 Feb 2009 16:24:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752242AbZBNVYI
	(ORCPT <rfc822;git-outgoing>); Sat, 14 Feb 2009 16:24:08 -0500
Received: from fg-out-1718.google.com ([72.14.220.159]:54557 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752138AbZBNVYF (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 14 Feb 2009 16:24:05 -0500
Received: by fg-out-1718.google.com with SMTP id 16so77837fgg.17
        for <git@vger.kernel.org>; Sat, 14 Feb 2009 13:24:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=jsvgQt7mz9osOdcH9chxkIxRPlLFOFqLdemw/7zRfD0=;
        b=lnmngWSWjB4/w65yYK+dvGHbuWxcWKZC6Vb8FLNkmvmhiSsDyXE6yRZl5kpCfu77R8
         cAEP0pPjzesdpKSkgu482LfihoCNSe5yY2Xvwv+pZWsTZPR1ZJKY4KQd6edA90HMNIWP
         1BLR18nBGjVLebn1dUXZQFIARxIhExTjR365E=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=IC7FcFM38YnzaSXjMgzQfE27yQPkrxwEFcqMCBgQ8MutLd0pXEFRQ8WJe7/S4XtAjD
         aVJT5fHWElsvLjasO2rTaoERqHIdFIiXzVgMKxCFP+zM9Yy6kASj4Q3uAETVzVht2vll
         AKExf7aG2Vzr+fdFtXQgbYLayvFbgG/aaoNv0=
Received: by 10.86.72.15 with SMTP id u15mr533950fga.8.1234646643671; Sat, 14 
	Feb 2009 13:24:03 -0800 (PST)
In-Reply-To: <7vtz6wrahg.fsf@gitster.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/109932>

On Sat, Feb 14, 2009 at 11:10 PM, Junio C Hamano <gitster@pobox.com> wrote:
> Felipe Contreras <felipe.contreras@gmail.com> writes:
>
>>> Unfortunately, not many patch authors write such a summary.  Sometimes we
>>> see summaries on things that were discussed but nobody has followed
>>> through posted by third parties (including myself), but we do not seem to
>>> have enough helpers to do that either.  This does not take much technical
>>> skills but is a good "trust point" earner.
>>
>> For me it's easier, and more fun to write a separate patch that fixes
>> the issues than writing a summary,...
>
> That certainly is something we should take into consideration.
>
> I however think an unwritten assumption around here so far has been that
> the patch author who gets review comments is expected to keep track of the
> issues raised, both about the patch itself and about the similar breakages
> in the existing code pointed out during the review process, if only
> because the patch author is the focal point of the discussion.
>
> We probably need to break that.
>
> Because it is very likely that the reviewer does not even realize that
> such similar breakages in the existing code when a review is made, we
> cannot ask reviewers to always start a separate discussion.  Some reviews
> do say "Admittedly, we already have the same pattern in here and there,
> but this in your patch is wrong," but the way how we collectively realize
> an existing breakage is often by hearing the patch author respond with
> "but there already are this and that breakages in the existing code."
>
> We do not want such knowledge of existing breakages go to waste in either
> case.  Perhaps it would be a good start to make it the responsibility of
> the first person who mentions an existing breakage (either the reviewer's
> "Admittedly", or the patch author's "but there already are") to begin a
> separate thread, so that mail archive would remember it.  It shouldn't
> take more than 3 minutes.

That is true, however I propose something a bit different. At least in
this review there has been a number of issues brought up, it would be
overkill to create a separate thread for each one of these issues as
they where found, and if the patch submitter is new, he probably
wouldn't know about this rule.

So, I propose that at the end of the patch review process the ack
person (or somebody else) asks the patch submitter (possibly cc'ing
the reviewers) to start a new thread mentioning the pending issues
brought up in the review.

-- 
Felipe Contreras
