From: Stefan Beller <sbeller@google.com>
Subject: Re: git fails updating submodule only if --quiet is specified
Date: Tue, 22 Mar 2016 14:38:34 -0700
Message-ID: <CAGZ79kb0izRAZoQaDxTjKNz0VFEBqbkCSmro2pHm_kmLpJk0mw@mail.gmail.com>
References: <3E1D841C-7665-43DB-A0F8-99999C59C28D@googlemail.com>
	<219B1DC5-8379-4FD5-8739-D99890362769@googlemail.com>
	<CAGZ79kZaV3w5TM+FPORcFOdeCY8idCYV_yB4Vt5eSNVrNomp2w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: "git@vger.kernel.org" <git@vger.kernel.org>
To: Marcus T <maddimax@googlemail.com>
X-From: git-owner@vger.kernel.org Tue Mar 22 22:38:47 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aiU0l-0007DI-Cq
	for gcvg-git-2@plane.gmane.org; Tue, 22 Mar 2016 22:38:47 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752489AbcCVVim (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 22 Mar 2016 17:38:42 -0400
Received: from mail-yw0-f177.google.com ([209.85.161.177]:36838 "EHLO
	mail-yw0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752387AbcCVVik (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 22 Mar 2016 17:38:40 -0400
Received: by mail-yw0-f177.google.com with SMTP id g3so271874069ywa.3
        for <git@vger.kernel.org>; Tue, 22 Mar 2016 14:38:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc;
        bh=mKi3ZazTBSH87m5OB5NnTqmU+afcCVphsoKJWeodm94=;
        b=L3e4TP8tpQYn9oKLuP1FMJXcTrpJAkVcrVEoJY/eQbuYbmrMwMt76oWo3V5SRsFGYH
         zTYG8MsFaD3DnNxQ40bOOzAsUFPV/5+eMY6nEHqVK207AmU3KMBlIcNLzUXCwGii3jzf
         jZr1RQe0Utte1Id2TYAFZLUy9yInzNPEgiEmBueAzPw8IWTePowGWg7Db9smfODBWiIh
         UUtBFXcZcMMxRpgWueKGO4j0dCD/T8Ok8ljlWyajI9GPvmIr5LAe8oXEfZh1szm8XOE6
         sE8CXUEGxJdpXz/kQKZ5ECWJ/Dv0q8fYi+BFP4/mpC2CFqH5JIoUJ2Fyru5UcwmPXNbz
         frmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc;
        bh=mKi3ZazTBSH87m5OB5NnTqmU+afcCVphsoKJWeodm94=;
        b=JMLv2Iv1odfUQxL8lyG1lirwH9Wx3+IKce/YtRPLl5jeFX6L+U2g9vDr1wvBGxsURO
         808VIoS9DmHXcjVdbMxCRE7U019ZaYrU8IxS702AY0H7n8Eam0c0mQgU9et+Ct54k6t4
         aLND23h6qX/m2ta4UsTobobdXFn83X0L94iF0QQiH2cc6WlznxN9fw71f71Tb93hYfcq
         Xc3y+JLpd0idK6UMgqUpPXMM6fN2i0H3Xf2JmeS3FQOq2Bsrbk3P/QBcrEuEPS1t/9e7
         1E06/sZ75ruB71ri4hpBkUgOjyCjE9KstfFR+GaD1UheG5fYxHdYpTClzM1/2UlTHPck
         sb+Q==
X-Gm-Message-State: AD7BkJIK+A4/IOyZ1aZLfRQkJyvPCnTbO3+QbvaijfuLUxiS5Btmpfdcm1sSmcaMlRL1Owux2GXl/cg4eV29oh72
X-Received: by 10.129.49.200 with SMTP id x191mr17591361ywx.176.1458682714725;
 Tue, 22 Mar 2016 14:38:34 -0700 (PDT)
Received: by 10.37.51.137 with HTTP; Tue, 22 Mar 2016 14:38:34 -0700 (PDT)
In-Reply-To: <CAGZ79kZaV3w5TM+FPORcFOdeCY8idCYV_yB4Vt5eSNVrNomp2w@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/289568>

On Tue, Mar 22, 2016 at 11:22 AM, Stefan Beller <sbeller@google.com> wrote:
> However lookingat your logs, I would suspect it is an error in git
> clone instead, as that is the
> last command which has the --quiet flag passed through the stack.

git clone --no-checkout --quiet --separate-git-dir tmp_gitdir
git://git.busybox.net/buildroot tmp_workdir
fails as a standalone program as well, so let's debug that.
