X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.4 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: "Paolo Ciarrocchi" <paolo.ciarrocchi@gmail.com>
Subject: Re: Pull and fetch
Date: Fri, 24 Nov 2006 10:30:33 +0100
Message-ID: <4d8e3fd30611240130m2d04efe8qcc8bb5d61f8c7386@mail.gmail.com>
References: <20061123203950.5d47421f@paolo-desktop>
	 <BAYC1-PASMTP11EB389CA59410315B2F8AAEE20@CEZ.ICE>
	 <4d8e3fd30611231245m198e4e37ga2012b1c466f4588@mail.gmail.com>
	 <BAYC1-PASMTP11A008C336418A659F0E75AEE20@CEZ.ICE>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
NNTP-Posting-Date: Fri, 24 Nov 2006 09:30:53 +0000 (UTC)
Cc: "Git Mailing List" <git@vger.kernel.org>
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=NunHhLzzUDTIR9BV0BQ98ojRDK/6ajwuNmaAF1v4b0NtRjYj7VDKg3akho1GbStWi4KuvMvGAFSB5v3oUS6aYiQdDP2kSZHxoig4pwp8k1RzAfeKyZQKhbOTdn9BUA0cyqETjHO2vuialyRxgoGdW6EW9wogoi5K1NNY03Wuiw4=
In-Reply-To: <BAYC1-PASMTP11A008C336418A659F0E75AEE20@CEZ.ICE>
Content-Disposition: inline
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/32204>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1GnXOQ-0007Cg-5H for gcvg-git@gmane.org; Fri, 24 Nov
 2006 10:30:46 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1755448AbWKXJag (ORCPT <rfc822;gcvg-git@m.gmane.org>); Fri, 24 Nov 2006
 04:30:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757531AbWKXJag
 (ORCPT <rfc822;git-outgoing>); Fri, 24 Nov 2006 04:30:36 -0500
Received: from ug-out-1314.google.com ([66.249.92.174]:62344 "EHLO
 ug-out-1314.google.com") by vger.kernel.org with ESMTP id S1755448AbWKXJaf
 (ORCPT <rfc822;git@vger.kernel.org>); Fri, 24 Nov 2006 04:30:35 -0500
Received: by ug-out-1314.google.com with SMTP id 44so616987uga for
 <git@vger.kernel.org>; Fri, 24 Nov 2006 01:30:34 -0800 (PST)
Received: by 10.78.204.20 with SMTP id b20mr10157303hug.1164360633887; Fri,
 24 Nov 2006 01:30:33 -0800 (PST)
Received: by 10.78.165.3 with HTTP; Fri, 24 Nov 2006 01:30:33 -0800 (PST)
To: Sean <seanlkml@sympatico.ca>
Sender: git-owner@vger.kernel.org

On 11/23/06, Sean <seanlkml@sympatico.ca> wrote:
> On Thu, 23 Nov 2006 21:45:32 +0100
> "Paolo Ciarrocchi" <paolo.ciarrocchi@gmail.com> wrote:

> > So it fetches into testbranchpull and merge its content with master.
> > Right?
>
> Exactly.  You'll hear people say, git-pull is simply a fetch + a merge.
> This is what they mean.

Fair enough.

> > Since master was empy I now have 3 identical branches if I'm getting
> > it correctly.
>
> Yes.
>
> > Not so sure I've got everything.
> >
> > If I do:
> > git checkout testbranch
> > edit file
> > git commit -a
> > git fetch ../git master:testbranch
>
> You are not allowed to fetch changes into a branch you have modified
> locally.   If you use the "-f" (force) option of fetch to force it,
> your local commits will be lost.

OK

> If you want to merge remote master changes into this testbranch
> after you've updated, you'd want:
>
> git pull ../git master
>
> (which fetches the remote master into a hidden temp branch, and
> then merges it with the locally checked out branch (testbranch))

Thanks, now I think I have a clear picture. I think it's worth to add
some more info to tutorial.txt about difference between fetch and
pull. I don't believe I'm the only confused user ;-)

> > Last command will merge my local change with the remote master but
> > will keep my local master unmodified, right?
>
> No.. Fetch never merges, only copies remote data into your repo.

I was confused by the "merge" terminology, if I fetch to an empty
branch the concept of copy is easy to be understood, but if I fetch to
a branch that contains data then it's somehow more difficult to think
about fetching without thinking of "merge the remote branch into
local".

But now I think I understood it ;-)


> But you're right, your local master would be unaffected.
>
> Cheers,
> Sean
>
> P.S.  Please keep the questions on the list.  That way if i get something
> wrong someone will correct it.  Someone else might be able to give
> you a better answer too.

Sure, sorry about that. It was not my intention, I just pressed the
wrong button :)

Regards,
-- 
Paolo
http://docs.google.com/View?docid=dhbdhs7d_4hsxqc8
