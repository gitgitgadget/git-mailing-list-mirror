Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIMWL_WL_MED shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id ACEF11F424
	for <e@80x24.org>; Fri, 27 Apr 2018 19:13:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1758277AbeD0TNa (ORCPT <rfc822;e@80x24.org>);
        Fri, 27 Apr 2018 15:13:30 -0400
Received: from mail-io0-f171.google.com ([209.85.223.171]:43965 "EHLO
        mail-io0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1758203AbeD0TN3 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 27 Apr 2018 15:13:29 -0400
Received: by mail-io0-f171.google.com with SMTP id t23-v6so3634313ioc.10
        for <git@vger.kernel.org>; Fri, 27 Apr 2018 12:13:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=atlassian-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=hv1rZoxHttav+lykWXIsKem3yveR0wpFIFk4zb4pgAY=;
        b=AsAf7h9AxtMNQhDEJUQp5VVai63MTY9ciP4PaGVcnZ+m7JiQ4dqD5vewvhOAdRcjvf
         NDPNdSNLCykp2FjIWyY1gWPis9ceKqVjJxP21+5LCW2aoNQf8nTM2ogl+DAlKIpI9Izt
         4iDiul7C7T2MMnJBJ5tqoqWhWwAXoL0QPhu6VHB8I2TebxB5bJ1X1BsR0LdxnThlTpEC
         6yhGYV+VPr/grWGOXeSNtCHWL5Do7O/mqW43G7VVqVyATi05HffxHvius37mZkzDPVOB
         xWYGWig0+Kfx/laUPjRRpgpqUgerDtoAL/4/ZcJjxavADaISNlZl/p9gJXSevvABIqin
         Y6/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=hv1rZoxHttav+lykWXIsKem3yveR0wpFIFk4zb4pgAY=;
        b=fG+eB18Q7aQJXv7dK+wsB2b9gm+JvjRElKabe3UJ4jVsaYV73/CDgIDaSGB2bQ+Fiz
         i40cuSJ6dA8LL8acWDrTWIKW195saO7eI3UyntAS0CBuBl8hKHd2fHdZ5zrLKu95DBUr
         pwEv3J3df75hFG2IoifkRXVutsaU1HTZgYSbODLm09ezNcl33jRNYoaxd0Rd/S2E+Di9
         otRGQaRY+28j89DzCRMRKWQx9gekodXmilGEwuOEkqEHJNcmDMyW7x7eqOTnpqGRjLTo
         eXuC7N/+GudsQDHtSaqMVSYhYgDhAEib1NUrbwR7KbUV09UPn4VZEdjbbxHEhMkjxAHm
         qFPQ==
X-Gm-Message-State: ALQs6tB6czjEQxDtGiNadC85k8CgCyMFxzBIi/KZ/kZV3wcj4139IYO1
        Tv4hMJ6CY+nKsGBbNqOMAgnyw346RqIn0+ZU//KuZw==
X-Google-Smtp-Source: AB8JxZq0zTef8I7O8jXj3wir26wtumt1Kf8IY+A34/g3EnrzaL6TikgVVqYKdrZ/XIkJPswNyqr6LQxfBCclX2upZuM=
X-Received: by 2002:a6b:27d5:: with SMTP id n204-v6mr3572920ion.206.1524856408684;
 Fri, 27 Apr 2018 12:13:28 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.107.97.20 with HTTP; Fri, 27 Apr 2018 12:13:28 -0700 (PDT)
In-Reply-To: <CAKk8isqAd11W4DpjNkd9AeMDGi=ESyhVSFXcvwteasTfHMPGLA@mail.gmail.com>
References: <CAKk8isrAmWOdioJe2CdY+2F_AzKxcTGwd+kBsrAmGx-U=ZHGgA@mail.gmail.com>
 <xmqqzi1s3y5h.fsf@gitster-ct.c.googlers.com> <CAKk8isr-7bSVqEv8EjF2UgFfw75D2oVZPJFui30pbY6kWfeL_Q@mail.gmail.com>
 <CAKk8ispWBoG7D+u8x+s+iB+wzXUN=7vpxgmz5wjL67P6XUmw9g@mail.gmail.com>
 <xmqqfu3h1t22.fsf@gitster-ct.c.googlers.com> <xmqqbme51rgn.fsf@gitster-ct.c.googlers.com>
 <CAKk8isqAd11W4DpjNkd9AeMDGi=ESyhVSFXcvwteasTfHMPGLA@mail.gmail.com>
From:   Bryan Turner <bturner@atlassian.com>
Date:   Fri, 27 Apr 2018 12:13:28 -0700
Message-ID: <CAGyf7-GhK_wAZn8zO35rsgQ=meLc=Lr+Q=S8omHg1c413dMsFw@mail.gmail.com>
Subject: Re: Fetching tags overwrites existing tags
To:     Wink Saville <wink@saville.com>
Cc:     Junio C Hamano <gitster@pobox.com>, Git List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Apr 27, 2018 at 12:08 PM, Wink Saville <wink@saville.com> wrote:
>
> The other change was rather than using ""+refs/tags/*:refs/remote-tags/$name/*"
> I've changed it to "+refs/tags/*:refs/remote/tags/$name/*" which seems cleaner.
> Again, if remote-tags is preferred I'll change it back.


From looking at the code, it looks like you mean
"+refs/tags/*:refs/remotes/tags/$name/*".

The issue with that approach is that it collides with a remote named
"tags". "refs/remote-tags", on the other hand, represents a new-to-Git
path, one that won't already be in use by any other standard
functionality. That seems like a better approach than hoping no one
out there will call one of their remotes "tags".

Bryan
