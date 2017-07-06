Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD,T_DKIM_INVALID shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E19AB202AB
	for <e@80x24.org>; Thu,  6 Jul 2017 16:22:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751813AbdGFQWR (ORCPT <rfc822;e@80x24.org>);
        Thu, 6 Jul 2017 12:22:17 -0400
Received: from mail-pf0-f196.google.com ([209.85.192.196]:33585 "EHLO
        mail-pf0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751751AbdGFQWQ (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 6 Jul 2017 12:22:16 -0400
Received: by mail-pf0-f196.google.com with SMTP id e199so900716pfh.0
        for <git@vger.kernel.org>; Thu, 06 Jul 2017 09:22:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=VHZQyzf/cWtJGZGiDKUF62gGWoFtq3e2OVlZ3iUtmQ8=;
        b=flTkgpLcoZ+9EbqyKmlLw7Oai2tL7Xo8Mgj6yd6MlAPVW+r78Htzfn0XOuHrTsb6nA
         yzOfVfnAyR0EtO9dIdL5jlfR4cUOKRzzojekDg+D3weEtYSQMB8CEJuW+fGWhbk5Hcon
         LWYLKCf+Vps9/t1t13LGpqFLOBO2Poie/7gzYHnrga4v5OtoYwP7i/X+2bS5gRfH/QJe
         4lH9BIcf5Ev1Dth/R6dxYOyS80matYSHhZ+fiEfDQDNjvxc+nd+P9H3aMP9gHkdsLQ7b
         fl4FYyeIYr00BAeTvR0K8pgxYwu19plk2dlyv2t+nRtYYKe5tQ72RVTPfv1Lh2UmhF5P
         j4yg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=VHZQyzf/cWtJGZGiDKUF62gGWoFtq3e2OVlZ3iUtmQ8=;
        b=Hsie9sdz33GDzgGl7zj+q2GqdEmWfHpSU75xrSaB/gkkXeWj28fA6J6LGdv018qbjb
         6pjRkJL3GSOjuKghVnla9a3CV4RTEaibXN4v0txDjsCvxrCapbNu/d6fsEaWUYVuamF5
         2tcj6674Z6s6Qlcwtj69AsM3M2fUhJHGV034PdM8fLKzfHopEHHZzsNVQVTexdNYCY/i
         MRzaAoQNVmqnh2pNqhSTbOLcA3PDUYpnqqoiKTxrR2zKIw8SE+2cSamsVMv52pwpAQnW
         RJl8GbZ+pg1RUo0swZ6Lryk2BCF4rnQoFHTvKeWiMfJ49aHocoih2we62PWuAAryDX8D
         Gl2w==
X-Gm-Message-State: AIVw112ILhSIvIQ/t715K9rlGqDMWp+x748iYifpubH5u60y4D4hmego
        sdap40j3WDQH7Q==
X-Received: by 10.99.119.12 with SMTP id s12mr26795189pgc.143.1499358135869;
        Thu, 06 Jul 2017 09:22:15 -0700 (PDT)
Received: from localhost ([2620:0:1000:8622:f878:6796:f790:dc38])
        by smtp.gmail.com with ESMTPSA id v70sm1098806pfi.110.2017.07.06.09.22.15
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Thu, 06 Jul 2017 09:22:15 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Todd Lewis <utoddl@email.unc.edu>
Cc:     git@vger.kernel.org
Subject: Re: bug report: dates on diff
References: <b28bc109-b06f-0acf-960b-0b6761b0ee38@email.unc.edu>
Date:   Thu, 06 Jul 2017 09:22:14 -0700
In-Reply-To: <b28bc109-b06f-0acf-960b-0b6761b0ee38@email.unc.edu> (Todd
        Lewis's message of "Thu, 6 Jul 2017 08:54:14 -0400")
Message-ID: <xmqqo9sxfscp.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Todd Lewis <utoddl@email.unc.edu> writes:

> [utoddl@tarna gitbug]$ git diff master@{01-01-2012} charter.txt
> warning: Log for 'master' only goes back to Thu, 6 Jul 2017 08:19:45 -0400.

What you observed is how <ref>@{<selector>} syntax is designed to
work, and is not limited to "git diff".  Any Git command e.g. "git
rev-parse master@{01-01-2012}", would and should behave the same
way.

The thing to note is that the syntax does not pay any attention to
author or committer dates recorded in the commit objects.  In fact,
if you have a ref that points at an object that is not a commit-ish,
you can still use the syntax.  If you did this, for example

    $ git config core.logallrefupdates always

    $ one=$(echo one | git hash-object --stdin -w)
    $ git update-ref refs/my/blob $one

    ... time passes ...

    $ two=$(echo two | git hash-object --stdin -w)
    $ git update-ref refs/my/blob $two

then "git show my/blob@{2.minutes.ago}" will show the blob object
your refs/my/blob ref was pointing at 2 minutes ago.

And as you may know, blobs do not record any timestamp.  So how does
this work?  

The reason why this works is because the time in <ref>@{$time}
syntax is about asking what was pointed by the <ref> back in $time
in your repository.  It does not matter what timestamp the object
that was pointed by the <ref> has (or does not have).

If you didn't create this repository back in 2012, then the syntax
"master@{01-01-2012}" that asks "Back at the beginning of 2012, what
object did the master branch point at?" does not have a sensible
answer.  That can be seen in the warning you got from Git.

Hope this clarifies.
