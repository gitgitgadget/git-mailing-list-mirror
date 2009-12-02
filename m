From: Karl Wiberg <kha@treskal.com>
Subject: Re: [StGit PATCH v2 1/6] stg mail: Refactor __send_message and 
	friends
Date: Wed, 2 Dec 2009 07:53:26 +0100
Message-ID: <b8197bcb0912012253l399bb542sab141021e7ff6353@mail.gmail.com>
References: <20091202003503.7737.51579.stgit@bob.kio>
	 <20091202004605.7737.2077.stgit@bob.kio>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: catalin.marinas@gmail.com, git <git@vger.kernel.org>
To: Alex Chiang <achiang@hp.com>
X-From: git-owner@vger.kernel.org Wed Dec 02 07:53:37 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NFj5h-000582-7V
	for gcvg-git-2@lo.gmane.org; Wed, 02 Dec 2009 07:53:33 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751953AbZLBGxW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 2 Dec 2009 01:53:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751933AbZLBGxW
	(ORCPT <rfc822;git-outgoing>); Wed, 2 Dec 2009 01:53:22 -0500
Received: from mail1.space2u.com ([62.20.1.135]:57668 "EHLO mail1.space2u.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751689AbZLBGxV (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 2 Dec 2009 01:53:21 -0500
Received: from mail-bw0-f227.google.com (mail-bw0-f227.google.com [209.85.218.227])
	(authenticated bits=0)
	by mail1.space2u.com (8.14.3/8.14.3) with ESMTP id nB26rKxE032743
	(version=TLSv1/SSLv3 cipher=DES-CBC3-SHA bits=168 verify=NOT)
	for <git@vger.kernel.org>; Wed, 2 Dec 2009 07:53:21 +0100
Received: by bwz27 with SMTP id 27so4108840bwz.21
        for <git@vger.kernel.org>; Tue, 01 Dec 2009 22:53:26 -0800 (PST)
Received: by 10.204.34.201 with SMTP id m9mr7160024bkd.77.1259736806702; Tue, 
	01 Dec 2009 22:53:26 -0800 (PST)
In-Reply-To: <20091202004605.7737.2077.stgit@bob.kio>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/134307>

On Wed, Dec 2, 2009 at 1:46 AM, Alex Chiang <achiang@hp.com> wrote:

> +    if (smtppassword and not smtpuser):
> +        raise Exception('SMTP password supplied, username needed')
> +    if (smtpusetls and not smtpuser):
> +        raise Exception('SMTP over TLS requested, username needed')
> +    if (smtpuser and not smtppassword):
> +        smtppassword = getpass.getpass("Please enter SMTP password: ")

Sorry if I confused you with my earlier explanation; I only meant that
you should use the _form_ "raise Exception('message')", not that you
should change the exception type from CmdException to Exception. If
you try to trigger these errors, I think you'll find that in the case
of CmdException, StGit will print just the message and exit with an
error; whereas for straight Exception, it'll print the full backtrace
as well under the assumption that it's a program bug.

-- 
Karl Wiberg, kha@treskal.com
   subrabbit.wordpress.com
   www.treskal.com/kalle
