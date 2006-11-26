X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [RFD] making separate-remote layout easier to use
Date: Sun, 26 Nov 2006 10:32:14 +0100
Message-ID: <200611261032.15207.jnareb@gmail.com>
References: <7v1wnr19do.fsf@assigned-by-dhcp.cox.net> <ekafpm$fs7$1@sea.gmane.org> <20061126033433.GD29394@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
NNTP-Posting-Date: Sun, 26 Nov 2006 09:30:51 +0000 (UTC)
Cc: Junio C Hamano <junkio@cox.net>, git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:from:to:subject:date:user-agent:cc:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=mRK7OOQo46l3sRy+eDQ/Wzc3ywNe0UIrpfmVyFUCtbZ3RskgkVyjtrN+2yLPvVXz6BJ8TyXSdX3tr/6heYzwVd2AFcGK9QaXrBIL/VYDoHL3U4pT29DbxLnM1egRg9XEMDEmAc8wjogoqZ6HTNpe4rKCapjPEysv09vA34Lqr1U=
User-Agent: KMail/1.9.3
In-Reply-To: <20061126033433.GD29394@spearce.org>
Content-Disposition: inline
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/32337>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1GoGLU-0008CC-UV for gcvg-git@gmane.org; Sun, 26 Nov
 2006 10:30:45 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S935285AbWKZJag (ORCPT <rfc822;gcvg-git@m.gmane.org>); Sun, 26 Nov 2006
 04:30:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S935286AbWKZJag
 (ORCPT <rfc822;git-outgoing>); Sun, 26 Nov 2006 04:30:36 -0500
Received: from ug-out-1314.google.com ([66.249.92.171]:368 "EHLO
 ug-out-1314.google.com") by vger.kernel.org with ESMTP id S935285AbWKZJaf
 (ORCPT <rfc822;git@vger.kernel.org>); Sun, 26 Nov 2006 04:30:35 -0500
Received: by ug-out-1314.google.com with SMTP id 44so923834uga for
 <git@vger.kernel.org>; Sun, 26 Nov 2006 01:30:34 -0800 (PST)
Received: by 10.67.30.6 with SMTP id h6mr10206811ugj.1164533434261; Sun, 26
 Nov 2006 01:30:34 -0800 (PST)
Received: from host-81-190-24-209.torun.mm.pl ( [81.190.24.209]) by
 mx.google.com with ESMTP id k2sm11056524ugf.2006.11.26.01.30.33; Sun, 26 Nov
 2006 01:30:33 -0800 (PST)
To: Shawn Pearce <spearce@spearce.org>
Sender: git-owner@vger.kernel.org

Shawn Pearce wrote:
> Jakub Narebski <jnareb@gmail.com> wrote:
>> Junio C Hamano wrote:
>>
>>> I am not sure if 'merge in corresponding branch' is the only
>>> valid workflow, however. I am reluctant to make the system
>>> automatically do so if the solution makes other workflows more
>>> painful to follow.  Automatically merging remotes/origin/$foo
>>> when on $foo branch is not good enough, in other words (also,
>>> there may be a hierarchy under remotes/ other than origin).  It
>>> might make sense to introduce "Merge: " in remotes/ file and if
>>> they are present use "Pull: " only to decide what are fetched
>>> and use "Merge: " to decide what is merged (if we were doing the
>>> system from scratch, the former would have been named "Fetch: "
>>> but it is too late now).
>> 
>> If you add "Merge: " in remotes/, then please add it also in
>> remote section in config file. Config file has now 
>> branch.<branchname>.merge (and it would be nice if clone would
>> set ou this for local branches corresponding to remote branches),
>> but it is not the same.
> 
> I'm against adding anything to the remotes/ file format.
> 
> We already have branch.<name>.merge to indicate what the default
> source for a git-pull on the branch named <name> should be.
> git-branch probably should fill that entry in when a branch is
> created from a remotes ref.

As I said, branch.<name>.merge is about something else: it just means
that if we are on <name> branch "git pull" will merge 
branch.<name>.merge branch into it.

I think the "Merge: " or remote.<repo>.merge is about changing current 
implicit rule: first branch is to be merged with current branch (if not 
specified otherwise) when pull-ing, into explicit rule: branch marked 
as "Merge: " is to be merged with current branch (unless specified 
otherwise).

Correct me if I'm wrong, Junio.
-- 
Jakub Narebski
