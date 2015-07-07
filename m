From: Jacob Keller <jacob.keller@gmail.com>
Subject: Re: Whether Git supports directory level access or not?
Date: Tue, 7 Jul 2015 00:20:27 -0700
Message-ID: <CA+P7+xpqk2m2Mxv_12Mg+03GzqVa5kzVk29HAOMiW9EGpmrWww@mail.gmail.com>
References: <705bdbdc6a8195d59203bcb1f3027714@stockal.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git@vger.kernel.org
To: saurabh@stockal.com
X-From: git-owner@vger.kernel.org Tue Jul 07 09:20:53 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZCNBU-0006gv-5i
	for gcvg-git-2@plane.gmane.org; Tue, 07 Jul 2015 09:20:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752071AbbGGHUs (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 7 Jul 2015 03:20:48 -0400
Received: from mail-oi0-f45.google.com ([209.85.218.45]:34502 "EHLO
	mail-oi0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751458AbbGGHUr (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 7 Jul 2015 03:20:47 -0400
Received: by oiab3 with SMTP id b3so16971832oia.1
        for <git@vger.kernel.org>; Tue, 07 Jul 2015 00:20:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=Fh57RArblWl8l5Ky3F/tyTV3865P32nMScaxVaY00+o=;
        b=H3bINFQ1PgPjEyrpAt8lMR/TOla4s961dwIZUViNkiIkuMpp1M4X++uBLIscvrmX5q
         4sWaSYln/gRT90aejJOjSzVX0WptMz0zBrGX8xTkc9iB52bteHIt4rNNURcgOOsjbqj0
         vBC65SwwfH+BGBC+gUBToLEdIoiAIaYNO2KNRX8//xgmu7aGIbd8GKgxi4n0DzoQYe+k
         NRUyNvSLf6JXh3a6WoXbeBluG5oCrXqdxz+GyDnF3+O3qF/g9cJ/y1YysxkG+4C+4vob
         fyRhMM73f1K6DNEm4R7kqqyUAmDNtpoeWzZ4lwiJKEeKNGUN1UAQYEwWQlTHK8X9x5F5
         REgw==
X-Received: by 10.182.246.136 with SMTP id xw8mr2750340obc.29.1436253646618;
 Tue, 07 Jul 2015 00:20:46 -0700 (PDT)
Received: by 10.76.174.8 with HTTP; Tue, 7 Jul 2015 00:20:27 -0700 (PDT)
In-Reply-To: <705bdbdc6a8195d59203bcb1f3027714@stockal.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/273485>

Hi

On Mon, Jul 6, 2015 at 11:40 PM,  <saurabh@stockal.com> wrote:
> Hi,
>
> Please let me know whether Git supports directory level access or not.
>
> For example :- Consider the structure with one repository consisting of sub
> directories for each product.
> main_repo:
>    dir1 dir
>    dir2 dir
>    shared-dir dir
>    private dir
> One group(user) of developers has access to dir1 and shared-dir while the
> other group(user) has access to dir2 and shared-resources.
> Just for context, both dir1 and dir2 require shared-dir to be checked out
> for building the products.
>
> And private dir is only accessible by admin(repo owner).
>
> Regards
> Saurabh gaur
> --
> To unsubscribe from this list: send the line "unsubscribe git" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

I do not believe this is possible with git. How would this even make
sense? You can do something with sub-repositories on the server end,
where each directory is its own repository with different access
rights (and servers like gerrit or other git server setups have
various controls which enable more complex access control beyond just
Unix paths)

However, in-repo per-directory permissions make no sense, as there
would be no way to generate commits.

Regards,
Jake
