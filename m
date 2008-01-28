From: Asheesh Laroia <asheesh@asheesh.org>
Subject: Re: [RFC] Secure central repositories by UNIX socket
 authentication
Date: Mon, 28 Jan 2008 09:23:51 -0500 (EST)
Message-ID: <alpine.DEB.1.00.0801280922160.3774@alchemy.localdomain>
References: <20080127103934.GA2735@spearce.org> <7vsl0ix4gh.fsf@gitster.siamese.dyndns.org> <20080128004722.GZ24004@spearce.org> <7vabmqwgvt.fsf@gitster.siamese.dyndns.org> <20080128075125.GC24004@spearce.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Mon Jan 28 15:55:00 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JJVNk-0000jv-2H
	for gcvg-git-2@gmane.org; Mon, 28 Jan 2008 15:54:44 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752831AbYA1OyF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 28 Jan 2008 09:54:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753193AbYA1OyE
	(ORCPT <rfc822;git-outgoing>); Mon, 28 Jan 2008 09:54:04 -0500
Received: from wide-rose.makesad.us ([203.178.130.147]:37888 "EHLO
	rose.makesad.us" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751730AbYA1OyB (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 28 Jan 2008 09:54:01 -0500
X-Greylist: delayed 1803 seconds by postgrey-1.27 at vger.kernel.org; Mon, 28 Jan 2008 09:54:01 EST
Received: from alchemy (localhost [127.0.0.1])
	(using TLSv1 with cipher ADH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by rose.makesad.us (Postfix) with ESMTP id 2E25B34D062;
	Mon, 28 Jan 2008 09:23:56 -0500 (EST)
Received: from localhost (localhost [127.0.0.1])
	by alchemy (Postfix) with ESMTP id E5A396EACF;
	Mon, 28 Jan 2008 09:23:51 -0500 (EST)
X-X-Sender: paulproteus@alchemy.localdomain
In-Reply-To: <20080128075125.GC24004@spearce.org>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/71891>

On Mon, 28 Jan 2008, Shawn O. Pearce wrote:

> Junio C Hamano <gitster@pobox.com> wrote:
>> "Shawn O. Pearce" <spearce@spearce.org> writes:
>>
>>> Hmm.  core.sharedrepository is sometimes a bad solution.
>>>
>>> core.sharedrepository means I need to give write access to both the 
>>> refs database and the object database to all members of the project. 
>>> Some of whom may not be able to be trusted with tools like "rm", but 
>>> who need real shell access to that system anyway.  And sometimes 
>>> management won't allow users to have two accounts on the same system 
>>> (one that is fixed to git-shell, and one that has a real shell) 
>>> because the world would implode if a user was given two different 
>>> accounts for two different access purposes.
>>
>> Ok, that was the motiviation I did not get from your original message. 
>> It begins to make sense somewhat.
>>
>> Another approach to do the same I can think of, without having to add 
>> 50 new accounts for 50 users, would be to collect a ssh key from each 
>> of these 50 users, and have 1 line per user in the authorized_keys file 
>> of gitadmin.gitadmin user (who owns the repository with the paranoia 
>> hook that decides the authorization aspect of the repository).  The 
>> authentication would come from the environment="Name=value" option in 
>> the authorized_keys file. Each of your aunt tillies can push or fetch 
>> over ssh using the key she has in the gitadmin.gitadmin's 
>> authorized_keys file.
>
> Yea.  The downside to this is we have to maintain that authorized_keys 
> file.  Today each user can generate their own SSH key and upload to 
> their own authorized_keys file.
>
> I've had enough cases of users losing their SSH key and needing to 
> recreate it that I'd rather not have to manage a 50 user long 
> authorized_keys file.

For what it's worth, if you haven't seen gitosis yet, you might want to 
take a look - at least it makes managing the keys easy. 
http://scie.nti.st/2007/11/14/hosting-git-repositories-the-easy-and-secure-way 
has a nice tutorial.

-- Asheesh.

-- 
He who despairs over an event is a coward, but he who holds hopes for
the human condition is a fool.
 		-- Albert Camus
