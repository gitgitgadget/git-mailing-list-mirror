From: Thomas Rast <tr@thomasrast.ch>
Subject: Re: [PATCH/WIP v2 00/14] inotify support
Date: Mon, 20 Jan 2014 22:51:24 +0100
Message-ID: <87iotecof7.fsf@thomasrast.ch>
References: <1389524622-6702-1-git-send-email-pclouds@gmail.com>
	<1389952060-12297-1-git-send-email-pclouds@gmail.com>
	<87mwirewd7.fsf@thomasrast.ch>
	<CACsJy8AbsC8m5ju8pj2r3GzyUEiYSp5Kye=d+OhhTDaOhte8hg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Git Mailing List <git@vger.kernel.org>
To: Duy Nguyen <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Mon Jan 20 22:51:49 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1W5Ml3-0003mZ-2c
	for gcvg-git-2@plane.gmane.org; Mon, 20 Jan 2014 22:51:49 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751887AbaATVvk (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 20 Jan 2014 16:51:40 -0500
Received: from ip1.thgersdorf.net ([148.251.9.194]:55139 "EHLO mail.psioc.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751087AbaATVvi (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 20 Jan 2014 16:51:38 -0500
Received: from localhost (localhost [127.0.0.1])
	by localhost.psioc.net (Postfix) with ESMTP id 714174D657D;
	Mon, 20 Jan 2014 22:51:36 +0100 (CET)
X-Virus-Scanned: amavisd-new at psioc.net
Received: from mail.psioc.net ([127.0.0.1])
	by localhost (mail.psioc.net [127.0.0.1]) (amavisd-new, port 10024)
	with LMTP id jGXzYjeryZV1; Mon, 20 Jan 2014 22:51:26 +0100 (CET)
Received: from linux-1gf2.thomasrast.ch (46-126-8-85.dynamic.hispeed.ch [46.126.8.85])
	(using TLSv1.2 with cipher AES128-GCM-SHA256 (128/128 bits))
	(Client did not present a certificate)
	by mail.psioc.net (Postfix) with ESMTPSA id 795554D64BD;
	Mon, 20 Jan 2014 22:51:26 +0100 (CET)
In-Reply-To: <CACsJy8AbsC8m5ju8pj2r3GzyUEiYSp5Kye=d+OhhTDaOhte8hg@mail.gmail.com>
	(Duy Nguyen's message of "Mon, 20 Jan 2014 08:28:26 +0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/240729>

Duy Nguyen <pclouds@gmail.com> writes:

>> I think a clever way to handle this would be to add a new command:
>>
>>   Wait::
>>     This command serves synchronization.  Git creates a file of its
>>     choice in $GIT_DIR/watch (say, `.git/watch/wait.<random>`).  Then it
>>     sends "wait <path>".  The watcher MUST block until it has processed
>>     all change notifications up to and including <path>.
>
> So wait.<random> inotify event functions as a barrier. Nice.

I forgot to specify a return for "wait".  Not sure you need one, though
correctly handling the timeout (that you apply for all select()) may be
somewhat tricky without it.

>> Ok, that's probably a confused sum of rambles.  Let me know if you can
>> make any sense of it.
>
> Thank you for your input. Now I'm back to the white board (or paper).

Don't go too far ;-)

Thanks a lot for doing this!  It's good that you picked it up, and I
think your design strikes a good balance in the complexity of the
protocol and the daemon's state.

-- 
Thomas Rast
tr@thomasrast.ch
