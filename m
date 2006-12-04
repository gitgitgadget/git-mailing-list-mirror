X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	DKIM_ADSP_CUSTOM_MED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: On removing files and "git-rm is pointless"
Date: Mon, 04 Dec 2006 11:48:42 +0100
Organization: At home
Message-ID: <el0uaf$n7h$1@sea.gmane.org>
References: <87odqm2ppv.wl%cworth@cworth.org> <Pine.LNX.4.64.0612020919400.3476@woody.osdl.org> <4571DB40.6020800@vilain.net> <Pine.LNX.4.64.0612022246310.2630@xanadu.home> <7vd570q888.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7Bit
NNTP-Posting-Date: Mon, 4 Dec 2006 10:46:56 +0000 (UTC)
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
X-Injected-Via-Gmane: http://gmane.org/
Original-Lines: 31
Original-X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: host-81-190-24-209.torun.mm.pl
Mail-Copies-To: jnareb@gmail.com
User-Agent: KNode/0.10.2
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/33184>
Received: from vger.kernel.org ([209.132.176.167]) by dough.gmane.org with
 esmtp (Exim 4.50) id 1GrBLZ-00015B-7S for gcvg-git@gmane.org; Mon, 04 Dec
 2006 11:46:53 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S935699AbWLDKqu (ORCPT <rfc822;gcvg-git@m.gmane.org>); Mon, 4 Dec 2006
 05:46:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S935728AbWLDKqu
 (ORCPT <rfc822;git-outgoing>); Mon, 4 Dec 2006 05:46:50 -0500
Received: from main.gmane.org ([80.91.229.2]:18884 "EHLO ciao.gmane.org") by
 vger.kernel.org with ESMTP id S935699AbWLDKqt (ORCPT
 <rfc822;git@vger.kernel.org>); Mon, 4 Dec 2006 05:46:49 -0500
Received: from list by ciao.gmane.org with local (Exim 4.43) id
 1GrBLT-0005WL-Mw for git@vger.kernel.org; Mon, 04 Dec 2006 11:46:47 +0100
Received: from host-81-190-24-209.torun.mm.pl ([81.190.24.209]) by
 main.gmane.org with esmtp (Gmexim 0.1 (Debian)) id 1AlnuQ-0007hv-00 for
 <git@vger.kernel.org>; Mon, 04 Dec 2006 11:46:47 +0100
Received: from jnareb by host-81-190-24-209.torun.mm.pl with local (Gmexim
 0.1 (Debian)) id 1AlnuQ-0007hv-00 for <git@vger.kernel.org>; Mon, 04 Dec 2006
 11:46:47 +0100
To: git@vger.kernel.org
Sender: git-owner@vger.kernel.org

Junio C Hamano wrote:

> Nicolas Pitre <nico@cam.org> writes:
> 
>> I think what Linus is proposing makes tons of sense.
>>
>> If you do git rm by mistake then you can always do git checkout on that
>> file to get it back.
>>
>> If you modified it so it doesn't match the index then git rm won't do
>> anything by default so you have a chance to think a bit more.
>>
>> If you updated the index, didn't commit anything but then do git rm then
>> you certainly wanted to really rm the file.
> 
> FWIW, I too am in favor of the proposed fix to "git rm" as Linus
> outlined.

+1. I'm also for this change. Of course if the working area version doesn't
match HEAD version git-rm should remove only index entry, and print warning
message, for example what it does now, i.e.
  rm '<filename>'
or if we want more chatty version (core.gitgor = true) it would print:
  File '<filename>' changed. Use "rm '<filename>'" to remove.
(or something like that).

-- 
Jakub Narebski
Warsaw, Poland
ShadeHawk on #git

