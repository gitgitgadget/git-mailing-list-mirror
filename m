From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH 03/19] t5800: document some non-functional parts of
 remote helpers
Date: Wed, 8 Jun 2011 14:36:31 -0500
Message-ID: <20110608193630.GH27715@elie>
References: <1307558930-16074-1-git-send-email-srabbelier@gmail.com>
 <1307558930-16074-4-git-send-email-srabbelier@gmail.com>
 <20110608192850.GF27715@elie>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jeff King <peff@peff.net>, Git List <git@vger.kernel.org>,
	Daniel Barkalow <barkalow@iabervon.org>,
	Ramkumar Ramachandra <artagnon@gmail.com>
To: Sverre Rabbelier <srabbelier@gmail.com>
X-From: git-owner@vger.kernel.org Wed Jun 08 21:36:50 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QUOYZ-0005yp-U1
	for gcvg-git-2@lo.gmane.org; Wed, 08 Jun 2011 21:36:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755718Ab1FHTgk (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 8 Jun 2011 15:36:40 -0400
Received: from mail-iy0-f174.google.com ([209.85.210.174]:44064 "EHLO
	mail-iy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755994Ab1FHTgg (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 8 Jun 2011 15:36:36 -0400
Received: by iyb14 with SMTP id 14so696418iyb.19
        for <git@vger.kernel.org>; Wed, 08 Jun 2011 12:36:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:date:from:to:cc:subject:message-id:references
         :mime-version:content-type:content-disposition:in-reply-to
         :user-agent;
        bh=ZkAnhJCU8VPjwS3vJtq2IbziBPStMDiiIWY5Y0thcyc=;
        b=poIE3If9NYiKH3Ys89WtqcxA0rqkwBPa7GLOTbCZ60S53kuExAY+wI8nG15RICYSZd
         xyAWC3SyW4PO6CD5fdM+Z3XN61Wr9MtLZ0dx8dy24aNiKsFI/FIx/6prg70RKxz1YjGp
         livD9yhgMj5SV1yaQ5Z89e+s/IiWbGxlYdnSs=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=V/qcVOSGCdDQeDHnaSgKyta19Lxou95Q8GBalU/3SDz9VmiiVmo3LTFk7AxudZOWUg
         fCatgacmEAaOzFrTgX6Wz3lXceodC3BY+CuuNR3L8w/w1AKPaFayKV1caafsfoSjyAgA
         XIvpFOLCiQ7PdJGDiBDaYv08t8MaOsCH4WASs=
Received: by 10.43.131.130 with SMTP id hq2mr12889175icc.90.1307561795826;
        Wed, 08 Jun 2011 12:36:35 -0700 (PDT)
Received: from elie (adsl-69-209-61-87.dsl.chcgil.ameritech.net [69.209.61.87])
        by mx.google.com with ESMTPS id e1sm685106icv.8.2011.06.08.12.36.33
        (version=SSLv3 cipher=OTHER);
        Wed, 08 Jun 2011 12:36:34 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20110608192850.GF27715@elie>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/175449>

Jonathan Nieder wrote:
> Sverre Rabbelier wrote:

>> The problem is that we push all of the work of generating
>> the export stream onto fast-export,
>
> Here "we" means remote-testgit, not transport-helper, right?

Gah!  Clearly I am not thinking straight and it means the
transport-helper.

> It's not just name mapping, no?  E.g., I could try
>
> 	git push testgit::/path/to/repo $(git rev-parse HEAD):new
>
> So I think the current implementation of "export" by testgit
> is just wrong. ;-)

So this refers to transport-helper, too, and...

[...]
> This seems like a reasonable solution.  One way would be to teach
> fast-export about refspecs

... the level of permissible hackishness goes down :), making teaching
fast-export about refspecs the only obviously reasonable fix at first
glance.

[...]
> Anyway, I don't think this should be in the commit message for the new
> test which doesn't even know about the remote helper protocol. :)

Sorry for the nonsense.  At least this last part still applies.
