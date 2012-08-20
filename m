From: Florian Achleitner <florian.achleitner.2.6.31@gmail.com>
Subject: Re: t9020 broken on pu ?
Date: Mon, 20 Aug 2012 23:08:27 +0200
Message-ID: <3012698.d22asrojOq@flomedio>
References: <5032A483.4000009@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: florian.achleitner.2.6.31@gmail.com,
	Git Mailing List <git@vger.kernel.org>
To: Torsten =?ISO-8859-1?Q?B=F6gershausen?= <tboegi@web.de>
X-From: git-owner@vger.kernel.org Mon Aug 20 23:08:45 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1T3ZDF-0002Qh-6l
	for gcvg-git-2@plane.gmane.org; Mon, 20 Aug 2012 23:08:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755195Ab2HTVIh convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 20 Aug 2012 17:08:37 -0400
Received: from mail-bk0-f46.google.com ([209.85.214.46]:35840 "EHLO
	mail-bk0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754095Ab2HTVIg convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 20 Aug 2012 17:08:36 -0400
Received: by bkwj10 with SMTP id j10so1998505bkw.19
        for <git@vger.kernel.org>; Mon, 20 Aug 2012 14:08:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:user-agent:in-reply-to
         :references:mime-version:content-transfer-encoding:content-type;
        bh=wh6i4P7MX1cq+Y2MWuSiBdGBxC3KjRjJCIy+mUrDLmA=;
        b=ZI4ejcOjXoSUGw6Y9CQIsHg4QcaIgBf+MqlO3ILU8Ub48GdZEQS+T6rEDMHNjuQ4cS
         Ckgs2s94+YsNZXSAIlbHmT1WMWgANGx6bUzqOPSzsiZfDVNL+EOHyzami7Dux/NauOzh
         OXlLUTDgKOw8MddTlb/tS2/tYHVnP1xNdit05kGZu7G7LPN7oN+MqT9era84cQ2omsYx
         NyOmFF9/F7Yv9QYNPe/SaZ82ilmVy+DNQTdhNOed49LyxCSERhPNPKQBLyJpeJxyNxMa
         ZRfdIAT0M12zZpVCJwLvoOCSBMdPGdUim/yBxusyT9iBC0bsakVh9WA8T5YW7ryRWGPB
         7pig==
Received: by 10.204.128.214 with SMTP id l22mr4671460bks.86.1345496915614;
        Mon, 20 Aug 2012 14:08:35 -0700 (PDT)
Received: from flomedio.localnet (91-115-90-54.adsl.highway.telekom.at. [91.115.90.54])
        by mx.google.com with ESMTPS id gq2sm6828073bkc.13.2012.08.20.14.08.29
        (version=SSLv3 cipher=OTHER);
        Mon, 20 Aug 2012 14:08:30 -0700 (PDT)
User-Agent: KMail/4.8.4 (Linux/3.0.0-24-generic; KDE/4.8.4; x86_64; ; )
In-Reply-To: <5032A483.4000009@web.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/203875>

On Monday 20 August 2012 22:56:35 Torsten B=F6gershausen wrote:
> t9020 from pu doesn't work for me (neither linux nor Mac OS)
>=20
> I haven't been able to find out more than this:
>=20
> Initialized empty Git repository in /home/tb/projects/git/git.pu/t/tr=
ash
> directory.t9020-remote-svn/.git/
> expecting success:
>          init_git &&
>          git fetch svnsim &&
>          test_cmp .git/refs/svn/svnsim/master
> .git/refs/remotes/svnsim/master  &&
>          cp .git/refs/remotes/svnsim/master master.good
>=20
> Initialized empty Git repository in /home/tb/projects/git/git.pu/t/tr=
ash
> directory.t9020-remote-svn/.git/
> fatal: Unable to find remote helper for 'svn'
> not ok - 1 simple fetch

The reason is that contrib/svn-fe, where remote-svn is in,  is not yet =
built=20
automatically by the toplevel makefile, so the remote helper can't be f=
ound.
If you build it manually it should work.
Working on it ..
