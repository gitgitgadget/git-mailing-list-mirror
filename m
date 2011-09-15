From: Brandon Casey <drafnel@gmail.com>
Subject: Re: git gc exit with out of memory, malloc failed error
Date: Wed, 14 Sep 2011 21:29:09 -0500
Message-ID: <CA+sFfMdXLkSE_RXB28TSx0JpPVjwe1Rf+03TkiT2YJjYH7m9MQ@mail.gmail.com>
References: <CAGAhT3mbGB-0q3EKh5MrGqB59wUea7NfaaY18DvnL3qimwh9QA@mail.gmail.com>
	<CA+sFfMcfy=GCFrCjonQXvXRQu=hLjDvQViJJ75xqa72Gb23MgQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Sep 15 04:29:18 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1R41hT-000641-N9
	for gcvg-git-2@lo.gmane.org; Thu, 15 Sep 2011 04:29:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753842Ab1IOC3L convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 14 Sep 2011 22:29:11 -0400
Received: from mail-fx0-f46.google.com ([209.85.161.46]:63317 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753500Ab1IOC3K convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 14 Sep 2011 22:29:10 -0400
Received: by fxe4 with SMTP id 4so192367fxe.19
        for <git@vger.kernel.org>; Wed, 14 Sep 2011 19:29:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :content-type:content-transfer-encoding;
        bh=Poi8cSfKcgVkXkFgG6SWBmTUBVxfGsfaSUYsYCuP/P4=;
        b=SZKwn34Jq7BG7Pjo5Puf3YqMUC5XhGhz9F3S9SNpIKftsGpgytDPIsbdO724nlEwjf
         yx1kE88cS0tzp+H0hvoTyb7uYVo+DO68v6b0u++EEIMwyfwSL9OAw2RmmciBSA41g/Lb
         x8aopIbteNBbHQXYMu7Z2lW4eb3B0oljheqog=
Received: by 10.223.5.76 with SMTP id 12mr854998fau.103.1316053749273; Wed, 14
 Sep 2011 19:29:09 -0700 (PDT)
Received: by 10.152.20.170 with HTTP; Wed, 14 Sep 2011 19:29:09 -0700 (PDT)
In-Reply-To: <CA+sFfMcfy=GCFrCjonQXvXRQu=hLjDvQViJJ75xqa72Gb23MgQ@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/181428>

[resend since gmail's Rich formatting was enabled]

On Wed, Sep 14, 2011 at 8:33 PM, Alexander Kostikov
<alex.kostikov@gmail.com> wrote:
>
> I'm new to git and I'm getting the following out of memory error on g=
it gc:
>
> $ git gc
> Counting objects: 80818, done.
> Delta compression using up to 8 threads.
> fatal: Out of memory, malloc failed (tried to allocate 24359675 bytes=
)
> error: failed to run repack

Try reducing the number of threads that are used. =C2=A0You must have s=
ome
pretty large objects if you have 24GB and ran out of memory. =C2=A0The
following will configure git to use only one thread.
=C2=A0 =C2=A0git config pack.threads=3D1
-Brandon
