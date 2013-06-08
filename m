From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: [PATCH 2/2] Move sequencer to builtin
Date: Sat, 8 Jun 2013 09:10:47 -0500
Message-ID: <CAMP44s0gbddk+UQXqj8D1U4L8jBRciWkJT_g4CbzcTP1oQrzLQ@mail.gmail.com>
References: <1370643409-3431-1-git-send-email-felipe.contreras@gmail.com>
	<1370643409-3431-3-git-send-email-felipe.contreras@gmail.com>
	<CACsJy8AMMCWSFC6EUHAgZdDA7E1kSPE3ZO6qGvS+WGji-di=Rw@mail.gmail.com>
	<CAMP44s29GiGJq3wyXAzJNo0FJY+Vbgd18bpBJMYQ47h-3M6sWA@mail.gmail.com>
	<CACsJy8A-qc0tHcsp5=syxv_7FjixahU7fGcZuUV=cGn_-qyWwg@mail.gmail.com>
	<CAMP44s2fP4_=HtOsuwmxXG8qmp8CmpgEhz=BJFOFZxsTf_3gcQ@mail.gmail.com>
	<CACsJy8CQRWU0mFLVD6RrpzJiHBH=9zFwf5xDo7UhGW6A-OAzuw@mail.gmail.com>
	<CALkWK0mLoeO5fKezE5S1LEC2LNH9qCwxHnNi_ZJpYzC7rVTqmg@mail.gmail.com>
	<CACsJy8B=m95mpRn1dAwQZAvHRUeJVjKy1hKXv43EKX08ZODsDw@mail.gmail.com>
	<CALkWK0mw8=CMuyw5-E0fzh+c6Om_NCgHohqa_p=J_kw3UfJCJQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Duy Nguyen <pclouds@gmail.com>,
	Git Mailing List <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>,
	Brandon Casey <drafnel@gmail.com>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Shawn Pearce <sop@google.com>
To: Ramkumar Ramachandra <artagnon@gmail.com>
X-From: git-owner@vger.kernel.org Sat Jun 08 16:10:54 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UlJr3-0001tB-Os
	for gcvg-git-2@plane.gmane.org; Sat, 08 Jun 2013 16:10:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752223Ab3FHOKu (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 8 Jun 2013 10:10:50 -0400
Received: from mail-lb0-f179.google.com ([209.85.217.179]:36652 "EHLO
	mail-lb0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751632Ab3FHOKt (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 8 Jun 2013 10:10:49 -0400
Received: by mail-lb0-f179.google.com with SMTP id w20so4998277lbh.24
        for <git@vger.kernel.org>; Sat, 08 Jun 2013 07:10:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=d02RhF1JFMIqwJR/aZ7rJyMy3j/5fXd1ckI+N0akunw=;
        b=fSrAMC44EK0aSCrnq7RyXx4i/vBfApUjUTXwQR7mqHD4fzcqqtRmAPEaPVi3p4JMDz
         NmiJdVfkYyKS2uzBX15FUAPqFT/Ya2WsngUD39pFQB1wO5SHAlXiPWfJWIkrDZVVWAH0
         aBeso2w3BDdR3QHLBiqlPuYgQiih1FQ0SWrlGIJCSW/Tab+6XEsFeDXNocm8rLlItJI3
         /Jg1hiTCdEPVdJZq9xDZNgd0zVfyGj7eH52WbwsBFd11YMAt1foMRsasQv2sZvKlHTl4
         JOsDV0hN1DPgBKDpQLvmUypYPULjLOiF/mUB17h/ukwk7naWEhCi3Hu3OM+PD3C959Wq
         w4GA==
X-Received: by 10.112.156.5 with SMTP id wa5mr3134174lbb.63.1370700647765;
 Sat, 08 Jun 2013 07:10:47 -0700 (PDT)
Received: by 10.114.59.202 with HTTP; Sat, 8 Jun 2013 07:10:47 -0700 (PDT)
In-Reply-To: <CALkWK0mw8=CMuyw5-E0fzh+c6Om_NCgHohqa_p=J_kw3UfJCJQ@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/226828>

On Sat, Jun 8, 2013 at 8:34 AM, Ramkumar Ramachandra <artagnon@gmail.com> wrote:
> Duy Nguyen wrote:
>> I _think_ the reason is because git was never written as a reusable
>> library in mind from the beginning.
>
> We cannot reverse-engineer intents, but I tend to agree with this.  My
> question is: so what?  Is it impossible to do now?

Nothing is impossible.

My feeling is that no Git developers are interested in libgit2, so the
idea of me contributing to libgit2 and leave libgit.a alone is more
like a "we don't want no reorganization". Then wait until libgit2 is
ready before considering using it in Git's core, but that's never
going to happen if we don't first start to bring the two code-bases
closer together.

IOW; sweep the issue under the carpet.

-- 
Felipe Contreras
