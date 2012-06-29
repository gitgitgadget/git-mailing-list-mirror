From: Richard Hartmann <richih.mailinglist@gmail.com>
Subject: Re: git submodule vs GIT_WORK_TREE
Date: Fri, 29 Jun 2012 10:43:05 +0200
Message-ID: <CAD77+gSyhR+4vdv3dEVSuEvyt7mT9ojT-F2BrwTL4FsXpNFeHA@mail.gmail.com>
References: <CAD77+gTVLsEOgWo+WDafzNOYOwSZQ2KkgBuibBXemVmGu_Fzgw@mail.gmail.com>
 <7vobo6cazk.fsf@alter.siamese.dyndns.org> <4FE9FF0C.8050409@web.de>
 <7vobo5c0n0.fsf@alter.siamese.dyndns.org> <4FEA380D.8070001@web.de> <7vzk7p8z38.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Jens Lehmann <Jens.Lehmann@web.de>, Git List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Jun 29 10:43:33 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SkWnd-0004UK-17
	for gcvg-git-2@plane.gmane.org; Fri, 29 Jun 2012 10:43:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752336Ab2F2In2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 29 Jun 2012 04:43:28 -0400
Received: from mail-yw0-f42.google.com ([209.85.213.42]:42540 "EHLO
	mail-yw0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751652Ab2F2In0 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 29 Jun 2012 04:43:26 -0400
Received: by yhfq11 with SMTP id q11so3531239yhf.1
        for <git@vger.kernel.org>; Fri, 29 Jun 2012 01:43:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=qK+nPsdEhGn9cDroOPW2di0UY7YK7jIIFISRxKWuvEg=;
        b=Q50VQFsEwopxvs4EoIMiQDoAisparh5v9MiFC0T2UATjA0wDJkRpyymgroQcdicg0r
         GulY/0c62QMEGa+a6YxziQ6wgto9g3cBKgoMHWa6MqJKiZ4fBkV8LxJ6fHrPN++zG237
         rpLeUR2QanOrFDGO2cpCWfE6ITNNF/Cj9wOafXxcuZeepol4vEFbE9pDWj4evoZbyfcI
         lUv1q5D0RRMWCJ0zciNoI8QjSbYtLEfKMeOZH5bOmsb6gwEUKuQLcadcDI3Di5D4jgza
         g5h+pD9p5XfS1+dXMQW2mBGaaAepw1tYOhi8Jul/ChYANDOsv33qRpmfBRmBFnADGPra
         4P2w==
Received: by 10.50.181.232 with SMTP id dz8mr419582igc.36.1340959405461; Fri,
 29 Jun 2012 01:43:25 -0700 (PDT)
Received: by 10.50.135.97 with HTTP; Fri, 29 Jun 2012 01:43:05 -0700 (PDT)
In-Reply-To: <7vzk7p8z38.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/200810>

Mangling the email I respond to out of order.

On Wed, Jun 27, 2012 at 12:53 AM, Junio C Hamano <gitster@pobox.com> wrote:

> but I
> am not sure if that is too restrictive for people who for some
> unknown reason want to use these environment variables to create
> repositories with a strange layout.

This is exactly the point. For vcsh[1] to work, I need to set it up like this:

    richih@titanium  ~ % vcsh enter zsh
    richih@titanium [zsh] [2] (git)-[master] ~ % echo $GIT_WORK_TREE
    /home/richih
    richih@titanium [zsh] [2] (git)-[master] ~ % echo $GIT_DIR
    /home/richih/.config/vcsh/repo.d/zsh.git
    richih@titanium [zsh] [2] (git)-[master] ~ %


> Declaring that a checked out submodule _must_ have its controlling
> repository as ".git" at its root level, i.e. it should be accessible
> without using GIT_WORK_TREE/GIT_DIR at all just like a normal Git
> repository is, would be a clean way to avoid the issue altogether
> and it still will allow the top-level superproject to be structured
> in a funny way to require GIT_WORK_TREE/GIT_DIR to access it,

I fear this would make vcsh unable to support submodules, ever.



Richard

[1] https://github.com/RichiH/vcsh
