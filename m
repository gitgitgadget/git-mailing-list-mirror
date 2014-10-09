From: Derek Moore <derek.p.moore@gmail.com>
Subject: Re: Some PRETTY FORMATS format:<string> options don't work with
 git-archive export-subst $Format:$
Date: Thu, 9 Oct 2014 12:42:39 -0500
Message-ID: <CAMsgyKYKAUXamcGOtUi3Bq-u4B9JaG2sk-Gttf+A1U2mwhghrw@mail.gmail.com>
References: <CAMsgyKb_-Xm0DH1-xVZa0XHs59nZsOxGwwLWKx-YiTmsJtrFHQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Oct 09 19:42:46 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XcHjh-0002MP-0i
	for gcvg-git-2@plane.gmane.org; Thu, 09 Oct 2014 19:42:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751390AbaJIRml (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 9 Oct 2014 13:42:41 -0400
Received: from mail-oi0-f41.google.com ([209.85.218.41]:36123 "EHLO
	mail-oi0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750855AbaJIRmk (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 9 Oct 2014 13:42:40 -0400
Received: by mail-oi0-f41.google.com with SMTP id u20so3736890oif.28
        for <git@vger.kernel.org>; Thu, 09 Oct 2014 10:42:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :content-type;
        bh=0D3GLQskmsEarLoq1TFtR462hzACzLewc25M/Q6LqrI=;
        b=tsA6hcwPqEsZpbic58RjyTJSX4sl4vjE2SCRMUrPMazQjfLM0TCDyBBXfzjpJEN6dR
         GtBOW7n5chPjIQ0wG0FZMx4EkQ4SpYkqXdQlh7JUwLFzI6jOFNDEeYf8YHxnXO+Qmt1P
         PYEe0ZzWIOUfGrV5b2Gn0ugOhj5VXNcwAOlKzGARYiA6D7duW8HlOS9ic28YXUg+K350
         LzEuRvD1LKwoKu4XtwqzI36pMwcYS/sRbzoHTBmjfFpA2ysADBbHGTAanyfxfTdiv7DW
         5FIe0DkvsPwJDlpP9Ywk4dcqIdJYaFUY+bxxVojtKHNa3GRG/oLtw0iAqfsnJT9/N35H
         K1uA==
X-Received: by 10.182.246.2 with SMTP id xs2mr25127944obc.63.1412876559733;
 Thu, 09 Oct 2014 10:42:39 -0700 (PDT)
Received: by 10.76.33.68 with HTTP; Thu, 9 Oct 2014 10:42:39 -0700 (PDT)
In-Reply-To: <CAMsgyKb_-Xm0DH1-xVZa0XHs59nZsOxGwwLWKx-YiTmsJtrFHQ@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Oct 9, 2014 at 10:56 AM, Derek Moore <derek.p.moore@gmail.com> wrote:
> I first noticed this using the system git provided in Fedora 21, so I
> cloned the official git repo, built from source, and it would appear
> there are even more options that don't work with export-subst in the
> latest code.

I'm a dumb ass. After installing my newly compiled git to /usr/local,
I neglected to spawn a new shell so the new binary could get picked up
by my $PATH. Despite /usr/local/bin preceding /usr/bin, /usr/bin/git
was cached by my shell, and 'which git' was lying to me, therefore my
testing of new format:<string> options was invalid.

I must retract the statement "and it would appear there are even more
options that don't work with export-subst in the latest code."

As far as I've tested it would seem only %N doesn't resolve inside of
$Format:$, until I maybe do unit tests for this to identify any
others.
