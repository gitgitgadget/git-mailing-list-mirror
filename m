X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.4 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD,
	T_DKIM_INVALID shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: Suggested workflow for frequent directory renames.
Date: Tue, 26 May 2009 02:24:16 -0700 (PDT)
Message-ID: <m37i04cj45.fsf@localhost.localdomain>
References: <4A1B352C.9030409@virgin.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
NNTP-Posting-Date: Tue, 26 May 2009 09:24:37 +0000 (UTC)
Cc: git@vger.kernel.org
To: Matthew Clemence <matthew.clemence@virgin.net>
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:received
         :x-authentication-warning:to:cc:subject:references:from:date
         :in-reply-to:message-id:lines:user-agent:mime-version:content-type;
        bh=k+hxDOgO6dB+NvnUrk8s2VSI0H8Yidmwz+82WITCceg=;
        b=WFy+jBuFBSJBRgRUHK6VHxQHoUDedb4FwQGE7DFD240tQypmyMSZKfdcPIuu7CUK8X
         FWit/FVQP8+4/ABZGggCJW8jNuEnlCqIDP8JM9xU30Hw/agLeeWSKctb+83d01jsEvjS
         yX+e/btMeLK2ANNi0tPuxs1Xd1y9sn0QnZezc=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=x-authentication-warning:to:cc:subject:references:from:date
         :in-reply-to:message-id:lines:user-agent:mime-version:content-type;
        b=tNBFshwzIQkyW4FBByKT0II8RkKjnIQa9qIaRL9eHoHWYsBT9lfAVyn7ey6cD6uPnu
         +ArduslIkwLNorAFmrS9HZuGGQW6Ock/6nHYYFrYAQ8xRPBCVxrGJCFs3r5DwuXAmtAx
         EANKz7Us4nQWeBH2vRdtqTk94VmZZgsBThBKc=
X-Authentication-Warning: localhost.localdomain: jnareb set sender to jnareb@gmail.com using -f
In-Reply-To: <4A1B352C.9030409@virgin.net>
Original-Lines: 58
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.4
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/120000>
Received: from vger.kernel.org ([209.132.176.167]) by lo.gmane.org with esmtp
 (Exim 4.50) id 1M8stY-0000mK-Qy for gcvg-git-2@gmane.org; Tue, 26 May 2009
 11:24:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1754178AbZEZJYT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>); Tue, 26 May 2009
 05:24:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754182AbZEZJYS
 (ORCPT <rfc822;git-outgoing>); Tue, 26 May 2009 05:24:18 -0400
Received: from mail-gx0-f166.google.com ([209.85.217.166]:39943 "EHLO
 mail-gx0-f166.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with
 ESMTP id S1753604AbZEZJYR (ORCPT <rfc822;git@vger.kernel.org>); Tue, 26 May
 2009 05:24:17 -0400
Received: by gxk10 with SMTP id 10so6392668gxk.13 for <git@vger.kernel.org>;
 Tue, 26 May 2009 02:24:18 -0700 (PDT)
Received: by 10.90.88.17 with SMTP id l17mr4878548agb.80.1243329858182; Tue,
 26 May 2009 02:24:18 -0700 (PDT)
Received: from localhost.localdomain (abuz119.neoplus.adsl.tpnet.pl
 [83.8.197.119]) by mx.google.com with ESMTPS id
 4sm16402118agc.12.2009.05.26.02.24.15 (version=TLSv1/SSLv3 cipher=RC4-MD5);
 Tue, 26 May 2009 02:24:16 -0700 (PDT)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1]) by
 localhost.localdomain (8.13.4/8.13.4) with ESMTP id n4Q9OBca026534; Tue, 26
 May 2009 11:24:12 +0200
Received: (from jnareb@localhost) by localhost.localdomain
 (8.13.4/8.13.4/Submit) id n4Q9OAs2026531; Tue, 26 May 2009 11:24:10 +0200
Sender: git-owner@vger.kernel.org

Matthew Clemence <matthew.clemence@virgin.net> writes:

> I am working with an externally supplied code tree (some 2000 files,
> which gets passed to me without any SCM) and have multiple users
> working on their own individual branched versions under git
> control. The problem I am facing is that there are frequenct directory
> renames when the code updates which I need to find a relatively
> painless way of bringing the users branches up to date. 

Hmmm... are you sure you are solving the correct problem? Can't you
avoid directory renames, e.g. by munging position of files before
entering them into SCM?

> From reading
> the lists and faq, there seems to be problems (and strong opinions)
> with this, and I am struggling to find an effcient model to manage
> this merging - either git loses track of the users changed files (and
> so have to be manually merged from diff files and usually lose
> history) or git loses track of everything else (and I end up manually
> adding files from the new tree to get out of merge conflict).
> 
> I would be very interested to hear if anyone has a suggestion on how
> this could best be handled.

Git, contrary to other version control systems such as Mercurial or
Bazaar, doesn't use tracking of renames (either via recording rename
event, or by using file identities / inodes), but heuristic similarity
based rename _detection_.  If the files are of sufficient size
compared to changes, rename detection should work well and when
merging changes should be applied to correct files / correct files
would be renamed.  Changing directory the file resides in is currently
in Git just the form of changing pathname of a file, i.e. renaming of
a file.  Rename detection uses similarity of filename as one of
factors so if basename didn't change git should correctly pair files.


The problem currently is when one side renames directory, and other
side creates new file in the old-name directory.  Rename tracking
would not help here unless SCM track also directory renames, like
Bazaar reportedly does.

But the problem is not impossible to overcome using rename detection
like in git.  There were even patches adding detection of wholesame
directory renaming (factoring out directory renames out of set of
detected file renames) by Yann Dirson, but they were not accepted for
some reason.  You migh want to either contact author, or clean up the
series and send them yourself (if possibly with use cases and success
stories):
  http://thread.gmane.org/gmane.comp.version-control.git/99529

See also directory rename detection script (in Perl) in
  http://permalink.gmane.org/gmane.comp.version-control.git/81547

BTW. This issue was discussed extensively on git mailing list...
-- 
Jakub Narebski
Poland
