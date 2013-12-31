From: Thiago Farina <tfransosi@gmail.com>
Subject: Re: [PATCH] gc: notice gc processes run by other users
Date: Tue, 31 Dec 2013 18:35:47 -0200
Message-ID: <CACnwZYe91VOX=JYOOek5UsDv4=F5wEDPj_20H5iyZKnurgXgzQ@mail.gmail.com>
References: <720d7a5676f8cbfc76c80198f9d3816@74d39fa044aa309eaea14b9f57fe79c>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Junio C Hamano <gitster@pobox.com>,
	=?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41jIER1eQ==?= 
	<pclouds@gmail.com>, Git Mailing List <git@vger.kernel.org>
To: "Kyle J. McKay" <mackyle@gmail.com>
X-From: git-owner@vger.kernel.org Tue Dec 31 21:35:53 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Vy62b-0003mc-0C
	for gcvg-git-2@plane.gmane.org; Tue, 31 Dec 2013 21:35:53 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756603Ab3LaUfs (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 31 Dec 2013 15:35:48 -0500
Received: from mail-qe0-f53.google.com ([209.85.128.53]:38655 "EHLO
	mail-qe0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756521Ab3LaUfs (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 31 Dec 2013 15:35:48 -0500
Received: by mail-qe0-f53.google.com with SMTP id nc12so13053183qeb.12
        for <git@vger.kernel.org>; Tue, 31 Dec 2013 12:35:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=r6ulrHu3hzeoYCWpYfc87W1zOYSo935bMEQt2lhc2Mg=;
        b=WRHtGFe38u1jg/3X7Xwx8IMYS979XvQv7FexPGkiMIhm+GvHQFycYm7cSy4wZnrQ2j
         grtN5QpURuFLQ0kzSK/cday1QwdKmVyFGsQUu1qBCKmFWggLzh/MdvKDe2MhHwpgPx15
         LxWveTpogvJPag45dq1TBS33MWAXhuKgfzQHe5KRIATwRdbxVHRIZJ3TdsWEemGRiTjD
         qwJZQt25nKB8qYnS8DOPZeAqgjX1ZVZtlsLrvxwwS69dqWpuU6M3Jh9TzoGn+MZGACAX
         uwjSTD3nIo4s3ihLuzEjZvqJxZYHwHXy/EkYEOWrUEDgziKi6pQsrZ8VYRPAbWDmMCAc
         nmpA==
X-Received: by 10.49.12.43 with SMTP id v11mr123813455qeb.50.1388522147238;
 Tue, 31 Dec 2013 12:35:47 -0800 (PST)
Received: by 10.224.33.79 with HTTP; Tue, 31 Dec 2013 12:35:47 -0800 (PST)
In-Reply-To: <720d7a5676f8cbfc76c80198f9d3816@74d39fa044aa309eaea14b9f57fe79c>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/239844>

On Tue, Dec 31, 2013 at 10:07 AM, Kyle J. McKay <mackyle@gmail.com> wrote:
> Since 64a99eb4 git gc refuses to run without the --force option if
> another gc process on the same repository is already running.
>
> However, if the repository is shared and user A runs git gc on the
> repository and while that gc is still running user B runs git gc on
> the same repository the gc process run by user A will not be noticed
> and the gc run by user B will go ahead and run.
>
> The problem is that the kill(pid, 0) test fails with an EPERM error
> since user B is not allowed to signal processes owned by user A
> (unless user B is root).
>
> Update the test to recognize an EPERM error as meaning the process
> exists and another gc should not be run (unless --force is given).

Looks like you are missing your Signed-off-by: line.

--
Thiago Farina
