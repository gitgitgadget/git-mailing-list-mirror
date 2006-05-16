From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [PATCH] CMIT_FMT_EMAIL: Q-encode Subject: and display-name part of From: fields.
Date: Tue, 16 May 2006 12:38:37 +0200
Organization: At home
Message-ID: <e4ca2p$ud5$1@sea.gmane.org>
References: <7vmzdi9ssv.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7Bit
X-From: git-owner@vger.kernel.org Tue May 16 12:38:41 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Ffwwk-0001cC-RD
	for gcvg-git@gmane.org; Tue, 16 May 2006 12:38:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751761AbWEPKic (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 16 May 2006 06:38:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751764AbWEPKic
	(ORCPT <rfc822;git-outgoing>); Tue, 16 May 2006 06:38:32 -0400
Received: from main.gmane.org ([80.91.229.2]:43923 "EHLO ciao.gmane.org")
	by vger.kernel.org with ESMTP id S1751761AbWEPKib (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 16 May 2006 06:38:31 -0400
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1Ffwwf-0001aw-Lh
	for git@vger.kernel.org; Tue, 16 May 2006 12:38:29 +0200
Received: from 193.0.122.19 ([193.0.122.19])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Tue, 16 May 2006 12:38:29 +0200
Received: from jnareb by 193.0.122.19 with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Tue, 16 May 2006 12:38:29 +0200
X-Injected-Via-Gmane: http://gmane.org/
To: git@vger.kernel.org
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: 193.0.122.19
User-Agent: KNode/0.7.7
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/20114>

Junio C Hamano wrote:

> By convention, the commit message and the author/committer names
> in the commit objects are UTF-8 encoded.  When formatting for
> e-mails, Q-encode them according to RFC 2047.
> 
> While we are at it, generate the content-type and
> content-transfer-encoding headers as well.
> 
> Signed-off-by: Junio C Hamano <junkio@cox.net>
> 
> ---
> 
>  With this patch, the output formatted with
> 
> git show --pretty=email --patch-with-stat 9d7f73d4
> 
>  would start like this:
> 
>    From 9d7f73d43fa49d0d2f5a8cfcce9d659e8ad2d265  Thu Apr 7 15:13:13 2005
>    From: =?utf-8?q?Lukas_Sandstr=C3=B6m?= <lukass@etek.chalmers.se>
>    Date: Sat, 25 Feb 2006 12:20:13 +0100
>    Subject: [PATCH] git-fetch: print the new and old ref when fast-forwarding 
>    Content-Type: text/plain; charset=UTF-8 
>    Content-Transfer-Encoding: 8bit

I guess that we also need
     
     MIME-Version: 1.0

(from what I remember of troubles with Eoutlook Express not sending all 
the required headers, and tin not working properly).

If I remember correctly encoding headers using quoted-printable is needed
only because headers are before charset is set. IIRC there was proposal
to use UTF-8 for headers regardless of the charset used for body of message.

P.S. Should we set User-Agent header as well?
-- 
Jakub Narebski
Warsaw, Poland
