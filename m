Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A76792036B
	for <e@80x24.org>; Fri,  6 Oct 2017 10:30:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751846AbdJFKaj (ORCPT <rfc822;e@80x24.org>);
        Fri, 6 Oct 2017 06:30:39 -0400
Received: from mail-it0-f46.google.com ([209.85.214.46]:49958 "EHLO
        mail-it0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751663AbdJFKai (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 6 Oct 2017 06:30:38 -0400
Received: by mail-it0-f46.google.com with SMTP id y15so434413ita.4
        for <git@vger.kernel.org>; Fri, 06 Oct 2017 03:30:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=4LOvS+Sivfo057UieElAVeJug82AHI6irc/mAtPxS8I=;
        b=qjnrsgXAPidr8cL35pfrptkqzwWGf7qHNPi95enddgy1S9lPHD034WmQT0KkY74uSR
         oYD30d0F3AeRuOoSn+tto06k6roUJd8kN2+IFQDHa4s9ziBRFKc+mwi4Hs1yMhWCvGdG
         Z4FIhQRZJK+4mCpQfP7SpIgyEwxTdznnhFz3NNvqvCFSvgwWw9OMEfN9yan6YYybJXvu
         qpoh7BXmu48U5Z+umT57nI2dJ9ET/u+FE/8OWOFAbA2qISo4jA1S9DN+M9KM2QvWnHbp
         ZkzZbJj7V8Ymwk/HiQnBWkSMvdg8H3Z3QEcCAkEjN2XfTQ8Jn48pQTX0a7UUHfSuEKGh
         wsXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=4LOvS+Sivfo057UieElAVeJug82AHI6irc/mAtPxS8I=;
        b=Vn54efOYQ81AiwkBlRcuF8dLAk2xq1YVt6mo5LXGIqwt7VecJv0h64vzvwl2KDaXpd
         Z4RfGWneXPhmMzKJ4AWo9cBnQNGwOu4RUindKsPzgD+fOodDU0GXaZXPy6k5XNlmC5Im
         cXxYpyAtLkS3Z3TX/1rjQFGcIKWC9wtOOALa7C/gL2vdJkGiVbaytQJHw8K34OYGCJWw
         4yo1eiWq9c4wFQnOHAg1qnSccQq4AXxsxlWXf1qjQCMSeRCwAwbdyJ9s8hz28fEwjEoE
         FBPQsS/qScuCEwPZDFjJHN0vrsY0vn3dsEcWMDZWHq97diEykaQYIXi8xwt+lV5SoYcH
         QYdw==
X-Gm-Message-State: AMCzsaX3h/vhXNM4JmU0qZBj4PrONnvBqPSfAPVsQIHcdyOMHacfYIjj
        zbu+9soEyk7Um2O6Sl14VKbIOdm04W5XNtE4qw0=
X-Google-Smtp-Source: AOwi7QBIadENtwmHkPxARaq+8ptOPm/oSFO8Grvj5aHdMEMofcKBXgFEI9XWEIt8td9EIpeQfjEsMjU8ncmqQMQJOIA=
X-Received: by 10.36.111.4 with SMTP id x4mr1617704itb.144.1507285837423; Fri,
 06 Oct 2017 03:30:37 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.79.115.198 with HTTP; Fri, 6 Oct 2017 03:30:36 -0700 (PDT)
In-Reply-To: <20171005132243.27058-1-pbonzini@redhat.com>
References: <20171005132243.27058-1-pbonzini@redhat.com>
From:   Christian Couder <christian.couder@gmail.com>
Date:   Fri, 6 Oct 2017 12:30:36 +0200
Message-ID: <CAP8UFD1X-aRN5sAB5PQt04jL_92APK279bjNf=Zt_x8KOxyL+A@mail.gmail.com>
Subject: Re: [RFC PATCH 0/4] interpret-trailers: introduce "move" action
To:     Paolo Bonzini <pbonzini@redhat.com>
Cc:     git <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Oct 5, 2017 at 3:22 PM, Paolo Bonzini <pbonzini@redhat.com> wrote:
> The purpose of this action is for scripts to be able to keep the
> user's Signed-off-by at the end.  For example say I have a script
> that adds a Reviewed-by tag:
>
>     #! /bin/sh
>     them=$(git log -i -1 --pretty='format:%an <%ae>' --author="$*")
>     trailer="Reviewed-by: $them"
>     git log -1 --pretty=format:%B | \
>       git interpret-trailers --where end --if-exists doNothing --trailer "$trailer" | \
>       git commit --amend -F-
>
> Now, this script will leave my Signed-off-by line in a non-canonical
> place, like
>
>    Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
>    Reviewed-by: Junio C Hamano <gitster@pobox.com>
>
> This new option enables the following improvement:
>
>     #! /bin/sh
>     me=$(git var GIT_COMMITTER_IDENT | sed 's,>.*,>,')
>     them=$(git log -i -1 --pretty='format:%an <%ae>' --author="$*")
>     trailer="Reviewed-by: $them"
>     sob="Signed-off-by: $me"
>     git log -1 --pretty=format:%B | \
>       git interpret-trailers --where end --if-exists doNothing --trailer "$trailer" \
>                              --where end --if-exists move --if-missing doNothing --trailer "$sob" | \
>       git commit --amend -F-
>
> which lets me keep the SoB line at the end, as it should be.
> Posting as RFC because it's possible that I'm missing a simpler
> way to achieve this...

Did you try using `--where end --if-exists replace --trailer "$sob"`?
