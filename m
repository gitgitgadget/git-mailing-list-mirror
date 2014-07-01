From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 0/9] add strip_suffix as an alternative to ends_with
Date: Mon, 30 Jun 2014 18:00:37 -0700
Message-ID: <CAPc5daW_WBBwKaXvmY7Htd1eL3NWiUTDQK-y=2M=_NWuozxSEg@mail.gmail.com>
References: <53AED59B.1020209@web.de> <CACsJy8B_DAjLRcMe4ys2LGkLOcKuW-PL_WNHyFB8Ry3Uv38LCw@mail.gmail.com>
 <53AFA775.1090900@web.de> <53AFAA89.6050200@web.de> <20140630134317.GB14799@sigill.intra.peff.net>
 <20140630165526.GA15690@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?Q?Ren=C3=A9_Scharfe?= <l.s.r@web.de>,
	Duy Nguyen <pclouds@gmail.com>,
	Git Mailing List <git@vger.kernel.org>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Tue Jul 01 03:01:07 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1X1mRU-0002AI-7D
	for gcvg-git-2@plane.gmane.org; Tue, 01 Jul 2014 03:01:04 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751806AbaGABBA convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 30 Jun 2014 21:01:00 -0400
Received: from mail-lb0-f174.google.com ([209.85.217.174]:64987 "EHLO
	mail-lb0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751246AbaGABA7 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 30 Jun 2014 21:00:59 -0400
Received: by mail-lb0-f174.google.com with SMTP id u10so6319234lbd.5
        for <git@vger.kernel.org>; Mon, 30 Jun 2014 18:00:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc:content-type:content-transfer-encoding;
        bh=kSripV0BrAH7XNXPqa9Addu9+qA+dF3GcQne6d/LI/Q=;
        b=BfEKvtsthpRiAgLvin3AcOMo8Fq91iP6sNOQcMw1CoE/saN1t8b1f94isgfuj7h3WQ
         J2UyYfOrqkKaJdL2WOvc+H2aXIrD9W0Bc0I8Ue4OyTH/XnqgfRB8fVgo7aROMX24L1pF
         2wNQlSvdlfqWuueB68LwylC+1wNjJEc73FUc2E4x8+/0srobF2pCRRfRgFtvYh5h6l+p
         R9MkQllmDFDJmdaOnE6liPEt95PVw0gVgEIdTwt1Ey6cF86lTk8O2WeiFuF4/sXaZQ3G
         8B3CgU4cu0RVT0E6lRYCCxcYDYeL8sBiYD32+dcfRq+gL6dJjUOsEDmj6kFuaYDB+UGm
         7WFQ==
X-Received: by 10.152.37.229 with SMTP id b5mr33238473lak.40.1404176457586;
 Mon, 30 Jun 2014 18:00:57 -0700 (PDT)
Received: by 10.112.26.212 with HTTP; Mon, 30 Jun 2014 18:00:37 -0700 (PDT)
In-Reply-To: <20140630165526.GA15690@sigill.intra.peff.net>
X-Google-Sender-Auth: lU-e8M9bpdZL8FtTAY7L6pUXX1M
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/252706>

On Mon, Jun 30, 2014 at 9:55 AM, Jeff King <peff@peff.net> wrote:
> Here's a series to do for ends_with what the recent skip_prefix serie=
s
> did for starts_with. Namely: drop some magic numbers and repeated str=
ing
> literals, and hopefully make things more readable.
>
> The first patch is Ren=C3=A9's patch 1/2, with the leak fix from Duy =
and typo
> fixes in the commit message from me. The rest are new, and replace th=
e
> changes to prepare_packed_git_one done elsewhere in the thread.
>
>   [1/9]: sha1_file: replace PATH_MAX buffer with strbuf in prepare_pa=
cked_git_one()
>   [2/9]: add strip_suffix function
>   [3/9]: implement ends_with via strip_suffix
>   [4/9]: replace has_extension with ends_with
>   [5/9]: use strip_suffix instead of ends_with in simple cases
>   [6/9]: index-pack: use strip_suffix to avoid magic numbers
>   [7/9]: strbuf: implement strbuf_strip_suffix
>   [8/9]: verify-pack: use strbuf_strip_suffix
>   [9/9]: prepare_packed_git_one: refactor duplicate-pack check

Looked very sensible. Thanks all ;-)
