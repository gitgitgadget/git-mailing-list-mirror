From: Paul Tan <pyokagan@gmail.com>
Subject: Re: [PATCH 0/7] Improve git-pull test coverage
Date: Tue, 5 May 2015 18:39:55 +0800
Message-ID: <CACRoPnSJdMmJNQ4xrKr5Og6rZOjCm4Ad8rv5dVfTZod6d5pKWg@mail.gmail.com>
References: <1430581035-29464-1-git-send-email-pyokagan@gmail.com>
	<vpqoam0sqp5.fsf@anie.imag.fr>
	<xmqqlhh4tfd0.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
	Git List <git@vger.kernel.org>,
	Stefan Beller <sbeller@google.com>,
	Johannes Schindelin <johannes.schindelin@gmx.de>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue May 05 12:40:29 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YpaGq-00024w-FJ
	for gcvg-git-2@plane.gmane.org; Tue, 05 May 2015 12:40:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757306AbbEEKkH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 5 May 2015 06:40:07 -0400
Received: from mail-la0-f42.google.com ([209.85.215.42]:32858 "EHLO
	mail-la0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756972AbbEEKj5 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 5 May 2015 06:39:57 -0400
Received: by layy10 with SMTP id y10so123982791lay.0
        for <git@vger.kernel.org>; Tue, 05 May 2015 03:39:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=4FchKzoFEA3wviIFXU6pVAdYn4HN2KEiGhXwKlW1BOI=;
        b=Nt6Bbq04CxV/4+5bxM1U9OeoWdVd1nT7X2OVQCcDYPAZXl7a2UspNTj9jvrRvjgY49
         q4p9BTd+tkPtWCD296PFUz8U1aD1GIEdJWroJ2OW24IC7x5LyMcIZAoquJAUYsuPKrdC
         2ACIMCHU5iwTKwK071WXF1GpNl8Dyr/KJu9MXCcsoB1MbbwCUaceQAwa/hKceutXQBTe
         14ALuhuQOsB62yQE1v8Eyy2UggGmop++2v/0toRInYsRMyMO/HD4obbmV2laMyHEzo4D
         sndHTf00iuBN+qm8JsZJKgUt8gprEbnEFMmb32wIqGoX0BSdp4+lsp1bGlE5CVE3GpL7
         dBQw==
X-Received: by 10.152.4.72 with SMTP id i8mr24035612lai.32.1430822395082; Tue,
 05 May 2015 03:39:55 -0700 (PDT)
Received: by 10.112.74.133 with HTTP; Tue, 5 May 2015 03:39:55 -0700 (PDT)
In-Reply-To: <xmqqlhh4tfd0.fsf@gitster.dls.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/268391>

Hi Junio,

On Tue, May 5, 2015 at 1:35 AM, Junio C Hamano <gitster@pobox.com> wrote:
> I didn't like the grepping of error messages alone as a way to
> diagnose the failure, though.  When we expect the pull to fail
> without touching anything in the working tree, I'd prefer to see
> that tested explicitly (e.g. "if pull mistakenly tried to go ahead
> and touch this file that would be involved in the merge, its
> contents would change---let's make sure that does not happen by
> making sure the contents before and after are the same" kind of
> thing).

Yes, you're right. Some tests do need these additional checks. Will
add them in the re-roll.

Just to be sure, aside from checking that git-pull does not touch
files it should not touch in the event of an error, I do believe we
also need to check its error message, as printing out the correct
user-friendly error messages is one of the features of git-pull.

Regards,
Paul
