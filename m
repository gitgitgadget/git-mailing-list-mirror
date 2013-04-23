From: Joel Jacobson <joel@trustly.com>
Subject: Re: [PATCH] Add .gitconfig variable commit.gpg-sign
Date: Tue, 23 Apr 2013 20:56:41 +0100
Message-ID: <CAASwCXcs8Q7qGWSNKttEuk0zPetDWNCse4J-KSm20r9h5XSo3Q@mail.gmail.com>
References: <CAASwCXf3YHmdQ_eSkShyzn5VniO=ufm3VTqV1JVOUN610bzE_A@mail.gmail.com>
	<7vip3em8rs.fsf@alter.siamese.dyndns.org>
	<CAASwCXcfCNqiMXD5JasTRKWZgCNsxnUY7k9E=f86xsTZjk37CA@mail.gmail.com>
	<51767290.2010208@drmicha.warpmail.net>
	<7va9opi163.fsf@alter.siamese.dyndns.org>
	<CAASwCXdhgNPzm51MfWTCTNYQwT0gC-UbV7xTNGcXhs6k9f4wsQ@mail.gmail.com>
	<7v1ua1hwx6.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Michael J Gruber <git@drmicha.warpmail.net>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Apr 23 21:56:49 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UUjKZ-00027B-7q
	for gcvg-git-2@plane.gmane.org; Tue, 23 Apr 2013 21:56:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752543Ab3DWT4m (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 23 Apr 2013 15:56:42 -0400
Received: from mail-vc0-f180.google.com ([209.85.220.180]:52117 "EHLO
	mail-vc0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751281Ab3DWT4m (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 23 Apr 2013 15:56:42 -0400
Received: by mail-vc0-f180.google.com with SMTP id m17so1043563vca.39
        for <git@vger.kernel.org>; Tue, 23 Apr 2013 12:56:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:x-received:in-reply-to:references:date:message-id
         :subject:from:to:cc:content-type:x-gm-message-state;
        bh=LXaRPlBz7aWC5UtLPGcGC65d7CcR5U5gkEYXTQ00u+s=;
        b=ZcWrnbtYCZ59wZ9/QIgj7KBvSMo1sC+2afReSon8pov9pvBdWQCSnkbsz8CIix6VxJ
         IObD1Q4VwTabpPPyMtiEGpNc8kkXcWS0smrmK/mcd/RDeqVY0Eh9nslOWcwU37RxOlBt
         x1P23rXGzENppcvd902+4yFxlc07c44WRRqZDoWyU4kWabgl8hDMIwTVSnLacJKGuPpU
         DRw2X46utotm8CSj2BPTAB5Qq5qdWsab3KCehRDQXUpgFoufyB+DN6nQfuhev6yV/f0a
         K8KjwOiRVYL84Fz3V8ThRQvhGXElJ7nLywShChQLhg1nr+MxrdbAyLDqQ0CKnhtN+ykp
         ZfrA==
X-Received: by 10.220.155.8 with SMTP id q8mr17702603vcw.42.1366747001403;
 Tue, 23 Apr 2013 12:56:41 -0700 (PDT)
Received: by 10.59.11.169 with HTTP; Tue, 23 Apr 2013 12:56:41 -0700 (PDT)
In-Reply-To: <7v1ua1hwx6.fsf@alter.siamese.dyndns.org>
X-Gm-Message-State: ALoCoQn0PpVzBzArDuvlzPIVgWMylZB73GBYiog72sKw6AVsXxNgSd84NROqE0lVZbmd/qpV+8DK
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/222210>

On Tue, Apr 23, 2013 at 8:25 PM, Junio C Hamano <gitster@pobox.com> wrote:
> Yup.
>
> And then we would need to add the same option to existing callers of
> "git commit" (such as "git rebase") to pass it down the callchain.

Got it.

> But stepping back a bit, I have a suspicion that your upstream
> project _only_ cares about what you feed them (either by pushing
> your work yourself to them, or telling them to pull from your
> repository).  There is no reason for you to be constantly signing
> your commits you make during your exploratory development that you
> may throw-away in the end.

Your suspicions are correct.
But I'm a bit paranoid, so it feels better to sign even local commits.

> It _might_ be a better option to just teach "-S" option to "git
> rebase" that tells it to replay all the commits with "commit -S",
> instead of adding commit.gpgSign configuration.

In my case, I don't do that much exploratory development locally,
so I usually just commit, pull and push.

Always signing everything can't really hurt, can it? Takes a few clock
cycles more, and a few more bytes, but apart from that I don't see any
problems?
