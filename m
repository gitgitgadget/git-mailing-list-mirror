X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	DKIM_ADSP_CUSTOM_MED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: git and bzr
Date: Tue, 28 Nov 2006 19:06:27 +0100
Organization: At home
Message-ID: <ekhtnt$rkk$1@sea.gmane.org>
References: <45357CC3.4040507@utoronto.ca>	<a7e835d40610250308v5d577482m139742e7fe1db185@mail.gmail.com>	<87slhcz8zh.wl%cworth@cworth.org>	<a7e835d40610260152k658aeaf0hb900cb63870c04e4@mail.gmail.com>	<7vu01ro20b.fsf@assigned-by-dhcp.cox.net>	<a7e835d40610260257r5f05ea4gc934f1c1cc267977@mail.gmail.com>	<20061026101038.GA13310@coredump.intra.peff.net>	<877iyne4dm.fsf@alplog.fr>	<Pine.LNX.4.64.0610260753090.3962@g5.osdl.org>	<456B7C6A.80104@webdrake.net>	<845b6e870611280410j58bdcd99nc05d0f67489293e4@mail.gmail.com>	<ekhaeg$etk$1@sea.gmane.org>	<Pine.LNX.4.63.0611281433270.30004@wbgn013.biozentrum.uni-wuerzburg.de> <Pine.LNX.4.64.0611280754050.30076@woody.osdl.org> <456C7592.6020700@ableton.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7Bit
NNTP-Posting-Date: Tue, 28 Nov 2006 18:07:27 +0000 (UTC)
Cc: bazaar-ng@lists.canonical.com
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
X-Injected-Via-Gmane: http://gmane.org/
Original-Followup-To: gmane.comp.version-control.git
Original-Lines: 48
Original-X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: host-81-190-24-209.torun.mm.pl
Mail-Copies-To: jnareb@gmail.com
User-Agent: KNode/0.10.2
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/32557>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1Gp7Ls-0000gh-B5 for gcvg-git@gmane.org; Tue, 28 Nov
 2006 19:06:40 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S935979AbWK1SG2 (ORCPT <rfc822;gcvg-git@m.gmane.org>); Tue, 28 Nov 2006
 13:06:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S935992AbWK1SG2
 (ORCPT <rfc822;git-outgoing>); Tue, 28 Nov 2006 13:06:28 -0500
Received: from main.gmane.org ([80.91.229.2]:39581 "EHLO ciao.gmane.org") by
 vger.kernel.org with ESMTP id S935979AbWK1SG1 (ORCPT
 <rfc822;git@vger.kernel.org>); Tue, 28 Nov 2006 13:06:27 -0500
Received: from list by ciao.gmane.org with local (Exim 4.43) id
 1Gp7Kr-0000PY-5p for git@vger.kernel.org; Tue, 28 Nov 2006 19:05:37 +0100
Received: from host-81-190-24-209.torun.mm.pl ([81.190.24.209]) by
 main.gmane.org with esmtp (Gmexim 0.1 (Debian)) id 1AlnuQ-0007hv-00 for
 <git@vger.kernel.org>; Tue, 28 Nov 2006 19:05:37 +0100
Received: from jnareb by host-81-190-24-209.torun.mm.pl with local (Gmexim
 0.1 (Debian)) id 1AlnuQ-0007hv-00 for <git@vger.kernel.org>; Tue, 28 Nov 2006
 19:05:37 +0100
To: git@vger.kernel.org
Sender: git-owner@vger.kernel.org

Nicholas Allen wrote:

>> The reason this is a good example is simply the fact that it should 
>> totally silence anybody who still thinks that tracking file identities is 
>> a good thing. It explains well why tracking file identities is just 
>> _stupid_.
>
> I'm unfamiliar with git so I could be totally wrong here!
> 
> I know that bzr supports file renames/moves very effectively and I 

This means: _usually_ works, doesn't it? Emphasisis on "usually"?

> understood that git doesn't support this to the same extent (correct me 
> if I am wrong as I have not used git at all!).

Git supports renames/moves in different way. Instead of recording renames
(which has trouble on it's own, for example rename via applying patch)
in the repository it _detect_ renames when needed.
 
> If that is the case, could that be because bzr gives each file its own 
> id and can detect this easily but git's content based approach can't? If 
> so then claiming file identifiers is *stupid* seems a bit extreme. So I 
> would have thought *both* file identifiers and line/content identifiers 
> are needed for tracking changes made to the files and to their contents 
> respectively. When a file is copied then the contents are copied and it 
> is given a new file identifier. When a file is moved it keeps the same 
> identifier. So don't you need file identifiers as well as line/content 
> identifiers?

There are trouble with file-ids. Most common example is trouble with file
which was created in two branches (two repositories) independently, then
branches got merged. Most (all?) file-id based rename detection has trouble
with repeated merging of those branches, even if there are no true
conflicts.

Read Linus post about file-id based rename detection:
  Message-ID: <Pine.LNX.4.64.0610201049250.3962@g5.osdl.org>
  http://permalink.gmane.org/gmane.comp.version-control.bazaar-ng.general/18458

Not that contents based rename detection doesn have it's own pitfals:
  Message-ID: <7virha4cnm.fsf@assigned-by-dhcp.cox.net>
  http://permalink.gmane.org/gmane.comp.version-control.git/31899
-- 
Jakub Narebski
Warsaw, Poland
ShadeHawk on #git

