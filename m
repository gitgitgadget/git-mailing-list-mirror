From: =?ISO-8859-1?Q?Santi_B=E9jar?= <santi@agolina.net>
Subject: Re: Difference between pull --rebase and fetch+rebase
Date: Thu, 7 Jan 2010 23:33:23 +0100
Message-ID: <adf1fd3d1001071433j6cd36641sdd2dfd6a936d8483@mail.gmail.com>
References: <27059158.post@talk.nabble.com>
	 <adf1fd3d1001070800k6fa501fej39b84f849b7e5b50@mail.gmail.com>
	 <1262889864880-4268064.post@n2.nabble.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: martinvz <martin.von.zweigbergk@gmail.com>
X-From: git-owner@vger.kernel.org Thu Jan 07 23:33:31 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NT0v4-0008I1-45
	for gcvg-git-2@lo.gmane.org; Thu, 07 Jan 2010 23:33:30 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751242Ab0AGWdZ convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 7 Jan 2010 17:33:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751207Ab0AGWdZ
	(ORCPT <rfc822;git-outgoing>); Thu, 7 Jan 2010 17:33:25 -0500
Received: from mail-fx0-f225.google.com ([209.85.220.225]:47741 "EHLO
	mail-fx0-f225.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750983Ab0AGWdY convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 7 Jan 2010 17:33:24 -0500
Received: by fxm25 with SMTP id 25so12178801fxm.21
        for <git@vger.kernel.org>; Thu, 07 Jan 2010 14:33:23 -0800 (PST)
Received: by 10.102.237.27 with SMTP id k27mr1655547muh.93.1262903603393; Thu, 
	07 Jan 2010 14:33:23 -0800 (PST)
In-Reply-To: <1262889864880-4268064.post@n2.nabble.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/136398>

[Do not top post, as it breaks the conversation flow]

On Thu, Jan 7, 2010 at 7:44 PM, martinvz
<martin.von.zweigbergk@gmail.com> wrote:
>
> Thanks for your post, Santi. I can not share my repository since it i=
s a
> project at work. I was troubleshooting a bit myself and found the fol=
lowing
> section in git-pull.sh:
>
> =A0 =A0 =A0 =A0oldremoteref=3D"$(git rev-parse -q --verify "$remotere=
f")" &&
> =A0 =A0 =A0 =A0for reflog in $(git rev-list -g $remoteref 2>/dev/null=
)
> =A0 =A0 =A0 =A0do
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0if test "$reflog" =3D "$(git merge-bas=
e $reflog $curr_branch)"
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0then
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0oldremoteref=3D"$reflo=
g"
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0break
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0fi
> =A0 =A0 =A0 =A0done
>
> Why is it that reflog entries are allowed to override the remote refe=
rence?

This is used when the upstream branch is rebased, as you only want to
rebase the local commits and not commits in the old upstream branch.

Is your upstream branch rebased?

Can you provide, at least, a graph of your history (ala git log
--graph --oneline for example)? And plot also the reflog entries and
all the important commits.

Santi
