From: Manlio Perillo <manlio.perillo@gmail.com>
Subject: Re: [PATCH] git-completion.bash: add support for path completion
Date: Thu, 20 Dec 2012 00:50:22 +0100
Message-ID: <50D252BE.1070808@gmail.com>
References: <1355693080-4765-1-git-send-email-manlio.perillo@gmail.com> <7vy5gxnuy1.fsf@alter.siamese.dyndns.org> <50CEFF3A.4050802@gmail.com> <7vzk1clb3n.fsf@alter.siamese.dyndns.org> <50D23960.4070108@gmail.com> <7vy5gt7j3c.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Dec 20 00:57:22 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TlTVk-0007rb-Mf
	for gcvg-git-2@plane.gmane.org; Thu, 20 Dec 2012 00:57:17 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751944Ab2LSX4y (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 19 Dec 2012 18:56:54 -0500
Received: from mail-ee0-f51.google.com ([74.125.83.51]:46299 "EHLO
	mail-ee0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751527Ab2LSX4t (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 19 Dec 2012 18:56:49 -0500
X-Greylist: delayed 380 seconds by postgrey-1.27 at vger.kernel.org; Wed, 19 Dec 2012 18:56:49 EST
Received: by mail-ee0-f51.google.com with SMTP id d4so1357248eek.24
        for <git@vger.kernel.org>; Wed, 19 Dec 2012 15:56:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:message-id:date:from:user-agent:mime-version:to:cc
         :subject:references:in-reply-to:x-enigmail-version:content-type
         :content-transfer-encoding;
        bh=JD7Pkep4qAXYxNMqGl893HywGkFMAfx4b7uwFPUGJb4=;
        b=G+NQ/TdKWYjgTq1kFDJF2L4PGwLcg50yrP4m+9hhI+E8PJ/vQiUVIsfBh41VPkz2Op
         Qu8sQ/bUZPYV9eEXdMTzwzPwGaWcLKVDU/Z3DMZA+u6/Ou3/tBCfrwbX79r1eO+/dYB1
         rkIabItJAR+fsPd+phJ8FljW0rw4yn+ANyP3gusR8BfB2/N9PSob8x9qQlgjseH1X4b3
         qIo9XoDueNGkAI/G4Z6fBjvUd6VQaiHzIjeP3wPc6/YLFSGlmatmzq5ZgXvvPH2+0dtR
         R+KGg593slDeT7E4M/RtaSh79lIrKj9eUn6DDNqedtDdF3WvhvuAu2cYmTwr+rI6Y3sJ
         txRQ==
X-Received: by 10.14.203.8 with SMTP id e8mr18364186eeo.2.1355961028115;
        Wed, 19 Dec 2012 15:50:28 -0800 (PST)
Received: from [192.168.0.3] ([151.70.213.162])
        by mx.google.com with ESMTPS id l3sm12065508eem.14.2012.12.19.15.50.26
        (version=TLSv1/SSLv3 cipher=OTHER);
        Wed, 19 Dec 2012 15:50:27 -0800 (PST)
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.9.1.16) Gecko/20121216 Icedove/3.0.11
In-Reply-To: <7vy5gt7j3c.fsf@alter.siamese.dyndns.org>
X-Enigmail-Version: 1.0.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/211866>

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Il 19/12/2012 23:49, Junio C Hamano ha scritto:
> Manlio Perillo <manlio.perillo@gmail.com> writes:
> 
>>> 	git mv COPYING README X
>>
>> Assuming X is a new untracked directory, do you think it is an usability
>> problem if an user try to do:
>>
>> 	git mv COPYING README <TAB>
>>
>> and X does not appear in the completion list?
> 
> It is hard to say.  Will it show "Documentation/" in the list?  Will
> it show "git.c" in the list?
> 

Currently all cached files will be showed.

> Your "git mv git.<TAB>" completing to "git mv git.c" would be an
> improvement compared to the stock "less git.<TAB>" that offers
> "git.c" and "git.o" as choices.  For things like "mv" and "rm", this
> may not make too much of a difference, "git add <TAB>" would be a
> vast improvement from the stock one.  The users will notice that the
> completion knows what it is doing, and will come to depend on it.
> 

Yes, this is precisely the reason why I'm implementing it ;-).

I also use Mercurial (I discovered Git just a few weeks ago, after
reading Pro Git), and Mercurial do have path completion (completion list
does not stop at directory boundary, however).

When I started to use Git, one of the first thing I noticed was the lack
of path completion for git add.

> [...]
> In the ideal world (read: I am *not* saying "you should implement it
> this way, or we won't look at your patch"), I think you would want
> to show tracked files (because it may be the third path that the
> user wants to move with the command, not the destination directory)
> and any directory on the filesystem (it could be the third path that
> is being moved if it has tracked files, or it could be the final
> destination directory argument).

What about this?

* show all and only cached files for the first argument
* show all cached + untracked directories and files for all other
  arguments

This should solve most of the problem, and will still not show ignored
files.  And, most important, it is very easy to implement.


The only issue is that "git ls-files -o" does not show empty
directories, and "git ls-files --directory -o" will add a trailing slash.



Thanks   Manlio
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org/

iEYEARECAAYFAlDSUr4ACgkQscQJ24LbaURf0gCeJVZviwfKHgHNZ8vYBjnjwP8+
WF4AnAn3/KPJciJg9r387qIzCajx4j0s
=/10k
-----END PGP SIGNATURE-----
