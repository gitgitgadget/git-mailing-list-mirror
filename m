From: Avery Pennarun <apenwarr@gmail.com>
Subject: Re: Git workflow with upstream repository
Date: Fri, 23 Jul 2010 21:24:54 -0400
Message-ID: <AANLkTik5U0oh8p42hK-871iwnTA5a66Yj-8pU4xSZS40@mail.gmail.com>
References: <AANLkTinyUGLMTQ=ruk69pptDUQ3VyaQ7CwtO+QfeJUVC@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: git@vger.kernel.org
To: Bradley Wagner <bradley.wagner@hannonhill.com>
X-From: git-owner@vger.kernel.org Sat Jul 24 03:25:24 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OcTUQ-0003jA-Im
	for gcvg-git-2@lo.gmane.org; Sat, 24 Jul 2010 03:25:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757291Ab0GXBZQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 23 Jul 2010 21:25:16 -0400
Received: from mail-ww0-f42.google.com ([74.125.82.42]:63251 "EHLO
	mail-ww0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756764Ab0GXBZP (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 23 Jul 2010 21:25:15 -0400
Received: by wwf26 with SMTP id 26so1197882wwf.1
        for <git@vger.kernel.org>; Fri, 23 Jul 2010 18:25:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:mime-version:received:in-reply-to
         :references:from:date:message-id:subject:to:cc:content-type;
        bh=eQv/Q0dPk3PSJPti7S1NMIyj+J/87/cibYiPPqbgJpg=;
        b=haMVbjmPekXluYWYnNPG0UcOWyr1ZcqRUVL16v8gXdwpUBv1nnk70bHk8TEXx87A+j
         1AJ1lqtWMeoNSD1BskIPej3Kbv54Y6nWG+emP/S4ElI4sZN1VdQeTztEb5zTiqSbuLCK
         NXO5ltxkumuoEeevn0s+SnYx1Mfdfl77boBug=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        b=OG3xBmgGm2VJmnvVaDnSDb9neZ+9IR0cQBCP0m4uZysT+qQIiSVKxzrRfVZ/l2Uovg
         i9qBtUdQYKTVb/+OQt4+I33KP34o7dgsG7YTiADJ++gPZYbGq2WI4NQHlLOTZN9mZL/2
         4oL6uY8/VUR+bpbfHGAdt4rYfuBUdRhCaRHgs=
Received: by 10.216.86.16 with SMTP id v16mr4326279wee.11.1279934714206; Fri, 
	23 Jul 2010 18:25:14 -0700 (PDT)
Received: by 10.216.235.202 with HTTP; Fri, 23 Jul 2010 18:24:54 -0700 (PDT)
In-Reply-To: <AANLkTinyUGLMTQ=ruk69pptDUQ3VyaQ7CwtO+QfeJUVC@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/151597>

On Fri, Jul 23, 2010 at 8:58 PM, Bradley Wagner
<bradley.wagner@hannonhill.com> wrote:
> If I'm working with another remote repository 'upstream' that I
> perhaps don't have permissions to and then my branches are not
> tracking against, how would I do something similar to be able to first
> see how my branch compares to the remote and then either rebase or
> pull/merge.

# show the commits in my local branch that aren't in upstream
git log upstream/master..

# show the commits in upstream that aren't in my local branch
git log ..upstream/master

# a cuter way to show the commits in upstream that aren't in my local branch
git shortlog ..upstream/master

# summarize the differences in upstream since we diverged (not
including my own changes)
git diff --stat upstream/master..

# summarize the differences between my branch and upstream (including
my changes and theirs)
# (note: three dots)
git diff --stat ...upstream/master

Have fun,

Avery
