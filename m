From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: [PATCH v2] prompt: fix show upstream with svn and zsh
Date: Wed, 22 May 2013 02:56:05 -0500
Message-ID: <CAMP44s2KhSNXF8rkkYcGvzi7xxr11oXQW4+Yj3-u+aZ1EDHguQ@mail.gmail.com>
References: <1369169667-25166-1-git-send-email-t.gummerer@gmail.com>
	<1369208439-20061-1-git-send-email-t.gummerer@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git@vger.kernel.org, szeder@ira.uka.de, gitster@pobox.com
To: Thomas Gummerer <t.gummerer@gmail.com>
X-From: git-owner@vger.kernel.org Wed May 22 09:56:14 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Uf3u8-0002q3-Nz
	for gcvg-git-2@plane.gmane.org; Wed, 22 May 2013 09:56:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755776Ab3EVH4I (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 22 May 2013 03:56:08 -0400
Received: from mail-la0-f42.google.com ([209.85.215.42]:44854 "EHLO
	mail-la0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755770Ab3EVH4H (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 22 May 2013 03:56:07 -0400
Received: by mail-la0-f42.google.com with SMTP id fg20so1631657lab.29
        for <git@vger.kernel.org>; Wed, 22 May 2013 00:56:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=oWAEC6Hzrcvl798QAeHPy9xNAM+v/fPstZ+3WNxSM5M=;
        b=RzL/MncB4dRQRtlkTjbYCZY6Lb/QIVcUAOxP0bkystX0mg32ar85ojWi+mPzLSde+7
         pPJO8MoYaoQS6EsgBgNYHWJ5eMbWXuAJEOGH1Ay/KjjC24ER2qFa8cJrA/11FCRpwP34
         nUjJFgRG0waisRVOy0shmRK8GRUXhvxN4CZUxE9++P4r9RvspCHjkQvHKgXLXOeiaxtf
         LQPWbpQ4J+JM3Fw22/+lscl41NMhfKCdod52quIJDDj9l9YxgIGxq6BJfRZHGx2Cu9Et
         dh3D1n2DS+28n12XQwvsYeEkK5KtBCQjognJygJHYnXQdbZv0G7ncqvJSn+jOmf+4Kyy
         tEmg==
X-Received: by 10.112.167.229 with SMTP id zr5mr3439062lbb.7.1369209365366;
 Wed, 22 May 2013 00:56:05 -0700 (PDT)
Received: by 10.114.174.170 with HTTP; Wed, 22 May 2013 00:56:05 -0700 (PDT)
In-Reply-To: <1369208439-20061-1-git-send-email-t.gummerer@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/225138>

On Wed, May 22, 2013 at 2:40 AM, Thomas Gummerer <t.gummerer@gmail.com> wrote:
> Currently the __git_ps1 git prompt gives the following error with a
> repository converted by git-svn, when used with zsh:
>
>    __git_ps1_show_upstream:19: bad pattern: svn_remote[
>    __git_ps1_show_upstream:45: bad substitution
>
> To reproduce the problem, the __git_ps1_show_upstream function can be
> executed in a repository converted with git-svn.  Both those errors are
> triggered by spaces after the '['.
>
> Zsh also doesn't support initializing an array with `local var=(...)`.
> This triggers the following error:
>
>    __git_ps1_show_upstream:41: bad pattern: svn_upstream=(commit
>
> Use
>    local -a
>    var=(...)
> instead to make is compatible.
>
> This was introduced by 6d158cba (bash completion: Support "divergence
> from upstream" messages in __git_ps1), when the script was for bash
> only.
>
> Signed-off-by: Thomas Gummerer <t.gummerer@gmail.com>

I think there's no need to be so verbose in the commit message, but
hey, that's just an opinion.

Acknowledged-by: Felipe Contreras <felipe.contreras@gmail.com>

-- 
Felipe Contreras
