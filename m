From: Chris Rorvick <chris@rorvick.com>
Subject: Re: [PATCH 1/2] Documentation/git-checkout.txt: clarify usage
Date: Mon, 17 Dec 2012 21:33:09 -0600
Message-ID: <CAEUsAPa1XMeymEXbLu=iy8VTdLO=iPUeVN3QPH+FbQecL8XnsA@mail.gmail.com>
References: <1355726702-27974-1-git-send-email-chris@rorvick.com>
	<1355726702-27974-2-git-send-email-chris@rorvick.com>
	<7vhanlnnz7.fsf@alter.siamese.dyndns.org>
	<17103971665F4C4495C6C96086A58B8F@PhilipOakley>
	<7v1ueol6ut.fsf@alter.siamese.dyndns.org>
	<CAH5451nVe1VcD3VzCO7EtKSkzv9CyJs=uqQ9MkMTJEXMTwEvmw@mail.gmail.com>
	<7vobhsjq6a.fsf@alter.siamese.dyndns.org>
	<7vvcc0i0rz.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Andrew Ardill <andrew.ardill@gmail.com>,
	Philip Oakley <philipoakley@iee.org>,
	Git List <git@vger.kernel.org>,
	Tomas Carnecky <tomas.carnecky@gmail.com>,
	Woody Wu <narkewoody@gmail.com>,
	Johannes Sixt <j.sixt@viscovery.net>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Dec 18 04:33:29 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Tknvt-0004ac-BB
	for gcvg-git-2@plane.gmane.org; Tue, 18 Dec 2012 04:33:29 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753029Ab2LRDdL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 17 Dec 2012 22:33:11 -0500
Received: from mail-lb0-f172.google.com ([209.85.217.172]:62260 "EHLO
	mail-lb0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752253Ab2LRDdK (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 17 Dec 2012 22:33:10 -0500
X-Greylist: delayed 2233 seconds by postgrey-1.27 at vger.kernel.org; Mon, 17 Dec 2012 22:33:10 EST
Received: by mail-lb0-f172.google.com with SMTP id y2so257758lbk.3
        for <git@vger.kernel.org>; Mon, 17 Dec 2012 19:33:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date
         :x-google-sender-auth:message-id:subject:from:to:cc:content-type;
        bh=UgZ4M+9Yk6eKqEvv6z5f9nA0PxBGQdfYDsfxYXekOA0=;
        b=swOxsa+CZBHjwc8EQSotRE+SqRrS5ll1CyarouSMRyyoz+EahKp4QR10umDS05fjZW
         qI5avCXurXeQIyIhk6iqn8U1W+1PD1eCUG+D5GSHbc/R4RTJJtO3a8MU7NhY/kzbfSQR
         5Bo3wmSlaG/PNk6gjLd2b1HQIL/+PIbc+0pjzWxs+PTRpoDTun85j5vgeSMHs+1QfgwO
         JZa8Yg8JjKJY8Sf+dn8gQB5Gb/FlKe3EGu9NWLioeOxZcnQ38UMrlqxC/+PGKt1sZeaJ
         7ar4DNonE48E6Ks5IKK3QeZK35BIy11c7rVPGeKfh/2eaDZfKRJev7HH6twFKsRHsOYY
         /s/A==
Received: by 10.112.101.135 with SMTP id fg7mr275982lbb.87.1355801589129; Mon,
 17 Dec 2012 19:33:09 -0800 (PST)
Received: by 10.114.94.131 with HTTP; Mon, 17 Dec 2012 19:33:09 -0800 (PST)
In-Reply-To: <7vvcc0i0rz.fsf@alter.siamese.dyndns.org>
X-Google-Sender-Auth: bnrJ5KXaeFk0XBEyT5wkEhJ6R70
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/211733>

On Mon, Dec 17, 2012 at 7:53 PM, Junio C Hamano <gitster@pobox.com> wrote:
> Here is a work-in-progress relative to Chris's 83c9989
> (Documentation/git-checkout.txt: document 70c9ac2 behavior,
> 2012-12-17).

It sounds pretty good to me.

> @@ -54,12 +61,17 @@ $ git checkout <branch>
>  that is to say, the branch is not reset/created unless "git checkout" is
>  successful.
>
> -'git checkout' [--detach] [<commit>]::
> +'git checkout' --detach [<commit>]::
> +'git checkout' <commit>::
>
> -       Update the index and working tree to reflect the specified
> -       commit and set HEAD to point directly to <commit> (see
> -       "DETACHED HEAD" section.)  Passing `--detach` forces this
> -       behavior even if <commit> is a branch.
> +       Prepare to work on top of <commit>, by detaching HEAD at it
> +       (see "DETACHED HEAD" section), and updating the index and the
> +       files in the working tree.  Local modifications to the files
> +       in the working tree are kept, so that the resulting working
> +       tree will be the state recorded in the commit plus the local
> +       modifications.
> ++
> +Passing `--detach` forces this behavior even if <commit> is a branch.
>
>  'git checkout' [-p|--patch] [<tree-ish>] [--] <pathspec>...::
>

I like Johannes' suggestion of using "<branch>" in the --detach case
instead of "<commit>" as I think it makes the reason for the
separation more obvious at a glance.  On top of your changes, maybe
something like:

--->8---
diff --git a/Documentation/git-checkout.txt b/Documentation/git-checkout.txt
index dcf1a32..4fdf41a 100644
--- a/Documentation/git-checkout.txt
+++ b/Documentation/git-checkout.txt
@@ -61,8 +61,8 @@ $ git checkout <branch>
 that is to say, the branch is not reset/created unless "git checkout" is
 successful.

-'git checkout' --detach [<commit>]::
 'git checkout' <commit>::
+'git checkout' --detach [<branch>]::

        Prepare to work on top of <commit>, by detaching HEAD at it
        (see "DETACHED HEAD" section), and updating the index and the
@@ -71,7 +71,8 @@ successful.
        tree will be the state recorded in the commit plus the local
        modifications.
 +
-Passing `--detach` forces this behavior even if <commit> is a branch.
+Passing `--detach` forces this behavior in the case of a <branch>, or
+the current branch if one is not specified.

 'git checkout' [-p|--patch] [<tree-ish>] [--] <pathspec>...::
