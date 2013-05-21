From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: Re: [PATCH 0/3] Fixing volatile HEAD in push.default = current
Date: Wed, 22 May 2013 01:22:45 +0530
Message-ID: <CALkWK0m3QP_eE14y8UoJ+HeFzkKM=1nVKAnYJcTrwQMp+Atphg@mail.gmail.com>
References: <1369160600-22337-1-git-send-email-artagnon@gmail.com> <7v38tgno2k.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue May 21 21:53:31 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Uesck-00019G-KF
	for gcvg-git-2@plane.gmane.org; Tue, 21 May 2013 21:53:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752598Ab3EUTx0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 21 May 2013 15:53:26 -0400
Received: from mail-ie0-f179.google.com ([209.85.223.179]:61616 "EHLO
	mail-ie0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751639Ab3EUTx0 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 21 May 2013 15:53:26 -0400
Received: by mail-ie0-f179.google.com with SMTP id c13so2879484ieb.24
        for <git@vger.kernel.org>; Tue, 21 May 2013 12:53:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=eUnXtXfg57VfImFZhLL8ZZAKxQPnyEwLImRzhMk0304=;
        b=EmLeH8pMbu8uLM8vYrvumlM2rxtdzZNP3KxA0/vwbakM6YqZEGcAOjXAr2ni/7qZis
         fyF4dfNHDqzHI+Ys5Kvni7C5qsvnqCvMUVYXuBm0PUdR7IrkNkpfwohobSSi/KAIr3es
         mS7hzwW2LmQFnlsjQdf7VdExUi1Ri4KDNcAsrYqdXu3dU27Iti6JZ92Et59WDnwBunQ9
         ZozktB/d58uf8tky5ezuWsuDw4htZyJweLv9P+jm2XUk5cIAxgHSEFqRxfyNgXVGCbDC
         NeEsr1Rr8U2wNILsjmnQpo9MC2sQYMxrF0feUG9Tg7pAXHagRvO2UbXRnn5EmkIkXJKU
         NKWA==
X-Received: by 10.42.27.146 with SMTP id j18mr1972761icc.54.1369166005622;
 Tue, 21 May 2013 12:53:25 -0700 (PDT)
Received: by 10.64.46.1 with HTTP; Tue, 21 May 2013 12:52:45 -0700 (PDT)
In-Reply-To: <7v38tgno2k.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/225069>

Junio C Hamano wrote:
> Is there?  I do not think "volatile" is particularly a good
> description for this, but showing what is pushed as a concrete
> branch name feels like a good improvement to me, at least in
> principle.

Okay.  I used "volatile", because push does not lock HEAD when the
operation begins, even though it performs a super-late resolution (in
the transport-layer); HEAD is not guaranteed to remain invariant in
that time.  Suggest nicer wording?

> I haven't picked them up, and I won't be picking them up today, as I
> suspect this series may conflict with the pre-2.0 preparation and
> 2.0 transition patches and I may end up having to fix conflicts
> unnecessarily (resolving is eventually needed before 2.0 happens,
> but resolving them, or even having to worry about the possibility
> that I may have to do so, do not have to steal time from me today).

We're at 1.8.3; isn't it a little early to be thinking of 2.0?  Is it
conflicting with jc/push-2.0-default-to-simple in pu?  I should
re-send after this topic graduates to master in 2.0?

I have no problems re-sending at a convenient time (provided you tell
me how to determine that convenient time), but reviews don't have to
wait: it's fresh in my memory now.
