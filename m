From: Chris Angelico <rosuav@gmail.com>
Subject: Re: git bisect/checkout and changes to .gitignore
Date: Fri, 22 Jun 2012 22:07:52 +1000
Message-ID: <CAPTjJmqw6hC_SnWiNOfcebzu4ywWkvLNOG8pbi_D+rBnQYenMw@mail.gmail.com>
References: <CAPTjJmq4zv6dBR2Z-HfM7CJoxfprSdJEYYELuyBfahw2PkZ4Lw@mail.gmail.com>
	<4FE44983.30209@viscovery.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Jun 22 14:08:02 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Si2ef-0007Ag-3I
	for gcvg-git-2@plane.gmane.org; Fri, 22 Jun 2012 14:08:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932648Ab2FVMHx (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 22 Jun 2012 08:07:53 -0400
Received: from mail-ob0-f174.google.com ([209.85.214.174]:41938 "EHLO
	mail-ob0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932573Ab2FVMHx (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 22 Jun 2012 08:07:53 -0400
Received: by obbuo13 with SMTP id uo13so1863249obb.19
        for <git@vger.kernel.org>; Fri, 22 Jun 2012 05:07:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :content-type;
        bh=lThvOyV3aClZ+LEsqYYcofP0cFgkGZpafRMBoewnA9U=;
        b=AG+ehMVXZr/VoJ0XvkmaAf9kRrFtnj6hG+Yp8zCAibih7iQyTdwinv/w0qVMECZUbO
         Tu+133hRGUnZggzbdjLyHOQUI3clv0G08AoQSPjplUWXe9zZ2umPIrUwyU0bVy/glj0o
         NS66O7e6B7l76VcRTwXuBmV93UQrhdAl8EZ2ruvwZ7X7Buo+zdBPeOoLClA4klr0Q3ng
         HTKQLh1dqfxNAMn281ZQpCt7a1VmLFEZYRTFthFCowixbFNGGkAirOnVum+qq/q/5JFT
         eSHWpN4FviGQodM3WRXPaF0h7bxVi+moc+aNV/xGHC+BCnpa/jxT5cbD/NDF+vUlABlb
         91tg==
Received: by 10.182.18.137 with SMTP id w9mr1657894obd.75.1340366872630; Fri,
 22 Jun 2012 05:07:52 -0700 (PDT)
Received: by 10.182.232.6 with HTTP; Fri, 22 Jun 2012 05:07:52 -0700 (PDT)
In-Reply-To: <4FE44983.30209@viscovery.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/200434>

On Fri, Jun 22, 2012 at 8:31 PM, Johannes Sixt <j.sixt@viscovery.net> wrote:
> Files mentioned in .gitignore are considered garbage. But your file is
> precious, hence, you should not list it in .gitignore.

An important distinction! Thanks for the thread pointer.

The --no-overwrite-ignore flag is part of what I want. It at least
gives protection against accidentally losing things (on Wednesday, I
unwittingly disposed of several large binary files, and didn't even
know about it until a chance discovery of directory size). Is there a
way to specify that this flag always be used, even when the checkout
doesn't happen on the command line but through (eg) git bisect?

Chris Angelico
