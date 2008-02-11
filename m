From: =?utf-8?Q?David_K=C3=A5gedal?= <davidk@lysator.liu.se>
Subject: Re: [StGit PATCH 5/5] Emacs mode: use "stg new --file"
Date: Mon, 11 Feb 2008 10:25:44 +0100
Message-ID: <87zlu7sv3b.fsf@lysator.liu.se>
References: <20080210203846.17683.43153.stgit@yoghurt>
	<20080210204434.17683.61684.stgit@yoghurt>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Catalin Marinas <catalin.marinas@gmail.com>,
	Karl =?utf-8?Q?Hasselstr?= =?utf-8?Q?=C3=B6m?= 
	<kha@treskal.com>
X-From: git-owner@vger.kernel.org Mon Feb 11 10:26:19 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JOUva-0006zh-KN
	for gcvg-git-2@gmane.org; Mon, 11 Feb 2008 10:26:19 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751314AbYBKJZo convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 11 Feb 2008 04:25:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751271AbYBKJZo
	(ORCPT <rfc822;git-outgoing>); Mon, 11 Feb 2008 04:25:44 -0500
Received: from mail.lysator.liu.se ([130.236.254.3]:47216 "EHLO
	mail.lysator.liu.se" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751087AbYBKJZm convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 11 Feb 2008 04:25:42 -0500
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.lysator.liu.se (Postfix) with ESMTP id 9AF4A200A1F4;
	Mon, 11 Feb 2008 10:25:41 +0100 (CET)
Received: from mail.lysator.liu.se ([127.0.0.1])
	by localhost (lenin.lysator.liu.se [127.0.0.1]) (amavisd-new, port 10024)
	with LMTP id 19552-01-84; Mon, 11 Feb 2008 10:25:41 +0100 (CET)
Received: from krank (78.156.200.233.bredband.tre.se [78.156.200.233])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.lysator.liu.se (Postfix) with ESMTP id C5E1E200A1EB;
	Mon, 11 Feb 2008 10:25:40 +0100 (CET)
Received: by krank (Postfix, from userid 1000)
	id 105427B4077; Mon, 11 Feb 2008 10:25:45 +0100 (CET)
In-Reply-To: <20080210204434.17683.61684.stgit@yoghurt> ("Karl =?utf-8?Q?H?=
 =?utf-8?Q?asselstr=C3=B6m=22's?= message of "Sun\, 10 Feb 2008 21\:46\:04
 +0100")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.1 (gnu/linux)
X-Virus-Scanned: by amavisd-new-20030616-p10 (Debian) at lysator.liu.se
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/73491>

Karl Hasselstr=C3=B6m <kha@treskal.com> writes:

> Creating a new patch is a great deal easier now that "stg new" has a
> --file flag.
>
> Signed-off-by: Karl Hasselstr=C3=B6m <kha@treskal.com>
>
> ---
>
> David, will you sanity-check this? I don't really speak elisp, so I
> might have done something insane without knowing it. But it does seem
> to work. :-)

Looks sane to me.

>  contrib/stgit.el |   10 ++--------
>  1 files changed, 2 insertions(+), 8 deletions(-)
>
>
> diff --git a/contrib/stgit.el b/contrib/stgit.el
> index bef41c7..30c1cd1 100644
> --- a/contrib/stgit.el
> +++ b/contrib/stgit.el
> @@ -316,16 +316,10 @@ Commands:
> =20
>  (defun stgit-confirm-new ()
>    (interactive)
> -  (let ((file (make-temp-file "stgit-edit-"))
> -        (patch (stgit-create-patch-name
> -                (buffer-substring (point-min)
> -                                  (save-excursion (goto-char (point-=
min))
> -                                                  (end-of-line)
> -                                                  (point))))))
> +  (let ((file (make-temp-file "stgit-edit-")))
>      (write-region (point-min) (point-max) file)
>      (stgit-capture-output nil
> -      (stgit-run "new" "-m" "placeholder" patch)
> -      (stgit-run "edit" "-f" file patch))
> +      (stgit-run "new" "-f" file))
>      (with-current-buffer log-edit-parent-buffer
>        (stgit-refresh))))
> =20
>

--=20
David K=C3=A5gedal
