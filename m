From: Matt Graham <mdg149@gmail.com>
Subject: Re: Git performance results on a large repository
Date: Mon, 6 Feb 2012 16:23:58 +0000
Message-ID: <CALts4TRGj1_uPX2b86GyfHHcDAUp6JSSMGmKjfS0p79DSAZ_uA@mail.gmail.com>
References: <CB5074CF.3AD7A%joshua.redstone@fb.com>
	<CACsJy8DkLCK0ZUKNz_PJazsxjsRbWVVZwjAU5n2EAjJfCYtpoQ@mail.gmail.com>
	<243C23AF01622E49BEA3F28617DBF0AD5912CA85@SC-MBX02-5.TheFacebook.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Nguyen Thai Ngoc Duy <pclouds@gmail.com>,
	"git@vger.kernel.org" <git@vger.kernel.org>
To: Joshua Redstone <joshua.redstone@fb.com>
X-From: git-owner@vger.kernel.org Mon Feb 06 17:24:05 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RuRMK-0005jk-9M
	for gcvg-git-2@plane.gmane.org; Mon, 06 Feb 2012 17:24:04 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755100Ab2BFQX7 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 6 Feb 2012 11:23:59 -0500
Received: from mail-yx0-f174.google.com ([209.85.213.174]:38596 "EHLO
	mail-yx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753003Ab2BFQX6 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 6 Feb 2012 11:23:58 -0500
Received: by yenm8 with SMTP id m8so2515420yen.19
        for <git@vger.kernel.org>; Mon, 06 Feb 2012 08:23:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        bh=3kzh2fpNEDL3aNunDCMOy+s+78VZkMBsrWjX3uiKyEc=;
        b=Wqu15EppgBNI3F9r2iBxe+W4AcgEOkZhwf/GfWHAheX8NOPtn4hwqzhXHTsNzYUzel
         e9KFUJoCfEp6J62Vm/xOAGuEHyIniBtOdcbvNp2BOrFQBBvN31h/tEwMrMGXQkXQjEhp
         WWk6lTBDgZDv57Sd+CDAwBb6U0diEdcPLP+yg=
Received: by 10.101.179.9 with SMTP id g9mr7769581anp.38.1328545438172; Mon,
 06 Feb 2012 08:23:58 -0800 (PST)
Received: by 10.146.157.21 with HTTP; Mon, 6 Feb 2012 08:23:58 -0800 (PST)
In-Reply-To: <243C23AF01622E49BEA3F28617DBF0AD5912CA85@SC-MBX02-5.TheFacebook.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/190076>

On Sat, Feb 4, 2012 at 18:05, Joshua Redstone <joshua.redstone@fb.com> =
wrote:
> [ wanted to reply to my initial msg, but wasn't subscribed to the lis=
t at time of mailing, so replying to most recent post instead ]
>
> Matt Graham: =C2=A0I don't have file stats at the moment. =C2=A0It's =
mostly code files, with a few larger data files here and there. =C2=A0 =
=C2=A0We also don't do sparse checkouts, primarily because most people =
use git (whether on top of SVN or not), which doesn't support it.


This doesn't help your original goal, but while you're still working
with git-svn, you can do sparse checkouts. Use --ignore-paths when you
do the original clone and it will filter out directories that are not
of interest.

We used this at Etsy to keep git svn checkouts manageable when we
still had a gigantic svn repo.  You've repeatedly said you don't want
to reorganize your repos but you may find this writeup informative
about how Etsy migrated to git (which included a health amount of repo
manipuation).
http://codeascraft.etsy.com/2011/12/02/moving-from-svn-to-git-in-1000-e=
asy-steps/
