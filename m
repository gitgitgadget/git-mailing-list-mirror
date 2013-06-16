From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: Re: [PATCH 5/6] status: do not depend on flaky reflog messages
Date: Sun, 16 Jun 2013 11:37:43 +0530
Message-ID: <CALkWK0kzGTHMv2x8mrgftVGX1OwtvVdb9_8jrXnV=fQCfPw9XQ@mail.gmail.com>
References: <1371130349-30651-1-git-send-email-artagnon@gmail.com>
 <1371130349-30651-6-git-send-email-artagnon@gmail.com> <7vvc5hubox.fsf@alter.siamese.dyndns.org>
 <CALkWK0kjxKFkrLArL1mLZYCMN1=sgnDSa3vaoJm6eSUp2E4Pyw@mail.gmail.com>
 <7vd2rpu3kf.fsf@alter.siamese.dyndns.org> <CALkWK0=NAiGDVWbwHXMmEffPF9wKXd23BdwOntfdvNCpVe8fiA@mail.gmail.com>
 <7vppvosstl.fsf@alter.siamese.dyndns.org> <CALkWK0k28u583Jci+Dvad1pbu7_dJdnmz1WBkP790a_t2QdPTg@mail.gmail.com>
 <7v38sksq14.fsf@alter.siamese.dyndns.org> <CALkWK0n_Jsb46qPojbGL3S+mPunNQWUOmypQOvdaBjcT5wgJBg@mail.gmail.com>
 <7vsj0kpsb0.fsf@alter.siamese.dyndns.org> <CALkWK0==Phbe-9QaOa3jkYMEvxb6F3kypRkk9RbzrLco-HkHKw@mail.gmail.com>
 <7v7ghwmi9x.fsf@alter.siamese.dyndns.org> <CALkWK0nDwqqiAq044wwj__1XzAuFDBUG59_0zHRMNzQ6ARsiww@mail.gmail.com>
 <7vsj0jln23.fsf@alter.siamese.dyndns.org> <CALkWK0=R8h0_FUYMUFQ_qGC1Lf_Xvu84qigznYUK5MtzP8usPQ@mail.gmail.com>
 <7vip1ek37o.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Jun 16 08:08:34 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Uo68b-0000Be-9t
	for gcvg-git-2@plane.gmane.org; Sun, 16 Jun 2013 08:08:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754976Ab3FPGIZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 16 Jun 2013 02:08:25 -0400
Received: from mail-ie0-f175.google.com ([209.85.223.175]:60350 "EHLO
	mail-ie0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754937Ab3FPGIY (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 16 Jun 2013 02:08:24 -0400
Received: by mail-ie0-f175.google.com with SMTP id a13so4525167iee.34
        for <git@vger.kernel.org>; Sat, 15 Jun 2013 23:08:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=U9+5Rw6Ec/VX0xk7XxplIMz9/4KKGoRQLTVswNGc0Ds=;
        b=hRTnmUETZmzeMtPIBsE6cL8ixg7upNMCJxkK95MKj39YoZJKjHe8o4hqyj+lwkPhgV
         rDu4wf4cgoPTlN5AwgpbqMEs9uW9HspUzm/vmklQhg/bLQ8loajiob5mvpUXWbwnGJWD
         Ga6e57gSUzyiTRvutfVMyVlea5J+0u6UqekRxhGm7+1mNNwZj0d2Bx2+3sI6Y/usEEJA
         2oZjO2C1H2Yw/imnCVXrkU/0dxSNZX54AvoPzKvgoBtGOg/AlAVMCCo4lBDP86m6ogtU
         IAsLfI2qxqwVJ0iRsgvYZf79kxhVCZeyteGGr8n47FhqSAoW8kqYc3Ec37CccFow1gZN
         x9hA==
X-Received: by 10.50.23.8 with SMTP id i8mr2300321igf.42.1371362904208; Sat,
 15 Jun 2013 23:08:24 -0700 (PDT)
Received: by 10.64.129.97 with HTTP; Sat, 15 Jun 2013 23:07:43 -0700 (PDT)
In-Reply-To: <7vip1ek37o.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/227991>

Junio C Hamano wrote:
> [...]

I have no desire to argue incessantly.  I just want a solution to the problem!

> A rerolled series that does:
>
>  - Tweak wt-status.c to take information not from reflog, when
>    detached during rebase (this may need to tweak existing tests,
>    as different "rebase" modes may use 'checkout' liberally in
>    different ways);

Please be more specific, and tell me what it should print when a
rebase is in progress.  Would a constant

  # rebase in progress; onto $ONTO

be sufficient?

>  - Teach builtin/commit.c to pay attention to reflog-action; thanks
>    to the previous step, this will not have to change the tests;

Where did builtin/commit.c enter into the equation?  Doesn't it
already respect GIT_REFLOG_ACTION?  See line 1461.

>  - Update the reflog message rebase uses, but again this will not
>    affect wt-status.c at all.

Okay.
