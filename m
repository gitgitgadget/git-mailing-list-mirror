X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	DKIM_ADSP_CUSTOM_MED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: git and bzr
Date: Tue, 28 Nov 2006 20:59:12 +0100
Organization: At home
Message-ID: <eki4b1$ivt$1@sea.gmane.org>
References: <45357CC3.4040507@utoronto.ca> <ekhtnt$rkk$1@sea.gmane.org> <456C89E7.8080404@ableton.com> <200611281940.40139.andyparkins@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7Bit
NNTP-Posting-Date: Tue, 28 Nov 2006 19:58:42 +0000 (UTC)
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
X-Injected-Via-Gmane: http://gmane.org/
Original-Lines: 44
Original-X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: host-81-190-24-209.torun.mm.pl
Mail-Copies-To: jnareb@gmail.com
User-Agent: KNode/0.10.2
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/32569>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1Gp95o-0005g3-Dn for gcvg-git@gmane.org; Tue, 28 Nov
 2006 20:58:12 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S936076AbWK1T6I (ORCPT <rfc822;gcvg-git@m.gmane.org>); Tue, 28 Nov 2006
 14:58:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S936077AbWK1T6I
 (ORCPT <rfc822;git-outgoing>); Tue, 28 Nov 2006 14:58:08 -0500
Received: from main.gmane.org ([80.91.229.2]:43679 "EHLO ciao.gmane.org") by
 vger.kernel.org with ESMTP id S936076AbWK1T6F (ORCPT
 <rfc822;git@vger.kernel.org>); Tue, 28 Nov 2006 14:58:05 -0500
Received: from list by ciao.gmane.org with local (Exim 4.43) id
 1Gp95N-0005Y2-1e for git@vger.kernel.org; Tue, 28 Nov 2006 20:57:45 +0100
Received: from host-81-190-24-209.torun.mm.pl ([81.190.24.209]) by
 main.gmane.org with esmtp (Gmexim 0.1 (Debian)) id 1AlnuQ-0007hv-00 for
 <git@vger.kernel.org>; Tue, 28 Nov 2006 20:57:45 +0100
Received: from jnareb by host-81-190-24-209.torun.mm.pl with local (Gmexim
 0.1 (Debian)) id 1AlnuQ-0007hv-00 for <git@vger.kernel.org>; Tue, 28 Nov 2006
 20:57:45 +0100
To: git@vger.kernel.org
Sender: git-owner@vger.kernel.org

Andy Parkins wrote:

> On Tuesday 2006, November 28 19:11, Nicholas Allen wrote:
> 
>> This can't be fail safe though. I would prefer to also have the option
>> to be able to *explicitly* tell the RCS that a file was renamed and not
>> have it try to detect from the content  which is bound to have corner
>> cases that fail. When I know I renamed a file why can't I explicitly
> 
> You want to tell git about a rename that will never fail to be detected?  No 
> problem.
> 
> $ git mv oldname newname
> $ git commit
> 
> The corner cases you speak about are when you rename and edit.
> 
> For me, I prefer that to be detected as at least the detection algorithm can 
> be tuned - there is no fixing it if the VCS was forced to consider it a 
> rename.
> 
> When I started using git I was worried about the lack of a rename, but now I 
> realise that it's not needed - it's pointless.  The VCS is snapshotting 
> moments in time, that's it.  Then by making cleverer and cleverer 
> interpreters of those snapshots you have the potential to do stuff that is 
> far more useful than "just" rename recording.

Well, there are two cases where this might be not enough.

On is following file renames for history tracking. git-blame does that,
but git-log and friends does not; the <path> is just revision limiter.
There is an idea of --follow option to git-log (and friends), to be
implemented.

Second is rename detection for 3way merges: only ancestor and final
states are considered, so the above would not help. And rename detection
might fail if ancestor is not similar enough to end states; well, the
merge has low chance of being without conflict then.

-- 
Jakub Narebski
Warsaw, Poland
ShadeHawk on #git

