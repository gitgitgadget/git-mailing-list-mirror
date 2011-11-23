From: Philippe Vaucher <philippe.vaucher@gmail.com>
Subject: Re: Proposal: create meaningful aliases for git reset's hard/soft/mixed
Date: Thu, 24 Nov 2011 00:00:38 +0100
Message-ID: <CAGK7Mr5nQoubAw11KDj4WKwQnXrfgteKbMj2=AR-HhsGKi52wQ@mail.gmail.com>
References: <CAGK7Mr4GZq5eXn4OB+B0ZborX-OVoXiWU8Lo1XM5LRZDuRe1YA@mail.gmail.com>
 <7vlir6brjw.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Christian Couder <chriscool@tuxfamily.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Nov 24 00:01:17 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RTLoa-0006V0-VZ
	for gcvg-git-2@lo.gmane.org; Thu, 24 Nov 2011 00:01:17 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755162Ab1KWXBM convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 23 Nov 2011 18:01:12 -0500
Received: from mail-yx0-f174.google.com ([209.85.213.174]:51599 "EHLO
	mail-yx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752023Ab1KWXBM convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 23 Nov 2011 18:01:12 -0500
Received: by yenq3 with SMTP id q3so1938625yen.19
        for <git@vger.kernel.org>; Wed, 23 Nov 2011 15:01:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        bh=xjmgiZoAfTh91EPKt/WYT0LfIwUIZU3zQ5Z+CHpskAk=;
        b=Vq9OO/t9oL5Rk+42caHMP297jTSPBOzxBI5l9XG9A/4dl7CWggfbK88zDAV2gspua5
         bH5N3/wnoAFhz1kDzvUco1DtH2Xe3rf4RSz0Vp+JyFQFyu2AhDDNTLVuwygpdbcJBNQi
         SyBmVvX0TIVP/3ZWB+47rZc7SnHOm0smZ0HjM=
Received: by 10.50.47.201 with SMTP id f9mr29617471ign.18.1322089270987; Wed,
 23 Nov 2011 15:01:10 -0800 (PST)
Received: by 10.50.195.199 with HTTP; Wed, 23 Nov 2011 15:00:38 -0800 (PST)
In-Reply-To: <7vlir6brjw.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/185885>

>> "I want to discard my changes" --> git reset --all HEAD^
>
> That is discarding your changes and also the last commit.

Yes, of course.


>> "I want to discard the last commit" --> git reset --index HEAD^
>
> I do not think this has a clear meaning. "discard the last commit but
> leave the contents in the working tree. I do not care a newly added f=
iles
> are forgotten by the index, I'll remember to re-add them if I need to=
" is
> what you are saying here, but the word "index" does not hint it. =A0W=
hen
> used as an option name, "--index" means "this command usually works o=
n or
> touches working tree but for this invocation please also affect the i=
ndex";
> "please look at or affect _only_ the index" is usually spelled "--cac=
hed".

Well, it's certainly a bit more descriptive and easy to remember than
"--mixed". I understand it could confuse people because of the other
commands, but maybe something like "--index-only"?


> In any case, I think your proposal makes it even worse than the curre=
nt
> state, and you should aim higher.

Why worse? I'd understand if you said it's doesn't improve it enough
for it to be worth the change tho.
Anyway, my proposal was to get a discussion going, and I'm all for
aiming higher if there's a way. What do you propose instead? You
seemed to imply we'd remove --soft and --merge, and make --keep as an
option for --hard but named differently, something like
--keep-changes. Maybe I didn't fully understand.

Mathieu even suggested that it'd have the behavior of --keep by
default, and that you have to add --force to get today's --hard
behavior, which sounds like a good idea to me (avoid destructive
behavior by default).

Philippe
