From: David <bouncingcats@gmail.com>
Subject: Re: git log commit limiting "show commits with >1 child" possible?
Date: Fri, 28 Dec 2012 14:15:28 +1100
Message-ID: <CAMPXz=ove0ezk4U8ykWDb09jTbvx+yp7J4803wYpQ6MVqawXSg@mail.gmail.com>
References: <CAMPXz=rQxh3niOKiASZE3qqbYUEKXN6TscPsjPPoZjZLnCRpFA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Dec 28 04:15:51 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ToQQG-0005yI-2L
	for gcvg-git-2@plane.gmane.org; Fri, 28 Dec 2012 04:15:48 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753081Ab2L1DPb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 27 Dec 2012 22:15:31 -0500
Received: from mail-bk0-f48.google.com ([209.85.214.48]:56486 "EHLO
	mail-bk0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752645Ab2L1DP3 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 27 Dec 2012 22:15:29 -0500
Received: by mail-bk0-f48.google.com with SMTP id jc3so4427464bkc.7
        for <git@vger.kernel.org>; Thu, 27 Dec 2012 19:15:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :content-type;
        bh=ggcZ5twcsPEL5EvbtkqjgiQN9oZyAraripzvQPKb2LM=;
        b=k0cYTbvLYbwfLHikvVwaIqd1xc7IFCTDUjsY9Ad2/1HRbpvp8QLs2GmTUaBlI5+yCG
         CR58NvtouIL1o95kheu3ZDpW1MYT0EhIfPBRk3ROapawsWl64w/04V2pwWHQxhgcQWv1
         D0+LWA5gUBtNrRodfy0Dpa1WLh8yIrysW6gVmtwlbjhfc5sEYxPbQYrOXZ2una3PjsFK
         JcnPB9bHQNEpvuJKsWh4utaVnt2fJ/BS0BNBm+t95nanbtps69fzh+oqLkR+FxMbQzJW
         tI+bjx3XPQkhrt3K4noWbT0CZHJlPjjhuf7ZzGv73zZ5ncIMm/5yt/SNcXaWEkr/XSuL
         kSGg==
Received: by 10.204.143.147 with SMTP id v19mr15299067bku.32.1356664528202;
 Thu, 27 Dec 2012 19:15:28 -0800 (PST)
Received: by 10.204.165.4 with HTTP; Thu, 27 Dec 2012 19:15:28 -0800 (PST)
In-Reply-To: <CAMPXz=rQxh3niOKiASZE3qqbYUEKXN6TscPsjPPoZjZLnCRpFA@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/212222>

CORRECTION:

So I hope to see:

* 00a27e0       J
| * 160d232     I
|/
* b981ea0       F
| * daa5b69     H
|/
* 546ae44       B
* 734db0c       A

On 28/12/2012, David <bouncingcats@gmail.com> wrote:
> My branches are very long so for years I have been doing a lot of scrolling
> when using gitk. I have just now discovered how to see a simplified
> history.
>
> For this example history where commits were added in alphabetical order:
>
> A--B--C--D--H
>        \
>         E--F--G--I
>                 \
>                  J
>
> I do this:
>
> $ git log --graph --branches --simplify-by-decoration --source --oneline
> * 00a27e0       J
> | * 160d232     I
> |/
> | * daa5b69     H
> |/
> * 734db0c       A
>
> and similar in gitk using the View > Edit View > Simple History = 1
> This is a great step forward for me! I am very happy with it.
>
> Is there any way to ask git log to additionally display all commits with
> more than one child, to show where each branch diverges?
>
> So I hope to see:
>
> * 00a27e0       J
> | * 160d232     I
> |/
> * b981ea0       G
> | * daa5b69     H
> |/
> * 546ae44       C
> * 734db0c       A
>
> I have read man git-log but I do not understand it all. If there is a way
> to
> achieve this then I am not seeing it.
>
> I notice that there is commit limiting by --merges and --no-merges.
> If --merges means "show only commits with more than one parent", and
> --no-merges means "show only commits with only one parent", what I
> want is "show also commits with more than one child".
>
> Or perhaps "show only commits with more than one parent or child".
>
> Is there a way to do this? It will be nice if it also works in gitk.
> Presently I have git version 1.7.2.3
>
