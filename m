X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.4 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: "James Henstridge" <james@jamesh.id.au>
Subject: Re: VCS comparison table
Date: Thu, 26 Oct 2006 17:57:20 +0800
Message-ID: <a7e835d40610260257r5f05ea4gc934f1c1cc267977@mail.gmail.com>
References: <45357CC3.4040507@utoronto.ca>
	 <20061021130111.GL75501@over-yonder.net> <453F2FF8.2080903@op5.se>
	 <200610251146.06116.jnareb@gmail.com>
	 <a7e835d40610250308v5d577482m139742e7fe1db185@mail.gmail.com>
	 <87slhcz8zh.wl%cworth@cworth.org>
	 <a7e835d40610260152k658aeaf0hb900cb63870c04e4@mail.gmail.com>
	 <7vu01ro20b.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
NNTP-Posting-Date: Thu, 26 Oct 2006 09:57:45 +0000 (UTC)
Cc: bazaar-ng@lists.canonical.com,
	"Matthew D. Fuller" <fullermd@over-yonder.net>,
	"Linus Torvalds" <torvalds@osdl.org>,
	"Andreas Ericsson" <ae@op5.se>, "Carl Worth" <cworth@cworth.org>,
	git@vger.kernel.org, "Jakub Narebski" <jnareb@gmail.com>
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:sender:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references:x-google-sender-auth;
        b=XyRRKl44OP7JCleiIaK38leFfPGv8hgitrvhu9SicrfbRyIU3CokdL8xD+ROxeVHMLC6VIb7DqVZxhgQ+oYzJbxuMdJT5GvLSpBn9rWed/xrDk+lYU4XrO2pE5IkY0iYXYVN1hpXLAOGEzfCrq0EBrPhTgxqRnVXtQGm2i84voE=
In-Reply-To: <7vu01ro20b.fsf@assigned-by-dhcp.cox.net>
Content-Disposition: inline
X-Google-Sender-Auth: a8aed2c10c344854
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/30174>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1Gd1zL-0007Mm-Q9 for gcvg-git@gmane.org; Thu, 26 Oct
 2006 11:57:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1423078AbWJZJ5Y (ORCPT <rfc822;gcvg-git@m.gmane.org>); Thu, 26 Oct 2006
 05:57:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1423086AbWJZJ5X
 (ORCPT <rfc822;git-outgoing>); Thu, 26 Oct 2006 05:57:23 -0400
Received: from nf-out-0910.google.com ([64.233.182.186]:9645 "EHLO
 nf-out-0910.google.com") by vger.kernel.org with ESMTP id S1423078AbWJZJ5W
 (ORCPT <rfc822;git@vger.kernel.org>); Thu, 26 Oct 2006 05:57:22 -0400
Received: by nf-out-0910.google.com with SMTP id o60so939871nfa for
 <git@vger.kernel.org>; Thu, 26 Oct 2006 02:57:21 -0700 (PDT)
Received: by 10.82.126.5 with SMTP id y5mr390915buc; Thu, 26 Oct 2006
 02:57:20 -0700 (PDT)
Received: by 10.82.108.1 with HTTP; Thu, 26 Oct 2006 02:57:20 -0700 (PDT)
To: "Junio C Hamano" <junkio@cox.net>
Sender: git-owner@vger.kernel.org

On 26/10/06, Junio C Hamano <junkio@cox.net> wrote:
> "James Henstridge" <james@jamesh.id.au> writes:
>
> > Can you really just rely on equal revision IDs meaning you have the
> > same code though?
>
> If you two have the same commit that is a guarantee that you two
> have identical trees.  The reverse is not true as logic 101
> would teach ;-).

That was the point I was trying to make.  Carl asserted that in git
you could tell if you had the same tree as someone else based on
revision IDs, which doesn't seem to be the case all the time.

The reverse assertion (that if you have the same revision ID, you have
the same tree) seems to hold equally in git and Bazaar.


> Doing fast-forward instead of doing a "useless" merges helps
> somewhat but not in cases like two people merging the same
> branches the same way or two people applying the same patch on
> top of the same commit.  You need to compare tree object IDs for
> that.

Sure, you can do the same in Bazaar by comparing the inventories for
the two revisions.

>
> >> In bzr, the only answer I'm hearing is attempting a merge to see if it
> >> introduces any changes. (I'm deliberately avoiding "pull" since we're
> >> talking about distributed cases here).
> >
> > Or run "bzr missing".  If the sole missing revision is a merge (and
> > not the revisions introduced by the merge), you could assume that you
> > have the same tree state.
>
> Is it "you could assume" or "it is guaranteed"?  If former, what
> kind of corner cases could invalidate that assumption?

The merge revision will also include any manual conflict resolution.
If the other person resolved the conflicts differently.

