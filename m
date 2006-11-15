X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.4 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Andy Parkins <andyparkins@gmail.com>
Subject: Re: Cleaning up git user-interface warts
Date: Wed, 15 Nov 2006 19:14:48 +0000
Message-ID: <200611151914.50530.andyparkins@gmail.com>
References: <87k61yt1x2.wl%cworth@cworth.org> <200611150917.23756.andyparkins@gmail.com> <7vk61woar5.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
NNTP-Posting-Date: Wed, 15 Nov 2006 19:18:10 +0000 (UTC)
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:from:to:subject:date:user-agent:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=shVzmA6OjkklzI1atBTtIyS4iw7vxv3C3rmrGrS1ncTs91Acvu8j86rI21DIEkXi8MWtI0akIE4uHGXnVAFSLaaDFchN6gAecAJ0H11/NaDBDlhGVrBZs62fnlV+wRfsqYesbE2AfJXMMTCKBsh1npqD0833AmIpKV1k3EMUtTU=
User-Agent: KMail/1.9.5
In-Reply-To: <7vk61woar5.fsf@assigned-by-dhcp.cox.net>
Content-Disposition: inline
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/31474>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1GkQGm-0000Bf-5o for gcvg-git@gmane.org; Wed, 15 Nov
 2006 20:18:00 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1030916AbWKOTRb (ORCPT <rfc822;gcvg-git@m.gmane.org>); Wed, 15 Nov 2006
 14:17:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030918AbWKOTRb
 (ORCPT <rfc822;git-outgoing>); Wed, 15 Nov 2006 14:17:31 -0500
Received: from ug-out-1314.google.com ([66.249.92.172]:9585 "EHLO
 ug-out-1314.google.com") by vger.kernel.org with ESMTP id S1030916AbWKOTR3
 (ORCPT <rfc822;git@vger.kernel.org>); Wed, 15 Nov 2006 14:17:29 -0500
Received: by ug-out-1314.google.com with SMTP id m3so232879ugc for
 <git@vger.kernel.org>; Wed, 15 Nov 2006 11:17:28 -0800 (PST)
Received: by 10.66.243.2 with SMTP id q2mr3511184ugh.1163618246996; Wed, 15
 Nov 2006 11:17:26 -0800 (PST)
Received: from grissom.internal.parkins.org.uk ( [84.201.153.164]) by
 mx.google.com with ESMTP id a1sm1331738ugf.2006.11.15.11.17.26; Wed, 15 Nov
 2006 11:17:26 -0800 (PST)
To: git@vger.kernel.org
Sender: git-owner@vger.kernel.org

On Wednesday 2006, November 15 17:55, Junio C Hamano wrote:

> I think the latter is what clone has done always; take remote's
> HEAD and use that to initialize local master (there is no

It's this sort of thing that is confusing though - the remote HEAD branch 
could be anything, and yet that is made to be origin locally as a tracking 
branch and then master as the writable branch.  What if upstream /has/ a 
master but "next" is its HEAD?  You'd then get

 next:remotes/origin
 master:remotes/master

Then a local master which is actually upstream next!  Oh dear.

I may well have misunderstood what you've said above above clone always 
initialising master from remote's HEAD; if so please disregard what I'm 
saying.

> > that as soon as git-clone has special capabilities (like --shared,
> > --local and --reference) then you are prevented from doing magic with
> > existing repositories.
>
> That is not entirely true.  clone has convenience because people
> asked.  It does not have to mean you are not allowed to give
> similar convenience to other commands.  Patches?

Absolutely, that was why I said clone shouldn't have special abilities.  In 
fact, if you're willing you don't need clone at all; you just need 
git-init-db and to write the correct remotes file.  

> > branches from two other local repositories that have the objects hard
> > linked?
>
> fetch by second local repository with git-local-fetch perhaps.

Is that not plumbing?  I thought this was about porcelain.

> A consensus would not write code and it generally does not take
> technology into account to tell what is realistic and what is
> not, so the result needs to be take with a grain of salt,
> though.

Of course, I only suggested it because the same suggestions were popping up 
multiple times.  Anyway; I put it in the GitWiki at 
http://git.or.cz/gitwiki/Wishlist

Andy

-- 
Dr Andrew Parkins, M Eng (Hons), AMIEE
