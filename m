From: Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH v6 6/6] tag -v: verfy directly rather than exec-ing verify-tag
Date: Mon, 18 Apr 2016 14:00:37 -0400
Message-ID: <CAPig+cTWit2NcVBV+r4o0ztOQx7=4XjNKbeo=HA7EAxasw6HsA@mail.gmail.com>
References: <1460932021-27633-1-git-send-email-santiago@nyu.edu>
	<1460932021-27633-7-git-send-email-santiago@nyu.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
	Jeff King <peff@peff.net>
To: Santiago Torres <santiago@nyu.edu>
X-From: git-owner@vger.kernel.org Mon Apr 18 20:00:43 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1asDTW-0005Xu-Vw
	for gcvg-git-2@plane.gmane.org; Mon, 18 Apr 2016 20:00:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751519AbcDRSAj (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 18 Apr 2016 14:00:39 -0400
Received: from mail-ig0-f195.google.com ([209.85.213.195]:35657 "EHLO
	mail-ig0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751047AbcDRSAi (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 18 Apr 2016 14:00:38 -0400
Received: by mail-ig0-f195.google.com with SMTP id fn8so11868723igb.2
        for <git@vger.kernel.org>; Mon, 18 Apr 2016 11:00:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc;
        bh=tAMCg6IIvx5yRlJJKuMUfHxVPBOmIuxkfO85lz23Mcc=;
        b=D0KjMDu5HIjz7wE0eblEyWBS40g1V+R1JUcMyPwS0noMYDOTHOiZGXD2YJj2CBWDFW
         I2tKCfn5aShTKdzGzCcm4Z4acKugjnTvIFGBixiBDW73+WEaqXFQyCp1mOOPobaxsHEB
         rZi/LI2EBD2pOxUw+9G0JfTpcc+dY3cxlT7qr8QAi9k0IqE7cjbmNQzi5xp0ny9UKR4A
         EBo2dlqzoeq/q2ScFi0oXceHYeBrh0D6FTvghhlh/5dOJmDJr+88tScMrQfgsLFgbKVa
         UzTTWcf698ABlxY5mrZjaMH6E5caYNXo5nr1ZHkvgQ6IyZnosxN9aJ2zitfgIylh6TSB
         NJmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:date
         :message-id:subject:from:to:cc;
        bh=tAMCg6IIvx5yRlJJKuMUfHxVPBOmIuxkfO85lz23Mcc=;
        b=XCThlQW/2rryUuvYXqJLwOeF3MDZYTrZNlbXiXJy0AM7aq/fHEaO5r4mSFMCNTy6O3
         TWPpijMiEr80FdwdX0ICO2hKlV2aDEjtLqPOKwtHSQc90VWpaBg+f05/Ksl4J1Ti6qko
         CmajW6JcFm5Cwfz5pXYthsRKWesUfz2V5ZOxG1f1cnxjnMe8StNA0PwcS5kJ3Lk55KT/
         V/+OCBgg3X7KMgrIKx6OA5/uPC5/MC55tlcXRSz/RUxRCFHpWmfCc63QLDIqtxogu+DE
         aeupLlOoTUAcZG40rkBhpjrtB56+Z1YUs/VKa19Cd2vCxlS7DYVg9Kr4YXYSuI1a+Fw5
         rQYA==
X-Gm-Message-State: AOPr4FVNTGQ0V84bUNbJ0kVogHYx0+YTr/zGC66x2/8RgKoEwikqjqziexbFS+C5zKyflBqQkbfkou+2Tqv1DA==
X-Received: by 10.50.247.51 with SMTP id yb19mr4494830igc.73.1461002437308;
 Mon, 18 Apr 2016 11:00:37 -0700 (PDT)
Received: by 10.79.139.4 with HTTP; Mon, 18 Apr 2016 11:00:37 -0700 (PDT)
In-Reply-To: <1460932021-27633-7-git-send-email-santiago@nyu.edu>
X-Google-Sender-Auth: 3wDJlGPZFYrgUgNFUJ4VJC0w6bQ
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/291815>

On Sun, Apr 17, 2016 at 6:27 PM,  <santiago@nyu.edu> wrote:
> tag -v forks into verify-tag, which only calls gpg_verify_tag().

"forks into" sounds odd.

> Instead of forking to verify-tag, call gpg_verify_tag directly().

s/ directly()/() directly/

I found the commit message of your previous version[1] more
descriptive and easier to understand (minus the grammo):

    Instead of running the verify-tag plumbing command, use the
    gpg_verify_tag() function to avoid doing an additional fork call.

The patch itself looks fine.

[1]: http://article.gmane.org/gmane.comp.version-control.git/290831

> Signed-off-by: Santiago Torres <santiago@nyu.edu>
> ---
> diff --git a/builtin/tag.c b/builtin/tag.c
> index 1705c94..7b2918e 100644
> --- a/builtin/tag.c
> +++ b/builtin/tag.c
> @@ -104,13 +104,7 @@ static int delete_tag(const char *name, const char *ref,
>  static int verify_tag(const char *name, const char *ref,
>                                 const unsigned char *sha1)
>  {
> -       const char *argv_verify_tag[] = {"verify-tag",
> -                                       "-v", "SHA1_HEX", NULL};
> -       argv_verify_tag[2] = sha1_to_hex(sha1);
> -
> -       if (run_command_v_opt(argv_verify_tag, RUN_GIT_CMD))
> -               return error(_("could not verify the tag '%s'"), name);
> -       return 0;
> +       return gpg_verify_tag(sha1, name, GPG_VERIFY_VERBOSE);
>  }
>
>  static int do_sign(struct strbuf *buffer)
> --
