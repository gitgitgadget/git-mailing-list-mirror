From: Christian Couder <christian.couder@gmail.com>
Subject: Re: [RFC/PATCH 10/11] branch.c: use 'ref-filter' APIs
Date: Tue, 28 Jul 2015 10:09:32 +0200
Message-ID: <CAP8UFD1q5oxchNUhWc8331nAq-eVkzVOe9=56v68HcY2CDXW4A@mail.gmail.com>
References: <CAOLa=ZT3_DMJWFN62cbF19uxYBFsE69dGaFR=af1HPKsQ42otg@mail.gmail.com>
	<1438067468-6835-1-git-send-email-Karthik.188@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git <git@vger.kernel.org>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
	Junio C Hamano <gitster@pobox.com>
To: Karthik Nayak <karthik.188@gmail.com>
X-From: git-owner@vger.kernel.org Tue Jul 28 10:09:47 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZJzxK-0004KB-3R
	for gcvg-git-2@plane.gmane.org; Tue, 28 Jul 2015 10:09:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932325AbbG1IJg (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 28 Jul 2015 04:09:36 -0400
Received: from mail-wi0-f179.google.com ([209.85.212.179]:33762 "EHLO
	mail-wi0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932094AbbG1IJe (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 28 Jul 2015 04:09:34 -0400
Received: by wicmv11 with SMTP id mv11so168537938wic.0
        for <git@vger.kernel.org>; Tue, 28 Jul 2015 01:09:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=nHkeQkdlylsjbwWohCtB/GsalBedMfXD5rGjOm1Y6MA=;
        b=1E71lpSp3D1omX9QXq2QhyoZPFe1gqvXpk1jkAa2gKrOHIAdE/5rnKLNLTYwN75lu/
         RdYhvZCeSg+yLz+Gu95LySD94BpLwocx0C/ub6SWSKN5fbjyvy0HZH+wsrBDtJnKtlJK
         R9iFaIMih1rYnRHwNINsFRBvsBfDySSS+e8hyICtqi1CyCbKeW77WuKCCkxf/j4cDgW+
         eI3QWsCHlEEt0V2+nDihSJQnTlB+ol6eo2cWdV1l4Jlg9HvaDc2/lPFQj/qPcfF+tS5b
         aNvCY4aHOkFp1OpifaHbePMbGPevrDnxxuqXOyEMkwTedEwWG7fVHlyXQZDMaZ5Y7Qfg
         vE3g==
X-Received: by 10.194.48.8 with SMTP id h8mr65211781wjn.82.1438070972986; Tue,
 28 Jul 2015 01:09:32 -0700 (PDT)
Received: by 10.194.36.106 with HTTP; Tue, 28 Jul 2015 01:09:32 -0700 (PDT)
In-Reply-To: <1438067468-6835-1-git-send-email-Karthik.188@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/274755>

On Tue, Jul 28, 2015 at 9:11 AM, Karthik Nayak <karthik.188@gmail.com> wrote:

> diff --git a/Documentation/git-branch.txt b/Documentation/git-branch.txt
> index a67138a..897cd81 100644
> --- a/Documentation/git-branch.txt
> +++ b/Documentation/git-branch.txt
> @@ -11,7 +11,7 @@ SYNOPSIS
>  'git branch' [--color[=<when>] | --no-color] [-r | -a]
>         [--list] [-v [--abbrev=<length> | --no-abbrev]]
>         [--column[=<options>] | --no-column]
> -       [(--merged | --no-merged | --contains) [<commit>]] [<pattern>...]
> +       [(--merged | --no-merged | --contains) [<commit>]] [--sort=<key>] [<pattern>...]

Maybe: [(--[no-]merged | --contains) [<commit>]]
