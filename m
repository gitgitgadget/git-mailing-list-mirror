From: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
Subject: Re: checkout extra files
Date: Tue, 4 Sep 2012 17:14:28 +0700
Message-ID: <CACsJy8C36eghwEOYqbnd2z5C5KnynWsvwMDa4e2hns3uW243EQ@mail.gmail.com>
References: <CAB9Jk9BvQmFfTq3a+e-7t-66s06jLK4fWuZB+MJHrAtbznBvHw@mail.gmail.com>
 <CACsJy8A6-Ok34QDqgSVavFDBE81UdcK4rLzkHe7P7UO=fXptGw@mail.gmail.com>
 <7vsjayew50.fsf@alter.siamese.dyndns.org> <CACsJy8BDtV95QmWmJ8CEh06FUePOB7KY6nKPR1KCZ7DkMN_MNQ@mail.gmail.com>
 <7vd322ebsz.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Angelo Borsotti <angelo.borsotti@gmail.com>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Sep 04 12:15:19 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1T8qAA-0001y9-S2
	for gcvg-git-2@plane.gmane.org; Tue, 04 Sep 2012 12:15:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756713Ab2IDKO7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 4 Sep 2012 06:14:59 -0400
Received: from mail-ie0-f174.google.com ([209.85.223.174]:54663 "EHLO
	mail-ie0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752253Ab2IDKO7 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 4 Sep 2012 06:14:59 -0400
Received: by ieje11 with SMTP id e11so4545729iej.19
        for <git@vger.kernel.org>; Tue, 04 Sep 2012 03:14:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=dRtuKuvAm2licBhfXRGX7ZJYUXwRVLk1NO3zV14Oims=;
        b=xpPmptSgYEF3P7R/Bk7PxnLTe5X2QCXJSO1B7GT2mTWoFpYwRtagIIm/BHOfvHPCJn
         30fhMnHzrJq6OHvOjCbimvX3dc7+KOkr7Sj+HmVAVDEvsSbRrOlEm3r96K/21XyhYpEN
         Y86BJn3zzlPMd31TzgRQj6W6JSNBdQTGWO5vUSypslOKxaXj/24u3n2hcZNrwMC8pQHE
         qN0B4fGnlr3u6hr/qsQ+SkDeMfDPjMQLcrzZb/dwFTkIlT1rWI0Vn40/uYLvuoSVqAbi
         YvrChIbLagiFmmYy6EoBewEVWRcn+jHZ3LZxpUdb8eqd3JnrI22fgGg/qHLO/KqdL+7o
         A8pw==
Received: by 10.50.159.130 with SMTP id xc2mr13422965igb.15.1346753698560;
 Tue, 04 Sep 2012 03:14:58 -0700 (PDT)
Received: by 10.64.64.72 with HTTP; Tue, 4 Sep 2012 03:14:28 -0700 (PDT)
In-Reply-To: <7vd322ebsz.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/204732>

On Tue, Sep 4, 2012 at 9:55 AM, Junio C Hamano <gitster@pobox.com> wrote:
> Perhaps like this?

Looks good. I was going to complain that this patch applied to
git-checkout.txt only but I just saw git-add.txt also mentions about
quoting wildcards. So I'm good.

> diff --git i/Documentation/git-checkout.txt w/Documentation/git-checkout.txt
> index 63a2516..e7272b6 100644
> --- i/Documentation/git-checkout.txt
> +++ w/Documentation/git-checkout.txt
> @@ -360,20 +360,32 @@ mistake, and gets it back from the index.
>  $ git checkout master             <1>
>  $ git checkout master~2 Makefile  <2>
>  $ rm -f hello.c
>  $ git checkout hello.c            <3>
>  ------------
>  +
>  <1> switch branch
>  <2> take a file out of another commit
>  <3> restore hello.c from the index
>  +
> +If you want to check out _all_ C source files out of the index,
> +you can say
> ++
> +------------
> +$ git checkout -- '*.c'
> +------------
> ++
> +Note the quotes around '*.c'.  'hello.c' will also be checked
> +out, even though it is no longer in the working tree, because
> +the pathspec is used to match entries in the index (not in the
> +working tree by your shell).
> ++
>  If you have an unfortunate branch that is named `hello.c`, this
>  step would be confused as an instruction to switch to that branch.
>  You should instead write:
>  +
>  ------------
>  $ git checkout -- hello.c
>  ------------
>
>  . After working in the wrong branch, switching to the correct
>  branch would be done using:
-- 
Duy
