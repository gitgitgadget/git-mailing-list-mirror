From: Kalle Launiala <kalle.launiala@gmail.com>
Subject: Re: Getting started with git
Date: Tue, 22 Mar 2011 02:21:15 +0200
Message-ID: <AANLkTimwR=knX4ORAWROutn=kxAhBUrUt0BgBTNA9G6A@mail.gmail.com>
References: <AANLkTinkuSJBvftDCh8++UyV5Wc=sMRr1+vc8WbeFYMs@mail.gmail.com>
	<20110321135931.GA3367@elie>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: git@vger.kernel.org
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Tue Mar 22 01:21:23 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Q1pLe-0004gc-C2
	for gcvg-git-2@lo.gmane.org; Tue, 22 Mar 2011 01:21:22 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755056Ab1CVAVR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 21 Mar 2011 20:21:17 -0400
Received: from mail-iw0-f174.google.com ([209.85.214.174]:36932 "EHLO
	mail-iw0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755028Ab1CVAVQ (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 21 Mar 2011 20:21:16 -0400
Received: by iwn34 with SMTP id 34so6909514iwn.19
        for <git@vger.kernel.org>; Mon, 21 Mar 2011 17:21:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type;
        bh=YycvD0kTqHIF76v6wHm0+lOwNuE4K6noa2sypaBY8V4=;
        b=xauZMXnMIjpCiknFbe9fMfonjNMgJNKep6vZ/0oxPrC5sFM0ct3/+epxCwuzQlpWp5
         t+Ro3wNRIPyX09S4wEengzZdS6RYLOFndvs/0uodgtaDn5m4k0nJv0RCSIo3I7MQ6fNK
         096/UCpwFWTrw3lvBnAUqRLChpFJbvZx1fNtg=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        b=TQjr5UnSsKNEkiecMQYGuh3zyavsJx89xwxN5fi3ZhimHDdURXv0uUBRKEKpvYAhJI
         PkF0wV2vw51aK9f4I66d/Fl/UX6KPFO+r6KqzY7yz4j7gKBe5DlrSy1KekYffEaMPcR9
         hdeuWvT6XX7mVgTkLMk7Mw6nenHskcbI4sl5E=
Received: by 10.231.150.205 with SMTP id z13mr4741553ibv.177.1300753275692;
 Mon, 21 Mar 2011 17:21:15 -0700 (PDT)
Received: by 10.231.142.16 with HTTP; Mon, 21 Mar 2011 17:21:15 -0700 (PDT)
In-Reply-To: <20110321135931.GA3367@elie>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/169695>

Hello!

Thanks for the links of overall programmer requirements, been reading
such so far as well. The hacking guide was fresh compared to what I
discovered.

Now the reason of specific detail understanding of the Git was to use
it on wide-range software-code-block distribution. I would like to
know if the following scenario either will "blow up" something or has
some other anti-Git patterns hidden inside.

1. Git repositories vs. "traditional" branch/merge

Within the current spec, we have identified "branching/merging" that
is VCS supported conflict management only feasible option. With Git
this seems to turn to forked/linked independent repositories; this
seems the best option. Every independent software-block would have an
independent root-repository of its own.

Any reason why Git would be using branching at all in distributing
between-project data, even when in traditional VCS they would be
within same repository?

2. Scalability, when having tiny repositories that are chained to the
end-developer

Basically none of the "bottom" is going to push back any changes, so
they're effectively just readers, and also from the nearest
repository; the repository syncing (while likely can be automated out)
will go with normal pulls. I'm not worrying about "seconds to pull",
but moreover is there something architectural structure, that will
cause single-bottleneck.

Is there any scalability issue, if there are say 10 levels from root
repository to the end-user-bottom (in between various feature-adding
or modifying tailoring), and total number of children of the bottom
level grows to hundreds of thousands?


3. Distribution of catalogues, registering "Abstractions"

Registering of new "Abstractions" from any provider (be it major
organization or single consultant) would be dealt with specific
"distribution" repository chain. Pushing the "Registration Request"
within the catalogue would be fullfilled by validating the data in the
claimed repository. The format of the data is strongly schema based
XML all the way. The openly used "root" catalogue would be synced
globally (daily or so, not immediatelly); the dedicated "private" or
other independent catalogue providers would be in charge of their
policies.

Are there any experience on this kind of use for Git?


4. Handling "private" catalogues; repository access filtered with
client-access-control

Private catalogues would be handled in a way, that their
existence/registration would be standard-pushed up to the chain.
However all the information of their data and their content would be
contained only within the repository. Hence, only the clients that
have the access to connect to the repository could fetch the actual
catalogue of information. They would cache their catalogues with same
manner as would the root catalogue.

Even if the clients would get improper private entires in their
connection lists, they would only get any real information out, if
their credentials authorized on the target repository.

Any blockers that come in mind with this?


Kalle
