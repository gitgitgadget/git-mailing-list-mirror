From: Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: Log messages beginning # and git rebase -i
Date: Mon, 27 Jul 2015 19:25:16 -0400
Message-ID: <CAPig+cRT6=YCHz+phfE+84y27ey-6ScjPxP2cHiVqumJmR6mOw@mail.gmail.com>
References: <loom.20150727T133256-715@post.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git List <git@vger.kernel.org>
To: Ed Avis <eda@waniasset.com>
X-From: git-owner@vger.kernel.org Tue Jul 28 01:25:36 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZJrlw-0000YP-84
	for gcvg-git-2@plane.gmane.org; Tue, 28 Jul 2015 01:25:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754842AbbG0XZU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 27 Jul 2015 19:25:20 -0400
Received: from mail-yk0-f181.google.com ([209.85.160.181]:35315 "EHLO
	mail-yk0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754828AbbG0XZR (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 27 Jul 2015 19:25:17 -0400
Received: by ykdu72 with SMTP id u72so82272897ykd.2
        for <git@vger.kernel.org>; Mon, 27 Jul 2015 16:25:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc:content-type;
        bh=ITqSBWZj8TVNhRQTzt+SI1yUvwPASSS2RzKN4epo9qg=;
        b=GNremcLWwEDgOL8fZhvs75dq4a0PgjbHrL2r3Mh60SDO0xrc1BBXMQW0YPH438SuhS
         G30voHL0+tFAeM+dKMXcjP3P31k/eA+NJJg2FHIhcr6jyDrFR+b+eKlmo4mvUoj39qFj
         UFltclE3b+Bf27LTg0eNvFsvxFZuhau3eSwLHC0DGw+WFhiczqQCWG1n06asuRejzCgX
         cyJb9ZJ8aDUaO7yd9GW4HlagSLWB4zMda5YIWdbAdIs0/5DYJRdiP87F84FDJD7mTnSW
         NH3BHiApPTVMfCwL1gvJwTheTJJVK+nzegFoemqLk++c1KizkGUm7dcD9I4EBhebunUt
         Yprw==
X-Received: by 10.13.207.1 with SMTP id r1mr33472400ywd.166.1438039516781;
 Mon, 27 Jul 2015 16:25:16 -0700 (PDT)
Received: by 10.37.12.129 with HTTP; Mon, 27 Jul 2015 16:25:16 -0700 (PDT)
In-Reply-To: <loom.20150727T133256-715@post.gmane.org>
X-Google-Sender-Auth: h_KrTTZ2p-v3CcJxq8AK8M9EBW8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/274721>

On Mon, Jul 27, 2015 at 7:38 AM, Ed Avis <eda@waniasset.com> wrote:
> git commit will happily let you specify log messages beginning with #.
> But then on git rebase -i, when squashing some commits, the editing for the
> combined log message treats lines beginning with # as comments.  This means
> that if you are not careful the commit message can get lost on rebasing.
>
> I suggest that git rebase should add an extra space at the start of existing
> log message lines which begin with #.  That is a bit of a kludge but it is
> better than losing them because they got mixed up with comments.

'git rebase --interactive' respects the core.commentChar configuration
variable, which you can set to some value other than '#'.
