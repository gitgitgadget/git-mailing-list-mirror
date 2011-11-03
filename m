From: Bert Wesarg <bert.wesarg@googlemail.com>
Subject: Re: [PATCH 1/2] git-gui: make config gui.warndetachedcommit a boolean
Date: Thu, 3 Nov 2011 12:27:34 +0100
Message-ID: <CAKPyHN24RwNjJanaMQ0AjXc2iorFw=taCmcS-iuNt0vQ46_TOg@mail.gmail.com>
References: <0f4995b5df707782c73ec83171fb2f512ae887ef.1319312280.git.bert.wesarg@googlemail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Heiko Voigt <hvoigt@hvoigt.net>, git@vger.kernel.org,
	Bert Wesarg <bert.wesarg@googlemail.com>
To: Pat Thoyts <patthoyts@users.sourceforge.net>
X-From: git-owner@vger.kernel.org Thu Nov 03 12:36:05 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RLvaW-0001Rg-A8
	for gcvg-git-2@lo.gmane.org; Thu, 03 Nov 2011 12:36:04 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932747Ab1KCLft convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 3 Nov 2011 07:35:49 -0400
Received: from mail-vw0-f51.google.com ([209.85.212.51]:62858 "EHLO
	mail-vw0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932440Ab1KCLfr convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 3 Nov 2011 07:35:47 -0400
X-Greylist: delayed 492 seconds by postgrey-1.27 at vger.kernel.org; Thu, 03 Nov 2011 07:35:47 EDT
Received: by vwl15 with SMTP id 15so967185vwl.10
        for <git@vger.kernel.org>; Thu, 03 Nov 2011 04:35:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        bh=nNivmXOCkCzZafh9QLy0gvsGOGQy6/0UiZsAAG1EdF0=;
        b=Vnry5svNBDkITDstoiJC12auCYDf7GUuHdmFJu1AbjMU38/bhYFBnt8+EepJAHhocY
         eVyDDj9IQXMO0Ygo4QC450Du+OxEevcKtehwBcLucqNzQYTAaabxJTCuqopHF02FD4Ll
         +NxVxrovUYGPqi8ZDdSuOSVNtXRXCyHw71jDM=
Received: by 10.52.68.164 with SMTP id x4mr9268777vdt.54.1320319654834; Thu,
 03 Nov 2011 04:27:34 -0700 (PDT)
Received: by 10.52.186.36 with HTTP; Thu, 3 Nov 2011 04:27:34 -0700 (PDT)
In-Reply-To: <0f4995b5df707782c73ec83171fb2f512ae887ef.1319312280.git.bert.wesarg@googlemail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/184714>

On Sat, Oct 22, 2011 at 21:39, Bert Wesarg <bert.wesarg@googlemail.com>=
 wrote:
> Signed-off-by: Bert Wesarg <bert.wesarg@googlemail.com>
> ---
> =C2=A0lib/commit.tcl | =C2=A0 =C2=A02 +-
> =C2=A0lib/option.tcl | =C2=A0 =C2=A01 +
> =C2=A02 files changed, 2 insertions(+), 1 deletions(-)
>
> diff --git a/lib/commit.tcl b/lib/commit.tcl
> index 372bed9..e27e148 100644
> --- a/lib/commit.tcl
> +++ b/lib/commit.tcl
> @@ -263,7 +263,7 @@ proc commit_commitmsg {curHEAD msg_p} {
> =C2=A0 =C2=A0 =C2=A0 =C2=A0global is_detached repo_config
> =C2=A0 =C2=A0 =C2=A0 =C2=A0global pch_error
>
> - =C2=A0 =C2=A0 =C2=A0 if {$is_detached && $repo_config(gui.warndetac=
hedcommit)} {
> + =C2=A0 =C2=A0 =C2=A0 if {$is_detached && [is_config_true gui.warnde=
tachedcommit]} {
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0set msg [mc "Y=
ou are about to commit on a detached head.\
> =C2=A0This is a potentially dangerous thing to do because if you swit=
ch\
> =C2=A0to another branch you will loose your changes and it can be dif=
ficult\
> diff --git a/lib/option.tcl b/lib/option.tcl
> index 719103a..f7f866b 100644
> --- a/lib/option.tcl
> +++ b/lib/option.tcl
> @@ -156,6 +156,7 @@ proc do_options {} {
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0{i-0..99 gui.c=
ommitmsgwidth {mc "Commit Message Text Width"}}
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0{t gui.newbran=
chtemplate {mc "New Branch Name Template"}}
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0{c gui.encodin=
g {mc "Default File Contents Encoding"}}
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 {b gui.warndetache=
dcommit {mc "Warn before commiting to a detached head"}}
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0{s gui.stageun=
tracked {mc "Staging of untracked files"} {list "yes" "no" "ask"}}
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0} {
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0set type [lind=
ex $option 0]

Pat,

if you're interessted in this patch, please fix the typo in the second
hunk, mentioning 'commiting'.

Also shouldn't this variable be called gui.warndetachedhead?

Thanks.

Bert

> --
> 1.7.7.908.g383b5
>
>
