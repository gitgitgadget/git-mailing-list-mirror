From: Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [GSoC14][RFC] Is there any interest in adding a port of
 checkpatch.pl to contrib/?
Date: Tue, 18 Mar 2014 00:40:13 -0400
Message-ID: <CAPig+cQPZrHf_Bm_s_qmP6nX2dKcFNi+EUKoPObXHn1novuaHw@mail.gmail.com>
References: <CAL0uuq0RWpWPa2TOk09xE9SjG0-Z=EAMG2iQ9Y0z_XMYvRsJ3g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Git Mailing List <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>,
	Michael Haggerty <mhagger@alum.mit.edu>
To: Jacopo Notarstefano <jacopo.notarstefano@gmail.com>
X-From: git-owner@vger.kernel.org Tue Mar 18 05:40:58 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WPlpg-0001tV-I6
	for gcvg-git-2@plane.gmane.org; Tue, 18 Mar 2014 05:40:56 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750881AbaCREkP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 18 Mar 2014 00:40:15 -0400
Received: from mail-yh0-f47.google.com ([209.85.213.47]:61914 "EHLO
	mail-yh0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750815AbaCREkO (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 18 Mar 2014 00:40:14 -0400
Received: by mail-yh0-f47.google.com with SMTP id 29so6364558yhl.34
        for <git@vger.kernel.org>; Mon, 17 Mar 2014 21:40:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc:content-type;
        bh=BEqSEAygxBFU3+NvfxCIxr71b5YagAiopnzNZ4FFivo=;
        b=0qmXdgDyjCNOvU3vjyw1Rj102aDgD/jPG+cREvkfOdF6iUREXlWzJEQP7k/WMaCth3
         r8027HcVquoWA2JB8+ryxy7JjCbLzADZ1vEyqrJatcUKtCS16jA5b5d/7juxkexOL+nJ
         GZusaFP0L8M2SFUphSAAmAWeC0GjFHxi4V3j9EsQ356er1G9igraNQIiuuX/KXF0VVLx
         saRkfkHiy7OBSJLkWHpfHZlPw/MHA5YGVV8ODZlrgg0UPEE1+2EYFoqxCKPX3qrW1r9H
         USTHPJBVRKoMJPyQow1N509YhLsHNeMZsLpvWieQu4ag5TAO6MkpSP9NM1apvXtAT+dX
         b/PA==
X-Received: by 10.236.5.174 with SMTP id 34mr15491437yhl.48.1395117613591;
 Mon, 17 Mar 2014 21:40:13 -0700 (PDT)
Received: by 10.170.180.134 with HTTP; Mon, 17 Mar 2014 21:40:13 -0700 (PDT)
In-Reply-To: <CAL0uuq0RWpWPa2TOk09xE9SjG0-Z=EAMG2iQ9Y0z_XMYvRsJ3g@mail.gmail.com>
X-Google-Sender-Auth: yvTY1CRYgQXCJxe9cNJuJJvY6Vw
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/244326>

On Mon, Mar 17, 2014 at 9:38 PM, Jacopo Notarstefano
<jacopo.notarstefano@gmail.com> wrote:
> It seems to me that the topic of adding the checkpatch.pl script to
> Git's source tree has cropped up several times in the past, as
> recently as a couple of days ago: $gmane/243607.
>
> It should be noted that its usage for its sake has been discouraged by
> Junio Hamano in $gmane/205998.

In the referenced message, Junio says that he often runs checkpatch.pl
on incoming patches.

> Also, its use is somewhat controversial
> and has led to flames and even a public fork.
>
> Despite this, I think that git might benefit from a port of
> checkpatch.pl. In fact, even Junio had admitted to use part of its
> features later in $gmane/205998.
>
> We could simply use linux's script/checkpatch.pl, but I think a port
> is needed for these reasons:
>
> 1. Git style guidelines are somewhat different and less strict than
> their Linux equivalents.

Are checkpatch.pl's customization options, such as --ignore,
insufficient to make it behave in the desired fashion for git?

> 2. Several patch threads bounce back and forth because of style fixes.
> A checkpatch script added as a hook could help reduce these and use
> more efficiently our time.
> 3. As far as I can tell, checkpatch needs to be run from the root
> folder of a linux repository clone. Cloning several hundred MBs for a
> single perl script looks a little foolish to me.

No need to clone the kernel. checkpatch.pl runs fine standalone with
the --no-tree option.

> So, is there any interest in adding a port of checkpatch.pl to
> contrib/? I might work on this as part of GSoC. I still haven't
> submitted my application about git bisect (life got in the way!), but
> Michael Heggarty remarked in $gmane/242703 that my original idea had
> too little meat in it to constitute a good GSoC proposal.
>
> Cheers,
> Jacopo Notarstefano
