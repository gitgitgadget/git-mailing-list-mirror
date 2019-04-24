Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	FROM_EXCESS_BASE64,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id BC2951F453
	for <e@80x24.org>; Wed, 24 Apr 2019 11:11:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727463AbfDXLL2 (ORCPT <rfc822;e@80x24.org>);
        Wed, 24 Apr 2019 07:11:28 -0400
Received: from mail-wr1-f47.google.com ([209.85.221.47]:40863 "EHLO
        mail-wr1-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726441AbfDXLL2 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 24 Apr 2019 07:11:28 -0400
Received: by mail-wr1-f47.google.com with SMTP id h4so24553183wre.7
        for <git@vger.kernel.org>; Wed, 24 Apr 2019 04:11:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=nl+J6Qjk21WHvO3UiHPVUAU/tPxFafTIJcKXjKepvTU=;
        b=ZvI0sEtBZsr5sGVRf2paXbad260u8lZThY8htfYGUe1T/aJ2VwdnJCZw3AqNau96JC
         KMw/oxd32OX7CcZQrnVnLtcEDR9j/fnaOMgoqZBYAS7iybjQ/hUe9xcLmajijvpbR7tm
         QemrD96L1ZFHjxwZKvQKTGLijrDYiyX+BUVSHDEHCrb4h4xp2JmR0PplAwTIJX4LMzKM
         0RM12DmdqnAsUL1zkECeJntoLaVKWHwmtkucwYgoKG8Vc4kQJXf2Hzjizj8kQR6ffb6c
         4pcS62YsDnO6FjdUBgXbOa8ZYrQKcFk4jfjpW+YcU6rgHop9dJoTVO8mJQb4qAhTbZw6
         Gl4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=nl+J6Qjk21WHvO3UiHPVUAU/tPxFafTIJcKXjKepvTU=;
        b=td0cWvYFmBYi1bE0neMTERiZEWTeu55+QeHOfkKKec8tZKrMXZs/JLO11ZNZcYqHaW
         dkz1Q4cYRzbaOyaaIZmrYWKMvI6MEUYRn0jtdWa8n7RKt93+GmHMlOwviWAm5t+2uIm/
         Qy6QnX9DesgTjHaNq4jAcLT4olUGYZJq9Yh5JvHVr0/bg19B9KjWNgdh3kme6l00hgfd
         AlYwdkY/eiP0pDlMpDCzgQfHeQL10mAuczUHBOzZTAi24Akn5Q46Fh5WlknbAvJa9WNR
         cRb/dhpsZKjtr/pI7H+qjnwfHhwSYDhsdUb4ikgKCs5+EC6ctwFcYUU6A4CvazgpUoKW
         oy7Q==
X-Gm-Message-State: APjAAAWXvwH7ghZbAGltmw8AElA3ZaHeiariBOR8oVSqXq+ZU6GjRDNN
        EJXhUZU6QPsh/DKSLPt20FE=
X-Google-Smtp-Source: APXvYqwpqQmzXtBEzuT2DreAdug0aykZyl4taiYyteTE57y0tkZpyKAjG69ugu1+Tg/JYrS/uHM0kQ==
X-Received: by 2002:adf:b60a:: with SMTP id f10mr20226398wre.116.1556104286238;
        Wed, 24 Apr 2019 04:11:26 -0700 (PDT)
Received: from szeder.dev (x4db31470.dyn.telefonica.de. [77.179.20.112])
        by smtp.gmail.com with ESMTPSA id x18sm20769293wrw.14.2019.04.24.04.11.24
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 24 Apr 2019 04:11:25 -0700 (PDT)
Date:   Wed, 24 Apr 2019 13:11:23 +0200
From:   SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Christoffer =?utf-8?Q?Stjernl=C3=B6f?= <a@xkqr.org>,
        git@vger.kernel.org
Subject: Re: Bug: git branch returns EXIT_SUCCESS when no branches found
Message-ID: <20190424111123.GB8695@szeder.dev>
References: <875zr3iucd.fsf@xkqr.org>
 <xmqqmukf1yh9.fsf@gitster-ct.c.googlers.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqqmukf1yh9.fsf@gitster-ct.c.googlers.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Apr 24, 2019 at 07:36:34PM +0900, Junio C Hamano wrote:
> 	if git merge-base --is-ancestor master "$DEV_BRANCH"
> 	then
> 		echo "master is an ancestor of $DEV_BRANCH"
> 	else
> 		echo "master has commits not in $DEV_BRANCH"
> 		git --no-pager log "master..$DEV_BRANCH" --
> 	fi

A non-zero exit code might indicate an error in 'git merge-base'
itself; I had basically the same if-else condition in a script of my
own that had to check the same thing...  until once I mistyped the
branchname, and, well, undesired behavior ensued.  After that I
added one more branch to the condition like this:

  git merge-base --is-ancestor master "$DEV_BRANCH"
  ret=$?
  if test $ret -gt 1
  then
        die "uh-oh, git merge-base errored out"
  elif test $ret -eq 0
  then
        echo "master is an ancestor of $DEV_BRANCH"
  else
        echo "master has commits not in $DEV_BRANCH"
  fi

