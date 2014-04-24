From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: [PATCH] git-rebase: fix probable reflog typo
Date: Thu, 24 Apr 2014 02:22:06 -0500
Message-ID: <5358bb9ea7d42_1f7b143d310c6@nysa.notmuch>
References: <1398212084-16304-1-git-send-email-felipe.contreras@gmail.com>
 <vpqy4ywxoos.fsf@anie.imag.fr>
 <53582f33385bc_24448772ec57@nysa.notmuch>
 <vpqzjjb1c4m.fsf@anie.imag.fr>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, Ramkumar Ramachandra <artagnon@gmail.com>
To: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
	Felipe Contreras <felipe.contreras@gmail.com>
X-From: git-owner@vger.kernel.org Thu Apr 24 09:32:40 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WdE99-0002BC-OS
	for gcvg-git-2@plane.gmane.org; Thu, 24 Apr 2014 09:32:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752677AbaDXHcf (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 24 Apr 2014 03:32:35 -0400
Received: from mail-oa0-f44.google.com ([209.85.219.44]:44882 "EHLO
	mail-oa0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752469AbaDXHce (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 24 Apr 2014 03:32:34 -0400
Received: by mail-oa0-f44.google.com with SMTP id n16so2231542oag.17
        for <git@vger.kernel.org>; Thu, 24 Apr 2014 00:32:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:message-id:in-reply-to:references:subject
         :mime-version:content-type:content-transfer-encoding;
        bh=xzqaeRvbqOC0GKeWt2t8afgbm0vUjReqcp5U3+4rG40=;
        b=WkR0dYWAPywgBX214h8Y0jS6y6wBv6FtLbLM3UUXdWQts/0086W+v8lXvDwr3Tanz5
         gB8chE5hJAeqenMAKGR0x3x2yTywwzXEaolFJ/EyyAw8/H3sY32veDIWNCDsAkCWJkwM
         WtdyDmyZSmVsOaO8LoB1JcvyRnnIuX1cv0E2xayEHHJ7GUJh2+vL04gScg0WErtyVphW
         8coInjhZ2CiojtostsMsU1ikl7E7dPT6QaHhjZ38Zh/LJV+mySZoynOfo9Yv03E+aY2A
         AOojwAdXjq5OK48/XhQpJdZSHYS6h7b3nmF6pAtkkoOPDTnY5NQdbcJElwu0U+ShwRRj
         taXg==
X-Received: by 10.182.165.3 with SMTP id yu3mr238711obb.14.1398324753755;
        Thu, 24 Apr 2014 00:32:33 -0700 (PDT)
Received: from localhost (189-211-224-40.static.axtel.net. [189.211.224.40])
        by mx.google.com with ESMTPSA id b6sm14381195oez.8.2014.04.24.00.32.30
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 24 Apr 2014 00:32:32 -0700 (PDT)
In-Reply-To: <vpqzjjb1c4m.fsf@anie.imag.fr>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/246944>

Matthieu Moy wrote:
> Felipe Contreras <felipe.contreras@gmail.com> writes:
> > Matthieu Moy wrote:
> >> Felipe Contreras <felipe.contreras@gmail.com> writes:
> >> 
> >> > Commit 26cd160 (rebase -i: use a better reflog message) tried to produce
> >> > a better reflog message, however, it seems a statement was introduced by
> >> > mistake.
> >> >
> >> > 'comment_for_reflog start' basically overides the GIT_REFLOG_ACTION we
> >> > just set.
> >
> >> So, one needs to reset $GIT_REFLOG_ACTION to what it used to be if is it
> >> to be used later. However, it seems to me that the "comment_for_reflog
> >> start" is used only for this checkout command. If so, there's no need
> >> for the "comment_for_reflog start" before the if statement either.
> >
> > Exactly. But if this variable is only meant for this command, it should be
> > `VAR=VAL command`, that would make it clear without the need of a comment.
> 
> I don't understand. Are you suggesting to replace the shell function
> "output" with an external command? If not, which command would you want
> to call here?

Recently some code was changed to do 'test_must_fail env VAR=VAL command', why
can't we do the same?

-- 
Felipe Contreras
