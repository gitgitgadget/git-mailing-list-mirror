From: Nazri Ramliy <ayiehere@gmail.com>
Subject: Re: Why are submodules not automatically handled by default or at
 least configurable to do so?
Date: Wed, 28 Oct 2015 15:36:11 +0800
Message-ID: <CAEY4ZpNrvF3-aLYpoN1+Qi-ZcFUqh_t8QrVpWqqgnEHqF4_cOQ@mail.gmail.com>
References: <D4E5E890658.000004DCjohsmi9933@inbox.com>
	<CAEY4ZpPduXXqgW3rWn9rzkpHrTvY8QfPX=YcBZ_DpyVwnsZ6jw@mail.gmail.com>
	<562E5B41.9090801@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: John Smith <johsmi9933@inbox.com>,
	Git Mailing List <git@vger.kernel.org>
To: Jens Lehmann <Jens.Lehmann@web.de>
X-From: git-owner@vger.kernel.org Wed Oct 28 08:36:19 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZrLHM-0005n1-M2
	for gcvg-git-2@plane.gmane.org; Wed, 28 Oct 2015 08:36:17 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755411AbbJ1HgM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 28 Oct 2015 03:36:12 -0400
Received: from mail-pa0-f67.google.com ([209.85.220.67]:36848 "EHLO
	mail-pa0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752109AbbJ1HgL (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 28 Oct 2015 03:36:11 -0400
Received: by pacik9 with SMTP id ik9so27440726pac.3
        for <git@vger.kernel.org>; Wed, 28 Oct 2015 00:36:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=SaAcP8+tX4zFpOR7RN11k3D5zDyUvplfqM9a9UTWqrU=;
        b=HycMUaGFydbleoLXkjxr3xOlso3hvJ2aGrE/gIqCZxPMV/pkjAxidfuIqZgc9zjzBV
         MYOHsUPDwB2zM07jvnFqTB+a7Sl0TQIWX9CeeHppaHVDxAA3ryo1Gw7j+C7gemVJ9L/o
         CDOzUz4eNo6KOzr1AKcEh4YL7gLHfZT7Y/qdL+gBAMOXqcP3sGhNgutuqRaz3CNNY0gN
         4jNTZxqcZo0fFSU+b9VJAKsWxo6l39BmlM88dUkq2BKdQNfuNAdXlMlfAgwYb1QL4XYT
         VmOLkseUEPJ+mSnMYgrdOqF5hyBvYnV2iaVfqrRW8zkT9r6Df+Yy92b8KHQKPXtYS6TA
         Us+w==
X-Received: by 10.68.254.170 with SMTP id aj10mr33111655pbd.97.1446017771384;
 Wed, 28 Oct 2015 00:36:11 -0700 (PDT)
Received: by 10.66.199.72 with HTTP; Wed, 28 Oct 2015 00:36:11 -0700 (PDT)
In-Reply-To: <562E5B41.9090801@web.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/280356>

On Tue, Oct 27, 2015 at 12:56 AM, Jens Lehmann <Jens.Lehmann@web.de> wrote:
> Which seems a bit error prone as you could forget to update the submodules
> and build incorrect rpms from them, or am I missing something?

For my case I'm not building the rpms directly after merging in the fixes
done in the octopus branch, so I don't care much about the state of the
submodules after the merge since I know that the octopus branch does
not modify any submodules. The rpms are built later on, possibly on
another machine where the submodules are updated w.r.t to each branch
in a release commit.

> I understand why you don't need to update the submodules every time, but
> would it hurt your workflow if they did (but don't get me wrong, that will
> always be configurable).

I'd say it depends - for the times when all I want to do is work on plain files
in the superproject (on an octopus branch for example) I don't want git to
automatically update the submodules everytime I switch branches - it would
hurt my productivity as there will be more disk activities due to files being
checked out unnecessarily for updating the submodules.

The submodule states are not committed that often into the superproject,
they are done normally when we're cutting a new release. During day-to-day
development each developer runs a script that pulls in the latest commits
for "hot" submodules.

git not updating the submodule state automatically is actually a convenient
for my particular use case here.

nazri
