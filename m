From: Eric Wong <normalperson@yhbt.net>
Subject: Re: [PATCH] git-svn: fix SVN 1.1.x compatibility
Date: Mon, 19 Jan 2009 17:23:01 -0800
Message-ID: <20090120012301.GA30236@dcvr.yhbt.net>
References: <496722CF.1060802@statsbiblioteket.dk> <20090112010354.GB23377@yp-box.dyndns.org> <496AF964.1070208@statsbiblioteket.dk> <20090117105811.GB15801@dcvr.yhbt.net> <20090119004556.GA25038@dcvr.yhbt.net> <4974450D.4090608@statsbiblioteket.dk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: "git@vger.kernel.org" <git@vger.kernel.org>
To: "Tom G. Christensen" <tgc@statsbiblioteket.dk>
X-From: git-owner@vger.kernel.org Tue Jan 20 02:25:16 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LP5Lw-0000xW-Tt
	for gcvg-git-2@gmane.org; Tue, 20 Jan 2009 02:24:29 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754919AbZATBXH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 19 Jan 2009 20:23:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754538AbZATBXF
	(ORCPT <rfc822;git-outgoing>); Mon, 19 Jan 2009 20:23:05 -0500
Received: from dcvr.yhbt.net ([64.71.152.64]:50307 "EHLO dcvr.yhbt.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752374AbZATBXE (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 19 Jan 2009 20:23:04 -0500
Received: from localhost (unknown [127.0.2.5])
	by dcvr.yhbt.net (Postfix) with ESMTP id 39D351F606;
	Tue, 20 Jan 2009 01:23:02 +0000 (UTC)
Content-Disposition: inline
In-Reply-To: <4974450D.4090608@statsbiblioteket.dk>
User-Agent: Mutt/1.5.18 (2008-05-17)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/106423>

"Tom G. Christensen" <tgc@statsbiblioteket.dk> wrote:
> Eric Wong wrote:
>> The get_log() function in the Perl SVN API introduced the limit
>> parameter in 1.2.0.  However, this got discarded in our SVN::Ra
>> compatibility layer when used with SVN 1.1.x.  We now emulate
>> the limit functionality in older SVN versions by preventing the
>> original callback from being called if the given limit has been
>> reached.  This emulation is less bandwidth efficient, but SVN
>> 1.1.x is becoming rarer now.
>>
>> Additionally, the --limit parameter in svn(1) uses the
>> aforementioned get_log() functionality change in SVN 1.2.x.
>> t9129 no longer depends on --limit to work and instead uses
>> Perl to parse out the commit message.
>>
>> Thanks to Tom G. Christensen for the bug report.
>>
>> Signed-off-by: Eric Wong <normalperson@yhbt.net>
>
> I applied this to 1.6.1 and the testsuite now passes using SVN 1.1.4 on  
> RHEL 4/i386 (t9106 still fails on RHEL 4/x86_64).

Any chance I could have access to that RHEL4/x86_64 environment?  I'll
try to work around bugs in older SVN as best I can, but can't guarantee
anything.

-- 
Eric Wong
