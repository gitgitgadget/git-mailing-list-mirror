From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] status: hint the user about -uno if read_directory takes
 too long
Date: Fri, 15 Mar 2013 09:53:48 -0700
Message-ID: <7vvc8svc2r.fsf@alter.siamese.dyndns.org>
References: <CACsJy8DZm153Tu_3GTOnxF8bFrYPh7_DP6Rn6rr3n6tfuVuv2Q@mail.gmail.com>
 <1363179556-4144-1-git-send-email-pclouds@gmail.com>
 <7vehfj46mu.fsf@alter.siamese.dyndns.org>
 <CACsJy8BixM-9bPB3G_WO+W3cTHBFxLQ=YCU2NDEzHmCYW73ZPQ@mail.gmail.com>
 <7vmwu6yqbd.fsf@alter.siamese.dyndns.org>
 <CACsJy8BruzR=EGnwA5nc_aCJ5pO4FHyQKxd-9_36U48Ci_FFew@mail.gmail.com>
 <514343BA.3030405@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Duy Nguyen <pclouds@gmail.com>, git@vger.kernel.org,
	artagnon@gmail.com, robert.allan.zeh@gmail.com, finnag@pvv.org
To: Torsten =?utf-8?Q?B=C3=B6gershausen?= <tboegi@web.de>
X-From: git-owner@vger.kernel.org Fri Mar 15 17:54:22 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UGXtc-00062j-10
	for gcvg-git-2@plane.gmane.org; Fri, 15 Mar 2013 17:54:20 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754843Ab3COQxw convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 15 Mar 2013 12:53:52 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:60741 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754330Ab3COQxv convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 15 Mar 2013 12:53:51 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 676B4A966;
	Fri, 15 Mar 2013 12:53:50 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=nfQd8wuulWxc
	tAw6AZzzO3k6Rc4=; b=St0OVGMx8SeWSnzxZuc3+hjO0Q1f5lGf27TPUo6cqZxc
	1LUp7Cq1DJ57ixIUDZQmlRRvab1VaDgW6oRL79um2t5WkBNoxWiq3bwhZtOZnsZc
	y40+kljo6RAaZXX5ISMKUSIGLj2rDZYIuY5TT9kUEUiqN/l/K9wZdxTGLTosWaM=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=vWbkBT
	89erh9RhTGHoQbHyBBLixhlNtOkEFZEVNN8Lfn5FFkuJt9DZy6aPKxGkGnp/xAwE
	oeZjNSbvh/326W3kjll5UhJUJOjF4B7GsDbsqLSc6ECqz5FEdalJJBKsQAc7Scvf
	o9r//DsfT1d0AhEjmOBEPYWdC8yZpBsvgBdjo=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 5A60DA963;
	Fri, 15 Mar 2013 12:53:50 -0400 (EDT)
Received: from pobox.com (unknown [24.4.35.13]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 90A28A961; Fri, 15 Mar 2013
 12:53:49 -0400 (EDT)
In-Reply-To: <514343BA.3030405@web.de> ("Torsten =?utf-8?Q?B=C3=B6gershaus?=
 =?utf-8?Q?en=22's?= message of "Fri, 15 Mar 2013 16:52:26 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: E8DB1C36-8D90-11E2-B60E-4AAA2E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/218252>

Torsten B=C3=B6gershausen <tboegi@web.de> writes:

> [PATCH] git status: Document that git status -uno is faster
>
> In some repostories users expere that "git status" command takes long=
 time.

expere???  Certainly you did not mean "expect".  "observe",
"experience", or "see", perhaps?

> The command spends some time searching the file system for untracked =
files.
> Document that searching for untracked file may take some time, and do=
cuemnt
> the option -uno better.

Good intentions.

> Signed-off-by: Torsten B=C3=B6gershausen <tboegi@web.de>
> ---
>  Documentation/git-status.txt | 7 +++++++
>  1 file changed, 7 insertions(+)
>
> diff --git a/Documentation/git-status.txt b/Documentation/git-status.=
txt
> index 0412c40..fd36bbd 100644
> --- a/Documentation/git-status.txt
> +++ b/Documentation/git-status.txt
> @@ -58,6 +58,13 @@ The possible options are:
>  The default can be changed using the status.showUntrackedFiles
>  configuration variable documented in linkgit:git-config[1].
>
> ++
> +Note: Searching the file system for untracked files may take some ti=
me.
> +git status -uno is faster than git status -uall.
> +There is a trade-off around the use of -uno between safety and perfo=
rmance.
> +The default is not to use -uno so that you will not forget to add a
> file you newly created (i.e safety).
> +You would pay for the safety with the cost to find such untracked
> files (i.e. performance).
> +

The second sentence looks out of flow, and the last sentence, while
technically not incorrect, is unclear what it is trying to convey in
the larger picture.

Perhaps it is just me.

In any case, I think it is a good idea to explain the reason why the
user might want to use a non-default setting, and the criteria the
user may want to base the choice on (which is the gist of your
addition), and it is a good idea to do so _before_ saying "The
default can be changed using ...".

How about this?

 Documentation/git-status.txt | 14 ++++++++++----
 1 file changed, 10 insertions(+), 4 deletions(-)

diff --git a/Documentation/git-status.txt b/Documentation/git-status.tx=
t
index 0412c40..9046df9 100644
--- a/Documentation/git-status.txt
+++ b/Documentation/git-status.txt
@@ -46,15 +46,21 @@ OPTIONS
 	Show untracked files.
 +
 The mode parameter is optional (defaults to 'all'), and is used to
-specify the handling of untracked files; when -u is not used, the
-default is 'normal', i.e. show untracked files and directories.
+specify the handling of untracked files.
 +
 The possible options are:
 +
-	- 'no'     - Show no untracked files
-	- 'normal' - Shows untracked files and directories
+	- 'no'     - Show no untracked files.
+	- 'normal' - Shows untracked files and directories.
 	- 'all'    - Also shows individual files in untracked directories.
 +
+When `-u` option is not used, untracked files and directories are
+shown (i.e. the same as specifying `normal`), to help you avoid
+forgetting to add newly created files.  Because it takes extra work
+to find untracked files in the filesystem, this mode may take some
+time in a large working tree.  You can use `no` to have `git status`
+return more quickly without showing untracked files.
++
 The default can be changed using the status.showUntrackedFiles
 configuration variable documented in linkgit:git-config[1].
=20
