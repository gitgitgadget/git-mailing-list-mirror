From: Drew Northup <n1xim.email@gmail.com>
Subject: Re: Where should git-prompt.sh be installed?
Date: Wed, 24 Oct 2012 21:59:31 -0400
Message-ID: <CAM9Z-nnqG2Gm_9T1k25yYHWGtyS3MSBzJW31XiizsCHa=Pc59A@mail.gmail.com>
References: <1337719600-7361-1-git-send-email-felipe.contreras@gmail.com>
	<1337719600-7361-3-git-send-email-felipe.contreras@gmail.com>
	<20121025005106.GA9112@elie.Belkin>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git@vger.kernel.org, Anders Kaseorg <andersk@mit.edu>,
	Danny Yates <mail4danny@googlemail.com>,
	Felipe Contreras <felipe.contreras@gmail.com>,
	Ted Pavlic <ted@tedpavlic.com>,
	=?UTF-8?Q?SZEDER_G=C3=A1bor?= <szeder@ira.uka.de>,
	Dan McGee <dan@archlinux.org>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Thu Oct 25 03:59:49 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TRCja-0001SL-Iq
	for gcvg-git-2@plane.gmane.org; Thu, 25 Oct 2012 03:59:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759079Ab2JYB7e (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 24 Oct 2012 21:59:34 -0400
Received: from mail-bk0-f46.google.com ([209.85.214.46]:36984 "EHLO
	mail-bk0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758987Ab2JYB7d (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 24 Oct 2012 21:59:33 -0400
Received: by mail-bk0-f46.google.com with SMTP id jk13so513575bkc.19
        for <git@vger.kernel.org>; Wed, 24 Oct 2012 18:59:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=OUIMP6/MsmokVf8Ijqpwal/4HWjIOYgdCkBhnrMUR5E=;
        b=mKjFv5FZXLGbqloKQaQjIlPRAqdtMiewpwGCqTKCz0jB0mP2hTs5j+v0NZx/b0lu24
         FqZqvEGgzCMQGn1H3I74dK5Um1ZNIU9R5Q8+1QSVjO6gXDnMQpN3Sf52SrvUx8yYnF5X
         1RMkJfcdseAOY5R9sfhma3/mzYqYqawHtjKzJvam6zkyHZ3lKGc9uXONpiyb5lzoQ9BP
         QumvnxoM1Wolmktqu5ZKolu4DXGPHxzTZSKzo9cN7tiaGx3tSogd8R6HxrIImzHV3+5X
         +HdoraQ/C6H+VvI20W0Ir8dL1SIEC3NtCbnYhj6qD+/FMgbMAxekN2mBtsnl4qZHHcey
         IaYg==
Received: by 10.204.148.21 with SMTP id n21mr5593797bkv.124.1351130372184;
 Wed, 24 Oct 2012 18:59:32 -0700 (PDT)
Received: by 10.205.122.144 with HTTP; Wed, 24 Oct 2012 18:59:31 -0700 (PDT)
In-Reply-To: <20121025005106.GA9112@elie.Belkin>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/208334>

On Wed, Oct 24, 2012 at 8:51 PM, Jonathan Nieder <jrnieder@gmail.com> wrote:
> Now the sysadmin should copy
> contrib/completion/git-completion.sh to
>
>         /usr/share/bash-completion/completions/git
>
> and contrib/completion/git-prompt.sh to
>
>         /usr/share/git-core/contrib/?? (somewhere?)
>
> Mortals source /etc/bash_completion in their ~/.bashrc (possibly
> shared among multiple machines) and expect bash completion to work.
> For __git_ps1, users should source that ?? path.
>
> Questions:
>
>  1) what path is appropriate for ?? above?
>  2) is this documented anywhere?
>
> Possible answers:
>
>  1) Fedora uses /etc/profile.d/git-prompt.sh.  Gentoo uses
>     /usr/share/bash-completion/git-prompt.  Maybe others use
>     some other path.
>
>  2) The scripts themselves suggest copying to ~/.git-completion.sh
>     and ~/.git-prompt.sh.
>
> Proposal:
>
>   1) /usr/lib/git-core/git-sh-prompt
>   2) git-sh-prompt(1)
>
> Sensible?

Does the LSB provide any guidance? If not, or if such guidance isn't
helpful, I say that looks reasonable.

What I'd like to know is why we are saying "copy" when symlinking is
likely to be more easily maintainable? (Less chance to screw up.)

-- 
-Drew Northup
--------------------------------------------------------------
"As opposed to vegetable or mineral error?"
-John Pescatore, SANS NewsBites Vol. 12 Num. 59
