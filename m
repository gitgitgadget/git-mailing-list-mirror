From: Jiang Xin <worldhello.net@gmail.com>
Subject: Re: What's cooking in git.git (Sep 2013, #01; Tue, 3)
Date: Fri, 6 Sep 2013 10:11:33 +0800
Message-ID: <CANYiYbGHKDENMCnWaRtb_=HmpenxWA95H-bfHdWM8f6098sT6g@mail.gmail.com>
References: <xmqqppspo6i7.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Sep 06 04:11:39 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VHlWN-0007d5-2Y
	for gcvg-git-2@plane.gmane.org; Fri, 06 Sep 2013 04:11:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753981Ab3IFCLf convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 5 Sep 2013 22:11:35 -0400
Received: from mail-we0-f176.google.com ([74.125.82.176]:53303 "EHLO
	mail-we0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753815Ab3IFCLe convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 5 Sep 2013 22:11:34 -0400
Received: by mail-we0-f176.google.com with SMTP id u56so2366836wes.21
        for <git@vger.kernel.org>; Thu, 05 Sep 2013 19:11:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        bh=9NxRLawEdEXURthlwu/nGNY+4wsDdHgLU/XrC7ipsB4=;
        b=BI6MxKfygn3Aio0pejy4RLgmgmAUdy0wrlovGSQsQhxMbMYdgOhnFfyCImo0djYS8k
         Xr1g9v20mE8GlXEUEFZvSli+Z33VEMNWIF1TTehUkKY48dUn2SR7UoavicE5AHH8GJjs
         lw45A8FsVS03PJYtUevpNFwY86Nez25wGLlch+JNBxaEwf/HEomHTr3GSiUozcDyW8Q6
         yQ5iOj4wo3rNNZBI938K+rLtYyW50urUKg1pLHYE7NFJBTZd3g+zCY5bmzj+au1my9z4
         6J7qc+f/2FQ1cA5910Bkon2AJ6WZ7v+BphTRAxt1CRSzzaQA1PlcZbqEZI5pSlsW8i7/
         o80A==
X-Received: by 10.180.160.212 with SMTP id xm20mr42933wib.23.1378433493295;
 Thu, 05 Sep 2013 19:11:33 -0700 (PDT)
Received: by 10.194.71.175 with HTTP; Thu, 5 Sep 2013 19:11:33 -0700 (PDT)
In-Reply-To: <xmqqppspo6i7.fsf@gitster.dls.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/234013>

2013/9/4 Junio C Hamano <gitster@pobox.com>:
> * jx/branch-vv-always-compare-with-upstream (2013-08-26) 2 commits
>  - status: always show tracking branch even no change
>  - branch: report invalid tracking branch as gone
>
>  "git branch -v -v" (and "git status") did not distinguish among a
>  branch that does not build on any other branch, a branch that is in
>  sync with the branch it builds on, and a branch that is configured
>  to build on some other branch that no longer exists.
>
>  Am I waiting for another reroll?
>

No more reroll if no more votes for =93absent" vs "gone", and
"in sync with" vs "up-to-date with". Currently, we choose "gone=94
and "up-to-date with", such as:

        $ git branch -v -v
          master    e67ac84 initial
        * topic     3fc0f2a [topicbase: gone] topic

        $ git status
        # On branch topic
        # Your branch is based on 'topicbase', but the upstream is gone=
=2E
        #   (use "git branch --unset-upstream" to fixup)
        ...

        $ git status
        # On branch feature1
        # Your branch is up-to-date with 'github/feature1'.
        ...


--=20
Jiang Xin
