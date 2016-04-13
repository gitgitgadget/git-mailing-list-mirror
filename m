From: Stefan Beller <sbeller@google.com>
Subject: Re: Why doesn't gitk highlight commit references from git-describe?
Date: Wed, 13 Apr 2016 14:27:12 -0700
Message-ID: <CAGZ79kZVC0FxUN45KgLh-2tEK2=j2-yyTajYOc=s-LECgx+yqQ@mail.gmail.com>
References: <nemal5$mb$1@ger.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: "git@vger.kernel.org" <git@vger.kernel.org>
To: Stephen Kelly <steveire@gmail.com>
X-From: git-owner@vger.kernel.org Wed Apr 13 23:27:20 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aqSJj-0004hR-GE
	for gcvg-git-2@plane.gmane.org; Wed, 13 Apr 2016 23:27:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752366AbcDMV1O (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 13 Apr 2016 17:27:14 -0400
Received: from mail-io0-f170.google.com ([209.85.223.170]:35459 "EHLO
	mail-io0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751972AbcDMV1N (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 13 Apr 2016 17:27:13 -0400
Received: by mail-io0-f170.google.com with SMTP id g185so85170380ioa.2
        for <git@vger.kernel.org>; Wed, 13 Apr 2016 14:27:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc;
        bh=rsCQNfCXlSWPm5IyNTHtmPO1gDUGybtJFtod5kFKLb0=;
        b=cciLddFHtw/d5q2wX3A4xKlc4oRqCgSOAlzE+5HmCK5iZ9T/XpOe7jYNrh8mrGyuXl
         gAHvPhwVu8NMgpsysZlsS/kH9vK0NZ5JA2QaFWuj0XHVUo4TJOnjQVigqXVFdFoLIaCo
         6DE3buIBv04ZMXvdSVdQbzQf4FSwkZMXHzvwJL1MpS5T/wLgXPQOofYXorKB3xkvp5X0
         jMPymUItsV6M4EvMWVsxVsGyssjlnC0PAZyEDNtFiIQIQjGcBTbT18tzYcNCpnyDpsRj
         0qezzN2V/tdBdcFKwTVd/ljAYBZULsOhDlSbu9tmWX4sU0kjeOR046RVKruLpwulqxD4
         Sn6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc;
        bh=rsCQNfCXlSWPm5IyNTHtmPO1gDUGybtJFtod5kFKLb0=;
        b=E/XaWyyT2gVewKYhbeteZ8TkjCYfb3rwcNT25ZtqHiweq6nIuEai8Pqx5bJHNdivRc
         nJA50yXmAzsACDrleg1I3JncK7Bt2m5YJ/gpZXgzk9mTGW52LnrcSGbXc/HKAoVP0hIO
         FxgEc97HbckWFv/+beI+7M1KMkypJDIkMg1OBKcQ1EjdEQsZD2PN5Pj7Q3UCfWxaCk0D
         okXTv3jlkFntoAqSrIfaOnReoM8dYXiqDDlJyNPEtQNnURwJQ1zJacWc+t9CSYHaG1UF
         B5M2VQEJTvSWlsW8mIthC4F+OjMaH3VVmjijqjN+FCiNNJKQfDnTFHfZHLLIHuHpr+wf
         bMug==
X-Gm-Message-State: AOPr4FVyO+gllp+QFUWE6pubUzDwwZiHcvrTcDYG+65G7+eI0MK80cawYmTp1TgdBsP9DcGmPHEqe2E65sQTtoGf
X-Received: by 10.107.184.8 with SMTP id i8mr12492847iof.96.1460582832632;
 Wed, 13 Apr 2016 14:27:12 -0700 (PDT)
Received: by 10.107.17.27 with HTTP; Wed, 13 Apr 2016 14:27:12 -0700 (PDT)
In-Reply-To: <nemal5$mb$1@ger.gmane.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/291486>

On Wed, Apr 13, 2016 at 1:36 PM, Stephen Kelly <steveire@gmail.com> wrote:
> Hi,
>
> If I look at git commit 89ea90351dd32fbe384d0cf844640a9c55606f3b in gitk, it
> does not linkify the v1.6.0-rc0~120^2 in the commit message.
>
> Is there any reason for that, or can gitk be changed?

Sure it can be changed. Go for it.

I think it is hard though. So for example it is easy to spot sha1s
and link them (see a6ee883b8e as an example picking up ebef7e5
as a link.)

How would you know(/code) that v1.6.0-rc0~120^2 is a text worth linking?
"v1.6.0-rc0" is a custom string as that is how we name tags in this project.
It can follow any convention in other projects.

Maybe a first approximation is if there is a `~` followed by numbers
or a ^ character, inspect the whole thing if it is a reference into the history?

(Special case for git.git: Sometimes in a discussion you want to explain stuff
and may use HEAD^ or such to demonstrate the use case. Other projects would
not use that as much in descriptive text I would assume. So we'd need
to make sure
changing refs (i.e. branches, symbolic refs such as HEAD, FETCH_HEAD) are not
considered worth linkifying.)

Thanks,
Stefan

>
> Thanks,
>
> Steve.
>
>
> --
> To unsubscribe from this list: send the line "unsubscribe git" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
