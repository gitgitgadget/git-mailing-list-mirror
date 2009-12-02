From: Karl Wiberg <kha@treskal.com>
Subject: Re: [StGit PATCH v2 0/6] add support for git send-email
Date: Wed, 2 Dec 2009 07:46:02 +0100
Message-ID: <b8197bcb0912012246n3b83866cjb93654effc000242@mail.gmail.com>
References: <20091202003503.7737.51579.stgit@bob.kio>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: catalin.marinas@gmail.com, git <git@vger.kernel.org>
To: Alex Chiang <achiang@hp.com>
X-From: git-owner@vger.kernel.org Wed Dec 02 07:46:23 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NFiyk-0003G9-Fs
	for gcvg-git-2@lo.gmane.org; Wed, 02 Dec 2009 07:46:22 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753893AbZLBGp7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 2 Dec 2009 01:45:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752321AbZLBGp7
	(ORCPT <rfc822;git-outgoing>); Wed, 2 Dec 2009 01:45:59 -0500
Received: from mail1.space2u.com ([62.20.1.135]:57340 "EHLO mail1.space2u.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752034AbZLBGp6 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 2 Dec 2009 01:45:58 -0500
Received: from mail-bw0-f227.google.com (mail-bw0-f227.google.com [209.85.218.227])
	(authenticated bits=0)
	by mail1.space2u.com (8.14.3/8.14.3) with ESMTP id nB26jv0D023243
	(version=TLSv1/SSLv3 cipher=DES-CBC3-SHA bits=168 verify=NOT)
	for <git@vger.kernel.org>; Wed, 2 Dec 2009 07:45:58 +0100
Received: by bwz27 with SMTP id 27so4106528bwz.21
        for <git@vger.kernel.org>; Tue, 01 Dec 2009 22:46:03 -0800 (PST)
Received: by 10.204.25.76 with SMTP id y12mr7075533bkb.13.1259736363011; Tue, 
	01 Dec 2009 22:46:03 -0800 (PST)
In-Reply-To: <20091202003503.7737.51579.stgit@bob.kio>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/134306>

On Wed, Dec 2, 2009 at 1:46 AM, Alex Chiang <achiang@hp.com> wrote:

> I also experimented with adding another test case for --git mode,
> basically duplicating t1900-mail.sh, and then adding the --git
> argument wherever it made sense.

Ah, good.

> However, that resulted in failure of the last 3 test cases, which is
> due to the fact that we no longer parse To/Cc/Bcc command line args
> in --git mode, and the resulting mbox file was missing the expected
> recipient addresses.
>
> I played around with that for a while, thinking that I could use git
> send-email --dry-run to do something equivalent, but then realized
> that git send-email's run-run mode is definitely not analogous to
> stg mail's --mbox mode.
>
> The upshot is that in stg mail, --git and --mbox don't interact
> well, and the resulting mbox file will lack the recipients. This
> might be fixed in the future if we teach git send-email how to
> generate mbox files, but then we introduce a versioning problem.

One wild idea: git send-email's --smtp-server flag will accept the
(full) path of a sendmail program; writing such a program, just
capable enough to receive the outgoing emails and dumping them to a
file, should be easy. Another option would be a program that speaks
just enough SMTP to accept the mails. (Incidentally, these two would
be useful in testing stg mail even without the --git option.)

I fully understand if you'd rather get on with scratching your actual
itch, though ...

> So let's just accept this wart for now, and say, if you want an mbox
> file generated, don't use --git. That seems reasonable to me.

Sure.

-- 
Karl Wiberg, kha@treskal.com
   subrabbit.wordpress.com
   www.treskal.com/kalle
