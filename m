From: Brandon Casey <drafnel@gmail.com>
Subject: Re: [PATCH 2/2] prune.c: only print informational message in
 show_only or verbose mode
Date: Mon, 6 Aug 2012 23:33:36 -0700
Message-ID: <CA+sFfMc28N2eKNa=GiKHvxOeN3u=-ruFQqTBz7cbCGX-G=TTgA@mail.gmail.com>
References: <CA+sFfMdXc+usFRnCNVoke91_X2qWZARTvPHO=B7Ukxr-j7JB2g@mail.gmail.com>
	<1344315709-15897-1-git-send-email-drafnel@gmail.com>
	<1344315709-15897-2-git-send-email-drafnel@gmail.com>
	<7vtxwfw9rp.fsf@alter.siamese.dyndns.org>
	<7vpq73w9i8.fsf@alter.siamese.dyndns.org>
	<CA+sFfMdVhTwAFLUgrO-mLBh8apG-5X1OJKCN9xgq3-N+1RBrvg@mail.gmail.com>
	<20120807060311.GB13222@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Tue Aug 07 08:33:43 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SydMM-0007Fj-A4
	for gcvg-git-2@plane.gmane.org; Tue, 07 Aug 2012 08:33:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750866Ab2HGGdh (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 7 Aug 2012 02:33:37 -0400
Received: from mail-vc0-f174.google.com ([209.85.220.174]:46223 "EHLO
	mail-vc0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750732Ab2HGGdh (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 7 Aug 2012 02:33:37 -0400
Received: by vcbfk26 with SMTP id fk26so3650379vcb.19
        for <git@vger.kernel.org>; Mon, 06 Aug 2012 23:33:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=S+kzlnYSjikfT8T0RsZcT/HC+rNUnUgRfzHagAyJOjc=;
        b=Fei4ErceV4c1kESdgo746jSYfWenaPw+tqli/jq9rQSuhzxwOIyPY3UqfIKI7VV3+s
         FKrWxrjcTQl7LjtIHulEtLCukKOulSNNTqhpN0ydI9jVrjisjE0bJZRvvtSnAERvKgcQ
         F31WmH+MmTv3qtJpNXkD+95f86oXees1oPQE36jWyHw/EftW9lf5g6EELylq5EqWJlO8
         t0FyKZSAt8Pl2a850aNnCDXp+2zP7YGULLl5AHWoPn8S/xWdAccVHayeAP2pHTfMiSV9
         Pq7oWdUVoBeWc4Kcbnabil032BTousadDroh8y1Np0RyPhokzi7uAQx5N5SUq7L/xs6N
         8TcQ==
Received: by 10.52.35.45 with SMTP id e13mr8731135vdj.100.1344321216395; Mon,
 06 Aug 2012 23:33:36 -0700 (PDT)
Received: by 10.59.5.196 with HTTP; Mon, 6 Aug 2012 23:33:36 -0700 (PDT)
In-Reply-To: <20120807060311.GB13222@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/203021>

On Mon, Aug 6, 2012 at 11:03 PM, Jeff King <peff@peff.net> wrote:
> On Mon, Aug 06, 2012 at 10:44:07PM -0700, Brandon Casey wrote:
>> Anyone else? :)
>
> Sorry to gang up on you. :)

Heh. :b

> I still think your 2/2 is worth doing independently, though. It is silly
> that git-prune will not mention pruned objects without "-v", but will
> mention temporary files. They should be in the same category.

As I mentioned in an earlier message, I think the original thinking
was that removing a temporary object should be an unusual occurrence
that indicates a failure of some sort, so you want to inform the user
who may want to investigate (of course the file's gone, so what's to
investigate).  Removing a stale object file on the other hand is just
part of the normal operation.  That is why the former is always
printed out and the latter only when -v is used.

That was the original thinking, but I don't think it matters very
much.  Printing both using the same conditions seems valid.  My commit
message should be scrapped and replaced with something like your
paragraph though..

-Brandon
