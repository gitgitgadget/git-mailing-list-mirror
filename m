From: Karthik Nayak <karthik.188@gmail.com>
Subject: Re: [PATCH v4 15/16] branch: use ref-filter printing APIs
Date: Thu, 14 Apr 2016 00:31:41 +0530
Message-ID: <CAOLa=ZQnM95mApOmYYZa3SeFq2af5FMmiqh0ZFZDn3EO8U9-Dg@mail.gmail.com>
References: <1460227515-28437-1-git-send-email-Karthik.188@gmail.com>
 <1460227515-28437-16-git-send-email-Karthik.188@gmail.com>
 <xmqqtwj6pnma.fsf@gitster.mtv.corp.google.com> <xmqqinzmpmg2.fsf@gitster.mtv.corp.google.com>
 <CAOLa=ZQ5gwW1vwREsK=h0tDuyk18axHU491brKJM_DR53=9zcQ@mail.gmail.com> <CAPc5daUZvP03o+eb2ngvRtV=aoXWGnZH9FKj9bRCEj3MrCT8WQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git <git@vger.kernel.org>, Jeff King <peff@peff.net>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Apr 13 21:02:19 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aqQ3N-0003a8-CR
	for gcvg-git-2@plane.gmane.org; Wed, 13 Apr 2016 21:02:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932319AbcDMTCM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 13 Apr 2016 15:02:12 -0400
Received: from mail-qk0-f174.google.com ([209.85.220.174]:36440 "EHLO
	mail-qk0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754170AbcDMTCL (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 13 Apr 2016 15:02:11 -0400
Received: by mail-qk0-f174.google.com with SMTP id n130so23010088qke.3
        for <git@vger.kernel.org>; Wed, 13 Apr 2016 12:02:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=9AkWcEBLfgXlPyhjagpbafGHEKKgkNUz0zBmwo2Zt9g=;
        b=XGPvjO051Nan/9mF/ED5dWVBYexYkvi+snfceUivD0cfqo76azyAdzRzHzec0+ggNi
         kFf8jykLnGlT0fR+P4Cyi8mGnAiJU9WBcrS4AcRoGeO3dAePlK4ump8foNkbxGtna++c
         p4WYBCJcL4GsNlZ1hu52v55nrDNeGKenHg5uvbNVxvFRwMG6TtOF22XMcDuKCtilYX1L
         AF87CCIwV1+U22OWnJIFOOTICiy7RrEvdnHumHdzIgSJrCSahKdISKzuGjhbmA54gocN
         gYlopdhUv3mwaSM6LTonZU/qRPVk3IccqNqDgSdfhTgBAQ/l8/Hqxj4Z3OmmYfSYqutT
         L0UA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=9AkWcEBLfgXlPyhjagpbafGHEKKgkNUz0zBmwo2Zt9g=;
        b=TYlIamxZLoNepMdM6U6iNh+fe0k7Bo1BZNmXv8TeVMazcX57YggEt4a6Bvxs6whlWp
         EfgRQ9W2wFApkZPkNSsvLTdhgo2YSqzbKSR+D5Qrzd2BO6/XQKIDWohKr3K80xTjlVwq
         G+hTmEbGYkUlUib/0ieqS5/KvaE5eGwbScZn23pQiWaZ3eSgnwBsQbPOgzpTvuI9MvvH
         fNmlGNupAEOF5ichnbIH7pr9zs5iB314hIPfFdGGoobcLIxglvb95Cy/M8nFvO1mlspV
         2WV1NncE00qQ8yFlMm1VXSfRQu7+WgH/BbKIM/xAti4RXG+yyzzLXSj3fTz+mUCJ+Lg7
         Ef9Q==
X-Gm-Message-State: AOPr4FXGEkF4TLL4dzv4PFsZiqJAfGcoNNC1WUxuSqsn6GMmw/yVhBggD0zPJwT549A2Np2+RWvonsM2ZPueog==
X-Received: by 10.55.72.196 with SMTP id v187mr13307730qka.97.1460574130673;
 Wed, 13 Apr 2016 12:02:10 -0700 (PDT)
Received: by 10.140.92.238 with HTTP; Wed, 13 Apr 2016 12:01:41 -0700 (PDT)
In-Reply-To: <CAPc5daUZvP03o+eb2ngvRtV=aoXWGnZH9FKj9bRCEj3MrCT8WQ@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/291478>

On Wed, Apr 13, 2016 at 8:42 PM, Junio C Hamano <gitster@pobox.com> wrote:
>>> Having said that, doesn't this need to be further adjusted for
>>> 95c38fb0 (branch: fix shortening of non-remote symrefs, 2016-04-03)?
>>>
>>> http://thread.gmane.org/gmane.comp.version-control.git/290622/focus=290624
>>>
>>
>> That was one of the changes made in this version of the patch series :)
>
> But with this patch applied, it seems that the tests in Peff's fix
> does not seem to pass.
> If I understand correctly, "fix shortening" stops doing your
> symref:short (which is to
> shorten the usual "drop refs/heads, refs/remotes, etc.") and makes the
> shortening
> conditional. The target of a symref that is found in refs/heads/ gets
> refs/heads and
> nothing else stripped.

Having a look here, WRT to the patch v4 it seems the problem is that
patch v4 doesn't support v2.6.x behavior, namely that cross-prefix symrefs will
not be shortened at all. As per the format given in the last patch
[16/16] it shortens
the symref irrespective of being cross-prefix symrefs.

Would it be a good idea to enforce this as in v2.6.x or change it as
to allow shortening
of cross-prefix symrefs.

-- 
Regards,
Karthik Nayak
