Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2C6A01F453
	for <e@80x24.org>; Wed, 19 Sep 2018 22:25:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725876AbeITEF3 (ORCPT <rfc822;e@80x24.org>);
        Thu, 20 Sep 2018 00:05:29 -0400
Received: from mail-lf1-f46.google.com ([209.85.167.46]:46590 "EHLO
        mail-lf1-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725834AbeITEF3 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 20 Sep 2018 00:05:29 -0400
Received: by mail-lf1-f46.google.com with SMTP id q22-v6so6538235lfa.13
        for <git@vger.kernel.org>; Wed, 19 Sep 2018 15:25:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to
         :content-transfer-encoding;
        bh=IuKoiE/Fa2prGIeOEMiXXCS0/AKHszeLpRIq4DT2U7c=;
        b=MH3qIObG8OfGferCHzD/ULmbwEdTJWri/T4J0Gnruzg40LTn3ina8gt5nss4hUbbJ8
         y6wan4ldX7PyP1v5e9hJJvx1jXGK2UteEFD9J619Xgt8s8zCQbKjqwmWWxVgPGsVYj3+
         Wf8MwuAm7YbZ0C+YIX1z/gsp4JVHodCztXrm17jmNEmmVo1AUbQlMPlOvA9L8iDsZA4s
         2xnhrGJctz6tXjb7Nfp1Cfq3mttRyWvYc9SvXcJ53BwVnJxIddENieMgQLz1ZwETPSQd
         ugjBB1Ze4hgmZXVKWTpRndbDr3OvXmd5NkK19huWxkU9vsyAB3gSwbHXojhw1Biq0sHo
         Z0+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to
         :content-transfer-encoding;
        bh=IuKoiE/Fa2prGIeOEMiXXCS0/AKHszeLpRIq4DT2U7c=;
        b=OqbmnL1/DfsopJf/v7BMnKmlv9IdvfdJOi1VgX5ZIS9OEmCl88eEJqkyGr3FCrJu4v
         pq7XGSe5gxSVw0m6Cr960G8JRJ7yLCcD112n/ZegFFDOnDS3QPCo55WM4uMzxRo+fFOY
         l6Plx7WqmN9fo9v5TYjh39kU9ItXTBREReY/7uEn3wc3ENjPZVrwjSiCCmuwy+9z8jg5
         EDzBJtEvbvp9o63VQOlrreIj9nn/b75pOiAkxvtZibImXBizI5P/uCMIZaUQte1dBkE6
         EOQB8yfIcufDgtqoW/Z0N6mQfiUxj9Eq2T/kZcIOicoz3YDyqzyHuzAqedlaYTVW/807
         IFsA==
X-Gm-Message-State: APzg51CPkusbeEkzAb/eD7RH0mBg8R9EJuRP4j7RzvnhSMva4SBWxTb5
        Vaf+Rx4paPC0LG4BFW9dh1aCnIPkQZyJ5RLUyNzZnI1S
X-Google-Smtp-Source: ANB0VdYS602FBfzuDZXRQyCxudgILeTRdArZ0OxRwH4lZY9+Z2fHOSk/tuyMKlDWp3Ssgyek5tmDWHcfN+Pd5sxtjSY=
X-Received: by 2002:a19:8f57:: with SMTP id r84-v6mr12167119lfd.131.1537395925565;
 Wed, 19 Sep 2018 15:25:25 -0700 (PDT)
MIME-Version: 1.0
From:   Alexander Mills <alexander.d.mills@gmail.com>
Date:   Wed, 19 Sep 2018 15:25:14 -0700
Message-ID: <CA+KyZp4G6WCXjp_9x+NBWZysfg+Fu_PtF4qrhipT8UuLNnsCHA@mail.gmail.com>
Subject: bug with git merge-base
To:     git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The following command sequence exits with 1, and no stderr

base=3D'remotes/origin/dev';
fork_point=3D"$(git merge-base --fork-point "$base")";

I cannot figure out why it's exiting with 1, but there is no stdout/stderr

-alex

--=20

Alexander D. Mills
=C2=A1=C2=A1=C2=A1 New cell phone number: (415)730-1805 !!!
alexander.d.mills@gmail.com

www.linkedin.com/pub/alexander-mills/b/7a5/418/
