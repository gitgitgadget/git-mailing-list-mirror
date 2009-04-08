From: layer <layer@known.net>
Subject: Re: need help with git show :1:...
Date: Wed, 08 Apr 2009 11:35:33 -0700
Message-ID: <7685.1239215733@relay.known.net>
References: <6838.1239212486@relay.known.net> <51419b2c0904081058p7d5a56c3j6aa5cebb0188ad43@mail.gmail.com> <7199.1239213762@relay.known.net> <51419b2c0904081107s7ba08367w671d5b494095402@mail.gmail.com> <7357.1239214209@relay.known.net> <51419b2c0904081125u3bdf37deyd5dd85f6c2a6d7cc@mail.gmail.com>
Cc: git@vger.kernel.org
To: Elijah Newren <newren@gmail.com>
X-From: git-owner@vger.kernel.org Wed Apr 08 20:37:49 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LrceJ-0000fg-Sw
	for gcvg-git-2@gmane.org; Wed, 08 Apr 2009 20:37:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932811AbZDHSfg (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 8 Apr 2009 14:35:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1765329AbZDHSff
	(ORCPT <rfc822;git-outgoing>); Wed, 8 Apr 2009 14:35:35 -0400
Received: from relay.known.net ([67.121.255.169]:54420 "HELO relay.known.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1764054AbZDHSfe (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 8 Apr 2009 14:35:34 -0400
Received: from localhost (127.0.0.1) by relay.known.net
    (Allegro Maild v1.2.17) id 000000034347; Wed, 8 Apr 2009 11:35:33 -0700
In-reply-to: <51419b2c0904081125u3bdf37deyd5dd85f6c2a6d7cc@mail.gmail.com>
Comments: In-reply-to Elijah Newren <newren@gmail.com>
   message dated "Wed, 08 Apr 2009 12:25:35 -0600."
X-Mailer: MH-E 8.1; nmh 1.3; GNU Emacs 22.3.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/116106>

Elijah Newren <newren@gmail.com> wrote:

>> > How can I redo the merge for just this file?  Is that possible?  I
>> > think I'd definitely like to start over on *just this one file*.
>> 
>> Well, someone else probably knows a clever way to do this.  I don't,
>> but the following may help:
>> 
>> MERGE_REF=$(cat .git/MERGE_HEAD)
>> git show HEAD:src/c/sock.c > current-sock
>> git show $MERGE_REF:src/c/sock.c > other-sock
>> git show $(git merge-base $MERGE_REF HEAD):src/c/sock.c > base-sock
>> git merge-file current-sock other-sock base-sock

Did you mean this?

  git merge-file current-sock base-sock other-sock

The man page seems to indicate that.

>> That'll redo the three way merge on src/c/sock.c (assuming no renames
>> or other special cases happened) and store the result in current-sock.
>>  You can then edit that file and when ready, move the result over
>> src/c/sock.c.

Thanks.  This is a big help.
