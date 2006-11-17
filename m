X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.4 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: "Michael K. Edwards" <medwards.linux@gmail.com>
Subject: Re: Cleaning up git user-interface warts
Date: Thu, 16 Nov 2006 22:42:55 -0800
Message-ID: <f2b55d220611162242s48dc42d6g4cbfd9173e712ff8@mail.gmail.com>
References: <87k61yt1x2.wl%cworth@cworth.org>
	 <7v3b8ltq7r.fsf@assigned-by-dhcp.cox.net>
	 <Pine.LNX.4.64.0611142306090.2591@xanadu.home>
	 <Pine.LNX.4.64.0611150950170.3349@woody.osdl.org>
	 <455BBCE9.4050503@xs4all.nl>
	 <Pine.LNX.4.64.0611151908130.3349@woody.osdl.org>
	 <Pine.LNX.4.63.0611162353250.13772@wbgn013.biozentrum.uni-wuerzburg.de>
	 <Pine.LNX.4.64.0611161508530.3349@woody.osdl.org>
	 <455CFCBD.8040901@xs4all.nl>
	 <f2b55d220611161734m49136e6fneda5b002eb67618b@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
NNTP-Posting-Date: Fri, 17 Nov 2006 06:43:11 +0000 (UTC)
Cc: "Junio C Hamano" <junkio@cox.net>
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=J225X2YkhHy3cvPNp0qMoE0kDpmgzGB4wPTDD3gIQmGozFexaNND90CpHEkesYAM1eLBiXhuu0YVy2fo1pcSHLMSEqvU9xdSNFW4faAGvACAzSUfb5/snrDfcWXk3Px/pYsgR0zPWrTHWDmBTUF5efMqHf24b7dghAh/7BXNSGc=
In-Reply-To: <f2b55d220611161734m49136e6fneda5b002eb67618b@mail.gmail.com>
Content-Disposition: inline
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/31670>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1GkxRD-00075q-K1 for gcvg-git@gmane.org; Fri, 17 Nov
 2006 07:42:59 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1754988AbWKQGm4 (ORCPT <rfc822;gcvg-git@m.gmane.org>); Fri, 17 Nov 2006
 01:42:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755468AbWKQGm4
 (ORCPT <rfc822;git-outgoing>); Fri, 17 Nov 2006 01:42:56 -0500
Received: from wx-out-0506.google.com ([66.249.82.224]:54319 "EHLO
 wx-out-0506.google.com") by vger.kernel.org with ESMTP id S1754988AbWKQGm4
 (ORCPT <rfc822;git@vger.kernel.org>); Fri, 17 Nov 2006 01:42:56 -0500
Received: by wx-out-0506.google.com with SMTP id s7so849838wxc for
 <git@vger.kernel.org>; Thu, 16 Nov 2006 22:42:55 -0800 (PST)
Received: by 10.90.25.7 with SMTP id 7mr1190856agy.1163745775332; Thu, 16 Nov
 2006 22:42:55 -0800 (PST)
Received: by 10.90.25.4 with HTTP; Thu, 16 Nov 2006 22:42:55 -0800 (PST)
To: git@vger.kernel.org
Sender: git-owner@vger.kernel.org

On 11/16/06, Michael K. Edwards <medwards.linux@gmail.com> wrote
>   The only entry placed in .git/remotes is the
> "origin" of the new clone, which is the "master" of the remote
> repository.  That's for the user's convenience, and is about the only
> thing in the new clone that _isn't_ a copy of something in the remote
> tree.

Actually, this "origin" entry does contain "Pull:" lines for all of
the branches that were cloned, so that "git pull" fetches and merges
updates to all of these branches.  (If upstream is in the habit of
reverting things, you may need "git pull -f"; I just did that on the
git repo to handle a failure to fast-forward on the "pu" branch.)

Presumably "git branch -D" should inspect everything under
.git/remotes to see whether one or more Pull: lines need to be deleted
along with the branch.  Currently, it looks like "remotes" entries are
created only by "git clone" or by hand.  Junio, are there any plans to
manage the contents of "remotes" through the tool instead of by hand?

Cheers,
