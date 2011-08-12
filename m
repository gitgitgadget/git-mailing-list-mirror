From: Elijah Newren <newren@gmail.com>
Subject: Re: [PATCHv2 00/57] Re-roll of en/merge-recursive from pu
Date: Fri, 12 Aug 2011 15:59:30 -0600
Message-ID: <CABPp-BE_cqtOBC_0tsy1nSOfH1XPGM0vdv9fHWp38Q0GBr7OhQ@mail.gmail.com>
References: <1313126429-17368-1-git-send-email-newren@gmail.com>
	<7vei0rnprt.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git@vger.kernel.org, Jim Foucar <jgfouca@sandia.gov>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Aug 12 23:59:42 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QrzlV-0006jH-Je
	for gcvg-git-2@lo.gmane.org; Fri, 12 Aug 2011 23:59:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752589Ab1HLV7e (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 12 Aug 2011 17:59:34 -0400
Received: from mail-fx0-f46.google.com ([209.85.161.46]:45307 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752503Ab1HLV7c (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 12 Aug 2011 17:59:32 -0400
Received: by fxh19 with SMTP id 19so2569314fxh.19
        for <git@vger.kernel.org>; Fri, 12 Aug 2011 14:59:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=T0MK3+R5ksAkfQ+c7Bas12megUCpgpp0QhO1D3uSu+E=;
        b=enpurZ94aAHaJMxO7oThN8TeCJAVdqFr+P3Qm2BUd++sYhPI5loAK9Y/UPs/lvEIEh
         aiQtRf5j2WmoeciqL+Xg+dujyY9qSb4W4XAg3lzESkcU1ceQ49MwgUI9q1C19RmT4CMl
         iXZPxQAYf5AzWJ6KyHBIKeo4f2FG+r22I2xvg=
Received: by 10.223.85.145 with SMTP id o17mr1923667fal.16.1313186370693; Fri,
 12 Aug 2011 14:59:30 -0700 (PDT)
Received: by 10.223.134.84 with HTTP; Fri, 12 Aug 2011 14:59:30 -0700 (PDT)
In-Reply-To: <7vei0rnprt.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/179256>

Hi,

On Thu, Aug 11, 2011 at 11:48 PM, Junio C Hamano <gitster@pobox.com> wrote:
> Avoiding silent mismerges is of course one of the most important criteria,
> but we also need to make sure that a conflicted state left in the index
> and the working tree files must not be harder to reconcile than what we
> have been giving our users---otherwise the change will be seen as a
> regression by them.

Yeah, good point.  I tried re-running my previous re-merge all merges
in git.git testcase, modified so that when both versions of git
reported a conflict I would compare the output of 'git ls-files  -s'.
That uncovered a regression.  I think I know the fix but I need to
retest and do some more checks.
