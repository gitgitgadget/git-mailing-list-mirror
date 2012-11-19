From: Francis Moreau <francis.moro@gmail.com>
Subject: Re: git-describe fails with "--dirty is incompatible with
 committishes" if passing HEAD as argument
Date: Mon, 19 Nov 2012 21:39:23 +0100
Message-ID: <CAC9WiBjcUMOpa_KvS-8k0bWR=XTqVRT_qFLx1keVmG1nee8GOw@mail.gmail.com>
References: <CAC9WiBjw0W4kLCKMj6HhdjAXOJYpDW2Rgncb+06ahjiYOWtZ8Q@mail.gmail.com>
	<7vfw45xu4e.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Nov 19 21:39:40 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TaY82-0004Bx-Nn
	for gcvg-git-2@plane.gmane.org; Mon, 19 Nov 2012 21:39:39 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751429Ab2KSUjY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 19 Nov 2012 15:39:24 -0500
Received: from mail-oa0-f46.google.com ([209.85.219.46]:61865 "EHLO
	mail-oa0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750808Ab2KSUjY (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 19 Nov 2012 15:39:24 -0500
Received: by mail-oa0-f46.google.com with SMTP id h16so5247417oag.19
        for <git@vger.kernel.org>; Mon, 19 Nov 2012 12:39:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=O8iXgf/U2Y/rcCC4Damf6btUoq/OLIHXa+g4WT4NZsU=;
        b=h9iMK2zHvDA5/T8mEWMZVX2O/a3RZqpe5gR6gQ2vw47PkPJzChWWYXWGF6c+xof30k
         FNWbqqGn2XrOcHkLDAGiWEUkNUecRyF7+gQTjWSdW+L1+ZpGXbuUOhkp/lGSO3iwEg0P
         msw4aGOKymqBicxa8JS66/xMGs5rzokaVnF6uwl28Jy4iYfeKxQ/o6VBm7lAddRgIV5A
         brHDus1tqTe2T4MdRy8v7sBTY9LG682Kpbh7sYHLZ2JiCwec2joqLNj1o6AN3Qnylt6t
         OWIJRw26glCSttGZ8kH0vxu0WolkuJEAqh04ERA1Ef/k5lvqYhpjzU9/9wQFUiQWbYQg
         gLgA==
Received: by 10.60.169.48 with SMTP id ab16mr11789575oec.15.1353357563505;
 Mon, 19 Nov 2012 12:39:23 -0800 (PST)
Received: by 10.60.93.163 with HTTP; Mon, 19 Nov 2012 12:39:23 -0800 (PST)
In-Reply-To: <7vfw45xu4e.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/210053>

On Mon, Nov 19, 2012 at 8:36 PM, Junio C Hamano <gitster@pobox.com> wrote:
> Francis Moreau <francis.moro@gmail.com> writes:
>
>> Inside the kernel repository, I tried this:
>>
>> $ git describe --dirty --match 'v[0-9]*' --abbrev=4 HEAD
>> fatal: --dirty is incompatible with committishes
>>
>> If 'HEAD' is removed then git-describe works as expected.
>>
>> Is that expected ?
>
> I would say so, at least in modern codebase.
>
> "git describe" without any commit object name used to mean "describe
> the HEAD commit using the better known points" before the --dirty
> option was introduced.
>
> But "--dirty" makes it describe the current checkout.  For example,
> output from "git describe --dirty" v1.8.0-211-gd8b4531-dirty means
> "your working tree contains work-in-progress based on d8b4531, which
> is 211 commits ahead of the v1.8.0 tag".  So conceptually, it should
> not take any commit, even if it were spelled HEAD.
>
> "git describe --dirty HEAD^^" would be an utter nonsense for the
> same reason.

Thanks for explaining, that makes sense.

--
Francis
