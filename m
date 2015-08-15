From: Duy Nguyen <pclouds@gmail.com>
Subject: Re: bug: git-archive does not use the zip64 extension for archives
 with more than 16k entries
Date: Sat, 15 Aug 2015 15:40:32 +0700
Message-ID: <CACsJy8AuuD-mk54Hx3tqBRLkEC5Phq04r98UaBVtk15tOsBT3Q@mail.gmail.com>
References: <20150811104056.16465.58131@localhost> <55CBA140.7050301@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Johannes Schauer <josch@debian.org>,
	Git Mailing List <git@vger.kernel.org>
To: =?UTF-8?Q?Ren=C3=A9_Scharfe?= <l.s.r@web.de>
X-From: git-owner@vger.kernel.org Sat Aug 15 10:41:15 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZQX1b-0000VE-4P
	for gcvg-git-2@plane.gmane.org; Sat, 15 Aug 2015 10:41:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751447AbbHOIlE convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 15 Aug 2015 04:41:04 -0400
Received: from mail-io0-f182.google.com ([209.85.223.182]:36020 "EHLO
	mail-io0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750987AbbHOIlC convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 15 Aug 2015 04:41:02 -0400
Received: by iodv127 with SMTP id v127so90828691iod.3
        for <git@vger.kernel.org>; Sat, 15 Aug 2015 01:41:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        bh=WY6Rs1ES6LpNASRcrVIzMmPHFsf/+7/fGD2x78OFG4A=;
        b=g/Rr+2co86wak0jplQazt+KTS3gVmHgi7OGTJ2faOhSYOKVewBNbX5HqalR/iFI/OI
         J+ovjxNvbND8yK7pbuhm1vczGOcT1wGthSerJPol1S4W4YPU7oaPuA4qgckysnpjU8pW
         wiROzRv1pHqDQmgP3ZXwOGloOixSKEumnAwtFPXtMkJEiETuWNNNLhmj79d14wl41LpY
         U/cmACEno8QnhltWzlYL/DYAJww0t6mj3C6nCQBc7ZIls1pfpwCtc3dDv6s9Fb3+v/8b
         gvXpzQ5ZjdOw4R67+7/PbEcHB1J69YPcVWHm5Nt5Yzpsxu45dT20qFMBclSs7kDqNIxy
         rSiw==
X-Received: by 10.107.4.1 with SMTP id 1mr46557299ioe.10.1439628061299; Sat,
 15 Aug 2015 01:41:01 -0700 (PDT)
Received: by 10.107.191.193 with HTTP; Sat, 15 Aug 2015 01:40:32 -0700 (PDT)
In-Reply-To: <55CBA140.7050301@web.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/275984>

On Thu, Aug 13, 2015 at 2:40 AM, Ren=C3=A9 Scharfe <l.s.r@web.de> wrote=
:
> Seriously, though: What kind of repository has that many files and us=
es the
> ZIP format to distribute snapshots?  Just curious.

Not the "uses the zip format" part, but at least webkit and gentoo-x86
both exceed 64k limit. Even if we don't support this case, we probably
should error out instead of producing corrupt archives.
--=20
Duy
