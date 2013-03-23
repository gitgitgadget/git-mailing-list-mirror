From: Duy Nguyen <pclouds@gmail.com>
Subject: Re: Hard reset of a subdirectory in a sparse checkout setting
Date: Sat, 23 Mar 2013 16:59:49 +0700
Message-ID: <CACsJy8DmkMWOx-u2=trz+GTtwpbksTbCvUU+AOQYo5SrNtM2Gw@mail.gmail.com>
References: <514C3249.7000100@ivt.baug.ethz.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: =?UTF-8?Q?Kirill_M=C3=BCller?= <kirill.mueller@ivt.baug.ethz.ch>
X-From: git-owner@vger.kernel.org Sat Mar 23 11:00:49 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UJLFp-0002yK-7p
	for gcvg-git-2@plane.gmane.org; Sat, 23 Mar 2013 11:00:49 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751536Ab3CWKAV convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 23 Mar 2013 06:00:21 -0400
Received: from mail-oa0-f50.google.com ([209.85.219.50]:41374 "EHLO
	mail-oa0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750838Ab3CWKAU convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 23 Mar 2013 06:00:20 -0400
Received: by mail-oa0-f50.google.com with SMTP id n1so2249156oag.37
        for <git@vger.kernel.org>; Sat, 23 Mar 2013 03:00:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:mime-version:in-reply-to:references:from:date:message-id
         :subject:to:cc:content-type:content-transfer-encoding;
        bh=v9jiXUNmJCeO2OqzPaD/VQKaT6ar16O9lzVSUGOWb4k=;
        b=BVYdITrjfyYlZd5nsG2B0gYiCc76YnquZ+Mt5VxKFCvUn/1n/O51HXtnse/yopQ8MK
         nzajPGVJ4Vak+9qT9XiO3srKyETEEb03DsZckXe9/WN4pvUIuD0bGy21mgWq2z1rbBy1
         yzEwpNvDIED3idC1bzG69o69XBsLTqHe3engN6oDgcixoV2yKS2jGGEuVRugXmGsilkZ
         AiIbXcc5kHGsVq+vpItyV1TXKhQZVUTmLbWU5tigciS1O37GYq1xJklrUUGVTcE7ShjZ
         PvfiHh43eTcDLfZZNJ0VXXQRpXgyrpZbq6qyqkXTcXxlaIIxEfZcP3/1yKyBfb0+BpEb
         F+kQ==
X-Received: by 10.60.31.79 with SMTP id y15mr4750580oeh.123.1364032819264;
 Sat, 23 Mar 2013 03:00:19 -0700 (PDT)
Received: by 10.76.27.137 with HTTP; Sat, 23 Mar 2013 02:59:49 -0700 (PDT)
In-Reply-To: <514C3249.7000100@ivt.baug.ethz.ch>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/218904>

On Fri, Mar 22, 2013 at 5:28 PM, Kirill M=C3=BCller
<kirill.mueller@ivt.baug.ethz.ch> wrote:
> I can't find a neat way to "git reset --hard" a subdirectory of a che=
ckout
> without reading in directories or files which are excluded by a spars=
e
> checkout. This has been asked on StackOverflow in greater detail, but=
 the
> "right" answer is still missing: http://stackoverflow.com/q/15404535/=
946850
>
> The options I see are:
>
> - git checkout . (will restore excluded directories)
>
> - git reset --hard (won't accept a path argument)
>
> - git diff | patch -R (awkward)

Another way is

git diff --name-only -z|xargs -0 git checkout

> What's the proper way to do this in Git?

I think adding --sparse to git checkout may be more user-friendly. And
it looks like a simple change. I'll make a patch soon (I need some
time to recall how sparse checkout interacts with git-checkout).
--=20
Duy
