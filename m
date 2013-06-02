From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: [PATCH 4/6] completion: correct completion for format-patch
Date: Sun, 2 Jun 2013 12:20:28 -0500
Message-ID: <CAMP44s16s3Uz6ybjYuqni9JdDX0XvG7F3z7F1cyNS2k=AqrkKQ@mail.gmail.com>
References: <1370181822-23450-1-git-send-email-artagnon@gmail.com>
	<1370181822-23450-5-git-send-email-artagnon@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git List <git@vger.kernel.org>
To: Ramkumar Ramachandra <artagnon@gmail.com>
X-From: git-owner@vger.kernel.org Sun Jun 02 19:20:43 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UjBxT-0001eK-57
	for gcvg-git-2@plane.gmane.org; Sun, 02 Jun 2013 19:20:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754562Ab3FBRUb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 2 Jun 2013 13:20:31 -0400
Received: from mail-lb0-f171.google.com ([209.85.217.171]:60197 "EHLO
	mail-lb0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754361Ab3FBRUa (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 2 Jun 2013 13:20:30 -0400
Received: by mail-lb0-f171.google.com with SMTP id v5so303836lbc.16
        for <git@vger.kernel.org>; Sun, 02 Jun 2013 10:20:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=youcWp5qSwGVTtQwDN1Fp3t+NMwprhLlZkbKuuFY3CU=;
        b=VOrllcw3qwxbJnebhUaYpMFbb5/PDeJA0lwZFcfGKAzyGD6K+lUwWEVNMr3Ilneb7p
         Amir3ejo8ZOf8/Ev7Z06dQHpeYirSjzKopOYsFogGrMr8PY1D2eYGzg3nxOK9Q+C2fRg
         cJJSKl2b0DzU4WduMSjSrfuD02VRnZzJ1XvsglAkOxq6YMhI4X3PFaaxw1USCZRp2+zq
         qlmCi7bQZzF3ZqIBLc/Ea73DJFPGiyUDHpSifGBL+3BFPs2bWynjB5U9mtqzdtBg3zyC
         1fKPSfkKLvL7h6AcF2aAwFDgsqPb8Ach5t9B5H/F0TPoxL0+SCfl9VvGwaQTSwKB2BHt
         o31w==
X-Received: by 10.112.138.131 with SMTP id qq3mr9448060lbb.46.1370193628946;
 Sun, 02 Jun 2013 10:20:28 -0700 (PDT)
Received: by 10.114.177.164 with HTTP; Sun, 2 Jun 2013 10:20:28 -0700 (PDT)
In-Reply-To: <1370181822-23450-5-git-send-email-artagnon@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/226167>

On Sun, Jun 2, 2013 at 9:03 AM, Ramkumar Ramachandra <artagnon@gmail.com> wrote:
> Currently, the completion for 'git format-patch' uses
> __git_complete_revlist.  Although this is technically correct, and you
> can
>
>   $ git format-patch master contrib
>
> where master is a ref and contrib is a pathspec, just like in 'git log',
> the usage is unidiomatic and undocumented.  'git format-patch' is used
> without pathspec filtering most of the time, and it makes sense to
> provide sensible completions using __git_refs.

This breaks 'git format-patch master..<TAB>'.

Moreover, this is a perfectly fine usage of 'git format-patch':

% git format-patch --full-diff master..fc/remote/hg-next --
contrib/remote-helpers/git-remote-bzr

Plus, even even with your patch 'contrib' will be completed regardless
(by default completion), wouldn't it?

NAK.

-- 
Felipe Contreras
