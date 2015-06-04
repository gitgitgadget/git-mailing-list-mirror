From: Christian Couder <christian.couder@gmail.com>
Subject: Re: Permission denied ONLY after pulling bundles
Date: Thu, 4 Jun 2015 21:06:07 +0200
Message-ID: <CAP8UFD1=96Y484GvG9ms2uiWm2uyWO0qE2Lh6SH2UwrwHpEF8w@mail.gmail.com>
References: <CAJeiYQGUsB-9XYdnqDgoSy5JU-EVTbf-1OuTU5BGfpT9q6xKbg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git <git@vger.kernel.org>, dario.ligorio@selex-es.com
To: Rossella Barletta <rossella.barletta@gmail.com>
X-From: git-owner@vger.kernel.org Thu Jun 04 21:06:23 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Z0aT3-0002y1-8E
	for gcvg-git-2@plane.gmane.org; Thu, 04 Jun 2015 21:06:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752335AbbFDTGL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 4 Jun 2015 15:06:11 -0400
Received: from mail-wi0-f171.google.com ([209.85.212.171]:38375 "EHLO
	mail-wi0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751632AbbFDTGJ (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 4 Jun 2015 15:06:09 -0400
Received: by wibdt2 with SMTP id dt2so59664299wib.1
        for <git@vger.kernel.org>; Thu, 04 Jun 2015 12:06:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=mD+YZ3/DpWexOxuK4cj190wKGXqmBRce5G6ziqcyBbg=;
        b=uGxkOEuV8x3N4+xUCVpvS4An+a+LvCkEVqHPD9W/eSp3f8xLt0eXRuxsE9atMIbw6c
         f+ck4Q2N1uHCksHs6+XuH0UdEp0zzAEGxFalyvfJl6B5oRrzr8/WsJ6BR5Wsoz3wdD4u
         FzSNYnenVkoWPgEtoHLJGeoeeeUM/I+DCvduH2MJRsQKgRCDgekIz9tbaU304bQ3j4Ef
         vjoIN37AwJ5l5X2UIbV5VAR98BegcHG3931mJmGtCVDN+Lemv7lhuIHvC5P3CUmU3Fs7
         JNzFZfyTDrNSQgXIV7zCIAxNGgboxf8Nqg2ViKe7yBrnX0joEeqagsA0+MEztVeuQ8di
         oYuA==
X-Received: by 10.194.95.132 with SMTP id dk4mr75256323wjb.88.1433444767806;
 Thu, 04 Jun 2015 12:06:07 -0700 (PDT)
Received: by 10.194.40.8 with HTTP; Thu, 4 Jun 2015 12:06:07 -0700 (PDT)
In-Reply-To: <CAJeiYQGUsB-9XYdnqDgoSy5JU-EVTbf-1OuTU5BGfpT9q6xKbg@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/270794>

Hi,

On Thu, Jun 4, 2015 at 3:04 PM, Rossella Barletta
<rossella.barletta@gmail.com> wrote:
> Dear git group,
>
>
> I would like to ask your help for a problem that we cannot fix in any way.
>
> We have a git repository in folder on Windows.
>
> Then we use VMware player on CentOS_6 on which we create a clone of
> the git repository, after of course having mounted the directory in
> which the repository is.
>
> So the repository is on windows and the clone on Linux.
>
> We are able to perfom all the git operations we need, except for the
> pull .bundle, which is successful in itself but prevent us from
> pushing after that.

It is not very clear how the bundle has been made, and on which
machine you made it and you pulled from it.

> As we try to push after pulling a .bundle in a branch we get the error message
>
> NODE1:fdp> git push
> Counting objects: 1977, done.
> Delta compression using up to 2 threads.
> Compressing objects: 100% (423/423), done.
> fatal: write error: Permission denied00 KiB | 158 KiB/s
> error: pack-objects died of signal 13
> error: pack-objects died with strange error

Can you have a look at the machine you push to and see if some file or
directory permissions changed between before and after you made the
bundle or you pulled the bundle?

> We have checked all the permissions, changed the users, recreated the
> clone but nothing worked.

What do you mean by checked all the permissions?
You mean that permissions haven't changed at all since before you
pulled the first bundle?

> The push operation works perfectly until we pull a bundle. After
> pulling a bundle we are not able to push anymore.We tryed to delete
> the branches, recreate others and all works perfectly, also the
> push.As we pull the .bundle we cannot get the permission to do the
> push anymore.
>
> What has this to do with the bundle?

Did you try to everything (cloning, creating a bundle, pulling it and
pushing on the same machine to see if it makes a difference? Also did
you try with another smaller fake repository?

If you can reproduce with a smaller fake repo on just one machine it
could help us reproduce on one of our machine and have a look.

And could you tell us which version of git (using git --version) you
are using on both machines?

Thanks,
Christian.
