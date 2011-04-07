From: Mark Lodato <lodatom@gmail.com>
Subject: Re: Bug report: git status does not report unmerged entries with copies
Date: Thu, 7 Apr 2011 19:36:09 -0400
Message-ID: <BANLkTim6Bn6WQrYCrfmw+B_by-PiSuu-9Q@mail.gmail.com>
References: <BANLkTikWVgsX6yEY=d7kEcO5PLMTRwDU_A@mail.gmail.com> <alpine.DEB.2.00.1104070948310.25447@debian>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git list <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>
To: Martin von Zweigbergk <martin.von.zweigbergk@gmail.com>
X-From: git-owner@vger.kernel.org Fri Apr 08 01:36:40 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Q7ykg-0004sM-LX
	for gcvg-git-2@lo.gmane.org; Fri, 08 Apr 2011 01:36:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757202Ab1DGXgb convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 7 Apr 2011 19:36:31 -0400
Received: from mail-vx0-f174.google.com ([209.85.220.174]:33794 "EHLO
	mail-vx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757159Ab1DGXgb convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 7 Apr 2011 19:36:31 -0400
Received: by vxi39 with SMTP id 39so2351101vxi.19
        for <git@vger.kernel.org>; Thu, 07 Apr 2011 16:36:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-type:content-transfer-encoding;
        bh=uM4ueKwbk2Q16HGE2AcdG6LwvwcQxHwFmV4995BWfSQ=;
        b=aTQXr4RMk+ghiRIOHgqGL0aSAqq0LJ5U6QxKgyLH37eLSlY99FF2Jpv9vhsvOJAt/z
         6nQzngIGCVhyqwV2eVaUBIMFxi/v2gGKnVYssoPZsthHEdlbioeVfioCZmmGX7LjgJ1g
         ZF2r/FSX/Vy6Zz5oWVhwhLxUG9DcgirCzOHuE=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        b=Qu/Y7L6CjnHvogxnef9giC+KrV6n+6cXO/e8yKfAz+7EUW6wT4STrV2MLbsurdTryJ
         RprFmndtNDwyQzWpNzkCSOpGWWIB1Jw9+XuxyFXbGFte1kh0OpEHT6WZ9mj0Guk2Rmkx
         sjC+/9VXpfgvFX9Uo9EOgAUliz0ieRpj5Oc9c=
Received: by 10.52.179.9 with SMTP id dc9mr2295399vdc.26.1302219390095; Thu,
 07 Apr 2011 16:36:30 -0700 (PDT)
Received: by 10.52.160.103 with HTTP; Thu, 7 Apr 2011 16:36:09 -0700 (PDT)
In-Reply-To: <alpine.DEB.2.00.1104070948310.25447@debian>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/171097>

On Thu, Apr 7, 2011 at 9:53 AM, Martin von Zweigbergk
<martin.von.zweigbergk@gmail.com> wrote:
>
> On Wed, 6 Apr 2011, Mark Lodato wrote:
>
>> Commit 4d4d572, "status: show worktree status of conflicted paths
>> separately" introduced the following bug: =C2=A0If one tries to merg=
e two
>> branches with a conflict, where the conflicting file was also copied
>> in one of the branches, "git status" (but not "git status -sb" or
>> git-gui) fails to report the unmerged status.
>
> I sent a patch for this not so long ago [1]. It is currently in "next=
"
> as commit d7c9bf2. I think Junio said the plan is to release it in
> 1.7.5.
>
> =C2=A0[1] http://thread.gmane.org/gmane.comp.version-control.git/1692=
89/focus=3D169887

Ah yes, sorry.  Your commit does fix the problem.  My test script
reports a failure, but it is only because my grep command was
insufficient to properly test.  (At the very least, I should have
check case insensitively.)
