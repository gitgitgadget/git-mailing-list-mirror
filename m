From: Jacob Keller <jacob.keller@gmail.com>
Subject: Re: git merge branch --no-commit does commit fast forward merges
Date: Sun, 17 Apr 2016 16:52:58 -0700
Message-ID: <CA+P7+xqpqc1Km842QF_NwXUzjFVTQCwmQU3L12EakDjzMTFk2w@mail.gmail.com>
References: <874mb0kkkk.fsf@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git mailing list <git@vger.kernel.org>
To: Christoph Paulik <cpaulik@gmail.com>
X-From: git-owner@vger.kernel.org Mon Apr 18 01:56:29 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1arwYG-0008Up-Dj
	for gcvg-git-2@plane.gmane.org; Mon, 18 Apr 2016 01:56:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751028AbcDQXxT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 17 Apr 2016 19:53:19 -0400
Received: from mail-vk0-f43.google.com ([209.85.213.43]:35056 "EHLO
	mail-vk0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750905AbcDQXxS (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 17 Apr 2016 19:53:18 -0400
Received: by mail-vk0-f43.google.com with SMTP id t129so203008927vkg.2
        for <git@vger.kernel.org>; Sun, 17 Apr 2016 16:53:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=9Sj2HCPFiqXr4vDkezW08RSJQKWTFvusJ/RppA189Bg=;
        b=TVDLB/u4E+L8A1S2zlM9ukkJ0VLk+48rnyJ8KebdEuOWDEZQgLmVz/7fbfrR193UcU
         PWNpOYfn8NL/0pL5dzYkILlrSb4KC7IOFW768ycnw6bOhR2AkyDc2ry0jpLCD6TI/f27
         ItAlKGMAoZ/IjMu1SvGqq0U+vYA9HYzbtDjt8wYU89AxMEF8ue5jvsx9kjzD6LW8mO0R
         LzFWD8VUn+p5e22SWB21oZOxSq9VTZ7Pftk2v7LrzMteSfiyE/qlu8kirIE3e/H85eIy
         wHmF6qVL7vcBtKGLCq6TXM8DaOPkAdOWKoYsepE1g06418WuI4RMJMVWd0/oJzgT73Ew
         nO6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=9Sj2HCPFiqXr4vDkezW08RSJQKWTFvusJ/RppA189Bg=;
        b=TWXKxc991tHXkPDwtiPDmsJHGjFvYv6F+gl/zM1Gd+YavXAp+1k0XjLJaRY915uRed
         oawA8vaRExd9aXQ1r2Atty6v1keSWVeH9eMeLKc1AwT99fT4dw1XWfww/OdXRlVsFGwt
         94nfoNPBagrbwS9OK2EdfPAFhHJyqauqYKA0/tL9BC0ayZbU5xlgL+qPaIaTjQtEGC94
         AguzuVyKIhllMXHvR7Bwv9jQSqHueSmfSkvBRoofcoCLX+s1WYMQPUl3mHLQH/d/v5xx
         fPnRKzT/AoPJDi3Tduj9W3FAPwlba0L6JpjO0EtW88KXXCx9tLUjTcblu2nm2VaQlCI5
         5KkQ==
X-Gm-Message-State: AOPr4FUK35Rz797HZEy0zcoWu1xALVm0yISxtmkxwIbAqcCONzbWtdLLeYAZ0op3KSJr7bHGnVwd6iOrzxwh+Q==
X-Received: by 10.159.38.16 with SMTP id 16mr16588450uag.87.1460937197680;
 Sun, 17 Apr 2016 16:53:17 -0700 (PDT)
Received: by 10.159.53.112 with HTTP; Sun, 17 Apr 2016 16:52:58 -0700 (PDT)
In-Reply-To: <874mb0kkkk.fsf@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/291785>

On Sun, Apr 17, 2016 at 2:10 PM, Christoph Paulik <cpaulik@gmail.com> wrote:
>
> Hi Git Mailinglist,
> git merge branch --no-commit does commit fast forward merges leaving users
> no way to change the merge results. The command only works as expected when
> also adding the --no-ff flag. Looking at the help text of the --no-commit
> flag I think that this might be a unintended.
> I've tested this on git 2.8.0.
>
> This bug was first reported to magit
> (https://github.com/magit/magit/issues/2620) whose maintainer then suggested
> that it might be a git bug.
>
> Best regards,
> Christoph
>


To be fair, the user can undo it with "git reset HEAD@{1}" I believe?

Thanks,
Jake
