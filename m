X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.4 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: "Martin Langhoff" <martin.langhoff@gmail.com>
Subject: Re: If merging that is really fast forwarding creates new commit [Was: Re: how to show log for only one branch]
Date: Mon, 6 Nov 2006 13:03:21 -0300
Message-ID: <46a038f90611060803o653b5b8cx44d3adcfda699ec5@mail.gmail.com>
References: <454EAEDB.8020909@gmail.com>
	 <7vk629f6is.fsf@assigned-by-dhcp.cox.net> <454F31D7.1030202@gmail.com>
	 <Pine.LNX.4.64.0611060734490.25218@g5.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
NNTP-Posting-Date: Mon, 6 Nov 2006 16:07:07 +0000 (UTC)
Cc: "Liu Yubao" <yubao.liu@gmail.com>,
	"Junio C Hamano" <junkio@cox.net>, git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=uQiMRdZk03OxQjcZFXBt+JDB7i8bqDcTymlYmwTBY1Tuky0ODf8X9zgLUwbmSlUTMpjJMKz0x8SUDWTU9fgskld6tmmg8eZH6aAXGSvGWgVdTUVAQY4HPhTZNMC1Vo8FWgagfFeJ3zr2oFc9xxf7ZsJHoSRwcVVUI19sT6ri66E=
In-Reply-To: <Pine.LNX.4.64.0611060734490.25218@g5.osdl.org>
Content-Disposition: inline
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/31017>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1Gh6wm-0001ew-26 for gcvg-git@gmane.org; Mon, 06 Nov
 2006 17:03:41 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1753333AbWKFQD0 (ORCPT <rfc822;gcvg-git@m.gmane.org>); Mon, 6 Nov 2006
 11:03:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753331AbWKFQD0
 (ORCPT <rfc822;git-outgoing>); Mon, 6 Nov 2006 11:03:26 -0500
Received: from nf-out-0910.google.com ([64.233.182.186]:4419 "EHLO
 nf-out-0910.google.com") by vger.kernel.org with ESMTP id S1753333AbWKFQDY
 (ORCPT <rfc822;git@vger.kernel.org>); Mon, 6 Nov 2006 11:03:24 -0500
Received: by nf-out-0910.google.com with SMTP id x30so2639476nfb for
 <git@vger.kernel.org>; Mon, 06 Nov 2006 08:03:22 -0800 (PST)
Received: by 10.48.217.20 with SMTP id p20mr1469942nfg.1162829001254; Mon, 06
 Nov 2006 08:03:21 -0800 (PST)
Received: by 10.49.51.10 with HTTP; Mon, 6 Nov 2006 08:03:21 -0800 (PST)
To: "Linus Torvalds" <torvalds@osdl.org>
Sender: git-owner@vger.kernel.org

On 11/6/06, Linus Torvalds <torvalds@osdl.org> wrote:
> On Mon, 6 Nov 2006, Liu Yubao wrote:
> > Then, what bad *logical* problem will happen if a merging that is really a
> > fast forwarding creates a new commit?
> You MUST NOT do that.
>
> If a fast-forward were to do a "merge commit", you'd never get into the
> situation where two people merging each other would really ever get a
> stable result. They'd just keep doing merge commits on top of each other.

Indeed. I used Arch for quite a while and if you were merging between
2 or more repos it would never reach a stable point even if the code
didn't change at all.

If a group of 3 developers (with one repor per developer) was
developing at a slow pace (say, a daily commit each, plus a couple of
pull/updates per day) the garbage-commit to content-commit ratio was
awful. If on a given day noone had made a single commit, we'd still
have a whole set of useless updates merged and committed.

> Besides, doing an empty commit like that ("I fast forwarded") literally
> doesn't add any true history information.

And as the number of developers and repos grows in a distributed
scenarios, fast-forwards increasingly outnumber real commits. The
usefulness of your logs sinks to the sewers.

cheers,


