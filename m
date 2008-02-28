From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] git.el: find the git-status buffer whatever its name is
Date: Thu, 28 Feb 2008 12:14:33 -0800
Message-ID: <7vprugj0t2.fsf@gitster.siamese.dyndns.org>
References: <87hcg0fyxe.dlv@maison.homelinux.org>
 <87skzd44qn.dlv@maison.homelinux.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: julliard@winehq.org, git@vger.kernel.org
To: Remi Vanicat <vanicat@debian.org>
X-From: git-owner@vger.kernel.org Thu Feb 28 21:15:31 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JUpA8-0004ZU-2X
	for gcvg-git-2@gmane.org; Thu, 28 Feb 2008 21:15:28 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758798AbYB1UOw convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 28 Feb 2008 15:14:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758071AbYB1UOw
	(ORCPT <rfc822;git-outgoing>); Thu, 28 Feb 2008 15:14:52 -0500
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:62033 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758798AbYB1UOv convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 28 Feb 2008 15:14:51 -0500
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id D5C6B23FB;
	Thu, 28 Feb 2008 15:14:47 -0500 (EST)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with
 ESMTP id D829E23F9; Thu, 28 Feb 2008 15:14:40 -0500 (EST)
In-Reply-To: <87skzd44qn.dlv@maison.homelinux.org> (Remi Vanicat's message of
 "Thu, 28 Feb 2008 13:58:40 +0100")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/75441>

Remi Vanicat <vanicat@debian.org> writes:

> Any comment on this bug fix ? It seem it was forgotten.
> I re-include it for convenience:

It is very cumbersome to apply if you "include everything
inside", so please don't do this.

Instead, send as if it is a new patch, adding Acked-by: by Alexandre
after your Signed-off-by: line.

> From 8ab57162a69c178dbc04bc4f94271e36ee9d120a Mon Sep 17 00:00:00 200=
1
> From: R=C3=A9mi Vanicat <vanicat@debian.org>
> Date: Fri, 22 Feb 2008 22:36:23 +0100
> Subject: [PATCH] git.el: find the git-status buffer whatever its name=
 is
>
> git-status used the buffer name to find git-status buffers, and that
> could failed if the buffer had another name, for example when multipl=
e
> working directories was tracked.
> ---
>  contrib/emacs/git.el |    2 +-
>  1 files changed, 1 insertions(+), 1 deletions(-)
>
> diff --git a/contrib/emacs/git.el b/contrib/emacs/git.el
> index f69b697..14a1601 100644
> --- a/contrib/emacs/git.el
> +++ b/contrib/emacs/git.el
> @@ -1545,7 +1545,7 @@ Commands:
>          (with-current-buffer buffer
>            (when (and list-buffers-directory
>                       (string-equal fulldir (expand-file-name list-bu=
ffers-directory))
> -                     (string-match "\\*git-status\\*$" (buffer-name =
buffer)))
> +		     (eq major-mode 'git-status-mode))
>              (setq found buffer))))
>        (setq list (cdr list)))
>      found))
> --=20
> 1.5.4.2.191.g7b407
>
>
> --=20
> R=C3=A9mi Vanicat
