From: Tay Ray Chuan <rctay89@gmail.com>
Subject: Re: [PATCH v2 0/2] make commit --verbose work with --no-status
Date: Fri, 5 Jun 2015 20:40:01 +0800
Message-ID: <CALUzUxqeadRii1o0-yo=QaZCqoAzGk+aVq=y1-11dJvK=em0qw@mail.gmail.com>
References: <1433440591-30917-1-git-send-email-rctay89@gmail.com> <xmqqd21buxla.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git Mailing List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Jun 05 14:40:46 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Z0qvE-00063M-T5
	for gcvg-git-2@plane.gmane.org; Fri, 05 Jun 2015 14:40:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752494AbbFEMkY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 5 Jun 2015 08:40:24 -0400
Received: from mail-ig0-f180.google.com ([209.85.213.180]:36418 "EHLO
	mail-ig0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751550AbbFEMkX (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 5 Jun 2015 08:40:23 -0400
Received: by igbpi8 with SMTP id pi8so14489104igb.1
        for <git@vger.kernel.org>; Fri, 05 Jun 2015 05:40:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=S7lYQJMTjPwKccfkAfcAY28Tdy1QEptMuUp3XyOmCj0=;
        b=O7R/joLOyBaswLALt2zUVOyh9phWexD2mLPS6SUgp31+l0d0MvcXiuLyofjhFkq+gu
         YkOz5V3hWf3dSzjT6nqbN06scz8msUwNmQQMqbe9Cvvgfnyr+/EA2xqEKMpNmH+M29s1
         jEsmd5bcDzayQsldYy5KRxUrHKhOw/VUnxk3PtpreS61rzE3D9clbWvxyNpgM1uhfDs9
         P2ofE8HSuoPE2F7yZFhVfHoWlk7fNRhD5LO3P3i2eEOhkPP7Hdi3NvtDqndnBDdMvIZ5
         k1G06uBTB7rLlZkNngFmnYDKfMVJeL/pHxf/TjlpoqFjbfTfgVvCzQi4e/wzjrnLYRpD
         17cw==
X-Received: by 10.42.28.135 with SMTP id n7mr9902044icc.41.1433508022397; Fri,
 05 Jun 2015 05:40:22 -0700 (PDT)
Received: by 10.64.246.103 with HTTP; Fri, 5 Jun 2015 05:40:01 -0700 (PDT)
In-Reply-To: <xmqqd21buxla.fsf@gitster.dls.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/270830>

Hi Junio,

On Fri, Jun 5, 2015 at 2:39 AM, Junio C Hamano <gitster@pobox.com> wrote:
>
> Tay Ray Chuan <rctay89@gmail.com> writes:
>
> > When running git-commit`, --verbose appends a diff to the prepared
> > message, while --no-status omits git-status output.
>
> The --verbose option is called --verbose and not --diff or --patch
> for a reason, though.  The default is to show extra information as
> comments, and verbose tells us to make that extra information more
> verbose.  We call that extra information "status", so it is natural
> for "--no-status" to drop that extra information.

Thanks for the explanation. Now I can appreciate why git-commit works this way.

Would it be a good idea to have a --diff-only option to include diff,
but not status output? Or perhaps a --diff option, while leaving it to
the user to specify if status output is to be included with
--no-status, which would open the doors for mixing and matching status
formatting control, eg. with --short.

-- 
Cheers,
Ray Chuan
