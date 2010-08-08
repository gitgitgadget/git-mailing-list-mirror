From: Jon Seymour <jon.seymour@gmail.com>
Subject: Re: [PATCH v3 9/9] Documentation: git stash branch now tolerates 
	non-stash references.
Date: Sun, 8 Aug 2010 23:18:22 +1000
Message-ID: <AANLkTik+E13hg=q5ML_9Y5GT2PygSEQ7YWOwXv3L_HmC@mail.gmail.com>
References: <1281242771-24764-1-git-send-email-jon.seymour@gmail.com>
	<1281242771-24764-10-git-send-email-jon.seymour@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: gitster@pobox.com, ams@toroid.org
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Aug 08 15:18:39 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Oi5lv-0005m3-Ag
	for gcvg-git-2@lo.gmane.org; Sun, 08 Aug 2010 15:18:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754034Ab0HHNSY convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 8 Aug 2010 09:18:24 -0400
Received: from mail-qw0-f46.google.com ([209.85.216.46]:48403 "EHLO
	mail-qw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753986Ab0HHNSX convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 8 Aug 2010 09:18:23 -0400
Received: by qwh6 with SMTP id 6so6419432qwh.19
        for <git@vger.kernel.org>; Sun, 08 Aug 2010 06:18:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:in-reply-to
         :references:date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=HeQr4miNwc+HEcftgHmHV6yFNIhQgX3Ffb8fFZY1MxY=;
        b=cM/vkZqyPCaqdzECRx5HeASfTgkFVU7bglQky5d8xH+m1sEnyUx8/GHwL0S2NGggea
         0imM44oUlNrnIwqvNTckiSOqQ8pYDWL8QRtzNRrXlKLAhbdPC5COPxnecbiV+NRxgbgz
         O+4DYCo+wCFMTWhFTHe+HFp6LDniSdOSRs0H0=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=fLcw6Q5ng5mP0qz2eUka2veoJEDDaWpQtQUTw+2Dk3cBVMz0IcdBQkrOspcE9Z4SG1
         QGfCr2F4ZU/tBEEtaMvTUKAWdHd+LS1UgUpX3w6aJfFaWVlolDIMGMFuEwp/2gw19Y3p
         JmDT0JRaaYMpGH8dtdTqirCYaHN4RpsFuUQXY=
Received: by 10.224.54.13 with SMTP id o13mr4556639qag.369.1281273502775; Sun, 
	08 Aug 2010 06:18:22 -0700 (PDT)
Received: by 10.229.222.13 with HTTP; Sun, 8 Aug 2010 06:18:22 -0700 (PDT)
In-Reply-To: <1281242771-24764-10-git-send-email-jon.seymour@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/152907>

The next iteration will amend the synopsis as follows:

-'git stash' show [<stash>]
-'git stash' drop [-q|--quiet] [<stash>]
-'git stash' ( pop | apply ) [--index] [-q|--quiet] [<stash>]
-'git stash' branch <branchname> [<stash>]
+'git stash' show [<stash-like>]
+'git stash' drop [-q|--quiet] [<stash-entry>]
+'git stash' pop [--index] [-q|--quiet] [<stash-entry>]
+'git stash' apply [--index] [-q|--quiet] [<stash-like>]
+'git stash' branch <branchname> [<stash-like>]

with corresponding changes to the body. This will help clarify when a
stash entry
is required and when a stash-like commit can be used instead.

On Sun, Aug 8, 2010 at 2:46 PM, Jon Seymour <jon.seymour@gmail.com> wro=
te:
> Update the documentation to indicate that git stash branch only attem=
pts
> to drop the specified stash if it looks like stash reference.
>
> Signed-off-by: Jon Seymour <jon.seymour@gmail.com>
> ---
> =C2=A0Documentation/git-stash.txt | =C2=A0 =C2=A04 ++--
> =C2=A01 files changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/Documentation/git-stash.txt b/Documentation/git-stash.tx=
t
> index 473889a..c7b7e4e 100644
> --- a/Documentation/git-stash.txt
> +++ b/Documentation/git-stash.txt
> @@ -115,8 +115,8 @@ branch <branchname> [<stash>]::
> =C2=A0 =C2=A0 =C2=A0 =C2=A0Creates and checks out a new branch named =
`<branchname>` starting from
> =C2=A0 =C2=A0 =C2=A0 =C2=A0the commit at which the `<stash>` was orig=
inally created, applies the
> =C2=A0 =C2=A0 =C2=A0 =C2=A0changes recorded in `<stash>` to the new w=
orking tree and index, then
> - =C2=A0 =C2=A0 =C2=A0 drops the `<stash>` if that completes successf=
ully. When no `<stash>`
> - =C2=A0 =C2=A0 =C2=A0 is given, applies the latest one.
> + =C2=A0 =C2=A0 =C2=A0 drops the `<stash>` if that completes successf=
ully and `<stash>` looks like a
> + =C2=A0 =C2=A0 =C2=A0 stash the name of a stash list entry. When no =
`<stash>` is given, applies the latest one.
> =C2=A0+
> =C2=A0This is useful if the branch on which you ran `git stash save` =
has
> =C2=A0changed enough that `git stash apply` fails due to conflicts. S=
ince
> --
> 1.7.2.1.51.g82c0c0
>
>
