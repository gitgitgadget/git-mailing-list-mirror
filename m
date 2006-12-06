X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Michael Loeffler <zvpunry@zvpunry.de>
Subject: Re: [PATCH 2/3] git-fetch: do not use "*" for fetching multiple
	refs
Date: Wed, 06 Dec 2006 17:34:25 +0100
Message-ID: <1165422865.29714.13.camel@ibook.zvpunry.de>
References: <1165261102.20055.9.camel@ibook.zvpunry.de>
	 <el1tud$n07$2@sea.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
NNTP-Posting-Date: Wed, 6 Dec 2006 16:34:41 +0000 (UTC)
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
In-Reply-To: <el1tud$n07$2@sea.gmane.org>
X-Mailer: Evolution 2.6.3 
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/33486>
Received: from vger.kernel.org ([209.132.176.167]) by dough.gmane.org with
 esmtp (Exim 4.50) id 1Grzj8-0005mc-LC for gcvg-git@gmane.org; Wed, 06 Dec
 2006 17:34:35 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S936331AbWLFQeb (ORCPT <rfc822;gcvg-git@m.gmane.org>); Wed, 6 Dec 2006
 11:34:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S936399AbWLFQeb
 (ORCPT <rfc822;git-outgoing>); Wed, 6 Dec 2006 11:34:31 -0500
Received: from mx01.ap-wdsl.de ([88.198.184.82]:34500 "EHLO mx01.ap-wdsl.de"
 rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP id S936331AbWLFQeb
 (ORCPT <rfc822;git@vger.kernel.org>); Wed, 6 Dec 2006 11:34:31 -0500
To: git@vger.kernel.org
Sender: git-owner@vger.kernel.org

Am Montag, den 04.12.2006, 20:48 +0100 schrieb Jakub Narebski:
...
> I'm not sure if regexp support is truly better than the usual path globbing,
> as in fnmatch / glob.
The current code does not do a real glob, this was the reason for me to
think about regex support, I thought it is easy to use sed for this. Now
I know it better.

I want it a bit portable, but sed on other systems (like macos or
solaris) does not support extended REs, and the basic REs do not support
the | operator (but this works on systems with glibc with \|).

Maybe we should support something like this:
Pull: refs/heads/v*:refs/remotes/origin/

I still don't like the * on the destination ref, it looks a bit strange
(like cp Downloads/*.mp3 Music/*).

