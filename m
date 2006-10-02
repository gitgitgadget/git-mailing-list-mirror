From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: gitweb: using quotemeta
Date: Mon, 02 Oct 2006 02:28:14 +0200
Organization: At home
Message-ID: <efpme9$o13$1@sea.gmane.org>
References: <7vodszshq3.fsf@assigned-by-dhcp.cox.net> <20060928232752.99373.qmail@web31804.mail.mud.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7Bit
X-From: git-owner@vger.kernel.org Mon Oct 02 02:28:30 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GUBfS-0000Zi-5E
	for gcvg-git@gmane.org; Mon, 02 Oct 2006 02:28:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932528AbWJBA2R (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 1 Oct 2006 20:28:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932529AbWJBA2R
	(ORCPT <rfc822;git-outgoing>); Sun, 1 Oct 2006 20:28:17 -0400
Received: from main.gmane.org ([80.91.229.2]:22696 "EHLO ciao.gmane.org")
	by vger.kernel.org with ESMTP id S932528AbWJBA2Q (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 1 Oct 2006 20:28:16 -0400
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1GUBfC-0000Xk-7c
	for git@vger.kernel.org; Mon, 02 Oct 2006 02:28:06 +0200
Received: from host-81-190-17-45.torun.mm.pl ([81.190.17.45])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Mon, 02 Oct 2006 02:28:06 +0200
Received: from jnareb by host-81-190-17-45.torun.mm.pl with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Mon, 02 Oct 2006 02:28:06 +0200
X-Injected-Via-Gmane: http://gmane.org/
To: git@vger.kernel.org
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: host-81-190-17-45.torun.mm.pl
Mail-Copies-To: jnareb@gmail.com
User-Agent: KNode/0.10.2
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/28209>

Luben Tuikov wrote:

> --- Junio C Hamano <junkio@cox.net> wrote:
>> 
>> Ouch, that was a sloppy planning and coding, and sloppier
>> reviewing.  Sorry.
>> 
>> What is the right quoting there?  Just quoting double-quotes?
> 
> I'm not sure.  What undesired character could we have in $filename
> of a snapshot?  The commit ab41dfbfd4f message gives this
> justification: "Just in case filename contains end of line character."
> 
> It looks like $filename is constructed by well defined strings:
> basename($project), $hash and $suffix all of which should be ok.
> 
> I'd say we don't need quotemeta for $filename of snapshot.

But we do need quoting for blob_plain and perhaps blobdiff_plain
views, although not quotemeta, but perhaps the reverse of unescape,
i.e. quote '"', EOLN (end of line) and perhaps also TAB.

-- 
Jakub Narebski
Warsaw, Poland
ShadeHawk on #git
