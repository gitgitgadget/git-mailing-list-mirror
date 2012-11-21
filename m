From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: Topics currently in the Stalled category
Date: Wed, 21 Nov 2012 04:31:11 +0100
Message-ID: <CAMP44s30cbH5+HUxRBByk5sZGq=j_MdqLSnNzREozEk40_zbOw@mail.gmail.com>
References: <7vpq39up0m.fsf@alter.siamese.dyndns.org>
	<7vy5hvq1ey.fsf@alter.siamese.dyndns.org>
	<7vobirq0q2.fsf_-_@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Nov 21 04:31:28 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Tb127-0002tY-BA
	for gcvg-git-2@plane.gmane.org; Wed, 21 Nov 2012 04:31:27 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753640Ab2KUDbM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 20 Nov 2012 22:31:12 -0500
Received: from mail-ob0-f174.google.com ([209.85.214.174]:59034 "EHLO
	mail-ob0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753344Ab2KUDbM (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 20 Nov 2012 22:31:12 -0500
Received: by mail-ob0-f174.google.com with SMTP id wc20so6637183obb.19
        for <git@vger.kernel.org>; Tue, 20 Nov 2012 19:31:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=FUn0lqTSP4829MbwSGXObEQpaxZQNLb1tNTjDW1PbZI=;
        b=KwmkmiwBkaigp1/n013t/sEIoKbalWhaWQUpk1/uMdKkfObpc8eM2dmK3St1UGN7c2
         2W5YLaVhFW3Bgkvi9oEp+kW5e7+9cL224iggEdv6RTKZ57aoscEFhaeAAB+gLK9lh/cB
         nRykkWug7vAQPEikh2vzJLGVyPD4TQyr4SCvRUftHBkafUGoF1wXmnrzciwefztFYg53
         4VZ3xyJiIVAqJv3WWYMKGqL/ILAQrE0XaWecjwpphVrPDBPzIxFiEkXx1+FA3bx3cASo
         pp2IiJ0usjtqsctjdzsbYB00OgDLYeFOgzXde23gRyWTVjurl0PLT/J4CF6hazCKd8yI
         Az+g==
Received: by 10.60.13.138 with SMTP id h10mr3096899oec.65.1353468671444; Tue,
 20 Nov 2012 19:31:11 -0800 (PST)
Received: by 10.60.28.232 with HTTP; Tue, 20 Nov 2012 19:31:11 -0800 (PST)
In-Reply-To: <7vobirq0q2.fsf_-_@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/210132>

On Wed, Nov 21, 2012 at 1:05 AM, Junio C Hamano <gitster@pobox.com> wrote:
> Here is a list of stalled topics I am having trouble deciding what
> to do (the default is to dismiss them around feature freeze).
>
> * fc/fast-export-fixes (2012-11-08) 14 commits
>
>  Renaming of remote-testgit feels to be a mistake.  It probably
>  should keep its source in remote-testgit.bash and generate it,

Why generate it? There's nothing to generate. python's source code
needs regeneration, bash's code doesn't.

> and
>  moreover, if it wants to rename remote-testgit.py to remote-testpy,
>  the new one should be called remote-testbash.

No, remote-testbash is not testing anything that is specific to bash,
it's testing the remote helper framework itself. It could be written
in Ruby, or Python, or C, or anything.

remote-testgit.py is *not* testing the remote helper framework, it's
testing the Python-specific remote helper framework.

IOW. remote-testgit tests this:

  transport-helper.c

remote-testpy tests this:

  git_remote_helpers/Makefile
  git_remote_helpers/__init__.py
  git_remote_helpers/git/__init__.py
  git_remote_helpers/git/exporter.py
  git_remote_helpers/git/git.py
  git_remote_helpers/git/importer.py
  git_remote_helpers/git/non_local.py
  git_remote_helpers/git/repo.py
  git_remote_helpers/setup.cfg
  git_remote_helpers/setup.py
  git_remote_helpers/util.py

Cheers.

-- 
Felipe Contreras
