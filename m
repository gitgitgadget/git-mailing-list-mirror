From: Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: bug in bash completion for git-branch --set-upstream-to on OSX
Date: Sat, 21 Mar 2015 23:24:45 -0400
Message-ID: <CAPig+cRYQfSNvyCXJc2a4wFAsZ8S4v3zvc5K5-fW+guepMeVPg@mail.gmail.com>
References: <CAKNmmv3wu-5s9UB_RFO5Wptdo+a71Lmzn2Zs4kb=MwnFoTctCg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git List <git@vger.kernel.org>
To: Jason Karns <karns.17@gmail.com>
X-From: git-owner@vger.kernel.org Sun Mar 22 04:24:54 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YZWVP-0005bg-0i
	for gcvg-git-2@plane.gmane.org; Sun, 22 Mar 2015 04:24:51 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751798AbbCVDYr (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 21 Mar 2015 23:24:47 -0400
Received: from mail-yh0-f46.google.com ([209.85.213.46]:35452 "EHLO
	mail-yh0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751609AbbCVDYq (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 21 Mar 2015 23:24:46 -0400
Received: by yhim52 with SMTP id m52so27039965yhi.2
        for <git@vger.kernel.org>; Sat, 21 Mar 2015 20:24:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc:content-type;
        bh=zyBW7GZ1KZJJGE+u40Fu9QizncHyQzfSeYw3KqBeIVM=;
        b=PztlajT8uTYoNTYAyf2JdOY6FFxhNtUVclr8LelvDhJFQMVifzUY03BszHzLMtuJhM
         wmi/5s5bDln678JEhTUC/pBRGiV+O64iYdm7LEKyLdMhFWC0VbqZi57shg9qTVeLaCGQ
         R7KBRGUpQr9U78+RvuJGiPQkkXjOJn/Yd7RXlJkDHIOhHW78Jpn3PapG/IzhNbH47WBZ
         qkH0b4sTAOYHgW3jA50no9UaOm6wu5eVgHZvyySHPAn0m4vslqfMtGdpVujzzhAe+pAp
         uYjJ8jcbfH7nWJynBh8ZPLdeT7+LwUQg1KiEsGyKsMCnNOVmkoDhezZvoBxvjiDzYeqc
         qZJw==
X-Received: by 10.170.194.7 with SMTP id l7mr65431735yke.91.1426994685482;
 Sat, 21 Mar 2015 20:24:45 -0700 (PDT)
Received: by 10.170.73.7 with HTTP; Sat, 21 Mar 2015 20:24:45 -0700 (PDT)
In-Reply-To: <CAKNmmv3wu-5s9UB_RFO5Wptdo+a71Lmzn2Zs4kb=MwnFoTctCg@mail.gmail.com>
X-Google-Sender-Auth: pn-vmvPFSP8OEc1rbi-GhMEWox4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/266041>

On Fri, Mar 20, 2015 at 11:15 AM, Jason Karns <karns.17@gmail.com> wrote:
> There appears to be a bug in the bash completion for git-branch when
> attempting to complete the remote ref argument for --set-upstream-to=
>
> When:
>
> $ git branch --set-upstream-to=origin/mast<TAB>
>
> I would expect it to complete to:
>
> $ git branch --set-upstream-to=origin/master
>
> However, the completion for --set-upstream-to= completes the ref
> correctly, but completely wipes the --set-upstream option; resulting
> in:
>
> $ git branch origin/master
>
> I'm running on OS X 10.9.5 with git from homebrew:
> $ bash --version
> GNU bash, version 4.3.33(1)-release (x86_64-apple-darwin13.4.0)

Presumably, your bash is also from homebrew? Stock OS X bash tends to
be quite a bit older.

> $ git --version
> git version 2.3.3

I'm unable to reproduce this problem using git 2.3.3 and bash 4.3.33.

> The same behavior does *not* manifest (it works as expected) on CentOS
> 6.5, bash 4.1.2.1 (GNU bash, version 4.1.2(1)-release
> (x86_64-redhat-linux-gnu)). I'm running git 2.0.3 on CentOs but
> sourcing the shell completion script from latest source: 9ab698f
>
> I also cloned down latest git source on OS X and the bug still
> manifests when sourcing the completion script at 9ab698f.

Perhaps something in your bash startup script(s) is causing a strange
interaction.
