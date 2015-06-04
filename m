From: John Szakmeister <john@szakmeister.net>
Subject: Re: Suggestion: make git checkout safer
Date: Thu, 4 Jun 2015 05:01:00 -0400
Message-ID: <CAEBDL5XcEWpXeVjYb9spvy1QHbODbuvcXxFRp7_-hq=RNemyXA@mail.gmail.com>
References: <loom.20150603T104534-909@post.gmane.org>
	<20150603090654.GD32000@peff.net>
	<loom.20150603T110826-777@post.gmane.org>
	<20150603093514.GF32000@peff.net>
	<xmqqlhg0y9xj.fsf@gitster.dls.corp.google.com>
	<20150603190616.GA28488@peff.net>
	<xmqqiob4wkem.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Jeff King <peff@peff.net>, Ed Avis <eda@waniasset.com>,
	git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Jun 04 11:02:15 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Z0R2T-0006x1-Cj
	for gcvg-git-2@plane.gmane.org; Thu, 04 Jun 2015 11:02:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752074AbbFDJCJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 4 Jun 2015 05:02:09 -0400
Received: from mail-ie0-f173.google.com ([209.85.223.173]:34673 "EHLO
	mail-ie0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751976AbbFDJBB (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 4 Jun 2015 05:01:01 -0400
Received: by iecwk5 with SMTP id wk5so31095338iec.1
        for <git@vger.kernel.org>; Thu, 04 Jun 2015 02:01:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc:content-type;
        bh=IH+nxXR9mYIy1RKrrH1gZTFJTPW3auHVb2vm5Z6+DP8=;
        b=X5KdtGTJqMsgGE/Hk2OGX/G2IuCHH9HcNClH/04lYH1BSNiy962alsmpx2RVmEN+US
         bfXVUuwoy+YaLLycIKU+p24SyUdPHjU4ryP6nZgqdLFaXXN3mv4uMqshA3CwlEjXrQw6
         idOzDDUzvdzQy/AKukPRcxGgAI29/sAe119gPtFuOpMWLW99tu8sErornWrOKd+SVUUT
         qvMZQch5VclY9eA92RDIkSvqUbEKHa6VQzvenoBtHnkfwhGWEinr3pps+nvyA7SrFVY2
         jeU9Yr9HUvA2AWBC9mOHDUF5F60IA78F2fh7FxNiSVqStoaZi2JGrXPbAH+M2y+ebnJs
         anSg==
X-Received: by 10.43.148.72 with SMTP id kf8mr3209606icc.76.1433408460482;
 Thu, 04 Jun 2015 02:01:00 -0700 (PDT)
Received: by 10.107.129.85 with HTTP; Thu, 4 Jun 2015 02:01:00 -0700 (PDT)
In-Reply-To: <xmqqiob4wkem.fsf@gitster.dls.corp.google.com>
X-Google-Sender-Auth: QxwvYbI05SF2Veg71teHjt_gXdo
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/270763>

On Wed, Jun 3, 2015 at 5:29 PM, Junio C Hamano <gitster@pobox.com> wrote:
[snip]
> [Footnote]
>
> *1* In the context of this discussion, after screwing up the change
>     in hello.c, instead of expressing the wish to recover and to
>     start from scratch in two separate commands, i.e.
>
>         rm hello.c && update-from-scm
>
>     they will learn to use a single command that is designed for
>     that purpose, i.e.
>
>         checkout-from-scm hello.c
>
>     without the "rm" step, which _is_ an artificial workaround for
>     their other SCMs that do not update from the repository unless
>     they remove the files.

Just to be clear, Subversion doesn't require you to remove the file to
restore it (I'm sure most of you know that, but just in case others
didn't).  There is a one-step way to restore the file:

    svn revert hello.c

Unfortunately, revert in the Git sense is about reverting commits, so
there's a bit of friction between Subversion and Git's terminology.
OTOH, once the team was educated how to think about it, "git checkout
<path>" has been pretty natural to use.

-John
