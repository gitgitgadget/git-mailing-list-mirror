From: Elijah Newren <newren@gmail.com>
Subject: Re: git-multimail: migration: Config is not iterable
Date: Thu, 29 May 2014 09:06:40 -0700
Message-ID: <CABPp-BHfUbh31ZBZk6XTMvmZjNioe1-rNpTn6tsHPNge2c-yTw@mail.gmail.com>
References: <20140529142208.GB27005@azat>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git Mailing List <git@vger.kernel.org>, mhagger@alum.mit.edu
To: Azat Khuzhin <a3at.mail@gmail.com>
X-From: git-owner@vger.kernel.org Thu May 29 18:06:47 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Wq2qs-0004Xr-7e
	for gcvg-git-2@plane.gmane.org; Thu, 29 May 2014 18:06:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757328AbaE2QGm (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 29 May 2014 12:06:42 -0400
Received: from mail-ie0-f177.google.com ([209.85.223.177]:49555 "EHLO
	mail-ie0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757287AbaE2QGl (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 29 May 2014 12:06:41 -0400
Received: by mail-ie0-f177.google.com with SMTP id y20so477980ier.8
        for <git@vger.kernel.org>; Thu, 29 May 2014 09:06:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=wY9HIZ6m3OitAcygxBGs0MTKPZP5mcTkobZerTec+qw=;
        b=qoksThfH+NJ7CQZpXZVE9m1/xXNdfSNWolEdq4YuvUJb7ZZVCnMTwRZQutf68JE1Ob
         s+yILOlL9+oFLLKoYOd0rmr3uuWQHi+vAobfhT1OMmilI7cZdFli8tlxOHkjeaoqDifk
         AuzJTuQFE1JJ9ZyhDfYmvA6Jx/2t0xqiHTOszPKbKNZmhv/kkZw6ICNXfEqUtq8HjmNx
         c2rkwpdz9T3nNLU2IkmSIiOGzRCu0nhXqReCqij5R1iCEW8V07flic0YZ7tKyk3I0bAn
         mLykrn4DWXHY6eMz174djjAgiidGgQFLf8MGaLqt9YA/qQO5EBqT4WNb3BXPG0J/cucy
         3HfQ==
X-Received: by 10.50.62.178 with SMTP id z18mr54084279igr.49.1401379600706;
 Thu, 29 May 2014 09:06:40 -0700 (PDT)
Received: by 10.64.87.195 with HTTP; Thu, 29 May 2014 09:06:40 -0700 (PDT)
In-Reply-To: <20140529142208.GB27005@azat>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/250374>

On Thu, May 29, 2014 at 7:22 AM, Azat Khuzhin <a3at.mail@gmail.com> wrote:
> Hi there,
>
> Using the latest version of git-multimail there is an issue with
> migration:
>
> $ ~azat/git-multimail/git-multimail/migrate-mailhook-config --overwrite
> Traceback (most recent call last):
...
>   File "/home/azat/git-multimail/git-multimail/migrate-mailhook-config", line 66, in _check_old_config_exists
>     if name in old:
> TypeError: argument of type 'Config' is not iterable

Thanks for the report.  I'm not the strongest on python data model and
its special methods but I believe I've got a fix:
https://github.com/mhagger/git-multimail/pull/58
