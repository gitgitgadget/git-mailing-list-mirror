From: "rocketscienc01100101 ." <rocketscienc01100101@gmail.com>
Subject: Re: Bug in git-diff output
Date: Wed, 2 Apr 2014 13:05:36 +0200
Message-ID: <CALgQ2n9VXVpqXe1NQO4+b-Ngmbhxnza52GJqr81t_ubLfjY75g@mail.gmail.com>
References: <CALgQ2n-vPK6_0LnWA_AAD2GLvepjLN4A3UZFCAWzEp9r_=XOVg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Apr 03 13:28:17 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WVeMw-0000xS-W1
	for gcvg-git-2@plane.gmane.org; Thu, 03 Apr 2014 11:55:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758590AbaDBLUB (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 2 Apr 2014 07:20:01 -0400
Received: from mail-ie0-f194.google.com ([209.85.223.194]:62869 "EHLO
	mail-ie0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758584AbaDBLUA (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 2 Apr 2014 07:20:00 -0400
Received: by mail-ie0-f194.google.com with SMTP id to1so8245ieb.5
        for <git@vger.kernel.org>; Wed, 02 Apr 2014 04:20:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :content-type;
        bh=zOZ8X8JpJmFBNyO5JJU0o4ObKPzcRw4LLBMvZnXwr+k=;
        b=zwHi2NL+GnN6TrXHCwZFxUWnVyGBXJ5S6p2YTCDtJ2vswZsural/iQynYjRxhVos/s
         HAsim6RvDLaRPOfAn4MdCBx5WUHyZT8DuR+u6+SfMCziqYGncEX6AkgdapVgik25lHhC
         sRU+/eyS1o6P7EDsIj4cmEQcVFVEX7zVvydmiNQtBk5KJFf5m40IPOpUVGJDiaqxyTHB
         9g3IGGCo36HcX0WxzVTf/AfB+2bxG2yA+etOWubNt3bqusDH9VYokWRlJsgXgyo3yfvo
         HrevOvJj/C2BltEFfuehqY+vpvnE54lnr7OKJzxV1acOEfp3li+Y/HOxu9PHzr+iMOSo
         rh+Q==
X-Received: by 10.50.22.210 with SMTP id g18mr8082420igf.19.1396436736964;
 Wed, 02 Apr 2014 04:05:36 -0700 (PDT)
Received: by 10.50.25.165 with HTTP; Wed, 2 Apr 2014 04:05:36 -0700 (PDT)
In-Reply-To: <CALgQ2n-vPK6_0LnWA_AAD2GLvepjLN4A3UZFCAWzEp9r_=XOVg@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/245714>

http://i.imgur.com/BoJSjm9.png

Here's a screenshot that shows the problem. There's always a misplaced
line in the output (most of the time a[href^=tel] { }), no matter
where in the file the changes are.
Sometimes it's even in the wrong position, above the @@ numbers.

I'd naturally expect the a[href^=tel] part to not show up at all
unless I make changes there.

On Tue, Apr 1, 2014 at 12:49 PM, rocketscienc01100101 .
<rocketscienc01100101@gmail.com> wrote:
> I tried to get a diff between HEAD and the current version of my
> project, so I did "git diff".
>
> It's a web project with a CSS file that contains the following CSS rule:
>
> a[href^=tel] {
>     color:inherit;
>     text-decoration:none;
> }
>
> Now, whenever I do "git diff", it will always show the a[href^=tel]
> part and mess up the output, even when I didn't change anything near
> that line. The problem is easily reproducable in a newly created
> repository.
>
> git --version
> git version 1.9.1
