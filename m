X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.4 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: "=?ISO-8859-1?Q?Santi_B=E9jar?=" <sbejar@gmail.com>
Subject: Re: git pull and merging.
Date: Fri, 8 Dec 2006 02:56:29 +0100
Message-ID: <8aa486160612071756s18f9530cr7ed26e4b7b47d1de@mail.gmail.com>
References: <cc723f590612052051r62111c4cgfd7ee893cb00f84a@mail.gmail.com>
	 <200612071227.46194.Josef.Weidendorfer@gmx.de>
	 <7vhcw7ttj9.fsf@assigned-by-dhcp.cox.net>
	 <200612072354.01830.Josef.Weidendorfer@gmx.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
NNTP-Posting-Date: Fri, 8 Dec 2006 01:56:39 +0000 (UTC)
Cc: "Junio C Hamano" <junkio@cox.net>,
	"Aneesh Kumar K.V" <aneesh.kumar@gmail.com>,
	"Johannes Schindelin" <Johannes.Schindelin@gmx.de>,
	git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=H+0rXLf2KVjlqe/jK8fmopOK6mjzxxXEByQKrhWfWIRTeK/LireVw2zPg0FlQiQ8uFUJX4wDVBQFZBXBMUHaP+ep++ndBWfJwl/wkiHFf/oTKtpGYrMRfJuEZys3tD7JfDa5sez5JpjH2tg7ADbtKtNZClh0PJ1x8bStGQJZmkU=
In-Reply-To: <200612072354.01830.Josef.Weidendorfer@gmx.de>
Content-Disposition: inline
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/33651>
Received: from vger.kernel.org ([209.132.176.167]) by dough.gmane.org with
 esmtp (Exim 4.50) id 1GsUyX-0007BK-J9 for gcvg-git@gmane.org; Fri, 08 Dec
 2006 02:56:33 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1423710AbWLHB4a (ORCPT <rfc822;gcvg-git@m.gmane.org>); Thu, 7 Dec 2006
 20:56:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1423715AbWLHB4a
 (ORCPT <rfc822;git-outgoing>); Thu, 7 Dec 2006 20:56:30 -0500
Received: from wx-out-0506.google.com ([66.249.82.230]:12658 "EHLO
 wx-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with
 ESMTP id S1423710AbWLHB4a (ORCPT <rfc822;git@vger.kernel.org>); Thu, 7 Dec
 2006 20:56:30 -0500
Received: by wx-out-0506.google.com with SMTP id h27so686973wxd for
 <git@vger.kernel.org>; Thu, 07 Dec 2006 17:56:29 -0800 (PST)
Received: by 10.70.39.2 with SMTP id m2mr4864797wxm.1165542989388; Thu, 07
 Dec 2006 17:56:29 -0800 (PST)
Received: by 10.70.45.1 with HTTP; Thu, 7 Dec 2006 17:56:29 -0800 (PST)
To: "Josef Weidendorfer" <Josef.Weidendorfer@gmx.de>
Sender: git-owner@vger.kernel.org

On 12/7/06, Josef Weidendorfer <Josef.Weidendorfer@gmx.de> wrote:
> On Thursday 07 December 2006 20:06, you wrote:
> > Once you place something like "branch.*.merge" in configuration
> > file (either $GIT_DIR/config, or a $GIT_DIR/remotes/* file), you
> > are talking about other repositories you regularly interact
> > with, so it might be probably Ok to require the user to use a
> > tracking branch if he wants the convenience of "branch.*.merge",
> > and make its value name the local tracking branch instead of the
> > remote branch.
> >
> > But that means I would never be able to benefit from the
> > convenience of "branch.*.merge";
>
> Hmm... that's true; actually, I did not thought about people
> which do not want to have any tracking branches (again!). So
>
> [remote "repo"]
>   url = ...
>   fetch = branch1
>   fetch = branch2
>
> [branch "mybranch1"]
>   remote = repo
>   merge = branch1
>
> actually looks fine, and is the only possible way.
> But still, this does not work.

It works for me.

> You have to specify
>
>   merge = refs/heads/branch1

It does not.

The merge line must match exactly the remote part of the refspec.

>
> That's confusing (perhaps I can come up with a patch
> to allow "branch1" alone).
>
> So probably the best way is to write some more detailed
> explanation into the docu ...

Perhaps that the branch.<name>.remote and branch.<name>.merge have the
equivalent meaning as the parameters of git-pull?

>
> Josef
> -
> To unsubscribe from this list: send the line "unsubscribe git" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
