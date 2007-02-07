From: Andy Parkins <andyparkins@gmail.com>
Subject: Re: [PATCH] Show an example of deleting commits with git-rebase.
Date: Wed, 7 Feb 2007 12:11:57 +0000
Message-ID: <200702071211.58890.andyparkins@gmail.com>
References: <20070205202106.GA8755@spearce.org> <20070207101624.GC20290@mellanox.co.il>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: "Shawn O. Pearce" <spearce@spearce.org>,
	Junio C Hamano <junkio@cox.net>
To: git@vger.kernel.org, "Michael S. Tsirkin" <mst@mellanox.co.il>
X-From: git-owner@vger.kernel.org Wed Feb 07 13:12:31 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HElev-0002cL-Nj
	for gcvg-git@gmane.org; Wed, 07 Feb 2007 13:12:22 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161285AbXBGMMO (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 7 Feb 2007 07:12:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161280AbXBGMMN
	(ORCPT <rfc822;git-outgoing>); Wed, 7 Feb 2007 07:12:13 -0500
Received: from nf-out-0910.google.com ([64.233.182.188]:1175 "EHLO
	nf-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1161275AbXBGMML (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 7 Feb 2007 07:12:11 -0500
Received: by nf-out-0910.google.com with SMTP id o25so500194nfa
        for <git@vger.kernel.org>; Wed, 07 Feb 2007 04:12:09 -0800 (PST)
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:from:to:subject:date:user-agent:cc:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=c6BC+tStiU0Q24/LcN3nt0Babzw8qN/WKXju8BY7U7MJmSe/xxDeyJIL6mjnyJIgggrigxKZ7l+pxOIDNjYBolzEfPI/wnmyDVviJu29vI5q799aedPI6kgY9/AHzj+Bzxbxa0U+JsU641M8ODbUPqfBL4+sVcKvvxs3PaR6Y9c=
Received: by 10.82.182.8 with SMTP id e8mr6596895buf.1170850322931;
        Wed, 07 Feb 2007 04:12:02 -0800 (PST)
Received: from 360run094l ( [194.70.53.227])
        by mx.google.com with ESMTP id 59sm1096447ugf.2007.02.07.04.12.00;
        Wed, 07 Feb 2007 04:12:01 -0800 (PST)
User-Agent: KMail/1.9.5
In-Reply-To: <20070207101624.GC20290@mellanox.co.il>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/38917>

On Wednesday 2007 February 07 10:16, Michael S. Tsirkin wrote:

> > +    git-rebase --onto topicA~5 topicA~2 topicA

> Good clarification, a couple of comments:
> - The use of <branch> is more confusing than useful in this case.
>   You can always just do
> 	git reset --hard topicA
> 	git-rebase --onto topicA~5 topicA~2
>   instead, correct?

Seems more dangerous to me.  If we're not on topicA now, then the reset would 
throw away our current branch; if we are on topicA then we don't need it 
(assuming the working directory is not dirty).  At least with the explicit 
specification of topicA as <branch> there is no risk that the user will find 
themselves with their master branch junked.

> - The use of ~ notation here is also more scary than clarifying.
>    git-rebase --onto F H
>   will be clearer I think.

While you're right that it is clearer; it also removes the practical example.  
In real life there is no easy name for F or H; they are just random hashes.  
topicA~5 will work in real life as well as the example.

Andy
-- 
Dr Andy Parkins, M Eng (hons), MIEE
andyparkins@gmail.com
