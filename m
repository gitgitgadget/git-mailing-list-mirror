From: Stefan Beller <sbeller@google.com>
Subject: Re: [PUB]corrupt repos does not return error with `git fsck`
Date: Wed, 20 May 2015 11:54:27 -0700
Message-ID: <CAGZ79kb9xUZfa9923rrUP1x0T2=KzczmmNyYi5zD30mWKJ81KQ@mail.gmail.com>
References: <alpine.DEB.2.11.1505202142540.9343@orwell.homelinux.org>
	<vpq382rkvzf.fsf@anie.imag.fr>
	<d21002e0fa92b03c3d417c8996328563@www.dscho.org>
	<CAGZ79kZY68HFDipxLVas9Dg9+NfpOGmywpWfwFL31A0EpLmJFw@mail.gmail.com>
	<alpine.DEB.2.11.1505202341170.9343@orwell.homelinux.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Johannes Schindelin <johannes.schindelin@gmx.de>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
	"git@vger.kernel.org" <git@vger.kernel.org>
To: Faheem Mitha <faheem@faheem.info>
X-From: git-owner@vger.kernel.org Wed May 20 20:54:35 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Yv98U-0003Aw-KF
	for gcvg-git-2@plane.gmane.org; Wed, 20 May 2015 20:54:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752566AbbETSy3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 20 May 2015 14:54:29 -0400
Received: from mail-qg0-f54.google.com ([209.85.192.54]:35411 "EHLO
	mail-qg0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752552AbbETSy2 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 20 May 2015 14:54:28 -0400
Received: by qgew3 with SMTP id w3so28217436qge.2
        for <git@vger.kernel.org>; Wed, 20 May 2015 11:54:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=a7zrJ3ZL4O7FV6VckU1Sqq1WweZs9YlBD/UL/38MECs=;
        b=BNkdbN+Uis/sfx9yHItyyLHHIQ3OVAkIJkkK190H9mGqlHWvm2C9g5xHD+qCjOivma
         p/pEaeY3LOqEo3IzFKIIqoAmO0DvJ5+brrqn2Kj7jfxUcG32xlQkJVqCmHm/sFGTYYrw
         t/9tR0rjqt/e8hpALsr9qME7nj8GKrMqZRrmrJ4nwnvVnzCfxm0DHAoJPefVz1bJUeQu
         osORz+ymcI313hEF7C5/DjeS6L0LyTxmX7bHyrwtI8IIaFjKWTWuAYghMmLZkwQfNmHP
         OJkpOfONfKOztU7RKLpz6CyhORAbM/VGT8YKEW/s9/qwwI/Pr+7PknqBqVglruIlOn6m
         ggpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type;
        bh=a7zrJ3ZL4O7FV6VckU1Sqq1WweZs9YlBD/UL/38MECs=;
        b=d+itvQJ3Us31Ywz/2mzDRJUf0K3zkvZmbJHM4mT9so9pNwRjUHfPXqYI1XESe8jIYB
         DhGvie9UsznhQvPIFuK1H9JrMNtimwvi17kTmWRronKohy9luMDl5XLrksQvtW4Zzkez
         4Njn/kzNoqBZjKUGUXuOijp0fCd2tzg4nnjbNkZPf2kt0H54HzA+F3nkIX4BeaCYj4+e
         src+BmslFxJjDiTAUcMvwDdVI07igYwp8Qv1vgEnoPrMdptWE52boXyEW7abHMerqkZX
         /YIDP7DVLT4dTHUX1zwNgu31iwKe17LQ3t23R69OKXQzpeJxiR2YjN00+e1G/S4UYrtG
         z6iw==
X-Gm-Message-State: ALoCoQk/yS8u+PDku6hOhRUX3F/8xd2LX8gwlqEjjdGMhm0sYXFIkeo7yKwp3XrTnZOW2dlmQ6Y5
X-Received: by 10.140.23.35 with SMTP id 32mr45244891qgo.106.1432148067857;
 Wed, 20 May 2015 11:54:27 -0700 (PDT)
Received: by 10.140.43.117 with HTTP; Wed, 20 May 2015 11:54:27 -0700 (PDT)
In-Reply-To: <alpine.DEB.2.11.1505202341170.9343@orwell.homelinux.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/269492>

On Wed, May 20, 2015 at 11:24 AM, Faheem Mitha <faheem@faheem.info> wrote:

> So, is the repos corrupt or not? Also, I don't understand why you say
>
>     There is no file 28/0c... however.
>
> Why would you expect there to be? I don't see it mentioned in that list.
>

Each object is stored at .git/objects/<xz>/<tail> with <xz> being the first
2 characters of the sha1 and the tail the remaining 38 characters of the sha1.
I did not draw a conclusion yet, as I needed to run for a meeting.

So the object you're looking for is not there (stating this as a fact).
But why would you expect it to be there? At the time of sending the previous
email I tried to do a reverse search "Give me all objects, which
reference objectX"
but did not succeed yet.

Stefan
