From: Paul Tan <pyokagan@gmail.com>
Subject: Re: [GSoC15] Interested in contributing to git
Date: Wed, 4 Mar 2015 02:08:26 +0800
Message-ID: <CACRoPnTAFXBRR3uv8gL8tGfYNo_ygNutJZuPm=Sq0Ae3obF-kw@mail.gmail.com>
References: <CACRoPnSrjysUhC77LXVjy5VJxFFPoiRuhD7pMab_8T2Pua_T+A@mail.gmail.com>
	<vpqbnkagiie.fsf@anie.imag.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git@vger.kernel.org
To: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
X-From: git-owner@vger.kernel.org Tue Mar 03 19:08:33 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YSrFA-00087G-To
	for gcvg-git-2@plane.gmane.org; Tue, 03 Mar 2015 19:08:33 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756366AbbCCSI2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 3 Mar 2015 13:08:28 -0500
Received: from mail-lb0-f171.google.com ([209.85.217.171]:37692 "EHLO
	mail-lb0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751477AbbCCSI2 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 3 Mar 2015 13:08:28 -0500
Received: by lbvn10 with SMTP id n10so38895901lbv.4
        for <git@vger.kernel.org>; Tue, 03 Mar 2015 10:08:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=xFvVfXfSGP8I5ZgfZV3Dpxvd7oR7xqf/I94L8CiNqZc=;
        b=iTZD1sNdxQpecRSbKnlQSYGWdQgLzWX5PRD1SAVCAAtfWH1MN+v01IxCZdtbFII40B
         0pvzgOo/iYZymKvf+lmlT7PlCYTjEvGHy4Qqe1ajOfkSUtj8dj9vlrwfkQzxLiSitPNj
         UxB4ems1lWpWx46QRYCb0rXxCZdUo5iiyPB9cRpVYWoBJpCdnCGQu1Kls0xdxGqtvDtS
         0gTPdqdNkqNMZx8VOFy7qsAsOblFHukfY9Z4STDuLWw/vjLZ/trzw/l44xs5IAXO3JY3
         aEo6oPlNELm0+tdFnOMR59Cma+fvLQvxxzjGtlNyNhDEW7UQnGVNpwRJjc9OI6Eu7avS
         GYbw==
X-Received: by 10.152.205.76 with SMTP id le12mr13208lac.65.1425406106611;
 Tue, 03 Mar 2015 10:08:26 -0800 (PST)
Received: by 10.112.130.228 with HTTP; Tue, 3 Mar 2015 10:08:26 -0800 (PST)
In-Reply-To: <vpqbnkagiie.fsf@anie.imag.fr>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/264674>

Hi Matthieu,

On Wed, Mar 4, 2015 at 12:20 AM, Matthieu Moy
<Matthieu.Moy@grenoble-inp.fr> wrote:
> Be carefull: a GSoC is a full-time job. The GSoC itself ends on August
> 21st, so there would be a substantial (too big?) overlap between the
> GSoC and your studies.

I understand. I will have to try my best to complete most of the work
before then.

>> I understand that I have to complete a microproject. I would like
>> complete "Move ~/.git-credentials and ~/.git-credential-cache to
>> ~/.config/git". I'm thinking that the XDG locations should take
>> precedence over the non-XDG locations?
>
> The logic is different for reading and for writting, see how Git deals
> with it for ~/.gitconfig for example. Essentially, we read both, and we
> write to the one which exists if there's only one.

I will try to implement something similar. My idea for credential-store.c is:

* For "get", lookup_credential() on the XDG file first if it exists,
and if it fails call it on the home file.
* For "remove", remove_credential() from both the xdg file and the home file.
* For "store", if the XDG file exists store_credential() in the XDG
file and remove_credential() from the home file, otherwise just
store_credential() in the home file.
* For all operations, if "--file" is provided, use it instead.

> I'm the one who proposed this microproject, and some feedback on the
> mailing-list was that it was not so "micro" and probably too big
> already.
> Both for the microproject and the GSoC itself, don't be too ambitious on
> the feature you target, and don't underestimate the effort needed to get
> from "the code looks OK to me" to "the code has been reviewed on list
> and merged upstream".

Thanks, I will keep that in mind.

Also, quick question, where should the XDG tests go for
git-credential-store? I see t1306-xdg-files.sh and
t0302-credentials-store.sh.

> Cheers,
>
> --
> Matthieu Moy
> http://www-verimag.imag.fr/~moy/

Regards,
Paul
