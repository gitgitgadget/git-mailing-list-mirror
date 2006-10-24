X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: "Marco Costalba" <mcostalba@gmail.com>
Subject: Re: [PATCH qgit] Change also tag marks when changing graph size
Date: Tue, 24 Oct 2006 21:45:02 +0200
Message-ID: <e5bfff550610241245r73b594ftf2cd39f4194b5411@mail.gmail.com>
References: <e5bfff550610240947i30bc3fc0x49710e4cbb0f0556@mail.gmail.com>
	 <200610242041.22230.Josef.Weidendorfer@gmx.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
NNTP-Posting-Date: Wed, 25 Oct 2006 18:16:01 +0000 (UTC)
Cc: "Git Mailing List" <git@vger.kernel.org>
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=Gp/Z6LlGexl2hGYgjz+LM5DIVJtBd/YvjR5Si+SBKGwTD0QtOvPY07rhpna7Fmpwlv+kYo7Gpdeyith2031ffEtwl6U/Okh+vkjaEjYlIpmD8Z9RAL071HxIzhh6OC8PpUyFfPZtowwDZFq3rZKVY7K7hIbWLwz9VmGdo2YbYmg=
In-Reply-To: <200610242041.22230.Josef.Weidendorfer@gmx.de>
Content-Disposition: inline
X-Virus-Scanned: ClamAV 0.88.4/2091/Tue Oct 24 13:27:53 2006 on zeus1.kernel.org
X-Virus-Status: Clean
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/30084>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1GcnI1-0002km-Lm for gcvg-git@gmane.org; Wed, 25 Oct
 2006 20:15:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1030343AbWJYSPm (ORCPT <rfc822;gcvg-git@m.gmane.org>); Wed, 25 Oct 2006
 14:15:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030400AbWJYSPm
 (ORCPT <rfc822;git-outgoing>); Wed, 25 Oct 2006 14:15:42 -0400
Received: from zeus1.kernel.org ([204.152.191.4]:55751 "EHLO
 zeus1.kernel.org") by vger.kernel.org with ESMTP id S1030343AbWJYSPl (ORCPT
 <rfc822;git@vger.kernel.org>); Wed, 25 Oct 2006 14:15:41 -0400
Received: from py-out-1112.google.com (py-out-1112.google.com
 [64.233.166.183]) by zeus1.kernel.org (8.13.7/8.13.1) with ESMTP id
 k9OJk593010284 for <git@vger.kernel.org>; Tue, 24 Oct 2006 19:46:18 GMT
Received: by py-out-1112.google.com with SMTP id z74so146850pyg for
 <git@vger.kernel.org>; Tue, 24 Oct 2006 12:45:02 -0700 (PDT)
Received: by 10.35.94.7 with SMTP id w7mr9487927pyl; Tue, 24 Oct 2006
 12:45:02 -0700 (PDT)
Received: by 10.35.42.4 with HTTP; Tue, 24 Oct 2006 12:45:02 -0700 (PDT)
To: "Josef Weidendorfer" <Josef.Weidendorfer@gmx.de>
Sender: git-owner@vger.kernel.org

On 10/24/06, Josef Weidendorfer <Josef.Weidendorfer@gmx.de> wrote:
> On Tuesday 24 October 2006 18:47, Marco Costalba wrote:
> > When changing graph size with CTRL+ and CTRL-
> > update also tag/branch marks.
> >
> > Also little cleanup.
> > ---
> >
> > Hi Josef,
> >
> >   please tell me if you are working on the same files, in this case I
> > will step back and wait you to finish your patch series and eventually
> > resubmit this one at the end.
>
> No, that is fine. Currently, I have not much time.
> Just curious: What did you expect next in my patch series? :-)
>

Quoting from your last e-mail:
"The new painting code regroups the drawing commands in
multiple switch-statements to prepare for far simpler code
with booleans for different elements, and not one type only."

Indeed it's not clear to me what the above line means exactly, it just
smells like there is something more cooking. Sorry If I've
misunderstood.

> Now that everything is drawn directly, the question is what to do with
> the new flexibility. E.g. we _could_ implement different
> graph drawing algorithms next to the original qgit one,
> e.g. mimicking gitk.

One little secret of current algorithm is that it just needs to know
the "state" of previous revision graph to calculate the next one. (see
Git::updateLanes() and lanes.cpp), it's a kind of a "rasterized" graph
drawing, i.e. line by line.

I didn't studied gitk in deep but it seems a little bit less simpler.
Anyway if you are interested it's for sure worth trying ;-)

