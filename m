X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Jeff Garzik <jeff@garzik.org>
Subject: Re: Using GIT to store /etc (Or: How to make GIT store all file permission
 bits)
Date: Sun, 10 Dec 2006 09:49:50 -0500
Message-ID: <457C1E8E.4080407@garzik.org>
References: <787BE48C-1808-4A33-A368-5E8A3F00C787@mac.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
NNTP-Posting-Date: Sun, 10 Dec 2006 14:50:02 +0000 (UTC)
Cc: git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
User-Agent: Thunderbird 1.5.0.8 (X11/20061107)
In-Reply-To: <787BE48C-1808-4A33-A368-5E8A3F00C787@mac.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/33892>
Received: from vger.kernel.org ([209.132.176.167]) by dough.gmane.org with
 esmtp (Exim 4.50) id 1GtQ07-0006ad-47 for gcvg-git@gmane.org; Sun, 10 Dec
 2006 15:49:59 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1760814AbWLJOty (ORCPT <rfc822;gcvg-git@m.gmane.org>); Sun, 10 Dec 2006
 09:49:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1760812AbWLJOty
 (ORCPT <rfc822;git-outgoing>); Sun, 10 Dec 2006 09:49:54 -0500
Received: from srv5.dvmed.net ([207.36.208.214]:38305 "EHLO mail.dvmed.net"
 rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP id S1760814AbWLJOtx
 (ORCPT <rfc822;git@vger.kernel.org>); Sun, 10 Dec 2006 09:49:53 -0500
Received: from cpe-065-190-194-075.nc.res.rr.com ([65.190.194.75]
 helo=[10.10.10.10]) by mail.dvmed.net with esmtpsa (Exim 4.63 #1 (Red Hat
 Linux)) id 1GtPzz-0000br-Lv; Sun, 10 Dec 2006 14:49:52 +0000
To: Kyle Moffett <mrmacman_g4@mac.com>
Sender: git-owner@vger.kernel.org

Kyle Moffett wrote:
> I've recently become somewhat interested in the idea of using GIT to 
> store the contents of various folders in /etc.  However after a bit of 
> playing with this, I discovered that GIT doesn't actually preserve all 
> permission bits since that would cause problems with the more 
> traditional software development model.  I'm curious if anyone has done 
> this before; and if so, how they went about handling the permissions and 
> ownership issues.
> 
> I spent a little time looking over how GIT stores and compares 
> permission bits; trying to figure out if it's possible to patch in a new 
> configuration variable or two; say "preserve_all_perms" and 
> "preserve_owner", or maybe even "save_acls".  It looks like standard 
> permission preservation is fairly basic; you would just need to patch a 
> few routines which alter the permissions read in from disk or compare 
> them with ones from the database.  On the other hand, it would appear 
> that preserving ownership or full POSIX ACLs might be a bit of a challenge.

It's a great idea, something I would like to do, and something I've 
suggested before.  You could dig through the mailing list archives, if 
you're motivated.

I actively use git to version, store and distribute an exim mail 
configuration across six servers.  So far my solution has been a 'fix 
perms' script, or using the file perm checking capabilities of cfengine.

But it would be a lot better if git natively cared about ownership and 
permissions (presumably via an option).

	Jeff


