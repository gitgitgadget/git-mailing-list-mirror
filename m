From: Jean Privat <jean.privat@gmail.com>
Subject: Re: [RFC] teach --edit to git rebase
Date: Tue, 11 Oct 2011 18:36:45 -0400
Message-ID: <CAMQw0oO+eGxOX=347G0vZPe1uf-SyGGnT1Ku7cykgv4PQK1ZVQ@mail.gmail.com>
References: <CAMQw0oOBEjW3yS2+wcktXDuEuUiHKjfbK2qDzKvBOiwxo7Zkow@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Oct 12 00:37:38 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RDkx7-0003hP-9K
	for gcvg-git-2@lo.gmane.org; Wed, 12 Oct 2011 00:37:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751548Ab1JKWh3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 11 Oct 2011 18:37:29 -0400
Received: from mail-ey0-f174.google.com ([209.85.215.174]:43524 "EHLO
	mail-ey0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750922Ab1JKWh0 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 11 Oct 2011 18:37:26 -0400
Received: by eye27 with SMTP id 27so117041eye.19
        for <git@vger.kernel.org>; Tue, 11 Oct 2011 15:37:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :content-type;
        bh=ytNoi4TRtHYA3u/M4Ckd6ddwOoGm9VzZOf/m7OFwDGk=;
        b=UQqzFcDbs+mXvaFhHeth2Yl2GuIGYM1imRkqJLUxS4oIOADc9pdmdIg7iwliwhEdfb
         ReNehIfbHkJkr+k6htvMjEiVuFIp5TQYo0fpvdstE/qFzNLxbSYrGobEJ0QEkEKohqoQ
         UoR0+OrQbUfBFok3VMVT/nuFWCOxO5KGGqzKU=
Received: by 10.223.5.139 with SMTP id 11mr42274695fav.21.1318372645204; Tue,
 11 Oct 2011 15:37:25 -0700 (PDT)
Received: by 10.223.79.3 with HTTP; Tue, 11 Oct 2011 15:36:45 -0700 (PDT)
In-Reply-To: <CAMQw0oOBEjW3yS2+wcktXDuEuUiHKjfbK2qDzKvBOiwxo7Zkow@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/183333>

> An other alternative is to use a simple git alias for myself (and do
> not bother the git community) but I do not know how to automatize the
> command 'git rebase --interactive' I suppose I need more complex
> infrastructure in the existing 'git rebase' (Maybe I did not look
> enough and there is a way to do it with a git alias).

Hum. I just found that I can do something like :

[alias]
        edit=!GIT_EDITOR='sed -i -e 1s/pick/edit/ --' git rebase -i
-no-autosquash $1^

The main thing that bothers me is that after the rebase, the head is
detached (why?)

The other thing is that the error messages for invalid usages are far
for perfect

$ git edit toto
fatal: Needed a single revision
invalid upstream toto^

$ git edit --root toto
error: unknown option `root^'
usage: git rebase [-i] [options] [--onto <newbase>] [<upstream>] [<branch>]
[...]

-Jean
