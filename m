From: Tim Henigan <tim.henigan@gmail.com>
Subject: Re: [PATCH] Update 'git remote' usage and man page to match.
Date: Sun, 15 Nov 2009 14:29:17 -0500
Message-ID: <32c343770911151129q7e2d9960q29205118c54abf4a@mail.gmail.com>
References: <32c343770911121715l7507b2d5j8c6cf8cccd1f1a61@mail.gmail.com>
	 <20091114071948.6117@nanako3.lavabit.com>
	 <32c343770911142034j6cf10e36jbd031c49119973c8@mail.gmail.com>
	 <7vr5s0qhnp.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Nanako Shiraishi <nanako3@lavabit.com>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Nov 15 20:29:27 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1N9kmr-0002EF-8i
	for gcvg-git-2@lo.gmane.org; Sun, 15 Nov 2009 20:29:25 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753459AbZKOT3N convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 15 Nov 2009 14:29:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753427AbZKOT3M
	(ORCPT <rfc822;git-outgoing>); Sun, 15 Nov 2009 14:29:12 -0500
Received: from fg-out-1718.google.com ([72.14.220.155]:11108 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753404AbZKOT3M convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 15 Nov 2009 14:29:12 -0500
Received: by fg-out-1718.google.com with SMTP id e12so2128758fga.1
        for <git@vger.kernel.org>; Sun, 15 Nov 2009 11:29:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=PqeFbpjPKK8x7p8z8a0eDlkAzenELDQZ1w/TGqSUNn8=;
        b=HFUIVTTakgcgCKN+f9SidBdZo/ooEAGCPoG9MDl28P6kCQQq8NzhnG4kGGJE7x0ZRM
         t6qUP0hglAeWjanM8gY/M4Rc+DGWv7US0I/ix6sWA9FtL114BORxz9AioT/rbAXVoJ9G
         FiHxl+kp5CDUHwEchZ9d6hHSMaso9r7+Wi71Y=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=tLdXzY4baS1XUnyv67/3kaWEjAynEObra9TvsQ38oMfUIVDfsuTBbGxSGhBXmHe9cb
         fUiRkxxEi9xWAEhCm1HWzwE+oxKlmu9VP1P90RVRcPAfUs5iITsLcwE2JsdfPUCCGZ5c
         RjMd8JBy2mSQ9YoOUaUyObu074G7ZXmSuR0nU=
Received: by 10.216.88.18 with SMTP id z18mr823887wee.78.1258313357236; Sun, 
	15 Nov 2009 11:29:17 -0800 (PST)
In-Reply-To: <7vr5s0qhnp.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/132953>

On Sun, Nov 15, 2009 at 4:08 AM, Junio C Hamano <gitster@pobox.com> wro=
te:
> You noticed a good issue to address. =C2=A0That is, "git remote -h" o=
utput
> looks Ok but "git remote add -h" and friends show way suboptimal help=
=2E
> The current output looks like:
>
> =C2=A0 =C2=A0$ git remote add -h
> =C2=A0 =C2=A0usage: git remote [-v | --verbose]
> =C2=A0 =C2=A0 =C2=A0 or: git remote add [-t <branch>] [-m <master>] [=
-f] [--mirror] <name>
> =C2=A0 =C2=A0 =C2=A0 <url>
> =C2=A0 =C2=A0 =C2=A0 or: git remote rename <old> <new>
> =C2=A0 =C2=A0 =C2=A0 or: git remote rm <name>
> =C2=A0 =C2=A0 =C2=A0 or: git remote set-head <name> [-a | -d | <branc=
h>]
> =C2=A0 =C2=A0 =C2=A0 or: git remote show [-n] <name>
> =C2=A0 =C2=A0 =C2=A0 or: git remote prune [-n | --dry-run] <name>
> =C2=A0 =C2=A0 =C2=A0 or: git remote [-v | --verbose] update [-p | --p=
rune] [group]
>
> =C2=A0 =C2=A0add specific options
> =C2=A0 =C2=A0 =C2=A0 =C2=A0-f, --fetch =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 fetch the remote branches
> =C2=A0 =C2=A0 =C2=A0 =C2=A0-t, --track <branch> =C2=A0branch(es) to t=
rack
> =C2=A0 =C2=A0 =C2=A0 =C2=A0-m, --master <branch>
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0master branch
> =C2=A0 =C2=A0 =C2=A0 =C2=A0--mirror =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0no separate remotes
>
> As the user already knows "add" is the subcommand she is interested i=
n,
> this is insane.
>
> My preference is:
>
> =C2=A0(1) to drop your change to the synopsis section ("git remote -v=
" is a
> =C2=A0 =C2=A0 valid way to get more verbose information, isn't it?);

Sounds reasonable.


> =C2=A0(2) to keep the current output of "git remote -h";

The usage string for "git remote update" should still be modified to ma=
tch
the changes made to the man page in commit b344e161.  That commit
taught 'git remote update' to understand [group | remote].  The man pag=
e
was changed to document the new feature, but the usage string was not.

I will send v2 of this patch to make this change and add the author of
b344e161 (Finn Arne Gangstad) to the CC list to confirm.


> =C2=A0(3) to drop the general description section altogether from "gi=
t remote
> =C2=A0 =C2=A0 add -h" output;

Okay, I will look into this.  If I find a good solution, I will send
an RFC patch
that updates 'git remote add'.  Based on the email threads you cited be=
low,
it sounds like the usage string for 'git push' is a good model to
follow.  If the
change looks sane, I will follow up with a patch series that updates ea=
ch of
the 'git remote' subcommands.


> I think this is related to a bigger issue of how we generally would w=
ant
> to show help in response to "-h", and also in the manual pages.
>
> =C2=A0http://thread.gmane.org/gmane.comp.version-control.git/129399/f=
ocus=3D129424
> =C2=A0http://thread.gmane.org/gmane.comp.version-control.git/129906/f=
ocus=3D130646
