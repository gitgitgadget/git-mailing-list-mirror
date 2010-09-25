From: Jon Seymour <jon.seymour@gmail.com>
Subject: Re: RFC: what should git rev-parse --flags HEAD do?
Date: Sun, 26 Sep 2010 05:46:31 +1000
Message-ID: <AANLkTim65zQp5Et2YQqk2ZZTuW-Dr0fJph+-8YZ0fDzw@mail.gmail.com>
References: <AANLkTimEToibgpUS1KTSruFRdggi3kbAJU5tfk9r6d2U@mail.gmail.com>
	<7vfwwxogiv.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git Mailing List <git@vger.kernel.org>,
	Brian Gernhardt <brian@gernhardtsoftware.com>,
	Brandon Casey <drafnel@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Sep 25 21:52:43 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OzanZ-0006dV-ME
	for gcvg-git-2@lo.gmane.org; Sat, 25 Sep 2010 21:52:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754633Ab0IYTqd (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 25 Sep 2010 15:46:33 -0400
Received: from mail-qy0-f174.google.com ([209.85.216.174]:43882 "EHLO
	mail-qy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750797Ab0IYTqc (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 25 Sep 2010 15:46:32 -0400
Received: by qyk36 with SMTP id 36so2982749qyk.19
        for <git@vger.kernel.org>; Sat, 25 Sep 2010 12:46:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:in-reply-to
         :references:date:message-id:subject:from:to:cc:content-type;
        bh=X5iw29vJdFwALXfwsof2fudf4DP9QXAvL0pL4HtFqkE=;
        b=MwS5TtcCGYk3eeGZ9z7DgP49ZSbCsIF3l4bCVjFPTZqJk8gNqds0jBdgmitUyphGLJ
         exdZ9/bMsvjtgAxpCJVascAIqJGQ7E01wkFFmM0onVVDcdiOzH2fR3gvwJJ70c3KgvTD
         1ZyzhAauEcjkXXBVv9E98sjaOx1oSTdzdpe2c=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        b=Zqc47p6wvkOKs2DPmTXUQJ7a0JBQOBHEG4r6JbOwWqXDcwaBVq5T/4BMnCm2HgOkWX
         rVWBxlEohZ64szYLl5wHVr4XHaEsnM+RxEurQ6/18AFi5ZmIK2W+BBB1P5u2y4i0E1qX
         XziO36CPdFdhfwDMsiwRSWGYf4vUOP2fzLZsQ=
Received: by 10.229.1.233 with SMTP id 41mr3783702qcg.284.1285443991933; Sat,
 25 Sep 2010 12:46:31 -0700 (PDT)
Received: by 10.229.219.196 with HTTP; Sat, 25 Sep 2010 12:46:31 -0700 (PDT)
In-Reply-To: <7vfwwxogiv.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/157195>

On Sun, Sep 26, 2010 at 3:54 AM, Junio C Hamano <gitster@pobox.com> wrote:
>
> Perhaps you are missing --no-revs.
> ...

> "--flags" is an afterthought that filters out non-flags in other parts; I
> do not think it applied to the "rev" part (i.e. giving --no-revs at the
> same time would be a valid workaround if you know you do not want HEAD or
> any revision traversal argument) in any released version of git.
>

i am aware that --no-revs exists and can be used with --flags to
ensure that only flag arguments are displayed.

The issue is that the documentation currently implies that --flags
alone is sufficient to suppress anything that is not a flag when this
is not, in fact, the case.  To wit:

--flags::
       Do not output any non-flag parameters.

This is simply not accurate, given the current implementation.

If there is some reason --flags should not imply --no-revs, then the
documentation should be updated to state:

--flags::
       Do not output any non-flag parameters (unless the parameter
also specifies a revision). To output only the flag parameters,
specify --no-revs as well.

jon.
