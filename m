From: Angelo Borsotti <angelo.borsotti@gmail.com>
Subject: Re: erratic behavior commit --allow-empty
Date: Wed, 3 Oct 2012 10:24:00 +0200
Message-ID: <CAB9Jk9DFb2s4s00yCNUytxFdrOQKPEKZGsXpKzwZDo5WAOdXaQ@mail.gmail.com>
References: <CAB9Jk9BynCunFHRFhGKoyDA-qof1iu6w952sAgSs2_JWb8+U3A@mail.gmail.com>
	<506AA51E.9010209@viscovery.net>
	<7vzk449449.fsf@alter.siamese.dyndns.org>
	<CAB9Jk9CSW0ObJtgsfSwjf+k438=V8i7dP0p+YUehqdh2Z0k6tA@mail.gmail.com>
	<7vhaqc7in6.fsf@alter.siamese.dyndns.org>
	<CAB9Jk9D-eJ8goYx7LWqGcWcLgRDS8+qLZVUsvvJ+QOtryP9-zg@mail.gmail.com>
	<90464C79DA97415C9D66846A77ECAA4A@PhilipOakley>
	<CAB9Jk9ARWnE-cWVjqMUFiua21QjqGEX3VhYjKQMBSotVYXXK1Q@mail.gmail.com>
	<vpq626s6kwu.fsf@grenoble-inp.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Philip Oakley <philipoakley@iee.org>,
	Junio C Hamano <gitster@pobox.com>,
	Johannes Sixt <j.sixt@viscovery.net>, git <git@vger.kernel.org>
To: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
X-From: git-owner@vger.kernel.org Wed Oct 03 10:24:49 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TJKFi-0007UO-DZ
	for gcvg-git-2@plane.gmane.org; Wed, 03 Oct 2012 10:24:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756038Ab2JCIYG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 3 Oct 2012 04:24:06 -0400
Received: from mail-vc0-f174.google.com ([209.85.220.174]:38963 "EHLO
	mail-vc0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753216Ab2JCIYB (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 3 Oct 2012 04:24:01 -0400
Received: by vcbfo13 with SMTP id fo13so7939271vcb.19
        for <git@vger.kernel.org>; Wed, 03 Oct 2012 01:24:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=7WIIVKSekSORBeOywfCfc0YZwHJtY4jIznN3ShVWPmo=;
        b=Cheiw62MHCAeQg2IpiO0FbJynAO1sQcBtxvozNGfUsBI5P/9hHqItcVdnJYnUJN+pM
         VGnUhbpKUKFkwwKx81stOL5KZ5NCDRMwMOjkJ/JG2Z/PzP9Hunk53mtUldLfVbbPEXMN
         UG2jjcQPQmlsdXeh5znaXDLB35KMpZPm71sEsJP4cWbL7EHs5AlQTtH/UJJIpgXtOuYl
         VqzU2qJEpBZF9iGAoVpzXXeEwUem9YKQ221nPOX+oHH70IV2F9XRu9KhHPfD+yoE41Vv
         7FbQ/NQckRekaHqbTK2xO/OxTZBjZ455k006+ltZv0G8+3pozABS0t5aw/kVLKxyanPO
         T0gA==
Received: by 10.52.21.81 with SMTP id t17mr562196vde.97.1349252640573; Wed, 03
 Oct 2012 01:24:00 -0700 (PDT)
Received: by 10.58.68.40 with HTTP; Wed, 3 Oct 2012 01:24:00 -0700 (PDT)
In-Reply-To: <vpq626s6kwu.fsf@grenoble-inp.fr>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/206871>

Hi Matthiew,

> Then the second commit does not "create" a new blob object for
> file2.txt, because it has the same content as an existing one. But the
> point is: you really don't care, or indeed, you care about sharing the
> blob objects to save disk space.

That is fine, and it is well documented.

> It is predictible: give it twice the same inputs in the same conditions,
> and it will yield the same output.

Well, I have some difficulties to hit the return key while watching the system
clock at the same time so as to make sure that the command is executed
before the seconds change. So, it theory it would be predictable, but not
in practice. Note that commands must be predictable for the user that writes
them, i.e. the user must be able to figure out what the result is. Which is
certainly not the case here.

>
> You still didn't tell us where the problem was.

I described it few mails above. I wanted to create an orphan branch. The command
to create it is git checkout --orphan. However, the branch is not
actually created
until a commit is done on it. Then I did such a commit (all this is
placed in a script
to be used by my developers), but if there are no changes, git commit does not
create a new one. To force it to create a brand new one I added
--allow-empty to it
because the man page stated that it would bypass the check that prevents to make
a new one. The I discovered that sometimes --allow-empty does not behave as
expected.


-Angelo
