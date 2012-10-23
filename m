From: Shawn Pearce <spearce@spearce.org>
Subject: Re: Git push slowly under 1000M/s network
Date: Tue, 23 Oct 2012 10:09:35 -0700
Message-ID: <CAJo=hJuGksy7pzzy7-7eTUxNmtT9qR2xCPxSfYO58_8SohFjxQ@mail.gmail.com>
References: <CAKOmCvp23fALGsDe4Ck7ZXpMJmOAq+YWCXPe_xb6GfQcjJi_kQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: git@vger.kernel.org
To: Joey Jiao <joey.jiaojg@gmail.com>
X-From: git-owner@vger.kernel.org Tue Oct 23 19:10:10 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TQhzW-0005yn-5M
	for gcvg-git-2@plane.gmane.org; Tue, 23 Oct 2012 19:10:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755421Ab2JWRJ5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 23 Oct 2012 13:09:57 -0400
Received: from mail-qa0-f46.google.com ([209.85.216.46]:56829 "EHLO
	mail-qa0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754731Ab2JWRJ4 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 23 Oct 2012 13:09:56 -0400
Received: by mail-qa0-f46.google.com with SMTP id c26so2034019qad.19
        for <git@vger.kernel.org>; Tue, 23 Oct 2012 10:09:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=spearce.org; s=google;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=qzDI+r8Zq4zmWsQdwnr3THMvpT7XCJ1BdnRAfCXCy34=;
        b=A4lKA80f2fmTlmr3uaH4BEblnfrTbDn5ziRoaoP6wiLj8X4OMx9oKl3eMC/+XRJbC8
         JC77hzUsNEVG3t624lSHTVXQEvJwPucvHKar1gM3AafHG9opLnqzhKdzAcuO0KPQoemY
         dpoN/83C2McWwQjFGur3BCEyBruQqjKyI0KR4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:x-gm-message-state;
        bh=qzDI+r8Zq4zmWsQdwnr3THMvpT7XCJ1BdnRAfCXCy34=;
        b=YWlteThPsgkWL1DLF+UmMqkpcYi7F98eb2pUBUlx5F+cm1+GiazBMQDyeaWDROFqfu
         8VXA9P/xocpBEveV/8obxYA1nBx7gzkEXe5s4I9hE6vBLzw6vctsTrOCm14dIhgHuPpi
         gJu1H+AvHuXr5R28qWsnZdF6zDNiZf/gryHjhGZd3HthTaTmPnBqzbpg++zFAV7sNhtC
         pWk/BG3tY/oa5VHc4RE3R+JsflYdzSwK3jjZ8SXPfKySj3cUjG/yssHOjLuRHTlKO01l
         cwOMxXqqL8Kbj7+VDlypctIi5DJoVsVgz+NRuSUqCgp6M67XRQn1EL8fcJ2d3er6f5JW
         +NdQ==
Received: by 10.224.189.12 with SMTP id dc12mr6048749qab.59.1351012196018;
 Tue, 23 Oct 2012 10:09:56 -0700 (PDT)
Received: by 10.49.35.75 with HTTP; Tue, 23 Oct 2012 10:09:35 -0700 (PDT)
In-Reply-To: <CAKOmCvp23fALGsDe4Ck7ZXpMJmOAq+YWCXPe_xb6GfQcjJi_kQ@mail.gmail.com>
X-Gm-Message-State: ALoCoQn3OJF9+0ZOMOPReHMFe2FQOMGYadgYZ/5PyqV4+m847z0FaU+8fvbR3wyhpP5fYDALtu+m
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/208232>

On Mon, Oct 22, 2012 at 11:27 PM, Joey Jiao <joey.jiaojg@gmail.com> wrote:
> It looks like the client is waiting the pushing result status from
> server although by checking server side, the real object has already
> been upload succeed.
>
> Below is the log after adding time info.
> $ time git push -v ssh://git.qrd.qualcomm.com:29418/kernel/msm.git
> HEAD:refs/changes/33599 2>&1|tee -a log.txt
...
> remote: Resolving deltas:   0% (0/2)
> remote: (W) afafdad: no files changed, message updated
...
> real    9m56.928s
> user    0m0.364s
> sys     0m0.160s

What version of Gerrit are you using?
How many changes already exist in this project?

I am fairly certain this is an issue with Gerrit. Which may be better
discussed at http://groups.google.com/group/repo-discuss
