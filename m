From: Duy Nguyen <pclouds@gmail.com>
Subject: Re: Git config depth option?
Date: Fri, 12 Feb 2016 07:16:54 +0700
Message-ID: <CACsJy8DV5HCMtphbyft6Jc6sk3+rutvQY9sqs3jQjf3aD4tUZw@mail.gmail.com>
References: <CAG7bRqy=eMhr7G_7ODUcXGCHQ97uZYicTiav8-vL8hVKkSV_gg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git Mailing List <git@vger.kernel.org>
To: Gary Mort <gary@sherodesigns.com>
X-From: git-owner@vger.kernel.org Fri Feb 12 01:17:32 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aU1QP-0001qs-3U
	for gcvg-git-2@plane.gmane.org; Fri, 12 Feb 2016 01:17:29 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750981AbcBLAR0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 11 Feb 2016 19:17:26 -0500
Received: from mail-lb0-f182.google.com ([209.85.217.182]:33857 "EHLO
	mail-lb0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750818AbcBLARY (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 11 Feb 2016 19:17:24 -0500
Received: by mail-lb0-f182.google.com with SMTP id uq3so1186663lbc.1
        for <git@vger.kernel.org>; Thu, 11 Feb 2016 16:17:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=ccQXniLOQHVOzx+pCOvWr6CgAhr/brZiGSW1KMGJqt8=;
        b=IhCjzR0XtUPIBf5KcL2XwXVniA5xm4CTjpJWCsPeUo50wrGm0rPUTZeOalwVrMknhh
         0zFiTYi68J5Mton1GTZJInFofpi/NKWF3RF5wQlwFDhnlMrQd3aMdpw/KskKVALE5+x6
         DF/+hCbwS84YNbREM9yxBRVs91coztSq93Y8qZhPkxj9jpwPi18wTek+6sf57b12tCOJ
         A8qieoGSN7Lk6uu8u++ESoZ/EHN8BBPdNThg4DZ+LhlV96O02+IwyyIo3wqr3MZB/esS
         Q9WVDI0sXixsqscn+Y5pB/I1ZMg4+iqjTuRg3fytkb+8QLdFtUqsW9xnEbWf7eVpC8Dj
         voIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-type;
        bh=ccQXniLOQHVOzx+pCOvWr6CgAhr/brZiGSW1KMGJqt8=;
        b=jlYT02SVnvH5wE2wvvUmTjYUJdA79MxqvXMW5oIF9SkRpZHyfnw8khCV839hQHkbF2
         WFsRLBvgUsCmpdnmPocaQNry2VxeUsIx8okx+qhDmun3qHJtqoj29/sX2HFxYsdnl8Cg
         mWt3l9zpEws2nArnsRenuBpiWqb6L+Piix8LWTEDQzJE9Io0Wdz3srQXqM381KC1O969
         Q7V/SqJnBY4z7v3uTx6LCLeROUSRBorvTvFQ5wCBbRS+Ut8X9BA5/H5rSuri8lUFvB6D
         UFuI+3MmpGFySMS6og/uPrvwqEYu/IG9oDrix2IHE3FaKEsVjbXBvHqxDPsmFg503hd4
         IMkA==
X-Gm-Message-State: AG10YOSBmqBASlDIBPNyQBgewNpTmZkphvloOiZQbkIrx1zGCmelu0cwVk94aVqPFmTk5Hhk4XCvCvXK4P+L/g==
X-Received: by 10.112.130.41 with SMTP id ob9mr19220401lbb.81.1455236243609;
 Thu, 11 Feb 2016 16:17:23 -0800 (PST)
Received: by 10.112.97.72 with HTTP; Thu, 11 Feb 2016 16:16:54 -0800 (PST)
In-Reply-To: <CAG7bRqy=eMhr7G_7ODUcXGCHQ97uZYicTiav8-vL8hVKkSV_gg@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/286022>

On Thu, Feb 11, 2016 at 12:57 AM, Gary Mort <gary@sherodesigns.com> wrote:
> I checked the documentation and scanned through the source code for clone:
> https://github.com/git/git/blob/master/builtin/clone.c
>
> And nothing jumps out at me as a way to specify a default depth using
> a global git configuration file.  I see the option defined at
> https://github.com/git/git/blob/master/builtin/clone.c#L87
>
> Since c is not my primary programming language, it may well be that
> there is some common parsing function/file which automatically maps
> command options to config file options.  So, is there a way to set a
> default depth for the clone command?

No. But it it necessary the _clone_ command? I mean, would this alias suffice?

git config --global c1 'clone --depth 1'
-- 
Duy
