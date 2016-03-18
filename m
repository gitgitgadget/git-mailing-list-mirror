From: =?UTF-8?B?5oOg6L22576k?= <huiyiqun@gmail.com>
Subject: Re: [PATCH v2/GSoC 4/4] t0301: test credential-cache support of XDG_RUNTIME_DIR
Date: Fri, 18 Mar 2016 13:22:48 +0800
Message-ID: <CAKqreuy8GQygYVvSBnrEU07E-4=1ajiMSSStPjqXp6t=xpNuXQ@mail.gmail.com>
References: <1458233326-7735-1-git-send-email-huiyiqun@gmail.com>
	<1458233326-7735-4-git-send-email-huiyiqun@gmail.com>
	<20160317180811.GA23669@sigill.intra.peff.net>
	<CAKqreuy0jU7WOi8_iGXR2hzYJE0kG8855hQuaeaW9OTKm3yF_Q@mail.gmail.com>
	<20160318050124.GB22327@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	Your friend <pickfire@riseup.net>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Fri Mar 18 06:22:56 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1agmsA-0003up-PT
	for gcvg-git-2@plane.gmane.org; Fri, 18 Mar 2016 06:22:55 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750847AbcCRFWv convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 18 Mar 2016 01:22:51 -0400
Received: from mail-oi0-f66.google.com ([209.85.218.66]:33239 "EHLO
	mail-oi0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750711AbcCRFWt convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 18 Mar 2016 01:22:49 -0400
Received: by mail-oi0-f66.google.com with SMTP id e22so2178283oib.0
        for <git@vger.kernel.org>; Thu, 17 Mar 2016 22:22:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-transfer-encoding;
        bh=nPQovT56Dg4L0ZgX2ZJg5dPhvB19HeIZS8oPvjwiCwc=;
        b=N29UeOmv7cNpXPDzjyK/xPdtMpgoRA/Owp29zg5aOXNNs+XvKmO9dALJzpPgErr+x1
         El+wW6L0wnvrsQBvFvqIuPTlma2mNttoomPFynpAEjrXfM0MNAxAQmPHYggD4noyrCTG
         bD3m+q9KZBH0JzKeGXBO4+7s3pItQ5bz1IKfaHgBqQL3rrnd1+nLXFY8YSZVspPMzWxT
         IfwYpnm5I5EYpf8leqzijR5pSUU1aeAI+Yw0r+RpZCU0i0HATHkwSfLtIKhixc4msqVz
         bTPiyWRDvqroBCuMyJAcCmoUD/d6mX1gWJeHgOjf+IDQt+lqC9KM5QxN6r0OVGukp8c9
         DWYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-transfer-encoding;
        bh=nPQovT56Dg4L0ZgX2ZJg5dPhvB19HeIZS8oPvjwiCwc=;
        b=HqRmVWmaHo8YSnsyaFbHyKuHrOgC9F1Uj9Gq39nMrKBwwYCWBeLdqd/UMvUrdgboc1
         ldip+YhkCwujvcLoVHTpaxGz31SJ4tuqXSq4zyJwYfsxIsII87VDn1j7slnWQMdDmaui
         Lc4xCSGJYN+LFpU47ojQ3TwUlVmV2Dc2lIGLpHwVp2XAJgU4R8vEfB8m0Cj6oe2/Ds2o
         fXmUPrmAeit+bHq6HeZh8kfN3Y0abdpbI/2bRJrOvYaKk363/yXWclqIQ1aAPx4NAVaC
         3TbgJ3tJ6ZkT2JYAjC5SdajskvB+f8vXmYSQ0W9GjqnxCKVn4NtSUwB6b/Zn3JMKgezq
         1VnQ==
X-Gm-Message-State: AD7BkJIpm6j7YLGCMyb0cdj/atpzFCmUucinScTaaMS/hJr78xg07GHN4K9sYwElvcuiQpbMcohR4S+cCAy9gA==
X-Received: by 10.202.181.11 with SMTP id e11mr8395116oif.77.1458278568980;
 Thu, 17 Mar 2016 22:22:48 -0700 (PDT)
Received: by 10.157.43.68 with HTTP; Thu, 17 Mar 2016 22:22:48 -0700 (PDT)
In-Reply-To: <20160318050124.GB22327@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/289190>

2016-03-18 13:01 GMT+08:00 Jeff King <peff@peff.net>:
> On Fri, Mar 18, 2016 at 12:38:16PM +0800, =E6=83=A0=E8=BD=B6=E7=BE=A4=
 wrote:
>
>> >> +test_expect_success 'when $XDG_RUNTIME_DIR is set, `$XDG_RUNTIME=
_DIR/git` are used' '
>> >> +     test_path_is_missing "/tmp/git-$(id -u)/git/credential-cach=
e.sock" &&
>> >> +     test -S "$HOME/xdg_runtime/git/credential-cache.sock"
>> >> +'
>> >
>> > This test fails for me, probably because XDG_RUNTIME_DIR is not
>> > exported.
>> >
>> > -Peff
>>
>> Could you please give a try to the patch set v2, test of which is
>> definitely passed on my computer.
>
> Yes, that was what I tried earlier (and I just re-tested to make sure=
).
> It still fails. I suspect it has to do with whether XDG_RUNTIME_DIR i=
s
> set in our environments (outside of the test suite). If I run:
>
>   XDG_RUNTIME_DIR=3D/tmp/foo ./t0301-credential-cache.sh
>
> it passes.
>
> -Peff

Sorry, I wrongly considered your comment is for my last commit. That
was partly because my thread is
disturbed by my commits in my mailbox(gmail). I hope that did not also
disturb yours.

I sent my commits with `--thread` and `--no-chain-reply-to` in hope
that I would send an summary as
[PATCH 0/x] and all my commits would be sent in reply to it. But I fail=
ed.
