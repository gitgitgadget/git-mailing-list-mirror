From: Thomas Harning <harningt@gmail.com>
Subject: Re: [BUG/RFC git-gui] password for push/pull in case of git+ssh://repo
Date: Thu, 06 Dec 2007 12:11:59 -0500
Message-ID: <47582D5F.7070003@gmail.com>
References: <1196951517.3294.24.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Ivo Alxneit <ivo.alxneit@psi.ch>
X-From: git-owner@vger.kernel.org Thu Dec 06 18:13:34 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1J0KHq-0003aA-56
	for gcvg-git-2@gmane.org; Thu, 06 Dec 2007 18:13:22 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752658AbXLFRM7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 6 Dec 2007 12:12:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751815AbXLFRM7
	(ORCPT <rfc822;git-outgoing>); Thu, 6 Dec 2007 12:12:59 -0500
Received: from nz-out-0506.google.com ([64.233.162.237]:12485 "EHLO
	nz-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751359AbXLFRM6 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 6 Dec 2007 12:12:58 -0500
Received: by nz-out-0506.google.com with SMTP id s18so115368nze
        for <git@vger.kernel.org>; Thu, 06 Dec 2007 09:12:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:user-agent:mime-version:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding;
        bh=CaHYpXnbmJaP81zpcWceyuW8gFQeSNko4J06OUq10Vk=;
        b=oBLj7ikSe5SQu1hviXh648G7+0PUD4jO32hwOwiL0kiRAkMZyOE/Vop+7l46MGeDkaW5KgSQ2gjhtdRVacvQc77G0Kve6ms5YQe+3fqj4iYjYLBPcu0fmM88LTfyoXvntDIvKb2vhm4UtgGsUJuhVNg13hSmk9c1W4veUap8Q0A=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding;
        b=is+AZ29c28WBinFP2pQjKnTY4L3iJ74Aznx0gQN7yz6iVcyebGwDQNKmE153Ws/mE1cYtkXrhFyeURPQTaZTFEfESZgrB6dTiPR9c1JTjzwNZm0VTTlQY/oPJHxOftCHlJO9TevZFUBJWd9/oRzfo+zPis9+SXK4LGA00koyVNI=
Received: by 10.142.106.18 with SMTP id e18mr1751284wfc.1196961177374;
        Thu, 06 Dec 2007 09:12:57 -0800 (PST)
Received: from ?192.168.24.40? ( [149.164.193.61])
        by mx.google.com with ESMTPS id a16sm1854272rof.2007.12.06.09.12.56
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Thu, 06 Dec 2007 09:12:56 -0800 (PST)
User-Agent: Thunderbird 2.0.0.5 (X11/20070716)
In-Reply-To: <1196951517.3294.24.camel@localhost.localdomain>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/67306>

Ivo Alxneit wrote:
> when i use git-gui (0.9.0) to push/pull to/from a git+ssh://repo i have
> to supply my password to ssh. i get the password prompt from ssh on the
> controlling shell. as i often use several shells and git-gui might run
> in the background it is rather bothering to find the correct shell where
> ssh expects the password. could this be changed (in a safe way) in
> git-gui e.g. like pinentry pops up a window when gpg is used to sign
> emails?
>
> p.s. please cc me. i have not subscribed to the list
>
> thanks
>   
I know this doesn't answer the problem exactly, but if you use ssh keys 
and some sort of key management utility (such as Keychain or maybe Gnome 
keyring?), you can dodge the password entry problem and never have to 
enter a password (pending you register your ssh key with the server [ex: 
ssh-copy-id servername])


Another option that might answer your problem (and could be potentially 
integrated into git-gui) is the usage of the SSH_ASKPASS environment 
variable.

SSH_ASKPASS is a program to execute to get the passphrase that works by 
reading console output from the program.
