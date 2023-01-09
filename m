Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 79EBEC54EBD
	for <git@archiver.kernel.org>; Mon,  9 Jan 2023 13:47:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234246AbjAINrN (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 9 Jan 2023 08:47:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59798 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237160AbjAINrC (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 9 Jan 2023 08:47:02 -0500
X-Greylist: delayed 1328 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Mon, 09 Jan 2023 05:47:01 PST
Received: from www40.your-server.de (www40.your-server.de [213.133.104.40])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5C27F1C439
        for <git@vger.kernel.org>; Mon,  9 Jan 2023 05:47:01 -0800 (PST)
Received: from p4fc975a6.dip0.t-ipconnect.de ([79.201.117.166] helo=akari.eregion.home)
        by www40.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <Mathias.Homann@opensuse.org>)
        id 1pEs8w-000HMJ-V7
        for git@vger.kernel.org; Mon, 09 Jan 2023 14:24:51 +0100
Received: from localhost (localhost [127.0.0.1])
        by akari.eregion.home (Postfix) with ESMTP id 96FDB1E07D4
        for <git@vger.kernel.org>; Mon,  9 Jan 2023 14:24:50 +0100 (CET)
X-Virus-Scanned: amavisd-new at eregion.home
Received: from akari.eregion.home ([127.0.0.1])
        by localhost (akari.eregion.home [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id 2ADy_jFEj29s for <git@vger.kernel.org>;
        Mon,  9 Jan 2023 14:24:47 +0100 (CET)
Received: from mio.localnet (mio.eregion.home [192.168.238.69])
        (Authenticated sender: lemmy@akari)
        by akari.eregion.home (Postfix) with ESMTPSA id 64C8C1E0D15
        for <git@vger.kernel.org>; Mon,  9 Jan 2023 14:24:47 +0100 (CET)
From:   Mathias Homann <Mathias.Homann@opensuse.org>
To:     git@vger.kernel.org
Subject: git 2.39 does not want to talk to git 2.35
Date:   Mon, 09 Jan 2023 14:24:45 +0100
Message-ID: <12130631.O9o76ZdvQC@mio>
Organization: openSUSE.org member lemmy04
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart5639390.DvuYhMxLoT";
 micalg="pgp-sha512"; protocol="application/pgp-signature"
X-Authenticated-Sender: admin@eregion.de
X-Virus-Scanned: Clear (ClamAV 0.103.7/26776/Mon Jan  9 10:39:18 2023)
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

--nextPart5639390.DvuYhMxLoT
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"; protected-headers="v1"
From: Mathias Homann <Mathias.Homann@opensuse.org>
To: git@vger.kernel.org
Subject: git 2.39 does not want to talk to git 2.35
Date: Mon, 09 Jan 2023 14:24:45 +0100
Message-ID: <12130631.O9o76ZdvQC@mio>
Organization: openSUSE.org member lemmy04
MIME-Version: 1.0

Thank you for filling out a Git bug report!
Please answer the following questions to help us understand your issue.

What did you do before the bug happened? (Steps to reproduce your issue)
I tried to pull from my upstream/remote repo

What did you expect to happen? (Expected behavior)
I expected it "to work normally"

What happened instead? (Actual behavior)
Git hangs. GIT_TRACE=true shows that it hangs at the "git rev-list" stage.

What's different between what you expected and what actually happened?
see above.

Anything else you want to add:
this only happens when I'm pulling from my own local repos that are served
from an openSUSE Leap 15.4 running git 2.35.
mathias@mio:~/work/ansible/ansible-updates> git remote -v
origin  ssh://lemmy@akari.eregion.home/srv/git/ansible-updates.git (fetch)
origin  ssh://lemmy@akari.eregion.home/srv/git/ansible-updates.git (push)

What's more, it does not always happen - sometimes the pull succeeds, then
the next attempt fails (hangs until ctrl-c)
this does not happen pulling from github, or from a local gogs instance...
only from the "oldstyle" git via ssh.
Bugreport with openSUSE is here:
https://bugzilla.suse.com/show_bug.cgi?id=1206775

Please review the rest of the bug report below.
You can delete any lines you don't wish to share.


[System Info]
git version:
git version 2.39.0
cpu: x86_64
no commit associated with this build
sizeof-long: 8
sizeof-size_t: 8
shell-path: /bin/sh
uname: Linux 6.1.3-1-default #1 SMP PREEMPT_DYNAMIC Wed Jan  4 11:03:53 UTC 
2023 (a5315fb) x86_64
compiler info: gnuc: 12.2
libc info: glibc: 2.36
$SHELL (typically, interactive shell): /bin/bash


[Enabled Hooks]

-- 
Mathias Homann
Mathias.Homann@openSUSE.org
OBS: lemmy04
Jabber (XMPP): lemmy@tuxonline.tech
Matrix: @mathias:eregion.de
IRC: [Lemmy] on liberachat and ircnet (bouncer active)
keybase: https://keybase.io/lemmy
gpg key fingerprint: 8029 2240 F4DD 7776 E7D2 C042 6B8E 029E 13F2 C102
--nextPart5639390.DvuYhMxLoT
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEgCkiQPTdd3bn0sBCa44CnhPywQIFAmO8FZ0ACgkQa44CnhPy
wQLqpgv+L+Lh2jOlgV49AiTSHWIQh52ampT7oNPeuRhFC/M1fZxFGlP7lDoD5+Rc
6m6mXhjXTlAhHk3QdGEhmEe1DAsh3R3wl4PNc+IwGlJvf/mbtLn5R5ceSK2d6cQ3
VV3zvOK1OkWeDAYaOXCzVyIsvck5z6YXk5lUKLAvVxpUEk9D2Fb2lMye0M9g2Cbg
w8pyXzKbphlMDw+G6JNYEEaFJfyeIJcNcGOsglaCEpcflwuB0V3riYJHiD4MK0e3
fIq0CtC5QeuOmIHaytxmC/vfz8FiaHisHTMxG/zIFsEzgy561iYnbg6QsMfZdjpk
UU9aXhApApiXQ4dKxOI/enkR7kmgohk6yV4jwV+wQ2t5wT0Jwbzo5+H4XAkPOH99
oSAfUabew5aDukjl3JwKq0xjI4oakhPABIE9098/akvmMg6y0HRLEj0JcEgnMC/v
y2QT4sj8DAUKtHwYo0xlUZNx0ir5psKPC0XY9/XXVcEvzPUgotGGrp2Vfs6rq6Zo
RBz9wodT
=npwB
-----END PGP SIGNATURE-----

--nextPart5639390.DvuYhMxLoT--



