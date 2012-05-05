From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: [1.8.0] use 'stage' term consistently
Date: Sat, 5 May 2012 15:04:25 +0200
Message-ID: <CAMP44s1qqpTxRvjEH32MNqzUeNhgZ1gB+fu=cgvxnSbMB6oBGA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Junio C Hamano <gitster@pobox.com>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Jeff King <peff@peff.net>, Scott Chacon <schacon@gmail.com>,
	Paolo Ciarrocchi <paolo.ciarrocchi@gmail.com>,
	=?UTF-8?Q?Jakub_Nar=C4=99bski?= <jnareb@gmail.com>,
	Johannes Schindelin <johannes.schindelin@gmx.de>,
	Matthieu Moy <matthieu.moy@imag.fr>,
	Piotr Krukowiecki <piotr.krukowiecki.news@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat May 05 15:04:34 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SQef3-0003E1-5k
	for gcvg-git-2@plane.gmane.org; Sat, 05 May 2012 15:04:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755629Ab2EENE1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 5 May 2012 09:04:27 -0400
Received: from mail-ey0-f174.google.com ([209.85.215.174]:50432 "EHLO
	mail-ey0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755509Ab2EENE0 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 5 May 2012 09:04:26 -0400
Received: by eaaq12 with SMTP id q12so1041184eaa.19
        for <git@vger.kernel.org>; Sat, 05 May 2012 06:04:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:date:message-id:subject:from:to:cc:content-type;
        bh=qCh+Ot+D4xxlev9c84seFBo8F22/GZGzDLu0EhxDyew=;
        b=MiTSv6ja7i+dPe9yl2HHKstX/HIXKvz7foex4P+hpJGwOFg/cTTTKs+T5hhtiVObkd
         bHYPIxckjCkc7wiQZqPkM7b1Z9hCkrBTuXzWNEBoFwj/6iLfnTh+caHNUmC5qiwTHc55
         EaWSOvX1BPzbSbikMLqgcKwi8p4Ebbo3CK4cppTndwuZzDfdzETir42lqmy67I5kA7aE
         7jbpaBJhUfaNa/7RRbm5nBAW/b8Pi+d05iIQX4IUGd3iQyqASWwO0b5NJ+KZYofxuP6y
         lcSoojJaZoUHiwB/d6pb5Z88N2CUNRlr12m1P2BjcAY9IeynnpnpcXOIIolwDMqjvhMq
         j/LA==
Received: by 10.14.96.129 with SMTP id r1mr1703684eef.86.1336223065156; Sat,
 05 May 2012 06:04:25 -0700 (PDT)
Received: by 10.213.103.18 with HTTP; Sat, 5 May 2012 06:04:25 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/197111>

Proposal:

Avoid the terms 'cache' and 'index' in favor of 'stage'.

Advantages:

The term 'stage' is more intuitive for newcomers which are more
familiar with English than with git, and it seems to be a
straightforward mental notion for people from different mother
tongues.

It is so intuitive that it is used already in a lot online
documentation, and the people that do teach git professionally use
this term.

Risks:

People might be accustomed to the current options, and might take some
time to get used to the new term. Scripts might be relying on the
current options.

There's also the possibility that a lot of people prefer the terms
'cache' and 'index', but from the countless discussions on this
subject, that seems to be rather unlikely.

Migration plan:

Follow a typical obsolete/deprecate process; for a period of time warn
that the options are obsolete and shouldn't be used, in case there's a
lot of people against this, this period would allow for them to shout;
then remove them.

Rationale:

First of all, this discussion _always_ keeps coming back, so its clear
something needs to be done, and in the last big discussion the
consensus was that 'stage' was the best option. In summary:

cache: a 'cache' is a place for easier access; a squirrel caches nuts
so it doesn't have to go looking for them in the future when it might
be much more difficult. Git porcelain is not using the staging area
for easier future access; it's not a cache.

index: an 'index' is a guide of pointers to something else; a book
index has a list of entries so the reader can locate information
easily without having to go through the whole book. Git porcelain is
not using the staging area to find out entries quicker; it's not an
index.

stage: a 'stage' is a special area designated for convenience in order
for some activity to take place; an orator would prepare a stage in
order for her speak to be successful, otherwise many people might not
be able to hear, or see her.  Git porcelain is using the staging area
precisly as a special area to be separated from the working directory
for convenience.

The term 'stage' is a good noun itself, but also 'staging area', it
has a good verb; 'to stage', and a nice past-participle; 'staged'.

-- 
Felipe Contreras
