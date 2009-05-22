From: Dan Loewenherz <dloewenherz@gmail.com>
Subject: Re: can anybody explain the following to a git noob?
Date: Fri, 22 May 2009 09:36:52 -0400
Message-ID: <20090522133652.GA8689@andros.its.yale.edu>
References: <855e4dcf0905212046o3e1d6ec6l487829a0a411dcaf@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Cc: git@vger.kernel.org
To: Tim Uckun <timuckun@gmail.com>
X-From: git-owner@vger.kernel.org Fri May 22 15:37:26 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1M7Uw9-0006wa-OK
	for gcvg-git-2@gmane.org; Fri, 22 May 2009 15:37:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756353AbZEVNhF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 22 May 2009 09:37:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756116AbZEVNhE
	(ORCPT <rfc822;git-outgoing>); Fri, 22 May 2009 09:37:04 -0400
Received: from qw-out-2122.google.com ([74.125.92.25]:51847 "EHLO
	qw-out-2122.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755847AbZEVNhC (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 22 May 2009 09:37:02 -0400
Received: by qw-out-2122.google.com with SMTP id 5so1206808qwd.37
        for <git@vger.kernel.org>; Fri, 22 May 2009 06:37:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:mail-followup-to:references:mime-version:content-type
         :content-disposition:in-reply-to:x-os:user-agent;
        bh=t/8Wa6ApuryFMuSoLOw3g+fEZGB/CHioCGnSkXSKIbQ=;
        b=dU6npRItGYQvdEVm0G0OwZeF1RKahr45zRyChsCJQVLQoIZsGT0oY1ft24dZBi5HqV
         RUds+K5wPutmgcmOokSANINRBz3GSp+LqIcUsvlYRg5lNTLlPHR8H4JwwP+Iy63YKCqs
         1TPi2NVdTiY/3yRoYnFNnunry5YSES0e23LCM=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:mail-followup-to:references
         :mime-version:content-type:content-disposition:in-reply-to:x-os
         :user-agent;
        b=xv/E56r/uls8yRBCin16+BsLAKJy70d5CNOoC99YhrnQODB9QOUZIo5S3mctp5L0XA
         sQu053ZyYj3VYLD+0BK0RXQOzBAtSdS1rZK4zTjBu2bJFKn6d801CVRMc0Uptx+diyH3
         UTiEKfvc2N6WNXp9a7yMShUUZ/FoqwzejwvbE=
Received: by 10.224.61.12 with SMTP id r12mr3845465qah.311.1242999416352;
        Fri, 22 May 2009 06:36:56 -0700 (PDT)
Received: from andros.its.yale.edu (yale128036066239.student.yale.edu [128.36.66.239])
        by mx.google.com with ESMTPS id 8sm3419019qwj.41.2009.05.22.06.36.54
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Fri, 22 May 2009 06:36:55 -0700 (PDT)
Mail-Followup-To: Tim Uckun <timuckun@gmail.com>, git@vger.kernel.org
Content-Disposition: inline
In-Reply-To: <855e4dcf0905212046o3e1d6ec6l487829a0a411dcaf@mail.gmail.com>
X-OS: Darwin andros 9.7.0 i386
User-Agent: Mutt/1.5.19 (2009-01-05)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/119730>

It would be nice if instead of a transcript, you provided us with a script
that duplicated your problem instead of having everyone on the git-list play
20 questions.

In any case, I'm going to try and explain what's going on.

On 22/05/09 15:46 +1200, Tim Uckun wrote:
>git mv vendor vendor_new
>fatal: source directory is empty, source=vendor/plugins/acts_as_audited,
>destination=vendor_new/plugins/acts_as_audited

Try reading `man git-mv`. "...it renames <source>, which must exist...".

>ls vendor/plugins/acts_as_audited/
>CHANGELOG  generators  init.rb  lib  LICENSE  Rakefile  README  spec  tasks
>test.txt

What was this `ls` for? Also, next time try doing `ls -a` so people know
what hidden files exist.

>ls test
>fixtures  functional  integration  mocks  test_helper.rb  unit  watir

Again, `ls -a`.

>git mv test test_new
>git commit -m 'renamed the test directory'

Where is `git add .`?? Additionally, you must specific the `-a` flag on `git
commit` to apply the commit to files you removed.

>********Checkout master. WTF?: Both the test and the test_new directories
>exist. Why does the test_new exist in this branch?
>git checkout master
>ls
>app  Capfile  config  db  doc  lib  MyProject.kpf  public  Rakefile  README
>script  test  test_new  tmp  vendor

This is because you didn't commit the deletion of test. I can't speak to
anything else. It's like telling you to change your tires when the engine
has disintegrated.

Best,
Dan
