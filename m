From: Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH] rebase-i: loosen over-eager check_bad_cmd check
Date: Wed, 30 Sep 2015 16:04:44 -0400
Message-ID: <CAPig+cTadBNcTRHzTti-WuQSz=hRUsJYK1w9xiW6m=uOYCdCMQ@mail.gmail.com>
References: <xmqqy4fn7m2s.fsf@gitster.mtv.corp.google.com>
	<1443643292-14505-1-git-send-email-Matthieu.Moy@imag.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Junio C Hamano <gitster@pobox.com>, Git List <git@vger.kernel.org>
To: Matthieu Moy <Matthieu.Moy@imag.fr>
X-From: git-owner@vger.kernel.org Wed Sep 30 22:04:53 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZhNcS-0000qm-J1
	for gcvg-git-2@plane.gmane.org; Wed, 30 Sep 2015 22:04:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932627AbbI3UEt (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 30 Sep 2015 16:04:49 -0400
Received: from mail-vk0-f42.google.com ([209.85.213.42]:33526 "EHLO
	mail-vk0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932505AbbI3UEq (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 30 Sep 2015 16:04:46 -0400
Received: by vkgd64 with SMTP id d64so29130408vkg.0
        for <git@vger.kernel.org>; Wed, 30 Sep 2015 13:04:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc:content-type;
        bh=TFHAJrBhk02CON7cwHhN5BTccPemWD3UdvHDUNugxhk=;
        b=jFP3gzznrpIZRCkHkpyXD+7borxjRwAUrj6JSYjTeAIMhp9j6XHsBfFSRstMRCx3ce
         A+U0ei1B+gd2bmAyUWoVL2RHho0FB1p/KQnL+0j8JJlViqhiu5Xr1xmRvOynRX2KQM2n
         aMFvvaTQJo9mFVJoJqB7XDhigwIuY+fqqVxyXOqKVYzSQmXYlcyHRMrEFPWxC8r44wKi
         TIIJmzcR2f4slElIBkWcH9ydn6/g7RdOZcGTXcavBGGlAMJD1+FO+WRhM3+nfuQr3N66
         gyP7VQmF3YWmzqyitsj4XXoIhwNdeLDgkTlIoNDx5JmIfOBglHDZjqVlqeJ+kbAE286B
         eCgg==
X-Received: by 10.31.11.17 with SMTP id 17mr4552617vkl.84.1443643485021; Wed,
 30 Sep 2015 13:04:45 -0700 (PDT)
Received: by 10.31.224.68 with HTTP; Wed, 30 Sep 2015 13:04:44 -0700 (PDT)
In-Reply-To: <1443643292-14505-1-git-send-email-Matthieu.Moy@imag.fr>
X-Google-Sender-Auth: WK3VzCNeYhNeygleXvqwqt58YWQ
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/278867>

On Wed, Sep 30, 2015 at 4:01 PM, Matthieu Moy <Matthieu.Moy@imag.fr> wrote:
> 804098bb (git rebase -i: add static check for commands and SHA-1,
> 2015-06-29) tried to check all insns before running any in the todo
> list, but it did so by implementing its own parser that is a lot
> stricter than necessary.  We used to allow lines that are indented
> (including comment lines), and we used to allow a whitespace between
> the insn and the commit object name to be HT, among other things,
> that are flagged as an invalid line by mistake.
>
> Fix this by using the same tokenizer that is used to parse the todo
> list file in the new check.
>
> Whether it's a good thing to accept indented comments is
> debatable (other commands like "git commit" do not accept them), but we
> already accepted them in the past, and some people and scripts rely on
> this behavior. Also, a line starting with space followed by a '#' cannot
> have any meaning other than being a comment, hence it doesn't harm to
> accept them as comments.
>
> Largely based on patch by: Junio C Hamano <gitster@pobox.com>

Missing sign-off.
