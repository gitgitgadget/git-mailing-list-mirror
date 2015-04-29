From: Roberto Tyley <roberto.tyley@gmail.com>
Subject: Re: Bug report : bad filter-branch (OSX only)
Date: Wed, 29 Apr 2015 15:42:07 +0100
Message-ID: <CAFY1edZ=NjiRsBB6TyiR_as3vtiFHSQthKbnhbNPdKKtYNH2mg@mail.gmail.com>
References: <CAM=W1NkZr6o-DCxXskeWC8xjRMiT2P9qXeeUe91qLBqOxzqNtg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: "git@vger.kernel.org" <git@vger.kernel.org>
To: Olivier ROLAND <cyrus-dev@edla.org>
X-From: git-owner@vger.kernel.org Wed Apr 29 16:42:23 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YnTBm-0006aU-4J
	for gcvg-git-2@plane.gmane.org; Wed, 29 Apr 2015 16:42:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1031716AbbD2OmK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 29 Apr 2015 10:42:10 -0400
Received: from mail-ie0-f174.google.com ([209.85.223.174]:36016 "EHLO
	mail-ie0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1031651AbbD2OmI (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 29 Apr 2015 10:42:08 -0400
Received: by iebrs15 with SMTP id rs15so43794445ieb.3
        for <git@vger.kernel.org>; Wed, 29 Apr 2015 07:42:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=f95fLuR+FW6FYI4FXzc7u0w1eHiXaayJLlNMg7Yu3Xo=;
        b=hh2hPCoK97BC0QqUt1JXqo5e84miY6g7wi82eMPFtkZSPhTIAnm+7WRGpcz2xDCs+p
         y6mi1xinX7Uw7aDzGaegsfEHs+KLp/JnObGa+O7wxm/yX4QQAKwlnBc4nTwfmf/M4b81
         UMROwBymiFi5Z/1owsQRTOmCNXre2fOmPkfQZyi46t184W+qZh7iUcS8wKBtS7twaiwb
         gR1wIV1jmTZMFqz9UF3gnmccJVze0KhYax+025ujRDUnEEtpUUOgk9C+LFyNzCA8iP9P
         Pxix9Jzghvp7HM81aLmtJ6lXQMpoAcyoi3rttLvGtrlZRz3Mal8qMbFyvrJKsMTCVnCm
         hlbg==
X-Received: by 10.107.10.201 with SMTP id 70mr29083707iok.0.1430318527205;
 Wed, 29 Apr 2015 07:42:07 -0700 (PDT)
Received: by 10.64.121.6 with HTTP; Wed, 29 Apr 2015 07:42:07 -0700 (PDT)
In-Reply-To: <CAM=W1NkZr6o-DCxXskeWC8xjRMiT2P9qXeeUe91qLBqOxzqNtg@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/267966>

As an aside, if you're a Scala dev
(https://github.com/begeric/FastParsers is a scala library), you might
find it fun to play with https://rtyley.github.io/bfg-repo-cleaner/ -
you could probably write some scala (eg a custom BFG
CommitNodeCleaner) that would do whatever it is you want filter-branch
to do.

Roberto

On 26 April 2015 at 10:25, Olivier ROLAND <cyrus-dev@edla.org> wrote:
> Hello,
>
> Seem to be a bug.
>
> OSX 10.10.3 git 2.3.6 HFS+ case-sensitive
>
> How to reproduce :
> Step 1 : git clone https://github.com/begeric/FastParsers.git
> Step 2 : cd FastParsers/
> Step 3 : git filter-branch --env-filter 'if [ 0 = 1 ]; then echo 0; fi' -- --all
>
> Result on OSX :
> Rewrite 65df7c5ac1ed956252b07b8c911ad7eba0a15c2b (206/206)
> Ref 'refs/heads/experiment' was rewritten
> Ref 'refs/remotes/origin/experiment' was rewritten
> WARNING: Ref 'refs/remotes/origin/experiment' is unchanged
> Ref 'refs/remotes/origin/master' was rewritten
>
> Result on Debian :
> Rewrite 65df7c5ac1ed956252b07b8c911ad7eba0a15c2b (206/206)
> WARNING: Ref 'refs/heads/experiment' is unchanged
> WARNING: Ref 'refs/remotes/origin/experiment' is unchanged
> WARNING: Ref 'refs/remotes/origin/experiment' is unchanged
> WARNING: Ref 'refs/remotes/origin/master' is unchanged
>
> Do you have any thoughts on this ?
>
> Thanks.
> --
> To unsubscribe from this list: send the line "unsubscribe git" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
