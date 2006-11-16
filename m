X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Han-Wen Nienhuys <hanwen@xs4all.nl>
Subject: Re: multi-project repos (was Re: Cleaning up git user-interface 
  warts)
Date: Fri, 17 Nov 2006 00:32:39 +0100
Message-ID: <455CF517.9000101@xs4all.nl>
References: <87k61yt1x2.wl%cworth@cworth.org> <455A1137.8030301@shadowen.org> <87hcx1u934.wl%cworth@cworth.org> <Pine.LNX.4.64.0611141518590.2591@xanadu.home> <87bqn9u43s.wl%cworth@cworth.org> <ejdcg5$4fl$1@sea.gmane.org> <Pine.LNX.4.64.0611141633430.2591@xanadu.home> <7vbqn9y6w6.fsf@assigned-by-dhcp.cox.net> <Pine.LNX.4.64.0611142007010.2591@xanadu.home> <7v3b8ltq7r.fsf@assigned-by-dhcp.cox.net> <Pine.LNX.4.64.0611142306090.2591@xanadu.home> <Pine.LNX.4.64.0611150950170.3349@woody.osdl.org> <455BBCE9.4050503@xs4all.nl> <Pine.LNX.4.64.0611151908130.3349@woody.osdl.org> <455C412D.1030408@xs4all.nl> <Pine.LNX.4.64.0611160814560.3349@woody.osdl.org> <455C94FA.3050903@xs4all.nl> <Pine.LNX.4.64.0611160904010.3349@woody.osdl.org> <455CA2A8.5010700@xs4all.nl> <Pine.LNX.4.64.0611160958170.3349@woody.osdl.org>
Reply-To: hanwen@xs4all.nl
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
NNTP-Posting-Date: Thu, 16 Nov 2006 23:33:05 +0000 (UTC)
Cc: Junio C Hamano <junkio@cox.net>, git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
User-Agent: Thunderbird 1.5.0.8 (X11/20061107)
Original-Newsgroups: gmane.comp.version-control.git
In-Reply-To: <Pine.LNX.4.64.0611160958170.3349@woody.osdl.org>
X-Virus-Scanned: by XS4ALL Virus Scanner
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/31636>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1Gkqiv-0000bz-Gd for gcvg-git@gmane.org; Fri, 17 Nov
 2006 00:32:50 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1424571AbWKPXcq (ORCPT <rfc822;gcvg-git@m.gmane.org>); Thu, 16 Nov 2006
 18:32:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1424568AbWKPXcq
 (ORCPT <rfc822;git-outgoing>); Thu, 16 Nov 2006 18:32:46 -0500
Received: from smtp-vbr3.xs4all.nl ([194.109.24.23]:27664 "EHLO
 smtp-vbr3.xs4all.nl") by vger.kernel.org with ESMTP id S1424578AbWKPXcp
 (ORCPT <rfc822;git@vger.kernel.org>); Thu, 16 Nov 2006 18:32:45 -0500
Received: from [192.168.123.187] (muurbloem.xs4all.nl [213.84.26.127])
 (authenticated bits=0) by smtp-vbr3.xs4all.nl (8.13.8/8.13.8) with ESMTP id
 kAGNWad7062492; Fri, 17 Nov 2006 00:32:37 +0100 (CET) (envelope-from
 hanwen@xs4all.nl)
To: Linus Torvalds <torvalds@osdl.org>
Sender: git-owner@vger.kernel.org


Linus Torvalds escreveu:
>> You're misunderstanding me: the multi-repo is at git.sv.gnu.org is the
>> remote one. The example I gave was about locally creating a single
>> project repo from a remote multiproject repo. 
> 
> Ahh.
> 
> Ok, try the patch I just sent out, and see if it works for you. It 
> _should_ allow you to do exactly that

I'm leaving for a short holiday tomorrow, but will do when I come back.

>> From UI perspective it would be nice if this could also be done with clone,
>>
>>   git clone . ssh+git://....
> 
> The creation of a new archive tends to need special rights (with _real_ 
> ssh access and a shell you could do it, but "ssh+git" really means "git 
> protocol over a connection that was opened with ssh, but doesn't 
> necessarily have a real shell at the other end").

What happens on savannah is that the sysadmins set up an empty GIT
repo with access, and leave it to you to push the stuff.  Of course,
if the initial import gets packed automatically, that's also ok.

> So I think the above syntax is actually not a good one, because it cannot 
> work in the general case. It's much better to get used to setting up a 
> repo first, and then pushing into it, and just accepting that it's a 
> two-phase thing.

Perhaps ; from a UI viewpoint, it would be nice though, even if it
were aliased to a simple push. (Darcs has a get command analogous to
git-clone, but also a put command to which git lacks the equivalent).

>> * why are objects downloaded twice?  If I do
>>
>>   git --bare fetch git://git.sv.gnu.org/lilypond.git web/master
>>
>> it downloads stuff, but I don't get a branch.
> [..] 
>> If I then do 
>>
>>   git --bare fetch git://git.sv.gnu.org/lilypond.git web/master:master
>>
>> it downloads the same stuff again. 
> 
> Right. So you can either
> [..]
> See?

No, I don't understand. In the fetch all the objects with their SHA1s
were already downloaded. I'd expect that the fetch with a refspec
would simply write a HEAD and a refs/heads/master, and notice that all
the actual data was already downloaded, and doesn't download it again. 


-- 
