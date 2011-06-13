From: Dmitry Potapov <dpotapov@gmail.com>
Subject: Re: UsrClass.dat Permission denied (Windows 7)
Date: Mon, 13 Jun 2011 10:45:54 +0400
Message-ID: <BANLkTi=HOJAtHDcgf45_y3N-YvsAXQUT8g@mail.gmail.com>
References: <1307941565243-6469046.post@n2.nabble.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: git@vger.kernel.org
To: dm2000 <david.matuszak@yahoo.com>
X-From: git-owner@vger.kernel.org Mon Jun 13 08:46:03 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QW0uR-0002fq-C4
	for gcvg-git-2@lo.gmane.org; Mon, 13 Jun 2011 08:46:03 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753140Ab1FMGp4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 13 Jun 2011 02:45:56 -0400
Received: from mail-qy0-f174.google.com ([209.85.216.174]:57897 "EHLO
	mail-qy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752147Ab1FMGp4 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 13 Jun 2011 02:45:56 -0400
Received: by qyk7 with SMTP id 7so698079qyk.19
        for <git@vger.kernel.org>; Sun, 12 Jun 2011 23:45:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type;
        bh=z6IDJoXeige6UxmwlffT5IDLcOcaSY4Z/xroPD00C1A=;
        b=eVt9RPE6jOY7muYxBNpYpcUr49GvqSrr8D+hR4P3RhQgiFOoF3JVsuDT+LxWu5dcyN
         C1CzF9UF25MTTDZtxD7c7WQSjYr7MW7g94g+uzA1uhU64zAYbTlTaATsAIp9ajcnTpxM
         z0gwivDTysIQVqs3mJqmd/yK6Gmg9VM4FM3Q4=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        b=SUiQpuuK7LQlZ6hecKvBaSrCOzMJyIh+u7PDEVXJLBIhr10VgBvqhdozFMSmG0h+aB
         hqGuJrx495gAJLK+4bAPgt9kRhPdm/YTL0HH/Cgka4FoWLaiXIyDqf+Bys6azXcaamNS
         2R3muDGdvPinAIyu8tusUBAr+kqDGJNnPb4sw=
Received: by 10.229.22.138 with SMTP id n10mr3518662qcb.175.1307947555003;
 Sun, 12 Jun 2011 23:45:55 -0700 (PDT)
Received: by 10.229.191.68 with HTTP; Sun, 12 Jun 2011 23:45:54 -0700 (PDT)
In-Reply-To: <1307941565243-6469046.post@n2.nabble.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/175686>

On Mon, Jun 13, 2011 at 9:06 AM, dm2000 <david.matuszak@yahoo.com> wrote:
>
> I am studying Ruby on Rails and having problems with the initial setup of
> Git on my machine. Basically, I am trying to edit the .gitignore file.
> However, when I enter: 'git add .' it results in the following:
>
> error: open("appdata/local/microsoft/windows/usrclass.dat"): Permission
> Denied
> error: unable to index file appdata/local/microsoft/windows/usrclass.dat
> fatal: adding files failed

Why are you trying to put your whole home directory in the git repository?
Basically, it will never work, because Windows locks usrclass.dat and some
other files...

What you probably want to do is to create a new directory for your project,
initialize a new git repository in it using 'git init' and then add files
from this directory to the git repository as you did before.

In Git, usually every project has its own repository. In fact, many developers
have more than one repository for the same project. For instance, one repository
can be made public (usually it will be a 'bare' repository) and you also have
your own private repository with the working tree (i.e. non-bare repository).
In any case, every developer has their own private repository for each project.


Dmitry
