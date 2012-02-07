From: Johan Herland <johan@herland.net>
Subject: Re: User authentication in GIT
Date: Tue, 7 Feb 2012 13:32:35 +0100
Message-ID: <CALKQrgdvOhfhTPg+g+LqCb6XOQczcz-nYC61B9x4W5dB4Up5oA@mail.gmail.com>
References: <1328595129258-7261349.post@n2.nabble.com>
	<1328615262741-7262113.post@n2.nabble.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: supadhyay <supadhyay@imany.com>
X-From: git-owner@vger.kernel.org Tue Feb 07 13:32:46 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RukE0-0002m6-TP
	for gcvg-git-2@plane.gmane.org; Tue, 07 Feb 2012 13:32:45 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755968Ab2BGMck convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 7 Feb 2012 07:32:40 -0500
Received: from locusts.copyleft.no ([178.255.144.241]:55240 "EHLO
	mail.mailgateway.no" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755676Ab2BGMck convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 7 Feb 2012 07:32:40 -0500
Received: from mail-gx0-f174.google.com ([209.85.161.174])
	by mail.mailgateway.no with esmtpsa (TLSv1:RC4-SHA:128)
	(Exim 4.72 (FreeBSD))
	(envelope-from <johan@herland.net>)
	id 1RukDu-0009Jl-Sl
	for git@vger.kernel.org; Tue, 07 Feb 2012 13:32:39 +0100
Received: by ggnh1 with SMTP id h1so3337113ggn.19
        for <git@vger.kernel.org>; Tue, 07 Feb 2012 04:32:35 -0800 (PST)
Received: by 10.50.213.41 with SMTP id np9mr23903317igc.21.1328617955433; Tue,
 07 Feb 2012 04:32:35 -0800 (PST)
Received: by 10.42.226.9 with HTTP; Tue, 7 Feb 2012 04:32:35 -0800 (PST)
In-Reply-To: <1328615262741-7262113.post@n2.nabble.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/190165>

On Tue, Feb 7, 2012 at 12:47, supadhyay <supadhyay@imany.com> wrote:
> Hi Robin and Jakub,
>
> Thanks for your reply. But I am still not getting what exactly I need=
 to
> perform on GIT server. Please find my reply on your suggestion below:
>
>
> Robin:
> All users must have their own SSH key. You do not create keys for the=
m.
> My rely: can you please give some more idea about how it works.. I am=
 not
> getting this or if you can provide any link for this to understand.

- Each user generates their own ssh key pair on their own workstation
(in openssh, the command for generating a new key is called
'ssh-keygen')

- Each user then sends their public key to you (using email or
whatever communication form is easiest for you).

- You then load the keys into gitolite (by copying them into your
local clone of the gitolite-admin repo, committing, and pushing to the
gitolite-admin repo to the server).

More details here: http://sitaramc.github.com/gitolite/add.html (and
in associated documentation)

> Jakub:
> My reply: existing version control system used =C2=A0pserver protocol=
=2E
>
> You would still need for each user to generate their own SSH key.
> My reply: Do I need to store all end users sSH key in .ssh/authorized=
_keys
> file on GIT server?

No. You load them into gitolite (as described above, and in gitolite's
documentation), and then gitolite takes care of managing them.


Have fun! :)

=2E..Johan

--=20
Johan Herland, <johan@herland.net>
www.herland.net
