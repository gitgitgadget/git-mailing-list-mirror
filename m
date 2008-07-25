From: "Thomas Adam" <thomas.adam22@gmail.com>
Subject: Re: Submodules: Publishing a locally created submodule.
Date: Fri, 25 Jul 2008 01:05:44 +0100
Message-ID: <18071eea0807241705j1359bc7ei46d74540d9090f6d@mail.gmail.com>
References: <18071eea0807240840g79da962ci8fbc65546d496323@mail.gmail.com>
	 <48891088.40709@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: "git mailing list" <git@vger.kernel.org>
To: "Mark Levedahl" <mlevedahl@gmail.com>
X-From: git-owner@vger.kernel.org Fri Jul 25 02:06:57 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KMApl-0004UM-EG
	for gcvg-git-2@gmane.org; Fri, 25 Jul 2008 02:06:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752271AbYGYAFr (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 24 Jul 2008 20:05:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752299AbYGYAFq
	(ORCPT <rfc822;git-outgoing>); Thu, 24 Jul 2008 20:05:46 -0400
Received: from wf-out-1314.google.com ([209.85.200.168]:5745 "EHLO
	wf-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752271AbYGYAFp (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 24 Jul 2008 20:05:45 -0400
Received: by wf-out-1314.google.com with SMTP id 27so3742330wfd.4
        for <git@vger.kernel.org>; Thu, 24 Jul 2008 17:05:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to
         :subject:cc:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:references;
        bh=Ket4Tu/1qQr6D3qurcTypIM/HjNHqQ6ZHnwDyXNokGQ=;
        b=LrMjGlmFDjkGVdIh+KbnKcS7oC+gHtY6/NOnDUociqRnEYRSk3+XxjC10nbnqqHJsr
         phPz5E6NRrq0xesEfgp81dxpfXmOQA4IynttU2REt2dpxsM5n+VETb73i1MtyBdRk6I9
         DT2iOkW/GU6LxhvfSRZvHnDrI2elcRwZKKHMc=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version
         :content-type:content-transfer-encoding:content-disposition
         :references;
        b=MrXyESAvxgSet2z9i8ZgF8biK8dGRgAQsith5V1boinoW78S5Lqv78FW0m89atdZDF
         0JnIfFtG2LN6Pmul/c3qe+HYAk0lTK2iFz7myzLj/MXYyhOrU9uHYNk/kwHWRhJT06rq
         E7B9IBbkzAqKftQwCp/uZB6qhTH6cq3XQq5gU=
Received: by 10.142.44.11 with SMTP id r11mr305222wfr.285.1216944344206;
        Thu, 24 Jul 2008 17:05:44 -0700 (PDT)
Received: by 10.142.104.15 with HTTP; Thu, 24 Jul 2008 17:05:44 -0700 (PDT)
In-Reply-To: <48891088.40709@gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/89978>

Hello --

2008/7/25 Mark Levedahl <mlevedahl@gmail.com>:
> git submodule add <URL where this will exist> ./mysubmoduleB
>
> will recognize that mysubmoduleB is already a valid git repo and add it as
> is at the current location to the superproject.

Ah -- now that was missing from the documentation (the syntax; not the
intention.)  Thanks.

It seems my brain has turned to mush so I need to go back to square
one and verify the steps for this are accurate.  If I am doing this
arse-about-face, do say.  ;)

I've mentioned I am using a bare repository which is shared amongst
developers.  We've been using one fine for normal development and for
various reaons I am creating a new repository to be filled with
submodules.  I shall call this "SM".

Our "superproject" is a directory hierarchy with interspersed files.
On the server I did this:

server% cd /usr/src/SM
server% git init
server% cd ./superproject
server% git init
server% git add .
server% git commit -m "Initial checkin"
server% cd ..
server% git submodule add /path/to/usr/src/SM
server% git commit -a -m "Submodules..."

Then cloned a bare repo from that which I was able to clone locally
and do stuff in.  I could push stuff out too for that one project.
But how from this clone do I then publish any further submodules I
might create locally?  I can't very well do so directly in my checkout
-- it has no concept of where the submodules are.  I could go to the
server, add another directory as a submodule (as I've done with
"superproject" above --- but then any changes under /usr/src/SM on the
server are local -- the bare repo has no knowledge of any changes made
there.

Does this even make sense?   ;)

Thanks in advance.

-- Thomas Adam
