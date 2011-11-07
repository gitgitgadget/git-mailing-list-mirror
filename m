From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: [RFC/PATCH] remote: add new sync command
Date: Mon, 7 Nov 2011 20:35:07 +0200
Message-ID: <CAMP44s358k4EsCg+K6MeLEU4eLbb4mWyX9AdAf4P9CHvf9Lrwg@mail.gmail.com>
References: <1320682032-12698-1-git-send-email-felipe.contreras@gmail.com>
	<20111107172218.GB3621@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Mon Nov 07 19:35:20 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RNU2O-0003Vz-4m
	for gcvg-git-2@lo.gmane.org; Mon, 07 Nov 2011 19:35:16 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751283Ab1KGSfJ convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 7 Nov 2011 13:35:09 -0500
Received: from mail-qy0-f174.google.com ([209.85.216.174]:48863 "EHLO
	mail-qy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751020Ab1KGSfI convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 7 Nov 2011 13:35:08 -0500
Received: by qyk27 with SMTP id 27so2699933qyk.19
        for <git@vger.kernel.org>; Mon, 07 Nov 2011 10:35:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        bh=D/ckGy5ATT69H3/Uh9uHu5Awculkf/bmrNmLItiHAnw=;
        b=Z2w9jowwl+snctHM70qEFjcEg3J4hhTqmH/7PcCT9To6V5/0bgIsiwSzFsLaVEg+iZ
         HPMqGK2zeIkZ8gMystWdww3VfdS6L9R6RrEiULoqMND15Tlymlu8s2NpaGzpjoujyXxK
         ftWLiJBnqFkLr/ZMiO+4Danh93AevmaFEDdHM=
Received: by 10.68.27.166 with SMTP id u6mr1138723pbg.59.1320690907572; Mon,
 07 Nov 2011 10:35:07 -0800 (PST)
Received: by 10.68.40.69 with HTTP; Mon, 7 Nov 2011 10:35:07 -0800 (PST)
In-Reply-To: <20111107172218.GB3621@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/185010>

On Mon, Nov 7, 2011 at 7:22 PM, Jeff King <peff@peff.net> wrote:
> On Mon, Nov 07, 2011 at 06:07:12PM +0200, Felipe Contreras wrote:
>
>> This is useful to mirror all the branches in the current repo to
>> another.
>> [...]
>> +'sync'::
>> +
>> +Synchronizes local branches with certain remote. This is useful to =
backup all
>> +the branches in a local repository to a remote one, regardless of w=
hat upstream
>> +is configured for each branch.
>> ++
>> +With `--prune`, remote branches will be deleted if they are not als=
o locally.
>> ++
>> +With `--new`, local branches that are not yet in the remote will be=
 pushed too.
>> ++
>> +With `--all`, basically both `--prune` and `--new` will be selected=
=2E
>> ++
>> +With `--force`, existing branches will be forced to update, like `g=
it push
>> +--force`.
>> ++
>> +With `--dry-run`, all the changes will be reported, but not really =
happen.
>
> Why is this in "git remote", and not "git push"? =C2=A0The former is =
usually
> about managing the configuration of remotes, not about actually doing
> the ref transfer (the "-f" flag excepted, but that is clearly just
> calling out to "fetch").

I don't know, seems logical to me what 'git remote sync' does, but
'git push sync'? That sounds weird, and there are no 'git push foo'
commands.

> And how does this differ from "git push --mirror"? It looks like you
> have more options for what pushing all versus pruning, but wouldn't i=
t
> be better for "git push" to grow those options?

But how? --mirror is just an option, I want a separate command, with
it's own options.

Cheers.

--=20
=46elipe Contreras
