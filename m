From: Christian Couder <christian.couder@gmail.com>
Subject: Re: Signed-off-by vs Reviewed-by
Date: Thu, 31 Mar 2016 17:02:12 +0200
Message-ID: <CAP8UFD3UEPGA80C8OZ9uOg+Hsd3x7uJ-nJOQMGGDtB8a+3QCrA@mail.gmail.com>
References: <20160331123507.GC19857@collabora.co.uk>
	<20160331143244.GD31116@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Miklos Vajna <vmiklos@collabora.co.uk>, git <git@vger.kernel.org>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Thu Mar 31 17:02:20 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ale71-00043O-EV
	for gcvg-git-2@plane.gmane.org; Thu, 31 Mar 2016 17:02:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757184AbcCaPCP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 31 Mar 2016 11:02:15 -0400
Received: from mail-wm0-f45.google.com ([74.125.82.45]:33819 "EHLO
	mail-wm0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757160AbcCaPCO (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 31 Mar 2016 11:02:14 -0400
Received: by mail-wm0-f45.google.com with SMTP id p65so229218221wmp.1
        for <git@vger.kernel.org>; Thu, 31 Mar 2016 08:02:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc;
        bh=aNHVEyQHwTJQMeJ5VG+DEAi5JDX6HqSNPrOlZMCRCwU=;
        b=Fa1lIAKtaC6k7GKt5Te+2hXkE7CUkB4Qrot79glHOASJEQ4HB5FMc7ko2j8Xs5THq4
         Dz9J6zaoZfwi1YOzulGVdUUov9TXJsUOlWWvvkaLQi1hm+u7kk8mRlBJP/0W0tIYJbIE
         Spa0GVyWEE25wj/4m+9NZK+ES/ZY7qmjGoD20YrGc6X44YuPc3zjXullghTZEMpI4Ysx
         8Wshj0zoFpiGA4sDc1hcxTOYT6IlEP5GsNFqQ7hZLf/KqppiRqWmFGsOGm6Ha3HOkIV+
         0Z64tX4a1++un9+o/mOROHNCSSDUqXKbWJJNx+QWWsO7Wwv0EsoznvAeo9cpDLvLF4Hy
         nzOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc;
        bh=aNHVEyQHwTJQMeJ5VG+DEAi5JDX6HqSNPrOlZMCRCwU=;
        b=JgEb2akpgD/4oNsS15gHH3x4Rubifx8IfeG4qGL2WsLgzsYOnpKhU0Jp38/56EJPZi
         n9Ie3ecdt6+dyflFjMnDkJ2ZA7s6CSXT8gQgBK5+s7Sd9nmMZMnvNZjmZw0L03v6Petw
         su033SRrwTV2J+joKIdH33/mJ5ezjNDUOv0D0EDsFSLj9Hj25og+dM5gk+GC9GUNskMJ
         XtW5LYIgi/AzCqinzSo+hWvjRi+tOaL8xHihiUU8JBP2+OPMw+Vblg2vj/aUiCRTS0W1
         xqzMsxJk4cJ0TmvhhSCcWLw36QzxIBs993WX5/jXyjp7cGIC4+XlMZOoCoE8IUZJ59uz
         WOog==
X-Gm-Message-State: AD7BkJK9cXweSvgB4Q/iyRwggBlHwI/gPIOmoxI5ZmrDApAoDcnsquSbhvVLSWfGf5ByZCFBHjOnKaQ2xCKggQ==
X-Received: by 10.194.21.102 with SMTP id u6mr3690992wje.124.1459436533063;
 Thu, 31 Mar 2016 08:02:13 -0700 (PDT)
Received: by 10.194.151.131 with HTTP; Thu, 31 Mar 2016 08:02:12 -0700 (PDT)
In-Reply-To: <20160331143244.GD31116@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/290399>

On Thu, Mar 31, 2016 at 4:32 PM, Jeff King <peff@peff.net> wrote:
> On Thu, Mar 31, 2016 at 02:35:07PM +0200, Miklos Vajna wrote:
>
>> Hi,
>>
>> Some projects like LibreOffice don't use Signed-off-by, instead usually
>> use Gerrit for code review, and reviewers add a Reviewed-by line when
>> they are OK with a patch.  In this workflow it's a bit unfortunate that
>> adding a Signed-off-by line is just a command-line switch, but adding a
>> Reviewed-by line is more complex.
>>
>> Is there anything in git that could help this situation? I didn't see
>> any related config option; I wonder if a patch would be accepted to make
>> the "Signed-off-by" line configurable, or there is a better way.
>
> There's git-interpret-trailers, which can do the heavy lifting of adding
> it in the right place. But I don't know how you'd want to trigger it; it
> would depend on the workflow that people use to add their signoff in the
> first place.  I don't think there is anything as easy as "git commit
> --amend -s", but I'm not all that familiar with the interpret-trailers
> code.

The plan was to make it possible for many commands, like commit,
cherry-pick, am, and so on, to accept "--trailer ..." options and to
pass them to interpret-trailers that would process them. I remember
starting working on that and sending some patches at one point...
