From: Fred's Personal <freddiewik@optonline.net>
Subject: RE: Trouble Cloning Git remote repository
Date: Sun, 28 Feb 2016 12:48:49 -0500
Message-ID: <00e001d17250$47c63fe0$d752bfa0$@optonline.net>
References: <009f01d170e9$ecd5cae0$c68160a0$@optonline.net>
 <CACsJy8A5539X+VhUAnNfn5Q_uW1pa5oYb9YAAF8=u3XfdhAeMw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7BIT
Cc: 'Git Mailing List' <git@vger.kernel.org>
To: 'Duy Nguyen' <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Sun Feb 28 18:49:05 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aa5Sq-0002v0-4m
	for gcvg-git-2@plane.gmane.org; Sun, 28 Feb 2016 18:49:04 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754606AbcB1Rsl (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 28 Feb 2016 12:48:41 -0500
Received: from mta7.srv.hcvlny.cv.net ([167.206.4.202]:51814 "EHLO
	mta7.srv.hcvlny.cv.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754556AbcB1Rsl (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 28 Feb 2016 12:48:41 -0500
Received: from mordor (ool-4350b670.dyn.optonline.net [67.80.182.112])
 by mta7.srv.hcvlny.cv.net
 (Sun Java System Messaging Server 6.2-8.04 (built Feb 28 2007))
 with ESMTP id <0O39000HQQT3N261@mta7.srv.hcvlny.cv.net> for
 git@vger.kernel.org; Sun, 28 Feb 2016 12:48:39 -0500 (EST)
In-reply-to: <CACsJy8A5539X+VhUAnNfn5Q_uW1pa5oYb9YAAF8=u3XfdhAeMw@mail.gmail.com>
X-Mailer: Microsoft Outlook 14.0
Content-language: en-us
Thread-index: AQOgdq5P9iRbUgta8tPA1S+543FP/gF6fvFXm5fc6+A=
X-Antivirus: AVG for E-mail 2016.0.7442 [4537/11713]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/287778>

Duy,

Thanks for advice, here is the result of executing the lines you suggested:

user1@Host1 MINGW64 ~/gitrepository (master)
$ export GIT_TRACE=1

user1@Host1 MINGW64 ~/gitrepository (master)
$ git clone -v ssh://user1@Host2/srv/centralrepo
12:33:47.928365 git.c:348               trace: built-in: git 'clone' '-v' 'ssh://user1@Host2/srv/centralrepo'
Cloning into 'centralrepo'...
12:33:48.022110 run-command.c:343       trace: run_command: 'C:\Program Files (x86)\PuTTY\plink.exe' 'user1@Host2' 'git-upload-pack '\''/srv/centralrepo'\'''

##>>>Lines from $HOME/.bashrc (See below, removed here for clarity)

+ user1@Host2 git-upload-pack /srv/centralrepo
bash: user1@Host2: command not found
fatal: Could not read from remote repository.

Please make sure you have the correct access rights
and the repository exists.


Regards,
Fred 

freddiewik@optonline.net


-----Original Message-----
From: Duy Nguyen [mailto:pclouds@gmail.com] 
Sent: Saturday, February 27, 2016 4:36 AM
To: Fred's Personal
Cc: Git Mailing List
Subject: Re: Trouble Cloning Git remote repository

On Sat, Feb 27, 2016 at 6:03 AM, Fred's Personal <freddiewik@optonline.net> wrote:
> $ git clone -v ssh://user1@Host2/srv/centralrepo Cloning into 
> 'centralrepo'...
>>>>Lines from $HOME/.bashrc
>   + export
> PATH=/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin:/usr
> /games
> :/usr/local/games
>   +
> PATH=/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin:/usr
> /games
> :/usr/local/games
>   + PROMPT_COMMAND=
>   + CDPATH=
>   + '[' '' = yes ']'
>   + PS1='${debian_chroot:+($debian_chroot)}\u:\W\$ '
>   + export GIT_TRACE_PACKET=1
>   + GIT_TRACE_PACKET=1
>   + export GIT_TRACE=1
>   + GIT_TRACE=1
>>>>End of Lines from $HOME/.bashrc
> ## WHERE DOES The following line COME FROM????What Script spits out 
> this line????
>   + user1@Host2 git-upload-pack /srv/centralrepo

Try set GIT_TRACE=1 at the clone line, I have a feeling that this line should be "ssh user@Host2..." but "ssh" is missing.

$ export GIT_TRACE=1
$ git clone -v ssh://user1@Host2/srv/centralrepo
--
Duy


-----
No virus found in this message.
Checked by AVG - www.avg.com
Version: 2016.0.7442 / Virus Database: 4537/11702 - Release Date: 02/26/16
