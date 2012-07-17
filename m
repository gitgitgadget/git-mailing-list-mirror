From: Jukka Lehtniemi <jukka.lehtniemi@gmail.com>
Subject: Re: [PATCH v2] Fix notes handling in rev-list
Date: Wed, 18 Jul 2012 00:22:32 +0300
Message-ID: <CAOQ7pMO8w79B1kpztv4a+x8oCSzL4b8t7STyQu2i68ZT6qk_wQ@mail.gmail.com>
References: <20120325005504.GA27651@sigill.intra.peff.net>
	<1342463409-6919-1-git-send-email-jukka.lehtniemi@gmail.com>
	<20120717034640.GB20945@sigill.intra.peff.net>
	<7vvchnx7tc.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Tue Jul 17 23:22:48 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SrFE9-0003a4-9g
	for gcvg-git-2@plane.gmane.org; Tue, 17 Jul 2012 23:22:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756775Ab2GQVWe (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 17 Jul 2012 17:22:34 -0400
Received: from mail-qc0-f174.google.com ([209.85.216.174]:64053 "EHLO
	mail-qc0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756763Ab2GQVWd (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 17 Jul 2012 17:22:33 -0400
Received: by qcro28 with SMTP id o28so607404qcr.19
        for <git@vger.kernel.org>; Tue, 17 Jul 2012 14:22:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=l28WPvXYF1lu/RePcN+BVyD7lqWhSmhAoXBiOyjwaAg=;
        b=roYMKphmrkybPlFrAlM3dfXyOhIdgIVmzYQpjzaK/cd2u5VJzgPo0esdH8EZtXbvHG
         Cc0xWV77hw0drhtZbfB3P+GDS9o0c9OYNZQwlk0S9JV//CtVggu8doTG0HKEP7yNarsD
         cZ8kcNduUCjkZAkzyYpRq4YDi4d/tTkspkkHS6oILXfLpIU1wJmRMYc54TmaYGosg3Tq
         0Tmm4xCjRlOtvYTxl03pkrolIYgU1UQ9/uD4fOOws/rgDe7dD43bE7jhnHYSVAwVCVfO
         nKFS+wEii6vXifhoenDPzyByOeeecblK38lIqN7ReA7p/J8bTJ+c0/l8qZ0TUSoqnDt3
         HUSg==
Received: by 10.224.203.8 with SMTP id fg8mr1981376qab.38.1342560153039; Tue,
 17 Jul 2012 14:22:33 -0700 (PDT)
Received: by 10.224.111.140 with HTTP; Tue, 17 Jul 2012 14:22:32 -0700 (PDT)
In-Reply-To: <7vvchnx7tc.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/201623>

First of all, thanks for you feedback, both of you. And sorry for
wasting your time . I thought that the "In-Reply-To"-header would
serve as a reference to the original patch but obviously it wasn't
enough.

On Tue, Jul 17, 2012 at 8:42 AM, Junio C Hamano <gitster@pobox.com> wrote:
>
> I wonder if we should show the blob object names that store the
> notes payload if we were given --notes option in a format that is
> easy for readers to mechanically parse its output.
>

Very good point indeed. I think this is how it should be. How would
you prefer the output format to be? Would e.g.

    189899d229ec Notes: 888ecad77e88

be ok?

> In any case, the use of format_display_notes() that is meant for
> human consumption feels very wrong to me, especially it seems to be
> placed outside the "if (revs->verbose_header && commit->buffer)"
> block in this patch.  I do not have any problem if the patch makes
> the notes text shown in the other side of the if block that uses
> pretty_print_commit(), though.
>

I think that another place where human readable notes should be shown
is inside the graph.

-- 
Jukka
