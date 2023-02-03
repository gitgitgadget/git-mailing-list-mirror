Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 82304C636D3
	for <git@archiver.kernel.org>; Fri,  3 Feb 2023 02:01:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232088AbjBCCBR (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 2 Feb 2023 21:01:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39234 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232053AbjBCCBN (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 2 Feb 2023 21:01:13 -0500
Received: from mail-pf1-x42c.google.com (mail-pf1-x42c.google.com [IPv6:2607:f8b0:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 207AB5C0DF
        for <git@vger.kernel.org>; Thu,  2 Feb 2023 18:01:13 -0800 (PST)
Received: by mail-pf1-x42c.google.com with SMTP id z3so2594179pfb.2
        for <git@vger.kernel.org>; Thu, 02 Feb 2023 18:01:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=kKiGnMq47WIktmXEMDFLse/DykoeT37vSePFDECoLJw=;
        b=kvYYzA00GzT39//F4I7etJENj6+1MAjjWU34SHfl27RuwhbD342xM7EDOXOtWjvSKB
         Dh0M+qxSaG8/g5/lKTaMeEiKCS37jvzgh/oQtII7jkUHN4NRYyezfRgih4ip67rxKHsk
         ekEi/k2iHpdmUQP09KmVNJIwAs8KsSwaWAu6BNkzKQpQrwCQBnqw5fxIID5/Nu4PL00q
         /hROl0J9SkwTXrOR3Osu99xYdXjQcaT7kdG8VOeRtz26lGSFZYThI/TdMwmU/9XSVANJ
         bQ472+OuUC3Veik1NLZoYaX8VGiNjNI6C4+rTBkl3gTBJPi82vEKgkbyBHBnwx4r+mpR
         O0rQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kKiGnMq47WIktmXEMDFLse/DykoeT37vSePFDECoLJw=;
        b=ysa6+Ka0oEROkHFl+YDeTPM4/Vaw2yatSd8VEuAuVnevQUfEPITWB9xSRVgLbvxNtq
         gQYZn2qMk+YlLa5IDHQGYCRbzrhKhP1HwzwFz8w5HBn+tugQ6kqW0/Uc9Ixhz8b6fdLE
         uOUotlxwJy+g76aYgw0bBzBuNMDB3aVFEgPetamPM1MA92xC35Ta3N7Oicis+DA0BaZc
         prva4MNXBaZ+yzPpsz3J4lifItJ+RU6JJQQN8zsxfqndS+lSd8hStziEIP3ZE97dSDSa
         2FQUL5aHsjqoW9YZ5fhAe77u700VUM0rCzaDCWV7CL7vMhdf3Mio6dg1jRDqwTaeSr5a
         Pqig==
X-Gm-Message-State: AO0yUKWZCAggcZSzW5Z/GiUqT8SMD4I5NTaP92XRhqj0tf9h4yZPuuwx
        eJHJlqMW9E+KOrPY2rLgpco=
X-Google-Smtp-Source: AK7set+89EL/fMFh1wbGSisT6nwA9P1JHmCrKt/L97QcOELkHZHbHP+f6M7HJkLbKiSVgFQQt37gKw==
X-Received: by 2002:a05:6a00:1348:b0:593:aa46:3ab7 with SMTP id k8-20020a056a00134800b00593aa463ab7mr10753669pfu.5.1675389672536;
        Thu, 02 Feb 2023 18:01:12 -0800 (PST)
Received: from localhost ([2001:ee0:50c5:86d0:18bc:74ea:9b3c:e4dd])
        by smtp.gmail.com with ESMTPSA id 23-20020a621617000000b0057726bd7335sm366269pfw.121.2023.02.02.18.01.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Feb 2023 18:01:12 -0800 (PST)
Date:   Fri, 3 Feb 2023 09:01:09 +0700
From:   =?utf-8?B?xJBvw6BuIFRy4bqnbiBDw7RuZw==?= Danh 
        <congdanhqx@gmail.com>
To:     Andry <andry@inbox.ru>
Cc:     git@vger.kernel.org
Subject: Re: Hash for a commit sourcetree beside to a commit hash
Message-ID: <Y9xq5VAMjzUqTb6X@danh.dev>
References: <1798489336.20230203042837@inbox.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1798489336.20230203042837@inbox.ru>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 2023-02-03 04:28:37+0300, Andry <andry@inbox.ru> wrote:
> Hello Git,
> 
> Is there a chance to add this property to a commit and a set of
> commands,

Does `git rev-parse commit^{tree}` works for you? E.g.

	git rev-parse HEAD^{tree}

> for example, to search a commit by a sourcetree hash?

I'm not sure if I understand your question correctly, but does this
work?

	git rev-list <a-commit-tish> |
	while read commit; do
		if test $(git rev-parse $commit^{tree}) = $hash; then
			echo $commit
			break
		fi
	done

> Sometimes a forked branch has edits which does chance commit hashes
> without changing the sourcetree, like user mail rewrite or commits
> remove or just a commit random property change. This leads to
> rewriting the rest commits in a branch or tree.
> 
> This feature will be useful to search in all commits including
> rewritten.
> 
> Of cause in case of rebase it won't work if is happened at least one
> merge with the interference with other commits in a commit chain.
> But if not, then it might help to search commits even after
> automatic rebase.
> 

-- 
Danh
