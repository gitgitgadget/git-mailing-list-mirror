X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	DKIM_ADSP_CUSTOM_MED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: Re: Moving a directory into another fails
Date: Mon, 04 Dec 2006 20:37:12 +0100
Organization: At home
Message-ID: <el1t9a$lmo$1@sea.gmane.org>
References: <9e4733910607260800v618edf0em7b0f5c3332bf8fc5@mail.gmail.com> <20060726223459.GA30601@vsectoor.geht-ab-wie-schnitzel.de> <9e4733910607261603m6772602cr333d8c58f555edaa@mail.gmail.com> <20060728014350.GI13776@pasky.or.cz> <f3d7535d0612041019q4bda01a1k9938b056d51f8a78@mail.gmail.com> <el1qtr$bca$1@sea.gmane.org> <Pine.LNX.4.63.0612042001320.28348@wbgn013.biozentrum.uni-wuerzburg.de> <el1rmm$bca$2@sea.gmane.org> <Pine.LNX.4.63.0612042009590.28348@wbgn013.biozentrum.uni-wuerzburg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7Bit
NNTP-Posting-Date: Mon, 4 Dec 2006 19:35:40 +0000 (UTC)
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
X-Injected-Via-Gmane: http://gmane.org/
Original-Lines: 37
Original-X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: host-81-190-24-209.torun.mm.pl
Mail-Copies-To: jnareb@gmail.com
User-Agent: KNode/0.10.2
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/33225>
Received: from vger.kernel.org ([209.132.176.167]) by dough.gmane.org with
 esmtp (Exim 4.50) id 1GrJb8-0007xq-Sn for gcvg-git@gmane.org; Mon, 04 Dec
 2006 20:35:31 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S937204AbWLDTf2 (ORCPT <rfc822;gcvg-git@m.gmane.org>); Mon, 4 Dec 2006
 14:35:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1759360AbWLDTf2
 (ORCPT <rfc822;git-outgoing>); Mon, 4 Dec 2006 14:35:28 -0500
Received: from main.gmane.org ([80.91.229.2]:37661 "EHLO ciao.gmane.org"
 rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP id S1759442AbWLDTf1
 (ORCPT <rfc822;git@vger.kernel.org>); Mon, 4 Dec 2006 14:35:27 -0500
Received: from list by ciao.gmane.org with local (Exim 4.43) id
 1GrJb2-0006ay-4M for git@vger.kernel.org; Mon, 04 Dec 2006 20:35:24 +0100
Received: from host-81-190-24-209.torun.mm.pl ([81.190.24.209]) by
 main.gmane.org with esmtp (Gmexim 0.1 (Debian)) id 1AlnuQ-0007hv-00 for
 <git@vger.kernel.org>; Mon, 04 Dec 2006 20:35:24 +0100
Received: from jnareb by host-81-190-24-209.torun.mm.pl with local (Gmexim
 0.1 (Debian)) id 1AlnuQ-0007hv-00 for <git@vger.kernel.org>; Mon, 04 Dec 2006
 20:35:24 +0100
To: git@vger.kernel.org
Sender: git-owner@vger.kernel.org

Johannes Schindelin wrote:

> On Mon, 4 Dec 2006, Jakub Narebski wrote:
> 
>> Johannes Schindelin wrote:
>> 
>>> On Mon, 4 Dec 2006, Jakub Narebski wrote:
>>> 
>>>> [...] git should acquire core.filesystemEncoding configuration variable 
>>>> which would encode from filesystem encoding used in working directory 
>>>> and perhaps index to UTF-8 encoding used in repository (in tree objects) 
>>>> and perhaps index.
>>> 
>>> So, you want to pull in all thinkable encodings? Of course, you could rely 
>>> on libiconv, adding yet another dependency to git. (Yes, I know, mailinfo 
>>> uses it already. But I never use mailinfo, so I do not need libiconv.)
>> 
>> A conditional dependency. If you don't have libiconv, this feature wouldn't
>> be available.
> 
> You are speaking as somebody compiling git from source. We are a minority.

Usually iconv is in libc.

# Define NEEDS_LIBICONV if linking with libc is not enough (Darwin).

Hmm... perhaps not that usually. The uname based configuration in Makefile
(not the test based configuration provided by autoconf generated
./configure script) sets NEEDS_LIBICONV for: Darwin, SunOS 5.8, Cygwin,
FreeBSD and OpenBSD, some versions of NetBSD, AIX.

And HFS+ is on MacOS X / Darwin, without iconv in libc...
-- 
Jakub Narebski
Warsaw, Poland
ShadeHawk on #git

