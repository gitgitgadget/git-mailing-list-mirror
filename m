From: Edmundo Carmona Antoranz <eantoranz@gmail.com>
Subject: Re: [PATCH v1] blame: avoid checking if a file exists on the working
 tree if a revision is provided
Date: Mon, 16 Nov 2015 19:25:52 -0600
Message-ID: <CAOc6etbmjufXLd7eXCtj7triO5190U4ea0RbXB40Br9-gvAwEA@mail.gmail.com>
References: <1447722437-14937-1-git-send-email-eantoranz@gmail.com>
	<CAOc6etbsqZ=gTGido2b3FXZyY+1JRkeF1O9pk37+7qOogaN6oA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: max@max630.net, Jeff King <peff@peff.net>,
	Edmundo Carmona Antoranz <eantoranz@gmail.com>
To: Git List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Tue Nov 17 02:26:16 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZyV2C-0003mc-BI
	for gcvg-git-2@plane.gmane.org; Tue, 17 Nov 2015 02:26:13 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751532AbbKQBZx (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 16 Nov 2015 20:25:53 -0500
Received: from mail-pa0-f47.google.com ([209.85.220.47]:33426 "EHLO
	mail-pa0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750913AbbKQBZx (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 16 Nov 2015 20:25:53 -0500
Received: by pabfh17 with SMTP id fh17so195912460pab.0
        for <git@vger.kernel.org>; Mon, 16 Nov 2015 17:25:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=xJE+A4472dTanbW05Q62opCaKS65xX+tuKZbL+W96S4=;
        b=wyo3HF3qzKZ1JvfFes7bu/NnC0V1CJawpGxj8jZhNp38QdqtAT2FQo92gAgArwv/u3
         8RJ6J2yIfvYyFTafTmyrY5WeQ2lWKZhmg8LHKP8caLg0EWtUDWqAjy74mSkjF8ikOqjI
         aYiP4FgxgssoGUBfMBD5GBmyLxB8KgPtLNTlDWZYoXdT+3A8jDsMvQJVP7wg2fDhQKXF
         iaomdi6wHA8MYMdIoe7MihWjdmkjlwPE7x1iiRKd6U0JJvm3MG1+BhC+H2vVMR3AcK4J
         iT2d+zyVNrHoQyIOUfsE7pnmJsoyIVDGoJP1kSXbeB7haXw2jwVgxZF3ht2rLIbKD9db
         rxlQ==
X-Received: by 10.68.165.131 with SMTP id yy3mr14697450pbb.163.1447723552961;
 Mon, 16 Nov 2015 17:25:52 -0800 (PST)
Received: by 10.66.97.70 with HTTP; Mon, 16 Nov 2015 17:25:52 -0800 (PST)
In-Reply-To: <CAOc6etbsqZ=gTGido2b3FXZyY+1JRkeF1O9pk37+7qOogaN6oA@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/281379>

Ok... I think I got how to check revisions / file existence after
revisions have been set up.

Sending next patch version

On Mon, Nov 16, 2015 at 7:16 PM, Edmundo Carmona Antoranz
<eantoranz@gmail.com> wrote:
> On Mon, Nov 16, 2015 at 7:07 PM, Edmundo Carmona Antoranz
> <eantoranz@gmail.com> wrote:
>> -               if (!file_exists(path))
>> -                       die_errno("cannot stat path '%s'", path);
>
> Two things:
> 1
> What I would love to do is check if revisions were provided. Something like:
>
> if (no_revisions() && !file_exists(path))
>     die_errno("cannot stat path '%s'", path);
>
> _but_ revisions are set up a little bit later. I don't know right now
> if I could just move it up (I don't think it would be that simple
> because I see there's some messing up with argv and argc in that 'if'
> that encloses the lines I'm removing). Maybe it would make sense to
> move the check for file existence to _after_ revisions have been set
> up? Even without the check for revisions, it's behaving kind of the
> way I mean it to. But I'm sure it'd be more elegant if I checked if
> revisions were provided.
>
> 2 It makes sense to create test cases for this patch, right?
>
> Looking forward to your comments. Thanks in advance.
