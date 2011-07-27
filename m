From: John Szakmeister <john@szakmeister.net>
Subject: Re: [RFC/PATCH] commit: allow partial commits with relative paths
Date: Wed, 27 Jul 2011 06:19:45 -0400
Message-ID: <CAEBDL5XJbYT9yczZiVPpeA3mpROuKQdw+-AOJjUmRp4W6M5uzg@mail.gmail.com>
References: <CAOnWdohKfwEOMx=wr_PKiW+ucYBK2ZWykm_7dqr7hy4xGRM02A@mail.gmail.com>
	<19b908142567fcfafe4da3d0fd60b134d30c613a.1311579663.git.git@drmicha.warpmail.net>
	<7v8vrmrxok.fsf@alter.siamese.dyndns.org>
	<4E2FCAC4.7020408@drmicha.warpmail.net>
	<CAOnWdojgxZNs4qyEG55URScqOGb6k5e6Mh_B3By6Lj6SpN9L9g@mail.gmail.com>
	<4E2FE024.2030204@drmicha.warpmail.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Reuben Thomas <rrt@sc3d.org>, Junio C Hamano <gitster@pobox.com>,
	git@vger.kernel.org
To: Michael J Gruber <git@drmicha.warpmail.net>
X-From: git-owner@vger.kernel.org Wed Jul 27 12:19:53 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Qm1DU-0000v2-Ob
	for gcvg-git-2@lo.gmane.org; Wed, 27 Jul 2011 12:19:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754270Ab1G0KTs (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 27 Jul 2011 06:19:48 -0400
Received: from mail-vw0-f46.google.com ([209.85.212.46]:48987 "EHLO
	mail-vw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752100Ab1G0KTq (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 27 Jul 2011 06:19:46 -0400
Received: by vws1 with SMTP id 1so977521vws.19
        for <git@vger.kernel.org>; Wed, 27 Jul 2011 03:19:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:sender:in-reply-to:references:date
         :x-google-sender-auth:message-id:subject:from:to:cc:content-type;
        bh=z2EQpOICBokqDl/aB7yh1Vg+aNbtcVqmtPv0QZczKtw=;
        b=U3PHB1TDFxMgPXcxyPUKpVahIq2eq6IitugLf+HEDNqXDfonpE1gDOa9RZeJZr6NKM
         WZaV82Ac4ZycJv9EC5j3tDtg42uP24pTvIeyoYUq+/I0bBgQiMTDWVnObVDmV4VAAgIQ
         2Uf4lgQHkAdZGApqIwNayFtM80jIPzB0cdob0=
Received: by 10.52.19.145 with SMTP id f17mr6848109vde.323.1311761986009; Wed,
 27 Jul 2011 03:19:46 -0700 (PDT)
Received: by 10.52.183.228 with HTTP; Wed, 27 Jul 2011 03:19:45 -0700 (PDT)
In-Reply-To: <4E2FE024.2030204@drmicha.warpmail.net>
X-Google-Sender-Auth: v5qOA6rkjIrPj3RwtR6bIePzJRY
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/177961>

On Wed, Jul 27, 2011 at 5:53 AM, Michael J Gruber
<git@drmicha.warpmail.net> wrote:
[snip]
> I can't reproduce that name truncation with a current git, btw. (So I
> won't bother bisecting where we removed a spurious offset by "prefix".)

I can:

:: git --version
git version 1.7.6.347.g4db0d
:: git init reproduce-bug
Initialized empty Git repository in /Users/jszakmeister/tmp/reproduce-bug/.git/
:: cd reproduce-bug
:: echo foo > foo.txt
:: mkdir bar
:: echo bar bar/bar.txt
bar bar/bar.txt
:: git add .
:: git commit -m '.'
[master (root-commit) a5f76f1] .
 2 files changed, 2 insertions(+), 0 deletions(-)
 create mode 100644 bar/bar.txt
 create mode 100644 foo.txt
:: cd bar
:: git rm ../foo.txt
rm 'foo.txt'
:: git commit ../foo.txt
error: pathspec 'txt' did not match any file(s) known to git.

-John
