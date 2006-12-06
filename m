X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	DKIM_ADSP_CUSTOM_MED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [PATCH 2/3] git-fetch: do not use "*" for fetching multiple refs
Date: Wed, 06 Dec 2006 17:58:27 +0100
Organization: At home
Message-ID: <el6sni$re3$1@sea.gmane.org>
References: <1165261102.20055.9.camel@ibook.zvpunry.de> <el1tud$n07$2@sea.gmane.org> <1165422865.29714.13.camel@ibook.zvpunry.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7Bit
NNTP-Posting-Date: Wed, 6 Dec 2006 16:57:13 +0000 (UTC)
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
X-Injected-Via-Gmane: http://gmane.org/
Original-Lines: 34
Original-X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: host-81-190-24-209.torun.mm.pl
Mail-Copies-To: jnareb@gmail.com
User-Agent: KNode/0.10.2
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/33491>
Received: from vger.kernel.org ([209.132.176.167]) by dough.gmane.org with
 esmtp (Exim 4.50) id 1Gs04v-00019x-0A for gcvg-git@gmane.org; Wed, 06 Dec
 2006 17:57:05 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S936458AbWLFQ4n (ORCPT <rfc822;gcvg-git@m.gmane.org>); Wed, 6 Dec 2006
 11:56:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S936498AbWLFQ4n
 (ORCPT <rfc822;git-outgoing>); Wed, 6 Dec 2006 11:56:43 -0500
Received: from main.gmane.org ([80.91.229.2]:33639 "EHLO ciao.gmane.org"
 rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP id S936458AbWLFQ4m
 (ORCPT <rfc822;git@vger.kernel.org>); Wed, 6 Dec 2006 11:56:42 -0500
Received: from list by ciao.gmane.org with local (Exim 4.43) id
 1Gs04Q-0003vh-T0 for git@vger.kernel.org; Wed, 06 Dec 2006 17:56:34 +0100
Received: from host-81-190-24-209.torun.mm.pl ([81.190.24.209]) by
 main.gmane.org with esmtp (Gmexim 0.1 (Debian)) id 1AlnuQ-0007hv-00 for
 <git@vger.kernel.org>; Wed, 06 Dec 2006 17:56:34 +0100
Received: from jnareb by host-81-190-24-209.torun.mm.pl with local (Gmexim
 0.1 (Debian)) id 1AlnuQ-0007hv-00 for <git@vger.kernel.org>; Wed, 06 Dec 2006
 17:56:34 +0100
To: git@vger.kernel.org
Sender: git-owner@vger.kernel.org

Michael Loeffler wrote:

> Am Montag, den 04.12.2006, 20:48 +0100 schrieb Jakub Narebski:
> ...
>> I'm not sure if regexp support is truly better than the usual path globbing,
>> as in fnmatch / glob.
>
> The current code does not do a real glob, this was the reason for me to
> think about regex support, I thought it is easy to use sed for this. Now
> I know it better.

We could use perl for that, but embedded perl is a bit horrible.

> I want it a bit portable, but sed on other systems (like macos or
> solaris) does not support extended REs, and the basic REs do not support
> the | operator (but this works on systems with glibc with \|).
> 
> Maybe we should support something like this:
> Pull: refs/heads/v*:refs/remotes/origin/
> 
> I still don't like the * on the destination ref, it looks a bit strange
> (like cp Downloads/*.mp3 Music/*).

'*' in destination part would mean $n / \n (n-th match for *).
And you need some way to mark if it is prefix match, or whole path match.
Ending prefix match with '/' is one way of doing this... Unless it would
be prefix match always, but I think this leads way to confusion.

Just a thought.
-- 
Jakub Narebski
Warsaw, Poland
ShadeHawk on #git

