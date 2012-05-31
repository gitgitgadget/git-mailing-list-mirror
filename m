From: Sitaram Chamarty <sitaramc@gmail.com>
Subject: Re: How to handle terminal detection in a daemon calling git?
Date: Thu, 31 May 2012 08:44:25 +0530
Message-ID: <CAMK1S_gmzgNZeJgywFaghYHH1enG=eoEnmiFhdWB0nq0iKUk3Q@mail.gmail.com>
References: <1338412607.9452.140661082904349.02F677C3@webmail.messagingengine.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Travis P <git@castle.fastmail.fm>
X-From: git-owner@vger.kernel.org Thu May 31 05:14:47 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SZvqY-0003wI-1e
	for gcvg-git-2@plane.gmane.org; Thu, 31 May 2012 05:14:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756136Ab2EaDO2 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 30 May 2012 23:14:28 -0400
Received: from mail-ob0-f174.google.com ([209.85.214.174]:36985 "EHLO
	mail-ob0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756042Ab2EaDO0 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 30 May 2012 23:14:26 -0400
Received: by obbtb18 with SMTP id tb18so701493obb.19
        for <git@vger.kernel.org>; Wed, 30 May 2012 20:14:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        bh=ZVE+eD6oPb0xqJ2hBTLICG/8asfQLtJDdoV9Lfh6Rl4=;
        b=0MDNehApBLArre6TVUeY2dyMxWWhMPFlY3o729gvuZ7wa5YEK6FPWGRROA/V3ArIYU
         VsyRlfX8b3rpg0uZy/modRb6wtDcQd4BWcFYMbM6kiMZRDZPVwwDcHKgFDKxvi+DWGHn
         FtmA5HCqGtIwAZrSmYOGdvBmidVdSpBqZAeEtic2hWJoNs7ZhvMvcHVkOlsXwicZsueW
         mLNzELWCecfEN2BM35rQXGvs7A8VEfar3Bg1MVRExCy/58IApw/xmGNhNeSILhj6t0/k
         ffArcJQg/nF9mSm593HGjoIp269ObDhzN62LRuEwrxQPfuqmm+I/08mzT/V6uDo+GJ1X
         35Xg==
Received: by 10.182.39.5 with SMTP id l5mr17279525obk.11.1338434065994; Wed,
 30 May 2012 20:14:25 -0700 (PDT)
Received: by 10.182.108.67 with HTTP; Wed, 30 May 2012 20:14:25 -0700 (PDT)
In-Reply-To: <1338412607.9452.140661082904349.02F677C3@webmail.messagingengine.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/198857>

On Thu, May 31, 2012 at 2:46 AM, Travis P <git@castle.fastmail.fm> wrot=
e:
>
> I've got a script that runs in the background without a terminal.
> It actually does have STDOUT and STDERR set to a rotating log file.
>
> When it runs:
> =C2=A0/bin/sh -c 'cd /to/my/wc; git pull --ff-only'
> the git command fails (rc 32768).
>
> When it runs
> =C2=A0/bin/sh -c 'cd /to/my/wc; git pull --ff-only > /to/a/file 2>&1'
>
> or even
> =C2=A0/bin/sh -c 'cd /to/my/wc; git pull --ff-only | cat'
>
> then all is well. =C2=A0The command succeeds (rc 0, and I see the exp=
ected
> results).
>
> Piping through 'cat' is okay, but I'd rather avoid the 'trick'. =C2=A0=
Is
> there
> some way to communicate to git that it should operate just as if outp=
ut
> were redirected?

would "git --no-pager" help?  Honestly I don't know why your first
error occurred at all -- they should all have worked, IMO.
