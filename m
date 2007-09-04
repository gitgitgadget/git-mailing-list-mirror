From: "David Tweed" <david.tweed@gmail.com>
Subject: Re: Git's database structure
Date: Tue, 4 Sep 2007 21:17:57 +0100
Message-ID: <e1dab3980709041317v35c1dab7wd5e6ac4f7292d522@mail.gmail.com>
References: <9e4733910709040823k731f0ffchba1f93bdb4a8373d@mail.gmail.com>
	 <46DD7FE4.1060908@op5.se>
	 <9e4733910709040919u3d252b91s2785ed4d20086c88@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: "Andreas Ericsson" <ae@op5.se>,
	"Git Mailing List" <git@vger.kernel.org>
To: "Jon Smirl" <jonsmirl@gmail.com>
X-From: git-owner@vger.kernel.org Tue Sep 04 22:18:07 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1ISeqc-0000BE-AR
	for gcvg-git@gmane.org; Tue, 04 Sep 2007 22:18:06 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753442AbXIDUR7 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 4 Sep 2007 16:17:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752798AbXIDUR7
	(ORCPT <rfc822;git-outgoing>); Tue, 4 Sep 2007 16:17:59 -0400
Received: from nz-out-0506.google.com ([64.233.162.229]:14821 "EHLO
	nz-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752187AbXIDUR6 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 4 Sep 2007 16:17:58 -0400
Received: by nz-out-0506.google.com with SMTP id s18so1086319nze
        for <git@vger.kernel.org>; Tue, 04 Sep 2007 13:17:58 -0700 (PDT)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=pW3dVQlUKRt/4pxDJQYHVHuS4Qp27SIg9Y0LKY1HFEn8NShyDQmmU7Mg+iql8O1K0voOiyS75Ik3x1c2pFooUI4jSwj7gWh21sm6RLhJr18dsIh6mQ0bg44cRZAc9v1rdQR3aKDptDT7l18yZcJWomBAG7aF9ZsiubTZn3bWmsQ=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=cHzDT7cJ5VQGhSTXCF9wek2kqHpUWY1OdzTQQFgsR6I1H+gq0/qzgRQc6qLguLK13z30Z+1tUOT9wJ1b4yfhDLSqk9/XOqNmn2DlNpPcwPq4LzlWa58s8j+PLMcMpXIik3oEi1Louh4vY5zIa8Wpm4NIBcVEI6mwlr5PbdwH6ys=
Received: by 10.65.183.7 with SMTP id k7mr5393024qbp.1188937077684;
        Tue, 04 Sep 2007 13:17:57 -0700 (PDT)
Received: by 10.65.81.12 with HTTP; Tue, 4 Sep 2007 13:17:57 -0700 (PDT)
In-Reply-To: <9e4733910709040919u3d252b91s2785ed4d20086c88@mail.gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/57639>

On 9/4/07, Jon Smirl <jonsmirl@gmail.com> wrote:
> without building another mapping table or a brute force search. I keep
> using Google as an example, Google is indexing hierarchical URLs but
> they do not use a hierarchical index to do it.

It might help the discussion if you could point to a reference,
preferably one that discusses the trade-offs in the design, with more
concrete details about what google or other search engines actually
do. It would be particularly useful if it addressed issues of

1. the type of queries the representation is optimised for.
2. consistency requirements. (Can a search engine use different data
structures if they improve average performance at the cost of
occasional inconsistency/lossage?)

Finally, this design space is not totally unexplored, for example,

http://plan9.bell-labs.com/sys/doc/venti/venti.html

AFAICS they only use SHA-1 for blocks within files (although this
might be misreading the paper) so presumably they'd have knowledge
about the trade-offs.

-- 
cheers, dave tweed__________________________
david.tweed@gmail.com
Rm 124, School of Systems Engineering, University of Reading.
"we had no idea that when we added templates we were adding a Turing-
complete compile-time language." -- C++ standardisation committee
