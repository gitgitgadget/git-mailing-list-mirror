From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: [RFC/PATCH] remote: add new sync command
Date: Mon, 7 Nov 2011 22:51:10 +0200
Message-ID: <CAMP44s0M-qnZeHCUadSJJCYO=t881sUOi11G3fCG2vaAakPyBQ@mail.gmail.com>
References: <1320682032-12698-1-git-send-email-felipe.contreras@gmail.com>
	<20111107172218.GB3621@sigill.intra.peff.net>
	<CAMP44s358k4EsCg+K6MeLEU4eLbb4mWyX9AdAf4P9CHvf9Lrwg@mail.gmail.com>
	<20111107183938.GA5155@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Mon Nov 07 21:51:17 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RNWA0-0004qL-Tt
	for gcvg-git-2@lo.gmane.org; Mon, 07 Nov 2011 21:51:17 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752213Ab1KGUvM convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 7 Nov 2011 15:51:12 -0500
Received: from mail-qw0-f46.google.com ([209.85.216.46]:34152 "EHLO
	mail-qw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751651Ab1KGUvM convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 7 Nov 2011 15:51:12 -0500
Received: by qao25 with SMTP id 25so1024454qao.19
        for <git@vger.kernel.org>; Mon, 07 Nov 2011 12:51:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        bh=5tV6O+u11beALOejZzZ3Il6CTcP8S4V+VMsvfbo5+f4=;
        b=DswXJs2xInrjDlb2A4S6vFJ1gFKu0rMGP2ldqdjii021rY4YMGZQ2xNP/3/X0fy8mM
         A9Mf7SgrfRbKjtYnXGIbYTC2FJqkHfA3QzB5E5l65yVkHsu41ivp4U1DNkwXPoRJnNPn
         RWDxbG82e+TSwi3eB3eelf/yt98XmYzUgtZjk=
Received: by 10.68.0.103 with SMTP id 7mr2079624pbd.76.1320699070788; Mon, 07
 Nov 2011 12:51:10 -0800 (PST)
Received: by 10.68.40.69 with HTTP; Mon, 7 Nov 2011 12:51:10 -0800 (PST)
In-Reply-To: <20111107183938.GA5155@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/185024>

On Mon, Nov 7, 2011 at 8:39 PM, Jeff King <peff@peff.net> wrote:
> On Mon, Nov 07, 2011 at 08:35:07PM +0200, Felipe Contreras wrote:
>
>> I don't know, seems logical to me what 'git remote sync' does, but
>> 'git push sync'? That sounds weird, and there are no 'git push foo'
>> commands.
>
> What I don't understand is why it is not:
>
> =C2=A0git push --mirror <URL|remote>

Because that pushes *everything*.

>> > And how does this differ from "git push --mirror"? It looks like y=
ou
>> > have more options for what pushing all versus pruning, but wouldn'=
t it
>> > be better for "git push" to grow those options?
>>
>> But how? --mirror is just an option, I want a separate command, with
>> it's own options.
>
> That's what I don't understand from your proposal. Your command is ju=
st
> pushing something to the remote, right? Why isn't "push" the command,
> and your sync options become options to push?

How exactly? --sync-prune, --sync-new, --sync-all? But actually, I was
thinking on adding an option to sync the other way around; to get all
the remote branches and have them locally.

> Can you step back and describe the problem you're trying to solve? Ma=
ybe
> we're not connecting there.

Well, I usually have quite a lot of branches in my local repositories,
like a dozen of so. And I like to back them up in some remote
repository, however, not all the branches all the time. git push
--mirror not only pushes branches, but also tags (and I don't want
that), and even other refs. Does that clarifies things?

--=20
=46elipe Contreras
