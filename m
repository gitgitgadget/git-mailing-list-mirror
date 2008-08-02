From: Pascal Obry <pascal@obry.net>
Subject: Re: git svn and the post-receive hook
Date: Sat, 02 Aug 2008 21:20:39 +0200
Organization: Home - http://www.obry.net
Message-ID: <4894B387.4040004@obry.net>
References: <489485BC.1020607@obry.net> <7vwsizl0l9.fsf@gitster.siamese.dyndns.org>
Reply-To: pascal@obry.net
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git list <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Aug 02 21:22:01 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KPMfp-0001NT-13
	for gcvg-git-2@gmane.org; Sat, 02 Aug 2008 21:21:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753698AbYHBTUw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 2 Aug 2008 15:20:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753778AbYHBTUw
	(ORCPT <rfc822;git-outgoing>); Sat, 2 Aug 2008 15:20:52 -0400
Received: from fk-out-0910.google.com ([209.85.128.184]:21821 "EHLO
	fk-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753626AbYHBTUv (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 2 Aug 2008 15:20:51 -0400
Received: by fk-out-0910.google.com with SMTP id 18so1292415fkq.5
        for <git@vger.kernel.org>; Sat, 02 Aug 2008 12:20:49 -0700 (PDT)
Received: by 10.180.252.8 with SMTP id z8mr4515901bkh.82.1217704849291;
        Sat, 02 Aug 2008 12:20:49 -0700 (PDT)
Received: from ?192.168.0.100? ( [82.124.74.244])
        by mx.google.com with ESMTPS id 13sm2653000fks.6.2008.08.02.12.20.47
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sat, 02 Aug 2008 12:20:48 -0700 (PDT)
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; fr-FR; rv:1.8.1.16) Gecko/20080708 Thunderbird/2.0.0.16 Mnenhy/0.7.5.0
In-Reply-To: <7vwsizl0l9.fsf@gitster.siamese.dyndns.org>
X-Enigmail-Version: 0.95.6
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/91170>


Junio,

> Are you saying that there may be breakages that is made at the Subversion
> side, and you would want to catch it?

Exactly.

> What would you do _after_ finding out that somebody screwed up and you
> have a borked history on the Subversion side already?

Notify the developer(s) about the problem(s).

> I do not think this belongs to "git svn rebase" (let alone "git rebase",
> no way --- you won't rewrite nor reject the upstream even if you find
> problems with it).
> 
> I understand that you would at least want to notice the damange to the
> history that happened at the remote end, and I agree it would make sense
> to do something like:
> 
> 	$ git command-that-updates-the-remote-tracking-branch git-svn
>         $ check-history git-svn@{1}..git-svn
> 
> The "command-that-updates" could be "svn fetch" or just a simple "fetch".
> 
> But the "check-history" script will be very specific to your project, and
> I do not think it makes sense to make it a hook to the "command-that-updates".

Hum... Any hook is very specific to a project. That's why it is a hook 
and not a built-in command.

BTW, I do not see why this would be a problem with git-svn whereas the 
post-receive hook is fine for Git. In many projects rewriting history is 
not permitted but post-receive is quite handy to do some checks.

post-received receive 3 parameters:

   - sha before
   - sha after
   - refname

It is perfectly usable after a git-svn rebase.

Pascal.

-- 

--|------------------------------------------------------
--| Pascal Obry                           Team-Ada Member
--| 45, rue Gabriel Peri - 78114 Magny Les Hameaux FRANCE
--|------------------------------------------------------
--|              http://www.obry.net
--| "The best way to travel is by means of imagination"
--|
--| gpg --keyserver wwwkeys.pgp.net --recv-key C1082595
