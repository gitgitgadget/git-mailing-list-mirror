From: "Martin Langhoff" <martin.langhoff@gmail.com>
Subject: Re: Implementing branch attributes in git config
Date: Thu, 11 May 2006 12:13:21 +1200
Message-ID: <46a038f90605101713n506207aem1326cd2bf5a1f861@mail.gmail.com>
References: <1147037659.25090.25.camel@dv>
	 <BAYC1-PASMTP02C02EAC2F64AC00BB5801AEA90@CEZ.ICE>
	 <BAYC1-PASMTP04D623089E043F1C792A37AEA90@CEZ.ICE>
	 <Pine.LNX.4.64.0605091543100.3718@g5.osdl.org>
	 <BAYC1-PASMTP037EBB0237B35C5F92FB0BAEAE0@CEZ.ICE>
	 <Pine.LNX.4.64.0605091854380.3718@g5.osdl.org>
	 <46a038f90605100019q3b44b87kf49e456668f2e249@mail.gmail.com>
	 <Pine.LNX.4.64.0605100823350.3718@g5.osdl.org>
	 <46a038f90605101617x1aa9bd2du959ead77ebf61795@mail.gmail.com>
	 <Pine.LNX.4.64.0605101629230.3718@g5.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
	format=flowed
Content-Transfer-Encoding: 7BIT
Cc: sean <seanlkml@sympatico.ca>, junkio@cox.net,
	Johannes.Schindelin@gmx.de, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu May 11 02:13:55 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Fdyo6-0001LP-2A
	for gcvg-git@gmane.org; Thu, 11 May 2006 02:13:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965100AbWEKAN1 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 10 May 2006 20:13:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965104AbWEKAN1
	(ORCPT <rfc822;git-outgoing>); Wed, 10 May 2006 20:13:27 -0400
Received: from wr-out-0506.google.com ([64.233.184.239]:42892 "EHLO
	wr-out-0506.google.com") by vger.kernel.org with ESMTP
	id S965100AbWEKAN0 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 10 May 2006 20:13:26 -0400
Received: by wr-out-0506.google.com with SMTP id i28so25766wra
        for <git@vger.kernel.org>; Wed, 10 May 2006 17:13:25 -0700 (PDT)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=jPBuJml7BU82LGxLrL1NuzAc6BXTUSrIgAqwR4VVRO+Trqz6INuGXDHmupFczylbmaVprpjA6zL/reKXroY7erLva1cFjcutLwi4FI8tRnDLTNShI8HH11Ax1F1KglBU6dHyDH/O9cNhuamwrUNBqU3CEk9x4sm68mYD6BjYyS8=
Received: by 10.54.98.19 with SMTP id v19mr161906wrb;
        Wed, 10 May 2006 17:12:55 -0700 (PDT)
Received: by 10.54.127.17 with HTTP; Wed, 10 May 2006 17:13:21 -0700 (PDT)
To: "Linus Torvalds" <torvalds@osdl.org>
In-Reply-To: <Pine.LNX.4.64.0605101629230.3718@g5.osdl.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/19900>

On 5/11/06, Linus Torvalds <torvalds@osdl.org> wrote:
>         [branch "origin"]
>                 remote = git://git.kernel.org/pub/scm/git/git.git
>                 branch master

This is confusing at first read -- is it branch origin or branch master?

>    Anyway, the point is, I think our current .git/remotes/xyzzy files
>    actually mix two different concepts, and they also end up doing it
>    pretty badly. They _work_, but because of the mix-ups, they aren't all
>    that they could be, and it's fundamentally impossible to make them so,
>    because the mixup really is that "origin" means TWO DIFFERENT THINGS
>    (the local branch, and the remote that it corresponds to)

As you say, this needs to be explained/exposed better to the user.
Now, how about having one .git/config and one .git/branches file?
Different semantics, etc.

> The .git/config file is _easier_ to edit by hand than the remotes. It's
> easier to copy-paste within one file than it is to work with two

Agreed, but I suspect repo config and branches config travel at
different speeds. Maybe what this means is that if this happens, we'll
start seeing a need for ~/.git/config and /etc/git/config to set
defaults (merge.summary=1 for all my repos, core.sharedrepository=1
for all the repos on this server) where I now I just mostly copy
.git/config around.

Does that make sense?

> I don't see why this is hard.

Must be me... it's not the Perl part... I just do a lot of grep |
xargs | sed stuff in my daily git usage ;-)

cheers,


martin
