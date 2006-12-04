X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: merlyn@stonehenge.com (Randal L. Schwartz)
Subject: Re: latest update to git-svn blows up for me
Date: 04 Dec 2006 11:36:08 -0800
Message-ID: <86zma3lahj.fsf@blue.stonehenge.com>
References: <863b7wnwcw.fsf@blue.stonehenge.com>
	<20061204070021.GG1369@localdomain>
	<86hcwbnb0o.fsf@blue.stonehenge.com> <20061204181241.GA27342@soma>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
NNTP-Posting-Date: Mon, 4 Dec 2006 19:36:21 +0000 (UTC)
Cc: git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
x-mayan-date: Long count = 12.19.13.15.11; tzolkin = 5 Chuen; haab = 4 Mac
In-Reply-To: <20061204181241.GA27342@soma>
Original-Lines: 37
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.4
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/33226>
Received: from vger.kernel.org ([209.132.176.167]) by dough.gmane.org with
 esmtp (Exim 4.50) id 1GrJbp-00085v-Sh for gcvg-git@gmane.org; Mon, 04 Dec
 2006 20:36:14 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1759421AbWLDTgL (ORCPT <rfc822;gcvg-git@m.gmane.org>); Mon, 4 Dec 2006
 14:36:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1759442AbWLDTgL
 (ORCPT <rfc822;git-outgoing>); Mon, 4 Dec 2006 14:36:11 -0500
Received: from blue.stonehenge.com ([209.223.236.162]:6975 "EHLO
 blue.stonehenge.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
 id S1759421AbWLDTgJ (ORCPT <rfc822;git@vger.kernel.org>); Mon, 4 Dec 2006
 14:36:09 -0500
Received: from localhost (localhost [127.0.0.1]) by blue.stonehenge.com
 (Postfix) with ESMTP id 4C0818F9D5; Mon,  4 Dec 2006 11:36:09 -0800 (PST)
Received: from blue.stonehenge.com ([127.0.0.1]) by localhost
 (blue.stonehenge.com [127.0.0.1]) (amavisd-new, port 10024) with LMTP id
 24865-01-76; Mon,  4 Dec 2006 11:36:08 -0800 (PST)
Received: by blue.stonehenge.com (Postfix, from userid 1001) id 95B538FA86;
 Mon,  4 Dec 2006 11:36:08 -0800 (PST)
To: Eric Wong <normalperson@yhbt.net>
Sender: git-owner@vger.kernel.org

>>>>> "Eric" == Eric Wong <normalperson@yhbt.net> writes:

Eric> "Randal L. Schwartz" <merlyn@stonehenge.com> wrote:
>> >>>>> "Eric" == Eric Wong <normalperson@yhbt.net> writes:
>> 
Eric> "Randal L. Schwartz" <merlyn@stonehenge.com> wrote:
>> >> 
>> >> Does this ring a bell?
>> 
Eric> Nope.
>> 
Eric> This is on r15941 of  https://svn.perl.org/parrot/trunk ?  I can't seem
Eric> to reproduce this with git svn fetch -r15940:15941
>> 
>> No, and that worked for me as well.  Apparently, I might have corrupted my
>> metadata because I updated git-svn while I was using it.  Is there any way to
>> reset the metadata without having to re-fetch 15000 revisions?

Eric> rm .git/refs/remotes/$GIT_SVN_ID .git/svn/$GIT_SVN_ID/.rev_db
Eric> git svn -i $GIT_SVN_ID rebuild

That's not working:

localhost.local:..RROR/parrot-GITSVN % git-svn -i git-svn rebuild
fatal: 'origin': unable to chdir or not a git archive
fatal: unexpected EOF
Failed to find remote refs
256 at /opt/git/bin/git-svn line 2151
        main::safe_qx('git-ls-remote', 'origin', 'refs/remotes/git-svn') called at /opt/git/bin/git-svn line 3404
        main::copy_remote_ref() called at /opt/git/bin/git-svn line 226
        main::rebuild() called at /opt/git/bin/git-svn line 187

-- 
Randal L. Schwartz - Stonehenge Consulting Services, Inc. - +1 503 777 0095
<merlyn@stonehenge.com> <URL:http://www.stonehenge.com/merlyn/>
Perl/Unix/security consulting, Technical writing, Comedy, etc. etc.
