From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: Re: [PATCH 1/2] pull: respect rebase.autostash
Date: Fri, 14 Jun 2013 16:11:58 +0530
Message-ID: <CALkWK0n4QXsRNQxiSfeoPRdwp6kva8V08oG0h9Ld7TpBTgKDKA@mail.gmail.com>
References: <1371200178-9927-1-git-send-email-artagnon@gmail.com>
 <1371200178-9927-2-git-send-email-artagnon@gmail.com> <vpqfvwlkqb5.fsf@anie.imag.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>
To: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
X-From: git-owner@vger.kernel.org Fri Jun 14 12:42:59 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UnRT9-0007s7-Fg
	for gcvg-git-2@plane.gmane.org; Fri, 14 Jun 2013 12:42:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751497Ab3FNKmm (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 14 Jun 2013 06:42:42 -0400
Received: from mail-ie0-f174.google.com ([209.85.223.174]:46657 "EHLO
	mail-ie0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751126Ab3FNKml (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 14 Jun 2013 06:42:41 -0400
Received: by mail-ie0-f174.google.com with SMTP id 9so1002049iec.33
        for <git@vger.kernel.org>; Fri, 14 Jun 2013 03:42:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=8AVQZbO1aHqn3zvGVTdTrMipDHA1n6gJx66V4p/YCas=;
        b=oCsy3CuwATMcwjDlVAc/blY6ejjLypF41pakS8+1/ubME2HG1d0grK57pDg5oLWDav
         TuQN2A6aV+oGtcNaxVd2TwUk1p1u9t0z4ZrOU5Z+dxS/fqXIdsbARx+ABgNlx9Up7jLt
         xUAkpCqJjMMIQR956sKX2FINjYZ7UZtn/5eFxVWuP9vXjv3aiUTdckeSoJUg7/wQX52R
         c++OzJt0SpRmk5mR3VzE4/fhp34AERjqVcW90tDG1wWdK3JjXb/Ah9C18okj52fVi6Wn
         Zb9gVlz2qQVD1AiI/ACkfWpbZM8rTtFqC0LCiYnJrW/tBZ2kOsxhxCbmPlazzfcWNxTK
         r2Sw==
X-Received: by 10.50.56.20 with SMTP id w20mr704731igp.40.1371206560990; Fri,
 14 Jun 2013 03:42:40 -0700 (PDT)
Received: by 10.64.129.97 with HTTP; Fri, 14 Jun 2013 03:41:58 -0700 (PDT)
In-Reply-To: <vpqfvwlkqb5.fsf@anie.imag.fr>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/227809>

Matthieu Moy wrote:
> It would be nice to have an --autostash command-line option too,

I thought it would be a bit ugly, since it's already overloaded with
options to pass to merge.

> and the
> error message in "require_clean_work_tree" could suggest using it. That
> would make the feature easily discoverable.

Cannot pull with rebase: You have unstaged changes.
Please commit or stash them.  See also: rebase.autostash in git-config(1).

> Perhaps this patch could mention "pull --rebase" in the doc, like (config.txt)

--- a/Documentation/git-pull.txt
+++ b/Documentation/git-pull.txt
@@ -112,5 +112,6 @@ include::merge-options.txt[]
 See `pull.rebase`, `branch.<name>.rebase` and `branch.autosetuprebase` in
 linkgit:git-config[1] if you want to make `git pull` always use
-`--rebase` instead of merging.
+`--rebase` instead of merging.  See `rebase.autostash` in
+linkgit:git-config[1] if you want to be able to run on a dirty worktree.
 +

Thanks.
