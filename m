From: Stefan Beller <sbeller@google.com>
Subject: Re: [PATCH] clone: add `--shallow-submodules` flag
Date: Mon, 25 Apr 2016 18:08:39 -0700
Message-ID: <CAGZ79kYJeqjoxXmcoe8ZdsdpwEjFrf4MtOuJsZ3EZr0NMuNAaQ@mail.gmail.com>
References: <1461609054-17118-1-git-send-email-sbeller@google.com>
	<xmqqd1pdjt7m.fsf@gitster.mtv.corp.google.com>
	<CAGZ79kbPcefodLd4Jt4tvJJmHZXJGe-AMEgzREWZiUvNeciFSQ@mail.gmail.com>
	<xmqqvb35iabx.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Jacob Keller <jacob.keller@gmail.com>,
	Lars Schneider <larsxschneider@gmail.com>,
	"git@vger.kernel.org" <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Apr 26 03:08:49 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aurUe-00081J-Np
	for gcvg-git-2@plane.gmane.org; Tue, 26 Apr 2016 03:08:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751220AbcDZBIl (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 25 Apr 2016 21:08:41 -0400
Received: from mail-ig0-f172.google.com ([209.85.213.172]:36540 "EHLO
	mail-ig0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750817AbcDZBIk (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 25 Apr 2016 21:08:40 -0400
Received: by mail-ig0-f172.google.com with SMTP id u10so28141250igr.1
        for <git@vger.kernel.org>; Mon, 25 Apr 2016 18:08:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc;
        bh=A4fCGPm6eQiEg+1oLVTp9q705PbJegfp2/C583BTwDU=;
        b=G6TV/1J+l0bwh01EATKKMHrIsChyZJdzg7aTJQMe5pLFe6cV1w5w3hnWf1wvQ2bUkA
         /tU3qqxNIehnIyaFksWwZrF2t8K3WWdrG+oT+VyN9lw9PKaCIEJ7NpnjMhe9ggZ+ZHM6
         rFhVkqQ1uujZqySWUwke+L3Afm76FtNuvZ40h4QFfxcRzUFmgKGUcgOx45pyc0q3a9O9
         RUBxbBnJCX4QfwciNvFL4y8jmzwixso9tjlyZ7oKfxCN/T05u48p6LUZ1rcEJKVRsaEE
         gzq6eVXFR1O192UxmJqvFXed70Gvr9X8tJ664+owAa2PTU9jtWtQQhGXRwBJFHg1IVw8
         xsng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc;
        bh=A4fCGPm6eQiEg+1oLVTp9q705PbJegfp2/C583BTwDU=;
        b=cmIviBinXDyrlaD/tA84E5g/3ccoyXVjiyU/ce5krrzmtxRQxoKq4K6w3QYlhQvRrA
         HNpkRsXonEQbAzBSzfmTyfGL/Y+Z/UAck/4VZTDGaiaG8AdPxMhOYvzUsZ8z0OmUJBzf
         v+DNnKp9vZ7LeT0eZQMxl3lXCkgA9uiJAwHRZ1a6c+lSKluL6OueNG1wENfK78mhFOYT
         UBLjbndvdu7meHoAUUCYZ/FtGOcfZWfK4zQGvfc+ZWNjRKSAmX1FPVeG10crVnCOvvLJ
         r9SK3v6whZMjWO2pa8Ea6Bxq2PXI+ZOUdgxRrYenp++l8bZszjrBB/sLxN8oZxKcKSFu
         Do6g==
X-Gm-Message-State: AOPr4FXarUzpn1lywcwCs6jTBmrZYcn5mzwfwfuIKf9FgeY2XeIdfAe8NrMSSkuB3pNwhWBKpipdNHteN8LK8nRL
X-Received: by 10.50.102.207 with SMTP id fq15mr10842285igb.94.1461632919703;
 Mon, 25 Apr 2016 18:08:39 -0700 (PDT)
Received: by 10.107.2.3 with HTTP; Mon, 25 Apr 2016 18:08:39 -0700 (PDT)
In-Reply-To: <xmqqvb35iabx.fsf@gitster.mtv.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/292581>

On Mon, Apr 25, 2016 at 3:37 PM, Junio C Hamano <gitster@pobox.com> wrote:
> Stefan Beller <sbeller@google.com> writes:
>
>> I agree. How about `currentdir`, `testdir` or `testtop` instead?
>> That is slightly longer than `D`, `here` or `top`, but is slightly more
>> informative. $TRASH would also work for me.
>
> I would not be happy to see a patch that adds yet another variable
> that is never used so far, like currentdir, testdir, or testtop.

D seems to be popular in 5510, the submodule crowd seems to prefer
$pwd though, see
t5526-fetch-submodules.sh
t7406-submodule-update.sh
t7407-submodule-foreach.s
t7400-submodule-basic.sh

as grep -r "\$pwd" put it.

>
> Among the ones I found that are already in use, $here is probably my
> favourite, because it does _not_ have to be set to the top; it just
> says "this is the directory my main focus is in".
>
> Having said that, personally, I find $D (as long as D is in capital)
> is distinctive and descriptive enough.

I rather go with pwd for now (it keeps the submodule stuff consistent),

Thanks,
Stefan
