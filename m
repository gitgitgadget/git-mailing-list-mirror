From: Andrew Ardill <andrew.ardill@gmail.com>
Subject: Re: Can I zip a git repo without losing anything?
Date: Mon, 26 Nov 2012 16:06:25 +1100
Message-ID: <CAH5451n4EQ16-bpKGiDZMu42ewSX_Jeg3Z9mcCHvvBv-xzoTfw@mail.gmail.com>
References: <CAP-uhDcQg0BuEdHDTa6qVqLCeB-LE1GZtEqHgY_j1--XodsDKw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: "git@vger.kernel.org" <git@vger.kernel.org>
To: Carl Smith <carl.input@gmail.com>
X-From: git-owner@vger.kernel.org Mon Nov 26 06:07:06 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TcquN-00070U-NE
	for gcvg-git-2@plane.gmane.org; Mon, 26 Nov 2012 06:07:04 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751282Ab2KZFGr (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 26 Nov 2012 00:06:47 -0500
Received: from mail-qa0-f46.google.com ([209.85.216.46]:60293 "EHLO
	mail-qa0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751250Ab2KZFGq (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 26 Nov 2012 00:06:46 -0500
Received: by mail-qa0-f46.google.com with SMTP id c11so2565738qad.19
        for <git@vger.kernel.org>; Sun, 25 Nov 2012 21:06:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=am1W8mVYpCDvDMmwClP/sEzcmT2ITgWakMMS4Khw/2c=;
        b=xKz76B2ugbaVE96w6YhDdYJzb8m6M/E6StogY9t9Zql+GEgFCxFjKIcc9nti5RC3ft
         /vigm22HbmMNotNcJ2g7k4M16NBTcxDEKLJ6xt5ILb6ecxTbfG/AQxpANwtp8n/W/8Hh
         KzyVOWVnP8NSmBRoQb3wgs17A7/Ioj+mAx3sUiE2Z97QiI0XaWghNPncl73XtmrgumxS
         mQ3NOASa0RxZI6F8fFrP6gQ4+pId8jIVGYScxoRE0AUTldmauDLgGXGUes+i9S2Yjdef
         JkjUM2R4hq7WZxpQwpS7XLo3QELaO1ANuzS3wuLgJs/j7vFalEiUFdOSPZfbVS3A03Vt
         Frbw==
Received: by 10.49.118.74 with SMTP id kk10mr11970442qeb.44.1353906405607;
 Sun, 25 Nov 2012 21:06:45 -0800 (PST)
Received: by 10.49.119.65 with HTTP; Sun, 25 Nov 2012 21:06:25 -0800 (PST)
In-Reply-To: <CAP-uhDcQg0BuEdHDTa6qVqLCeB-LE1GZtEqHgY_j1--XodsDKw@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/210412>

On 26 November 2012 15:55, Carl Smith <carl.input@gmail.com> wrote:
> Hi all
>
> This is my first post to this list, so thank you for all your work.
>
> After suggesting using zip files to move our projects around, I was
> told that you can not zip a git repo without loosing all the history.
> This didn't make sense to me, but two people told me the same thing,
> so I wasn't sure. I think they may have been confusing the zipped file
> you can download from GitHub with a zipped git repo.

Hi Carl,

The basics of it are as follows, a little simplified to hopefully make it clear

Git uses a working directory that contains the files which you are
working on. These get converted into a snapshot when you commit, and
these commits form the history of your project. These snapshots along
with everything else that git needs to work are stored in the git
directory, often called ".git".

When you zip the files you are working on you are creating a manual
snapshot of your project. If you zip the git directory you are
compressing the entire git repository and this has enough information
to recreate your entire history. If you zip both of them you get your
history as well as any changes that have not been committed yet. When
a server holds a copy of your repository it will not include a working
directory at all, but instead just the git directory. In this
situation the git directory will often be called the same name as the
project.

The zip from GitHub does indeed only contain the working directory,
and so doesn't include the history.

Hope that helps!

Regards,

Andrew Ardill
Regards,

Andrew Ardill
