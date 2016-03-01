From: David Aguilar <davvid@gmail.com>
Subject: Re: git-rebase + git-mergetool results in broken state
Date: Tue, 1 Mar 2016 08:38:01 -0800
Message-ID: <20160301163801.GA18095@gmail.com>
References: <CA+hqKG8M97SEmejrdr-OC0yQc=ofY4yWej4gG_6B2jsqGq8imw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Joe Einertson <joe@kidblog.org>
X-From: git-owner@vger.kernel.org Tue Mar 01 17:38:19 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aanJN-0000lr-ME
	for gcvg-git-2@plane.gmane.org; Tue, 01 Mar 2016 17:38:14 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751097AbcCAQiI convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 1 Mar 2016 11:38:08 -0500
Received: from mail-pf0-f171.google.com ([209.85.192.171]:34964 "EHLO
	mail-pf0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751026AbcCAQiH (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 1 Mar 2016 11:38:07 -0500
Received: by mail-pf0-f171.google.com with SMTP id w128so70922260pfb.2
        for <git@vger.kernel.org>; Tue, 01 Mar 2016 08:38:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=d4hp8J2wrt2NHCbYUd9ORgreMPsWayAF7ACuoXtJ4lY=;
        b=TyjLjJAhMP+S34oosF6oPQTE/RyKoRaNNiFYLoDCzQKexb3LdjPoHE8miU3SG/qlUR
         KpBA+pOMrWLZaXe2g4miQWI4Cbj6H8pjsXG1tHUf93Tn4HWPd9J9uPe/MdpzdOFF6pHy
         0xAehtIsdkDSaSd7SWB/kVTnKZQgYh+FTcs8meswGaH5/vSoOYj1QtLEAzdeojsGTRSk
         WEDmbRZoV8JcHd++jxolAgPNMuij/nu6IsPfeeaYXJWcg8oNNMiKhvmSmMyHmuOlcgGD
         aj3Qx1pHlhMQQLYjIV7gi78gvA3DAmrdYAL+diqYBJZXZzB2XZdfbBS+XLFJRe3ypool
         65oA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=d4hp8J2wrt2NHCbYUd9ORgreMPsWayAF7ACuoXtJ4lY=;
        b=ePpBxn+XMDpY+i9/1BzEBMMcY9VpE2HTnX3QkCItHWXB1wXsykwCctulsi/JpPmGr0
         zi7KbSg16993VFafi+45KKWTVQpo3m6WLN3NI7fbKy2qfFCDRpc6Z7lhZYjss5Vqiw0q
         /+kl69vCYm/NtHMN7l7oDrufRkQPO6Bzozd6TDPoJZ1HSyZ4C3HjGQPLqcZKesVlAJiF
         V/HLVmjlA/d4zxR90cyPkzCyA78Pp30e5L7aAKQb8cLw3Efr0z0qL7RLMuBZcPRjY9sf
         mlAficQ9avJcy1xkTLSlWZgPSBcRkuQHLlxuEh3xp4m/UkpbP4LWs3NR82ZxMng3socz
         0dww==
X-Gm-Message-State: AD7BkJLAI8dY7/6aM3tmbfHHTXM+ppYyQUUsFuKgmFcX1oFCcEPYbAPfVxnj3vA8oBbkhw==
X-Received: by 10.98.14.149 with SMTP id 21mr31472259pfo.79.1456850285741;
        Tue, 01 Mar 2016 08:38:05 -0800 (PST)
Received: from gmail.com (208-106-56-2.static.sonic.net. [208.106.56.2])
        by smtp.gmail.com with ESMTPSA id m5sm46696926pfi.84.2016.03.01.08.38.03
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 01 Mar 2016 08:38:04 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <CA+hqKG8M97SEmejrdr-OC0yQc=ofY4yWej4gG_6B2jsqGq8imw@mail.gmail.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/288036>

On Tue, Feb 23, 2016 at 04:44:49PM -0600, Joe Einertson wrote:
> I'm experiencing an annoying issue which leaves the repository in a
> weird, broken state. I am attempting a rather vanilla rebase, rebasin=
g
> the commits from a feature branch on top of the newest commits on
> master.

Can you tell us a little more about what's in the branch being
rebased?  Is it perhaps a public project that you can share so
that we can reproduce the issue?

Here are a few more questions that can help narrow down the
issue:

* What Git vesion are you using?

* What mergetool are you using?
  - See the output "git config merge.tool"

* What platform are you on?  Are you on Windows?

* Does the conflicting commit contain renames?

I'm trying to figure out whether we are missing a `mkdir -p`
somewhere, and whether we hadn't run into this in the past
because the merge needs to involve renames.

> So, I run a typical series of commands:
> 1. git checkout feature-branch
> 2. git rebase master (conflicts ensue)
> 3. git mergetool
>=20
> The conflicts are expected, but when using mergetool to resolve them,
> I encounter many "no such file or directory" errors.
>=20
> mv: cannot stat
> =E2=80=98app/components/mediaManager/kbImageEditor.directive.coffee=E2=
=80=99: No such
> file or directory
> cp: cannot stat
> =E2=80=98./app/components/mediaManager/kbImageEditor.directive_BACKUP=
_13615.coffee=E2=80=99:
> No such file or directory
> mv: cannot move =E2=80=98.merge_file_ogGjXX=E2=80=99 to
> =E2=80=98./app/components/mediaManager/kbImageEditor.directive_BASE_1=
3615.coffee=E2=80=99:
> No such file or directory
> /usr/lib/git-core/git-mergetool: 229: /usr/lib/git-core/git-mergetool=
:
> cannot create ./app/components/mediaManager/kbImageEditor.directive_L=
OCAL_13615.coffee:
> Directory nonexistent
> /usr/lib/git-core/git-mergetool: 229: /usr/lib/git-core/git-mergetool=
:
> cannot create ./app/components/mediaManager/kbImageEditor.directive_R=
EMOTE_13615.coffee:
> Directory nonexistent

* Does the directory ./app/components/medaiManager/ exist in master?

* Did a commit on master perhaps move its content somewhere else?

* Does that directory have some chmod permissions, or is it owned
  by a different user?

* Are you able to create new files in that directory?

> This leaves weird dangling files like '.merge_file_ogGjXX' in the
> repo, and I assume I should not proceed with the merge since it
> couldn't even create the files to compare.

If you got a failure at this step you can safely delete those
temporary dangling files and then follow the advice given by
`git status`.

Typically it'll list files with conflicts.  Open them with
your $EDITOR, resolve conflicts like normal, and add the
result using `git add`.  Nonetheless, we'd like to get to the
bottom of this issue.

> Is this a known issue? Is there any workaround? Is it safe to proceed
> with the merge?

I've never ran into this myself, and it's never been reported
here so this is not a known issue.

It's still safe to proceed with the merge and resolve files the
normal way.  If you would rather undo the rebase and go back to
your original state (before the rebase) then you can do
`git rebase --abort` anytime.

I'm not sure about a workaround, but.. it might possibly work if
you were to `mkdir -p` the directory mentioned above, but that's
a guess.  If that does workaround the issue then please let us
know since that would be an interesting data point.
--=20
David
