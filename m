From: "Dana How" <danahow@gmail.com>
Subject: Re: [PATCH] Use GIT_OBJECT_DIR for temporary files of pack-objects
Date: Mon, 7 May 2007 14:59:49 -0700
Message-ID: <56b7f5510705071459pceb8590j47bde5cc6a3e60a0@mail.gmail.com>
References: <81b0412b0705040225p26679dbib6a1261a1a43ee67@mail.gmail.com>
	 <7vy7k4ud3d.fsf@assigned-by-dhcp.cox.net>
	 <81b0412b0705040342p4fed3a4bnee92cce6b5fb6b9@mail.gmail.com>
	 <7vslacttij.fsf@assigned-by-dhcp.cox.net>
	 <81b0412b0705041024i43d7fc5ah1967d6a6192dc6ee@mail.gmail.com>
	 <7v6478tmyy.fsf@assigned-by-dhcp.cox.net>
	 <20070507173324.GA3436@steel.home>
	 <56b7f5510705071051l75d701d7r94b7c4629cc425f@mail.gmail.com>
	 <20070507213347.GB3436@steel.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, "Junio C Hamano" <junkio@cox.net>,
	danahow@gmail.com
To: "Alex Riesen" <raa.lkml@gmail.com>
X-From: git-owner@vger.kernel.org Tue May 08 00:00:03 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HlBFM-00021s-3m
	for gcvg-git@gmane.org; Mon, 07 May 2007 23:59:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S966499AbXEGV7w (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 7 May 2007 17:59:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S966517AbXEGV7w
	(ORCPT <rfc822;git-outgoing>); Mon, 7 May 2007 17:59:52 -0400
Received: from nz-out-0506.google.com ([64.233.162.225]:62988 "EHLO
	nz-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S966499AbXEGV7v (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 7 May 2007 17:59:51 -0400
Received: by nz-out-0506.google.com with SMTP id o1so1738602nzf
        for <git@vger.kernel.org>; Mon, 07 May 2007 14:59:51 -0700 (PDT)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=oWNFX9NTmFVICqyGFo69tLAGbChqFuFJ+qbAlVDZH7V4awjQ0DshmPrhmLrNu5jxIiUvu51DDyhP1SXcSRcVmkD0oerlRvnU/Cjc5ej8aKgnZChZGaZl2S5kgQVIDGg9RhZGGGCqWSkrttA3LwrowfsUG4Jv2WZXmn6zoTTSwKo=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=V94rmkgDkuvjo/MpHpxB9D7jN9Z0M9z8uGa5MBMETFydmKa3Ne58V3X617+PQYVRhFX0f01kyJfGef4LPgD5m5Bsh0CVYKEql5cMNRt18dKKP4vFKs/ptzSY7Dgy3Vjo51F7orq07HrrqzQHZNPYr44JuWCLV8PP+01U8K48Xl8=
Received: by 10.114.94.1 with SMTP id r1mr2322339wab.1178575190687;
        Mon, 07 May 2007 14:59:50 -0700 (PDT)
Received: by 10.115.58.7 with HTTP; Mon, 7 May 2007 14:59:49 -0700 (PDT)
In-Reply-To: <20070507213347.GB3436@steel.home>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/46495>

On 5/7/07, Alex Riesen <raa.lkml@gmail.com> wrote:
> Dana How, Mon, May 07, 2007 19:51:24 +0200:
> > On 5/7/07, Alex Riesen <raa.lkml@gmail.com> wrote:
> > >I'm not sure about fsck cleaning up after crashed/killed pack-objects:
> > >not sure I _can_ detect if the temp files really are just leftovers.
> >
> > It looks like you create temp file in objects , not objects/pack .
> >
> > So a rule could be : packs left in the former are crashed/killed,
> > and packs in the latter are complete?
>
> How do you know for sure that they are _left_ already?
Ah, e.g. you're packing and fsck'ing at the same time?
Then you can't know.  Never mind...

> > You should also look at $PACKTMP in git-repack.sh .
> > In it $GIT_DIR should probably be $GIT_OBJECT_DIRECTORY ?
>
> I think it should, but it is already not the working directory, so my
> original complaint does not apply
OK, if I have to further change my --max-pack-size patchset
which touches git-repack.sh, I'll roll this in.

Thanks,
-- 
Dana L. How  danahow@gmail.com  +1 650 804 5991 cell
