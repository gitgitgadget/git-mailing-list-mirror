X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	DKIM_ADSP_CUSTOM_MED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [PATCH] remove "[PATCH]" prefix from shortlog output
Date: Mon, 11 Dec 2006 00:10:02 +0100
Organization: At home
Message-ID: <eli3vr$j6v$1@sea.gmane.org>
References: <Pine.LNX.4.64.0612091954010.2630@xanadu.home> <Pine.LNX.4.63.0612102337090.28348@wbgn013.biozentrum.uni-wuerzburg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7Bit
NNTP-Posting-Date: Sun, 10 Dec 2006 23:15:31 +0000 (UTC)
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
X-Injected-Via-Gmane: http://gmane.org/
Original-Lines: 33
Original-X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: host-81-190-25-107.torun.mm.pl
Mail-Copies-To: jnareb@gmail.com
User-Agent: KNode/0.10.2
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/33956>
Received: from vger.kernel.org ([209.132.176.167]) by dough.gmane.org with
 esmtp (Exim 4.50) id 1GtXtJ-0006rO-Qy for gcvg-git@gmane.org; Mon, 11 Dec
 2006 00:15:30 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1759854AbWLJXP0 (ORCPT <rfc822;gcvg-git@m.gmane.org>); Sun, 10 Dec 2006
 18:15:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1760836AbWLJXP0
 (ORCPT <rfc822;git-outgoing>); Sun, 10 Dec 2006 18:15:26 -0500
Received: from main.gmane.org ([80.91.229.2]:60508 "EHLO ciao.gmane.org"
 rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP id S1760247AbWLJXPZ
 (ORCPT <rfc822;git@vger.kernel.org>); Sun, 10 Dec 2006 18:15:25 -0500
Received: from list by ciao.gmane.org with local (Exim 4.43) id
 1GtXrA-0005hp-8F for git@vger.kernel.org; Mon, 11 Dec 2006 00:13:16 +0100
Received: from host-81-190-25-107.torun.mm.pl ([81.190.25.107]) by
 main.gmane.org with esmtp (Gmexim 0.1 (Debian)) id 1AlnuQ-0007hv-00 for
 <git@vger.kernel.org>; Mon, 11 Dec 2006 00:13:16 +0100
Received: from jnareb by host-81-190-25-107.torun.mm.pl with local (Gmexim
 0.1 (Debian)) id 1AlnuQ-0007hv-00 for <git@vger.kernel.org>; Mon, 11 Dec 2006
 00:13:16 +0100
To: git@vger.kernel.org
Sender: git-owner@vger.kernel.org

Johannes Schindelin wrote:

> On Sat, 9 Dec 2006, Nicolas Pitre wrote:
> 
>> This doesn't convey much information in the shortlog context.
>> And the perl version did strip it as well.
> 
> From the current builtin-shortlog.c:128ff:
> 
>         if (!strncmp(oneline, "[PATCH", 6)) {
>                 char *eob = strchr(oneline, ']');
> 
>                 if (eob) {
>                         while (isspace(eob[1]) && eob[1] != '\n')
>                                 eob++;
>                         if (eob - oneline < onelinelen) {
>                                 onelinelen -= eob - oneline;
>                                 oneline = eob;
>                         }
>                 }
>         }
> 
> It tries not only to strip "[PATCH]", but also "[PATCH 0/n]" and basically 
> every prefix beginning with "[PATCH" and ending in "]". I do not remember 
> if I really tested that code, but it should work.

What happens if you have "[PATCH" without closing "]"? Does it work (and
doesn't crash)? Does it strip anything?
-- 
Jakub Narebski
Warsaw, Poland
ShadeHawk on #git

