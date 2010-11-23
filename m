From: Jeenu V <jeenuv@gmail.com>
Subject: Re: Git reset -p on working tree
Date: Tue, 23 Nov 2010 18:30:39 +0530
Message-ID: <AANLkTimEOULR8_PAs5iPu7z+n4DQPSyDKYg8RghZxosz@mail.gmail.com>
References: <AANLkTimc=Dt9YSu=J=7C-f1hZ9UODU7VHu6oD8dmFX3N@mail.gmail.com>
 <AANLkTimP9zr=wQDYeBxtvYCE1mZ1aHXQ_nLOxGFfR9YD@mail.gmail.com>
 <AANLkTimQ644C-dEoJTj8bNd9y+YzpMez7D1KLZFNEe7c@mail.gmail.com>
 <AANLkTindHnjeXEGbKWiQkWgoUBwqZbdx71sQwNr_gFp0@mail.gmail.com> <AANLkTi=5w3YpYu0_WbmHud0BUkO2BqYNVezWDMkCaSj2@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: git@vger.kernel.org
To: knittl <knittl89@googlemail.com>
X-From: git-owner@vger.kernel.org Tue Nov 23 14:04:57 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PKsYK-0004rw-JB
	for gcvg-git-2@lo.gmane.org; Tue, 23 Nov 2010 14:04:56 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752154Ab0KWNEv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 23 Nov 2010 08:04:51 -0500
Received: from mail-yx0-f174.google.com ([209.85.213.174]:63205 "EHLO
	mail-yx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751584Ab0KWNEu (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 23 Nov 2010 08:04:50 -0500
Received: by yxn35 with SMTP id 35so66744yxn.19
        for <git@vger.kernel.org>; Tue, 23 Nov 2010 05:04:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:mime-version:received:in-reply-to
         :references:from:date:message-id:subject:to:cc:content-type;
        bh=eoDYusIIGoYdsS/FojJ5Oc6P0WUQDZqRFewTptq1SN4=;
        b=bPJGmJ6tD+qCa2MViQfM0Q7CRHwCa0CGmIMlg0nesznkb50kI9GlKIudETH7/GZ7sV
         IP0qoz+UeyqEwER3ZZbHCQsPSr3r67OyN7vgKu0DW3NZXXaNeTrRK35pG27MomgW/XwM
         A3hVEjOy5LnWINSrrmUbmFzGSvAnv0ASJ+NEU=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        b=NwCEv4NAM75sfbdc9uqJrLOrIWZbnZm3QVlT/V8pvWc8qb7xVNPjPgMb0mtI8KMmjS
         hXL610EJIZLg4+gW35w8E6u4VLbi6NgWREkrkAm+oDK7gCC8zXICagJkBic0viplMxXi
         9SS6SisTe+4aAO/L4fOX9Lbi8Ep0FuHz4gx/o=
Received: by 10.216.20.201 with SMTP id p51mr6545883wep.33.1290517387775; Tue,
 23 Nov 2010 05:03:07 -0800 (PST)
Received: by 10.216.10.209 with HTTP; Tue, 23 Nov 2010 05:00:39 -0800 (PST)
In-Reply-To: <AANLkTi=5w3YpYu0_WbmHud0BUkO2BqYNVezWDMkCaSj2@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/161955>

On Tue, Nov 23, 2010 at 4:28 PM, knittl <knittl89@googlemail.com> wrote:
> `git reset` seldomly affects the working tree, unless using `--hard`,
> `--merge` or `--keep`, and those switches are potentially dangerous if
> you are not aware of the implications to your worktree and index.
>
> without options reset undoes a previous add, i.e. remove changes from
> the index, but not the working tree.
>
> git reset manpage mentions git-checkout:

Agreed. What I'm saying is most manuals/guides out there tips user to
use 'git reset --hard' to discard changes in the working directory and
restore the pristine copy of files. 'reset' then becomes synonymous to
discard, and it kind of is but for a different reason. Because other
commands offer -p for selective operations, one might try to discard
selectively, and end up using 'git reset -p --hard', which obviously
isn't going to work.

Knowing the users intention in such cases, I was suggesting the error
message could hint the right command (just like git commit hints user
to use git-add when one does 'git commit' with a dirty working tree).

But that's just me.

-- 
Jeenu
