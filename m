From: Phil Hord <phil.hord@gmail.com>
Subject: Re: Proposal: create meaningful aliases for git reset's hard/soft/mixed
Date: Fri, 2 Dec 2011 10:38:05 -0500
Message-ID: <CABURp0pmnsgE1ywW-W2+QFNci=3Lm=JKj9Y3U8zjh8+Cg_NA6Q@mail.gmail.com>
References: <CAGK7Mr4GZq5eXn4OB+B0ZborX-OVoXiWU8Lo1XM5LRZDuRe1YA@mail.gmail.com>
 <7vlir6brjw.fsf@alter.siamese.dyndns.org> <CAGK7Mr5nQoubAw11KDj4WKwQnXrfgteKbMj2=AR-HhsGKi52wQ@mail.gmail.com>
 <CABURp0rtCUbJXLHtXv_1g6GRKL3mX-T+3vN1=QO4CUibqXdEMg@mail.gmail.com> <CAGK7Mr7zdstbm7QsrYq9a6m9ui_r8Ak8XtyWADLQ0n-mXiov4w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	Christian Couder <chriscool@tuxfamily.org>
To: Philippe Vaucher <philippe.vaucher@gmail.com>
X-From: git-owner@vger.kernel.org Fri Dec 02 16:38:34 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RWVC4-0002DQ-PY
	for gcvg-git-2@lo.gmane.org; Fri, 02 Dec 2011 16:38:33 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756837Ab1LBPi2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 2 Dec 2011 10:38:28 -0500
Received: from mail-ww0-f44.google.com ([74.125.82.44]:38186 "EHLO
	mail-ww0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756773Ab1LBPi1 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 2 Dec 2011 10:38:27 -0500
Received: by wgbdr13 with SMTP id dr13so1406340wgb.1
        for <git@vger.kernel.org>; Fri, 02 Dec 2011 07:38:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=w1C4GlZQT7F8dNZiUQnj1mx2hy41G/jBq8AzCCToqR0=;
        b=xHGlrja0Injau41roLlYk9q+d474sDJqQ0Ue9LCa8qNRuQ8k113q7jailwOuSNCvYm
         SFca4+6TwJAfgrMGGj/PDNvu/ISIcEuzJtGfMJmhoNER2ERCORb8P1NMnW5hwLB5Gabq
         H4kdNaV26zEuQEpyxBPGYY/wkF4HkyAyM4/WY=
Received: by 10.227.203.131 with SMTP id fi3mr8160532wbb.17.1322840306343;
 Fri, 02 Dec 2011 07:38:26 -0800 (PST)
Received: by 10.216.61.142 with HTTP; Fri, 2 Dec 2011 07:38:05 -0800 (PST)
In-Reply-To: <CAGK7Mr7zdstbm7QsrYq9a6m9ui_r8Ak8XtyWADLQ0n-mXiov4w@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/186223>

On Fri, Dec 2, 2011 at 9:27 AM, Philippe Vaucher
<philippe.vaucher@gmail.com> wrote:
> Maybe we'd start by listing the features we want to be able to do:
>
> - Move git's HEAD to a particular commit without touching the files or the index
> - Move git's HEAD to a particular commit and clear the index but
> without touching the files
> - Move git's HEAD to a particular commit and clear the index and have
> all the files match that particular commit files
> - Move git's HEAD to a particular commit and clear the index and have
> all the files match that particular commit files and remove files that
> are unknown to that commit
>
> Is there a scenario I'm missing? Once we have the scenarios nailed
> down we can start thinking about how to express them.

Aim higher.

Do not think about the git-reset command and all of its features.
Moreover, do not limit yourself to git-reset's functionality.

Think about why you need to use git-reset.  Why do new users need to
use git-reset?  What is it they are after?

For me, it was the three I mentioned before.

So, let's look at yours:

> - Move git's HEAD to a particular commit without touching the files or the index

I know what this is, but I don't know to describe it without saying
"reset".  It's like teleportation.  "Move me to a new location in the
tree".
git teleport <commit>


> - Move git's HEAD to a particular commit and clear the index but
> without touching the files

git teleport --index <commit>


> - Move git's HEAD to a particular commit and clear the index and have
> all the files match that particular commit files

git checkout --clean <commit>


> - Move git's HEAD to a particular commit and clear the index and have
> all the files match that particular commit files and remove files that
> are unknown to that commit

git checkout --clean <commit> && git clean -fd  # maybe this needs a switch?


One you left out is this:
- Do NOT move git's HEAD; clear the index and workdir

git reset


I think the ability to move git's HEAD is what makes reset dangerous,
especially in the hands of new users.

Phil
