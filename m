X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	DKIM_ADSP_CUSTOM_MED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: Rename detection at git log
Date: Mon, 20 Nov 2006 11:11:17 +0100
Organization: At home
Message-ID: <ejrutd$j98$1@sea.gmane.org>
References: <200611201157.23680.litvinov2004@gmail.com> <200611200951.05529.andyparkins@gmail.com> <7vejry5t4g.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7Bit
NNTP-Posting-Date: Mon, 20 Nov 2006 10:10:09 +0000 (UTC)
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
X-Injected-Via-Gmane: http://gmane.org/
Original-Lines: 36
Original-X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: host-81-190-24-209.torun.mm.pl
Mail-Copies-To: jnareb@gmail.com
User-Agent: KNode/0.10.2
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/31894>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1Gm66F-0004uV-Lk for gcvg-git@gmane.org; Mon, 20 Nov
 2006 11:10:04 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S965599AbWKTKJ7 (ORCPT <rfc822;gcvg-git@m.gmane.org>); Mon, 20 Nov 2006
 05:09:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965613AbWKTKJ7
 (ORCPT <rfc822;git-outgoing>); Mon, 20 Nov 2006 05:09:59 -0500
Received: from main.gmane.org ([80.91.229.2]:52427 "EHLO ciao.gmane.org") by
 vger.kernel.org with ESMTP id S965599AbWKTKJ6 (ORCPT
 <rfc822;git@vger.kernel.org>); Mon, 20 Nov 2006 05:09:58 -0500
Received: from list by ciao.gmane.org with local (Exim 4.43) id
 1Gm669-0004ts-Je for git@vger.kernel.org; Mon, 20 Nov 2006 11:09:57 +0100
Received: from host-81-190-24-209.torun.mm.pl ([81.190.24.209]) by
 main.gmane.org with esmtp (Gmexim 0.1 (Debian)) id 1AlnuQ-0007hv-00 for
 <git@vger.kernel.org>; Mon, 20 Nov 2006 11:09:57 +0100
Received: from jnareb by host-81-190-24-209.torun.mm.pl with local (Gmexim
 0.1 (Debian)) id 1AlnuQ-0007hv-00 for <git@vger.kernel.org>; Mon, 20 Nov 2006
 11:09:57 +0100
To: git@vger.kernel.org
Sender: git-owner@vger.kernel.org

Junio C Hamano wrote:

> Andy Parkins <andyparkins@gmail.com> writes:
> 
>> On Monday 2006 November 20 05:57, Alexander Litvinov wrote:
>>
>>> > PAGER=cat git log -M -C --pretty=oneline b/a
>>
>> I've come across this too.  Personally I'm not sure what use "-C" is.  From 
>> the manpage, man git-diff-files (no, this isn't the place I'd look either).
> 
> The real issue here is because the b/a on the command line
> applies on the input-side, and does not act as the output
> filter.  This comes from _very_ early design decision and if you
> dig the list archive you will see Linus and I arguing about
> diffcore-pathspec (which later died off).
> 
> What it means is that "git log" will look at path that matches
> b/a (that means b/a/c and b/a/d are looked at, if b/a were a
> directory).  Since path "a" which is what the file was
> originally at is not something the pattern b/a matches, there is
> no way b/a is noticed as a rename from a.
> 
> I've been meaning to resurrect Fredrik's --single-follow=path
> patch but haven't had time to recently, with all the other
> interesting discussion happening on the list.

But for now, you can use

  PAGER= git log -M -C -- b/a a

-- 
Jakub Narebski
Warsaw, Poland
ShadeHawk on #git

