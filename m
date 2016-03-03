From: Duy Nguyen <pclouds@gmail.com>
Subject: Re: "./t0001-init.sh --valgrind" is broken
Date: Thu, 3 Mar 2016 19:16:55 +0700
Message-ID: <CACsJy8AE9VovwuviwOLxRDTAbTXCivRVhk8ia4mdUnMN-0Y4OA@mail.gmail.com>
References: <CAP8UFD0-FxoPe5-35NAKSkegFBoRPy1+BOsqN-y+QJUoXAqR3g@mail.gmail.com>
 <CACsJy8AL_RGEb2z44-yoL+3yF7n1+FMLqZkmWwUDFJnEPYS_nw@mail.gmail.com>
 <56D7DFD5.8010108@kdbg.org> <CACsJy8CVfJdCmwWo50wHsc6DP6ft71d5bfBaFSJpv9XcNRwdSQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Christian Couder <christian.couder@gmail.com>,
	git <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>
To: Johannes Sixt <j6t@kdbg.org>
X-From: git-owner@vger.kernel.org Thu Mar 03 13:17:31 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1abSCA-00028N-Bh
	for gcvg-git-2@plane.gmane.org; Thu, 03 Mar 2016 13:17:30 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932163AbcCCMR1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 3 Mar 2016 07:17:27 -0500
Received: from mail-lb0-f177.google.com ([209.85.217.177]:36249 "EHLO
	mail-lb0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754429AbcCCMR0 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 3 Mar 2016 07:17:26 -0500
Received: by mail-lb0-f177.google.com with SMTP id x1so20993401lbj.3
        for <git@vger.kernel.org>; Thu, 03 Mar 2016 04:17:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=AzgNfqqymp8BCFbLzcSNI9WYGyh6ZjQ8BsFK8k5Cevc=;
        b=GmmAILyNDU5BiuwpjNL1Igia0+Zlcn953SnZ96wbUXW8gow3Jn5ERRkKONEm70gjVd
         Jli5V2sQa47FGNXYDXmh8feKhDAFYklvCgb0aX1LDvYjKIVV+2dOiAGBpYfr9QDqQaBy
         VP98V41tODBoj2Mj8DyRuPQGRiDeJiEq4LXLTMwpDJipL7vl6hOUSaytf+Nj5EWyzesL
         EN26Of6YRd0al3AkKKwTwOYVVOdKP3UN+uLSH0BmqCjBjT/d1MaNFG1QQ/hvoiCr2ztR
         33n34daohqdYa3CK0YTOXB47cG/4ogWb2d9IDiFi53aYBNWjG2ihWpz4SXPfG8O53mIV
         XjRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=AzgNfqqymp8BCFbLzcSNI9WYGyh6ZjQ8BsFK8k5Cevc=;
        b=XvqfOwm3tG+DDkOThfVuiubnjJKL6uSEWicEyIN52Rm5/e+ytlaW8UII5DmfFeXZLa
         MHAxnShF/8GmBdrVheivxWiX1TAO7RNU8ZdHpd5iGyCb/v0sacH4gsImlTdg65hVRa/b
         u/yYzPOfhcKlqEP3yL7n1DiFPU7UCQ4Dfu8lgbyXnf1unC9EpwpVHqqvx7tNnn3wDO3N
         7RjJx6lis6NS7rZuTD83Lxu/h0Pcnt+iW+fw1MFMLciQJhPD3RCys704cf0TDbcXecbC
         U1vLqSU/IgDOAs/C//vHxitMRR4kwgqwqFKOVtAkF86JMVSuZcYHw8tPjBFY6+UExtoW
         dPvA==
X-Gm-Message-State: AD7BkJIHYZcZLPmmkJPPhfoLohsajwUcQpJUelff1LdjlyGyM4FdrJkNnbXDL5VG8lRrRDwxxDM87lNSL0QR3w==
X-Received: by 10.25.159.68 with SMTP id i65mr924987lfe.94.1457007445186; Thu,
 03 Mar 2016 04:17:25 -0800 (PST)
Received: by 10.112.34.162 with HTTP; Thu, 3 Mar 2016 04:16:55 -0800 (PST)
In-Reply-To: <CACsJy8CVfJdCmwWo50wHsc6DP6ft71d5bfBaFSJpv9XcNRwdSQ@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/288172>

On Thu, Mar 3, 2016 at 7:09 PM, Duy Nguyen <pclouds@gmail.com> wrote:
> But it's probably better that we inject valgrind command
> from inside bin-wrappers script, the same way we inject gdb, I think.

For the best of both worlds, we should recreate bin-wrappers in
test-lib.sh (i.e. the valgrind way), not in Makefile. Somewhat
unrelated, but because topdir is getting really crowded and
bin-wrappers is used for the test suite only, it should be moved
inside t/ (i'm going to move all test-* to t/ too, later).
-- 
Duy
