From: Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH v4 10/27] Add new environment variable $GIT_COMMON_DIR
Date: Mon, 3 Mar 2014 02:29:33 -0500
Message-ID: <CAPig+cSq0nRWC97_7L+nBuiKdDjPtOkP3x=5u2a5cvONgwyMRg@mail.gmail.com>
References: <1392730814-19656-1-git-send-email-pclouds@gmail.com>
	<1393675983-3232-1-git-send-email-pclouds@gmail.com>
	<1393675983-3232-11-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>
To: =?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41jIER1eQ==?= 
	<pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Mon Mar 03 08:29:40 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WKNJj-0006Ap-Kj
	for gcvg-git-2@plane.gmane.org; Mon, 03 Mar 2014 08:29:39 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753943AbaCCH3f convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 3 Mar 2014 02:29:35 -0500
Received: from mail-yh0-f42.google.com ([209.85.213.42]:56746 "EHLO
	mail-yh0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752549AbaCCH3e convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 3 Mar 2014 02:29:34 -0500
Received: by mail-yh0-f42.google.com with SMTP id a41so3253159yho.29
        for <git@vger.kernel.org>; Sun, 02 Mar 2014 23:29:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc:content-type:content-transfer-encoding;
        bh=bALOUvP5vL7yFI2nRCvFdh2tjDc2xafBLdMvq1ieAnY=;
        b=JfGz4aFtngt0eNc+wo+wgQPHbtxUn2UIp4+7mgOazN6qqr/+QSkDVJ/uQGuuyQ0B/0
         oTygCwoYkcA2A5g3F2hXGmXYO4/bbAj0+FinN+NIQcNcnbE1SDbL+n+kGi9pCUXEjiBh
         pK8vjq6zwgbGT2RKgdW4To2eYwuV4SDBkBKUzuV6/rW7/MdVD6t21YkthOtG4bVflexb
         C9/C1uqKOSbkdsudTp1kCjbhnaXVz8vy0FqqSYcBtNoM9Qm/cqHL5tej/hYhqXL9fqDW
         P+/KtMi4vqGhJqC63gEMcC9THMGUIEIWhGr5JC4ii9EuCaWmoFA+DluS2WDbgMJg1a81
         RyxA==
X-Received: by 10.236.81.237 with SMTP id m73mr20309983yhe.29.1393831774041;
 Sun, 02 Mar 2014 23:29:34 -0800 (PST)
Received: by 10.170.180.195 with HTTP; Sun, 2 Mar 2014 23:29:33 -0800 (PST)
In-Reply-To: <1393675983-3232-11-git-send-email-pclouds@gmail.com>
X-Google-Sender-Auth: 2YtUYHTR0UekrdgaQ_yG0QoesnI
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/243191>

On Sat, Mar 1, 2014 at 7:12 AM, Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc D=
uy <pclouds@gmail.com> wrote:
> This variable is intended to support multiple working directories
> attached to a repository. Such a repository may have a main working
> directory, created by either "git init" or "git clone" and one or mor=
e
> linked working directories. These working directories and the main
> repository share the same repository directory.
> ---
> diff --git a/Documentation/gitrepository-layout.txt b/Documentation/g=
itrepository-layout.txt
> index aa03882..10672a1 100644
> --- a/Documentation/gitrepository-layout.txt
> +++ b/Documentation/gitrepository-layout.txt
> @@ -46,6 +46,9 @@ of incomplete object store is not suitable to be pu=
blished for
>  use with dumb transports but otherwise is OK as long as
>  `objects/info/alternates` points at the object stores it
>  borrows from.
> ++
> +This directory is ignored $GIT_COMMON_DIR is set and

s/ignored \$/ignored if $/g

Note the /g since this error is repeated throughout the rest of the
gitrepository-layout.txt patch.

> +"$GIT_COMMON_DIR/objects" will be used instead.
>
>  objects/[0-9a-f][0-9a-f]::
>         A newly created object is stored in its own file.
