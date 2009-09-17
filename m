From: Brendan Miller <catphive@catphive.net>
Subject: Re: obnoxious CLI complaints
Date: Thu, 17 Sep 2009 09:48:32 +0900
Message-ID: <ef38762f0909161748u32ad56bcya3314fe28fd06ffe@mail.gmail.com>
References: <ef38762f0909091427m5b8f3am72c88fd4dbfebc59@mail.gmail.com>
	 <m3fxavvl5k.fsf@localhost.localdomain>
	 <ef38762f0909091709t7336d86dkd2f175e5b3a6a3f@mail.gmail.com>
	 <20090912103156.GA30385@dpotapov.dyndns.org>
	 <43d8ce650909121132n76cda485ycd53a0497e397960@mail.gmail.com>
	 <20090912214428.GB30385@dpotapov.dyndns.org>
	 <43d8ce650909121521m3dbac12co7f5f2dcaf15190e7@mail.gmail.com>
	 <20090912224335.GC30385@dpotapov.dyndns.org>
	 <43d8ce650909121608t2b9c4b9bw44104acceea26e12@mail.gmail.com>
	 <7v3a6r5znq.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: John Tapsell <johnflux@gmail.com>,
	Dmitry Potapov <dpotapov@gmail.com>,
	Jakub Narebski <jnareb@gmail.com>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Sep 17 02:48:40 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Mo5As-0002DG-Ky
	for gcvg-git-2@lo.gmane.org; Thu, 17 Sep 2009 02:48:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754635AbZIQAs3 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 16 Sep 2009 20:48:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752077AbZIQAs3
	(ORCPT <rfc822;git-outgoing>); Wed, 16 Sep 2009 20:48:29 -0400
Received: from qw-out-2122.google.com ([74.125.92.25]:28390 "EHLO
	qw-out-2122.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751193AbZIQAs2 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 16 Sep 2009 20:48:28 -0400
Received: by qw-out-2122.google.com with SMTP id 9so1816826qwb.37
        for <git@vger.kernel.org>; Wed, 16 Sep 2009 17:48:32 -0700 (PDT)
Received: by 10.229.32.82 with SMTP id b18mr2945959qcd.10.1253148512418; Wed, 
	16 Sep 2009 17:48:32 -0700 (PDT)
In-Reply-To: <7v3a6r5znq.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/128700>

On Sun, Sep 13, 2009 at 11:47 AM, Junio C Hamano <gitster@pobox.com> wr=
ote:
> John Tapsell <johnflux@gmail.com> writes:
>
>> Ah, the manpage examples specifically give the --format=3Dtar though=
=2E
>
> So what?

That looks like a manpage bug. In the version I have 1.6.4 the format
for archive is given like this:

 git archive --format=3D<fmt> [--list] [--prefix=3D<prefix>/] [<extra>]
                         [--output=3D<file>] [--worktree-attributes]
                         [--remote=3D<repo> [--exec=3D<git-upload-archi=
ve>]] <tree-i
sh>
                         [path...]

So --format isn't marked as optional. Later in the manpage it mentions
tar as the default, but that contradicts this, and the examples use
--format=3Dtar, so it's easy to miss.

>
>> Why not have =A0--format=3Dtgz =A0then or something? =A0Or better ye=
t, give
>> the filename on the command line and detect the format from the file
>> extension.
>
> That is an interesting enhancement and sounds like a useful feature.
>
I do like that idea.

git archive --output=3Dmyarchive.tar.gz HEAD is a bit more
straightforward, and still lets people pipe in the old way if they
want to.

I think someone mentioned we're already linking the requisite library?
Otherwise, you can always open up a pipe programmatically within git.
Don't you guys do something like that for ssh? I seem to recall it
complaining that ssh couldn't be found on windows, but maybe it was
just the library.

Prefix could be myarchive. I guess some people have more specific
requirements, but I usually just want it to be *sometime* so it
doesn't spew out tons of files into the directory I decompress it
into.

Brendan
