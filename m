From: Pat Thoyts <patthoyts@gmail.com>
Subject: Re: [PATCH 1/2] git-gui: fix deleting item from all_remotes variable
Date: Sun, 13 Feb 2011 13:20:14 +0000
Message-ID: <AANLkTi=hY1XpBNfhNDfM8kwgnitQXN-97mM-dkhCpTac@mail.gmail.com>
References: <20110212164344.GA19433@book.hvoigt.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Pat Thoyts <patthoyts@googlemail.com>, git@vger.kernel.org,
	Jens Lehmann <jens.lehmann@web.de>
To: Heiko Voigt <hvoigt@hvoigt.net>
X-From: git-owner@vger.kernel.org Sun Feb 13 14:20:34 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PobsP-0008Vl-F9
	for gcvg-git-2@lo.gmane.org; Sun, 13 Feb 2011 14:20:33 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754350Ab1BMNUS convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 13 Feb 2011 08:20:18 -0500
Received: from mail-bw0-f46.google.com ([209.85.214.46]:61043 "EHLO
	mail-bw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753960Ab1BMNUQ convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 13 Feb 2011 08:20:16 -0500
Received: by bwz15 with SMTP id 15so4666594bwz.19
        for <git@vger.kernel.org>; Sun, 13 Feb 2011 05:20:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=01sWqlNgzPew6W+iqSDfhD1z7u/2j4oYCSzd+lFjNiA=;
        b=Bs/NiXov8vANxvO97/exVkP3sNmf8Xw5CqBn4Uue2FxkG8YaXOHkKEBa2vZ1oSWp3a
         eXvbbwrDUIXRWu+28ZUnJtlcS57QINiAo6gomBrU0fgZicqGATpUTqLmNiTXK0reifKC
         QHl9IfDwVDhKEcLauRWlZDk+tWYD7oaO17jLg=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=iZA5fUmSs6ofnlM1cyMgBWP3988XL2zwuw5LkRlyVfp1WRBv0rInqXNuD7yWr4ct10
         HdAZ8SDIe6gXMkK3+nH6ttMApUqyI3GX0wdEgUW9IlfM5VgS4goBIG0RmWDQDU7X5Xuy
         hBIcZaf0aB1s7pW+725reu7X7KiBgCKejESb8=
Received: by 10.204.71.20 with SMTP id f20mr1856663bkj.139.1297603215015; Sun,
 13 Feb 2011 05:20:15 -0800 (PST)
Received: by 10.204.118.12 with HTTP; Sun, 13 Feb 2011 05:20:14 -0800 (PST)
In-Reply-To: <20110212164344.GA19433@book.hvoigt.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/166664>

On 12 February 2011 16:43, Heiko Voigt <hvoigt@hvoigt.net> wrote:
> lsearch and lreplace both take the variable content as argument and n=
ot
> just their name.
>
> Signed-off-by: Heiko Voigt <heiko.voigt@mahr.de>
> ---
> =C2=A0lib/remote.tcl | =C2=A0 =C2=A04 ++--
> =C2=A01 files changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/lib/remote.tcl b/lib/remote.tcl
> index b92b429..1383e97 100644
> --- a/lib/remote.tcl
> +++ b/lib/remote.tcl
> @@ -264,8 +264,8 @@ proc remove_remote {name} {
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0unset repo_con=
fig(remote.$name.push)
> =C2=A0 =C2=A0 =C2=A0 =C2=A0}
>
> - =C2=A0 =C2=A0 =C2=A0 set i [lsearch -exact all_remotes $name]
> - =C2=A0 =C2=A0 =C2=A0 lreplace all_remotes $i $i
> + =C2=A0 =C2=A0 =C2=A0 set i [lsearch -exact $all_remotes $name]
> + =C2=A0 =C2=A0 =C2=A0 set all_remotes [lreplace $all_remotes $i $i]
>
> =C2=A0 =C2=A0 =C2=A0 =C2=A0set remote_m .mbar.remote
> =C2=A0 =C2=A0 =C2=A0 =C2=A0delete_from_menu $remote_m.fetch $name
> --
> 1.7.4.34.gd2cb1
>
>
This fix is good and clearly resolves a bug in the tcl code --
however, what does it actually fix in the application? It looks like
removing a remote works anyway even though this variable is not being
updated.
Pat Thoyts
