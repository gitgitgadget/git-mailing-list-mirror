X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	DKIM_ADSP_CUSTOM_MED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: VCS comparison table
Date: Thu, 26 Oct 2006 19:45:27 +0200
Organization: At home
Message-ID: <ehqs6c$co1$2@sea.gmane.org>
References: <45354AD0.1020107@utoronto.ca> <BAYC1-PASMTP07AB11A64250AAF683424DAE0E0@CEZ.ICE> <vpq4ptz2uh8.fsf@ecrins.imag.fr> <453DAC87.8050203@research.canon.com.au> <Pine.LNX.4.64.0610232318200.3962@g5.osdl.org> <Pine.LNX.4.64N.0610232336010.30334@attu2.cs.washington.edu> <Pine.LNX.4.64.0610240812410.3962@g5.osdl.org> <Pine.LNX.4.64N.0610241300450.8112@attu4.cs.washington.edu> <20061025084810.GA26618@coredump.intra.peff.net> <Pine.LNX.4.64N.0610250157470.3467@attu1.cs.washington.edu> <20061025094900.GA26989@coredump.intra.peff.net> <Pine.LNX.4.64N.0610250954380.31053@attu2.cs.washington.edu> <454098EC.8040406@op5.se> <Pine.LNX.4.63.0610260929040.2424@qynat.qvtvafvgr.pbz> <Pine.LNX.4.64.0610261247420.12418@xanadu.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7Bit
NNTP-Posting-Date: Thu, 26 Oct 2006 17:45:43 +0000 (UTC)
Cc: bazaar-ng@lists.canonical.com
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
X-Injected-Via-Gmane: http://gmane.org/
Original-Followup-To: gmane.comp.version-control.git
Original-Lines: 33
Original-X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: host-81-190-23-110.torun.mm.pl
Mail-Copies-To: jnareb@gmail.com
User-Agent: KNode/0.10.2
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/30253>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1Gd9IE-0007Ti-Gj for gcvg-git@gmane.org; Thu, 26 Oct
 2006 19:45:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1423589AbWJZRpX (ORCPT <rfc822;gcvg-git@m.gmane.org>); Thu, 26 Oct 2006
 13:45:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1423592AbWJZRpX
 (ORCPT <rfc822;git-outgoing>); Thu, 26 Oct 2006 13:45:23 -0400
Received: from main.gmane.org ([80.91.229.2]:64211 "EHLO ciao.gmane.org") by
 vger.kernel.org with ESMTP id S1423589AbWJZRpW (ORCPT
 <rfc822;git@vger.kernel.org>); Thu, 26 Oct 2006 13:45:22 -0400
Received: from list by ciao.gmane.org with local (Exim 4.43) id
 1Gd9Ht-0007QW-Dl for git@vger.kernel.org; Thu, 26 Oct 2006 19:45:05 +0200
Received: from host-81-190-23-110.torun.mm.pl ([81.190.23.110]) by
 main.gmane.org with esmtp (Gmexim 0.1 (Debian)) id 1AlnuQ-0007hv-00 for
 <git@vger.kernel.org>; Thu, 26 Oct 2006 19:45:05 +0200
Received: from jnareb by host-81-190-23-110.torun.mm.pl with local (Gmexim
 0.1 (Debian)) id 1AlnuQ-0007hv-00 for <git@vger.kernel.org>; Thu, 26 Oct 2006
 19:45:05 +0200
To: git@vger.kernel.org
Sender: git-owner@vger.kernel.org

Nicolas Pitre wrote:

> On Thu, 26 Oct 2006, David Lang wrote:
> 
>> actually, there are some real problems in this area. the git pack format can't
>> be larger then 4G, and I wouldn't be surprised if there were other issues with
>> files larger then 4G (these all boil down to 32 bit limits). once these limits
>> are dealt with then you will be right.
> 
> There is no such limit on the pack format.  A pack itself can be as 
> large as you want.  The 4G limit is in the tool not the format.
[...]
> The _code_ is currently limited to 4G though, especially on 32-bit 
> architectures.  The delta issue could be resolved in a backward 
> compatible way but it hasn't been formalized yet.
> 
> The pack index is actually limited to 32-bits meaning it can cope with 
> packs no larger than 4G.  But the pack index is a local matter and not 
> part of the protocol so this is not a big issue to define a new index 
> format and automatically convert existing indexes at that point.

If I remember correctly those issues are under development:
1. There is work on 64-bit index
2. There is work that would allow to have multiple packs, repack only one
   of packs and treat the rest as 'archive packs' (which can be more
   aggresively packed). This solution is to split pack into multiple packs.
3. There is work on mmaping only part of pack, which would avoid 4G limit
   even on 32-bit machines, if I understand it correctly.
-- 
Jakub Narebski
Warsaw, Poland
ShadeHawk on #git

