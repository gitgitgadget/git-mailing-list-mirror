From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: [PATCH] remote-helpers: remove --graph in hg_log()
Date: Sat, 6 Apr 2013 10:06:39 -0600
Message-ID: <CAMP44s2tdKhGuH3E7nGqU4R3jgEw4tH-=Cq6dhHwiLc=b_fm6Q@mail.gmail.com>
References: <1365264055-30507-1-git-send-email-apelisse@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git@vger.kernel.org
To: Antoine Pelisse <apelisse@gmail.com>
X-From: git-owner@vger.kernel.org Sat Apr 06 19:52:47 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UOWWu-0001D7-VH
	for gcvg-git-2@plane.gmane.org; Sat, 06 Apr 2013 19:03:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1423237Ab3DFQGl (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 6 Apr 2013 12:06:41 -0400
Received: from mail-la0-f46.google.com ([209.85.215.46]:52336 "EHLO
	mail-la0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1423234Ab3DFQGk (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 6 Apr 2013 12:06:40 -0400
Received: by mail-la0-f46.google.com with SMTP id fq12so4220171lab.5
        for <git@vger.kernel.org>; Sat, 06 Apr 2013 09:06:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:x-received:in-reply-to:references:date:message-id
         :subject:from:to:cc:content-type;
        bh=0k9fqv+fQ46hNfHqnK9tTufg0BigTfsDRWJ2yviOdQk=;
        b=NeSseUTyJQbwMcWNY1udCOkD9UXfSd83IicTbrILv3ewoE8vxFZe5Ef7g6Nf5XNv6W
         DomV2esl2+WIPze2eTMRLuuNpBafNcJdG7BEFe5z4go47qNXyGEpKlIVWvITQynLU/lK
         lszbGzEOZba1sPCPQFbF9ryG3UBbIWcrtrPCg+hdlZkPiN0udfaBtz7xbXlWfYUxTdXN
         Ct5OzuPfQL/CQwgmrlFHg1YggjBcuOFIlIQIaNAONeMPR0/BsayqmEhYrZ6uXAIlaHTL
         u6Xig36ExK/BH4M5jVsK8nMCIpSJoIZQruKLu7tleQ4ZHS5CbA7NdFn/FRes4povdXjU
         6O4g==
X-Received: by 10.112.145.8 with SMTP id sq8mr8526705lbb.55.1365264399159;
 Sat, 06 Apr 2013 09:06:39 -0700 (PDT)
Received: by 10.114.20.36 with HTTP; Sat, 6 Apr 2013 09:06:39 -0700 (PDT)
In-Reply-To: <1365264055-30507-1-git-send-email-apelisse@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/220241>

On Sat, Apr 6, 2013 at 10:00 AM, Antoine Pelisse <apelisse@gmail.com> wrote:
> The hg_log() test helper uses the "--graph" parameter that is
> implemented by the GraphLog extension. If the extension is not activated
> by the user, the parameter is not available. Do not use the option that
> is unnecessary.

> I'm not so confident that --graph is useless to the test. If it's really
> necessary, it would be nice either to activate it in setup() or to use
> it just for the command through: "--config extensions.graphlog=".

I think it should be activated in the setup, it comes packaged with
mercurial, and it's likely that many users have it enabled.

> Also changes the way we grep the output in hg_log(). The pipe operator
> can hide the return code of hg command. As a matter of fact, if log
> fails because it doesn't know about "--graph", it doesn't report any
> failure and let's you think everything worked.

Yeap, that is good to have.

Cheers.

-- 
Felipe Contreras
