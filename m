From: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
Subject: Re: Long clone time after "done."
Date: Wed, 24 Oct 2012 11:29:00 +0700
Message-ID: <CACsJy8DvNSVSUT_9ym52pVaDSNMk10WfaVGhfgQeC8+SOWSpEw@mail.gmail.com>
References: <CAMJd5AQBbnFqT5xrFuPOEsJevwDE=jUgBVFZ5KqTZk5zv5+NOw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git@vger.kernel.org
To: Uri Moszkowicz <uri@4refs.com>
X-From: git-owner@vger.kernel.org Wed Oct 24 06:29:44 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TQsb9-0004i4-Hb
	for gcvg-git-2@plane.gmane.org; Wed, 24 Oct 2012 06:29:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753265Ab2JXE3b (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 24 Oct 2012 00:29:31 -0400
Received: from mail-ob0-f174.google.com ([209.85.214.174]:55957 "EHLO
	mail-ob0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751170Ab2JXE3a (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 24 Oct 2012 00:29:30 -0400
Received: by mail-ob0-f174.google.com with SMTP id uo13so92969obb.19
        for <git@vger.kernel.org>; Tue, 23 Oct 2012 21:29:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=h4utVALrKv3JnVWmtPc7wd65sak12inZ4yfWibhMbH4=;
        b=TdDecmi6hiFRhEShZilFiazO/BBnlfQipi1tosaeQNCygdQ66eHMCR/4wnxnPwhrpc
         lYHWW01lYh4S0taWggMZXJJD/bEKWxX6NzivBDS/s8ZHMw67jkj77CkkbvIsX/S7S+8t
         Pl2J4h1Wh7jO1mBuKku7wriYrkJGDkB6d2bDBj9KlpjSMQ2TYKSOohqx2Z9ZHkCVZ2Jd
         KofH51Ibwc0xPc2E+r0F1ygYrpHhBmOI7mLaJVxOAnswqHsTCQ72mVyiGF7PDZqXivfh
         7iIWjpdsIlk/GTsgYT15coZRKwf694Um8QcQn0BaFADLmXjCsBJaMJW4QbSyiYqmyHtg
         gHiQ==
Received: by 10.182.174.39 with SMTP id bp7mr11906498obc.1.1351052970340; Tue,
 23 Oct 2012 21:29:30 -0700 (PDT)
Received: by 10.182.108.10 with HTTP; Tue, 23 Oct 2012 21:29:00 -0700 (PDT)
In-Reply-To: <CAMJd5AQBbnFqT5xrFuPOEsJevwDE=jUgBVFZ5KqTZk5zv5+NOw@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/208284>

On Wed, Oct 24, 2012 at 1:30 AM, Uri Moszkowicz <uri@4refs.com> wrote:
> I have a large repository which I ran "git gc --aggressive" on that
> I'm trying to clone on a local file system. I would expect it to
> complete very quickly with hard links but it's taking about 6min to
> complete with no checkout (git clone -n). I see the message "Clining
> into 'repos'... done." appear after a few seconds but then Git just
> hangs there for another 6min. Any idea what it's doing at this point
> and how I can speed it up?

"done." is printed by clone_local(), which is called in cmd_clone().
After that there are just a few more calls. Maybe you could add a few
printf in between these calls, see which one takes most time?
-- 
Duy
