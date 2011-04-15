From: Alex Riesen <raa.lkml@gmail.com>
Subject: Re: Commit hashes differ from local and remote
Date: Fri, 15 Apr 2011 17:26:01 +0200
Message-ID: <BANLkTinEJkLbZRc+=wMUaBRKq=xpxYhk3Q@mail.gmail.com>
References: <BANLkTimhx1tN7EzU94bpKK64P1F8P7MG0g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git mailing list <git@vger.kernel.org>
To: Arthur Debert <arthur@stimuli.com.br>
X-From: git-owner@vger.kernel.org Fri Apr 15 17:26:33 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QAkum-0006b2-47
	for gcvg-git-2@lo.gmane.org; Fri, 15 Apr 2011 17:26:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755083Ab1DOP0Y (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 15 Apr 2011 11:26:24 -0400
Received: from mail-bw0-f46.google.com ([209.85.214.46]:39749 "EHLO
	mail-bw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754105Ab1DOP0W (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 15 Apr 2011 11:26:22 -0400
Received: by bwz15 with SMTP id 15so2273367bwz.19
        for <git@vger.kernel.org>; Fri, 15 Apr 2011 08:26:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-type;
        bh=iWBbt7tvUxQsy5H9FUfUYndjLemI28/fnUVrDtpHA/0=;
        b=gfhkI4wWy01dmRK6aGuuZkcFR4rq6bJK7WgyICJtnCJhmiKTvwVPhrc8Aba7fdhlCq
         cf19OBgd2qmqAvgfIBdWZaJabaptZrqawnQm/kbU0OmS1cXmzV0cO5wQ0lc7G2PQEPJv
         yXcRlJpUhQr0n6viKkgeVoWgJyJFjF9v4My5M=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        b=H3Bph9kmZjATsl3WvBcVNiHba3uWUkgW6t7/aYP1vFYz8NlYFzYadLoGEoJU9JNLkx
         nphpbLieFngE7WOST0ZCingSnpN4TBjMVKrcq0930MAHfIO5YzDYcjhn4R+o5b9Elb+O
         QbkWeFnqJnfV02MpnpTE4yBX/hIqSfzMJ8YIU=
Received: by 10.204.84.166 with SMTP id j38mr1736678bkl.84.1302881181158; Fri,
 15 Apr 2011 08:26:21 -0700 (PDT)
Received: by 10.204.29.2 with HTTP; Fri, 15 Apr 2011 08:26:01 -0700 (PDT)
In-Reply-To: <BANLkTimhx1tN7EzU94bpKK64P1F8P7MG0g@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/171612>

On Wed, Apr 13, 2011 at 21:38, Arthur Debert <arthur@stimuli.com.br> wrote:
> Hi Folks.
>
> I'm seeing some behavior that my git-fu isn't quite capable of explaining.
>
> On a local branch the last commit has a hash different than the remote
> branch it is tracking from. Nothing has been committed locally and
> doing:
> $ git diff branch-name origin/branch-name
> Comes up empty
> git pull also says my branch is already up to date.
>
> It seems that git pull has generated a bogus commit (a merge commit),

git pull is designed to create merge commits, if needed.
In your case both branches just have the same content,
for whatever reason.

You probably want to specify "--ff-only" (only fast-forwards) to all
your pulls to achieve what you seem to want.
