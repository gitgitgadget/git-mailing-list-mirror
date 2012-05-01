From: Vinnie Falco <vinnie.falco@gmail.com>
Subject: Re: git-subtree split O(N)
Date: Mon, 30 Apr 2012 20:10:07 -0700
Message-ID: <CA+EzHGcxcKt=tmrscnJ1GtiBtTFhtVO7Ae9ndx61D9piFcnq3A@mail.gmail.com>
References: <CA+EzHGfiRg+w8FsvrXEi0Yr4oVzxaZA_1JT8cmRR0YrYG7m6AQ@mail.gmail.com>
	<86aa1sr4a9.fsf@red.stonehenge.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: git@vger.kernel.org
To: "Randal L. Schwartz" <merlyn@stonehenge.com>
X-From: git-owner@vger.kernel.org Tue May 01 05:10:19 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SP3Tn-0005hW-GW
	for gcvg-git-2@plane.gmane.org; Tue, 01 May 2012 05:10:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753921Ab2EADKJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 30 Apr 2012 23:10:09 -0400
Received: from mail-qc0-f174.google.com ([209.85.216.174]:58258 "EHLO
	mail-qc0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753701Ab2EADKI (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 30 Apr 2012 23:10:08 -0400
Received: by qcro28 with SMTP id o28so1742133qcr.19
        for <git@vger.kernel.org>; Mon, 30 Apr 2012 20:10:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=dIQXu4u9/+CXIMonMfk5L61vF/nkwqJB0VQSKqse34A=;
        b=Nm/JWFBpnZ8HP3VWN/CPFzGaxtV0gtiKX8++5EucG9/zBc7NaVSSQLKnakvsbuUKw3
         PBVeCi/s8GbuG+J9KJ2ZzJ5/lc2gnCU+TIGPYjkwzmE2CKXDGp0GTGhwtzWlbgAZz5Th
         YKTIeSJs+2oen2oXZyNWRFtwau86Q4AJ82uHsQ9g3liRCvZhJNPiBZdqegbUYP5i8Ypa
         nlPwR7zsD6RvofbWZgmfX9FgaKtWQXF/OJJhSIZKsT5HFoFYc6thbz/Yh/gheSvq87V/
         hekimn1SD5qqQu+DBLtzaC7RG9Uy+gB/zLop3ohPAwhdGkcTpgIBsRlZR/QO5xe7+W6S
         BK3Q==
Received: by 10.224.212.1 with SMTP id gq1mr15746750qab.79.1335841807621; Mon,
 30 Apr 2012 20:10:07 -0700 (PDT)
Received: by 10.229.74.212 with HTTP; Mon, 30 Apr 2012 20:10:07 -0700 (PDT)
In-Reply-To: <86aa1sr4a9.fsf@red.stonehenge.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/196651>

> Vinnie> I'm using git-subtree split to extract changes to a directory
>
> Are you using -rejoin?

I am not using --rejoin. Admittedly, the documentation is somewhat
opaque on its usage:

"--rejoin:: This option is only valid for the split command."

This is confusing. One would think that an option named "rejoin" has
more to do with merge or pull than split. Although I guess the meaning
is that you want your local changes to "rejoin" the upstream?

"...future splits can search only the part of history that has been
added since the most recent --rejoin."

This sounds exactly like my use-case, I want to avoid starting from
initial commit on a split, but...

"If you do all your merges with '--squash', don't use '--rejoin' when
you split, because you don't want the subproject's history to be part
of your project anyway."

I always use --squash with git-subtree pull, so I interpreted this to
mean I should never use --rejoin.

"Unfortunately, using this option results in 'git log' showing an
extra copy of every new commit that was created"

This is what discouraged me from ever touching "--rejoin"

I hope this helps

Thanks
