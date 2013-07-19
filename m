From: Junio C Hamano <gitster@pobox.com>
Subject: Re: One question about git-format-patch
Date: Fri, 19 Jul 2013 16:06:08 -0700
Message-ID: <CAPc5daW6ohYxJP0eyfW0DT_Q-E8v0quweRBwJCAZOVrEMWchjA@mail.gmail.com>
References: <804161F448B352478D7503429A0B7F27CA94AC@ex10-mbx-36002.ant.amazon.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: "git@vger.kernel.org" <git@vger.kernel.org>
To: "Hua, Siyuan" <siyuahua@amazon.com>
X-From: git-owner@vger.kernel.org Sat Jul 20 01:06:37 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1V0Jkw-0003dU-O8
	for gcvg-git-2@plane.gmane.org; Sat, 20 Jul 2013 01:06:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753076Ab3GSXGb convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 19 Jul 2013 19:06:31 -0400
Received: from mail-la0-f54.google.com ([209.85.215.54]:48555 "EHLO
	mail-la0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752755Ab3GSXGa convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 19 Jul 2013 19:06:30 -0400
Received: by mail-la0-f54.google.com with SMTP id ec20so3743371lab.41
        for <git@vger.kernel.org>; Fri, 19 Jul 2013 16:06:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:from:date
         :x-google-sender-auth:message-id:subject:to:cc:content-type
         :content-transfer-encoding;
        bh=Z2yt3DVdZq1lrCD+jXMstN/hPrfz7zDeroAHIoQZXlE=;
        b=TiKP8zKamjssmQOPChf3vIwuc8utPG7hkSRro+myOvYnVuEjTwhohyHwNHyHMUcB0u
         Me769cuF/PEOY91knW3lUuMTRHVWreiTvdGziUZTFZAXX7fn/OD604MJ3GQM2R+N+oAi
         pfIaYhxWp6leGXU4zWLXP5WeKAwZ/QAiPAGYg2cvNkEe2GfEMe4tNJth7/EFWZkgfTFy
         04oMu3Wth0UBMhTEbF4ReohIfaUQES2fHWKZ+mBxuMvUCxNEOH6QIbqVDqwRdGhbWy65
         /9q627xqgJFDgT5JRnx0ZvQb+m178s5Ae4czP9A1NpBgCvqjOWHhWf84/mTgcVMXLxHV
         Gl1A==
X-Received: by 10.112.157.137 with SMTP id wm9mr8276400lbb.14.1374275188858;
 Fri, 19 Jul 2013 16:06:28 -0700 (PDT)
Received: by 10.112.64.73 with HTTP; Fri, 19 Jul 2013 16:06:08 -0700 (PDT)
In-Reply-To: <804161F448B352478D7503429A0B7F27CA94AC@ex10-mbx-36002.ant.amazon.com>
X-Google-Sender-Auth: UEFV58uudq9bEMaHHiItHLQ3rks
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/230857>

> I=E2=80=99m a git user, and recently I=E2=80=99ve noticed there=E2=80=
=99re some differences between
> =E2=80=9C$ git format-patch =E2=80=93n=E2=80=9D and =E2=80=9C$ git fo=
rmat-patch HEAD~n=E2=80=9D. According to the
> documentation: =E2=80=9C-<n> Prepare patches from the topmost <n> com=
mits.=E2=80=9D

Correct.  However, HEAD~n will prepare patches for commits that are
not ancestor of HEAD~n.

And there may well be a lot more than n such commits, unless you are
working on a strictly linear history.
