From: Brian Vandenberg <phantall@gmail.com>
Subject: Re: [PATCH] [RFC] Make git-update-ref invoke the update and
 post-update hooks
Date: Tue, 16 Jun 2015 08:31:23 -0600
Message-ID: <CAEJ-0i-QptjYLtr0CnYOgt4X+2R5tQGZqRhicFdxAPBxNA8J7Q@mail.gmail.com>
References: <CAEJ-0i-BB=5W-Ah3nkeLFCe5-4XW4CvYaDgdqv1mMp4UGF81qw@mail.gmail.com>
	<xmqqpp4w7mco.fsf@gitster.dls.corp.google.com>
	<CAEJ-0i8mfabWoLivX_ZJHRJBYFftoENWmHw5__CGphK54oOpug@mail.gmail.com>
	<xmqqd20w7ii4.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Jun 16 16:31:30 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Z4rth-0003U2-V5
	for gcvg-git-2@plane.gmane.org; Tue, 16 Jun 2015 16:31:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754654AbbFPOb0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 16 Jun 2015 10:31:26 -0400
Received: from mail-yh0-f49.google.com ([209.85.213.49]:34432 "EHLO
	mail-yh0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752538AbbFPObY (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 16 Jun 2015 10:31:24 -0400
Received: by yhid80 with SMTP id d80so12519375yhi.1
        for <git@vger.kernel.org>; Tue, 16 Jun 2015 07:31:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=O6L0XCtMTkzIktjn3UbphONF+ZwuwJDYzdJtwbDHxdY=;
        b=go21ixRM1nz3DxQVEdqpuJIyyWhopiRzKEASed120hJ2efr8xThWqW62+qY2VR1Vb0
         epabkVo4nUlcYdbsqz8OoSoOvlGcbeyM27eI8gtlSk2YsWOptPKz6HnsRMGGPErpR3qa
         dfISFLxTwQ1ltbp7Ibngj+9wOM2SdEyTZiN+s+s91ciDopwm/UtD0ixXIW0LmdW/Ui2Y
         v573ezhVTjiGGrEhawSMb+Jc7EpysmDbUZ7wNQ3XkNlo+oNj3VzNRPR27oTDvOLgZqJM
         TwfQaMnxlV7iavUOFDE/p1zUIbfHH+dGqKwY/Yfpo+S9zj0hJ/nDnQktmFLBXGuXdQJV
         czzQ==
X-Received: by 10.13.229.198 with SMTP id o189mr827670ywe.108.1434465083849;
 Tue, 16 Jun 2015 07:31:23 -0700 (PDT)
Received: by 10.37.24.67 with HTTP; Tue, 16 Jun 2015 07:31:23 -0700 (PDT)
In-Reply-To: <xmqqd20w7ii4.fsf@gitster.dls.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/271766>

On Mon, Jun 15, 2015 at 3:45 PM, Junio C Hamano <gitster@pobox.com> wrote:
> Those who want to bypass your policy can use "vi .git/packed-refs"
> and/or "rm .git/refs/heads/foo"; you would not propose to patch "rm"
> and "vi" to pay attention to git configuration, because they are not
> about "git" at all, and there are cases where these bare-metal level
> editing of repositories is necessary.  You would instead tell them
> "don't do that".
>
> When I say "update-ref is a low-level plumbing command that should
> not enforce policy", I am suggesting you to treat the command just
> like you would treat "rm" and "vi".

I suppose I see your point, though the line they've crossed at that
point is from benign to malicious.

When you assume they've crossed that line, hooks and configuration
parameters are mostly useless in other git commands as well.  My
assumption here is they want to do something productive and aren't
intentionally seeking to subvert policies, but rather aren't aware of
the policies and/or correct procedure.

Thanks for your responses, I appreciate your time.

-Brian
