Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIMWL_WL_MED shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id AF0BB215F4
	for <e@80x24.org>; Tue,  1 May 2018 17:12:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754727AbeEARMB (ORCPT <rfc822;e@80x24.org>);
        Tue, 1 May 2018 13:12:01 -0400
Received: from mail-lf0-f44.google.com ([209.85.215.44]:32951 "EHLO
        mail-lf0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753505AbeEARMA (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 1 May 2018 13:12:00 -0400
Received: by mail-lf0-f44.google.com with SMTP id m18-v6so17108305lfb.0
        for <git@vger.kernel.org>; Tue, 01 May 2018 10:11:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=saville-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to;
        bh=VeUmkHCmi17MhNM3VsSEmAR9dcoFbR+1gqW87XpEcaQ=;
        b=1ktUAbGogeSbEYQoo1NXB7UV9PY/dYqgKMKHVwCdBnMVImNhREFgH3FCSICdnOIguR
         L/T7SQp/tWjxYg0zLRciaIUf/RG4kEFte4vjj34PyakZLWQVS6dq465GD0izgXfFWIWj
         10rYEotByDZdfC1MVrZnsp1kAy07RPa+FbhdhCot6ZsdMU9BwJY3rFs+d3NYmP0ZdAGJ
         wfrhp4zBkXjEvwgluki8tNrXUO6JzEM2RO1T3TmBOabqt+QZxUk3odoIQuecCuB1fH2h
         1jeGIsuWkBwlpK99YnytgJZXiB1iqHQH8sCowJKk8zx3ub7F9KjnnGdX/oVfVD7mM1Jy
         R9Vw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to;
        bh=VeUmkHCmi17MhNM3VsSEmAR9dcoFbR+1gqW87XpEcaQ=;
        b=cFO+Z4KdSBq0vqUCddz7lPHr2VNxrgfGNTj/UR0jv/3tGoZYitL1CIvyf2rEelnyLJ
         D3LGLia/0U1p0B1TjPJQod474vK+f/A5GEEc+AnF5B/wjGWcLdAcoFdWUhAbzZ+/3eDj
         lYlpQPVHtvD+RYZD8/Z2AudUo9PD2mJfWoUrebEahg4tCUMLp1ewsJqMhIU0Xhg1yMWO
         hzdztE9plznmCLxObwH6kDBCf7ZzDZtcxfKpwTYOBg9WBSu1JqnKwoNnB1qGYzQbydOv
         Dz6pDr8QL0wlTYWbxwQolh452C//ASS3fJaQ9DlY9oecD6nKiSRYTD8ilUj3ez26t9O1
         I0rw==
X-Gm-Message-State: ALQs6tBlIkjXh7/GSTNUYSwENJmDWlh5jfLKa3U4YI4LyEIP0KpTRJZL
        2CjXJOVtCRM9ofOOgZYxkJaLiUsDFWjKRaIPRZnXArPujz8=
X-Google-Smtp-Source: AB8JxZp6s0vI9LCyWFwcvFuI4IKQlJcqntekSzCdeGrFHqK0HX9+/DYlBWe8SPemjbdnqwY2jTFMUWH+BAXq+/JxkXc=
X-Received: by 2002:a2e:9248:: with SMTP id v8-v6mr11601145ljg.133.1525194718262;
 Tue, 01 May 2018 10:11:58 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a19:9ecc:0:0:0:0:0 with HTTP; Tue, 1 May 2018 10:11:37 -0700 (PDT)
In-Reply-To: <CAKk8isrAmWOdioJe2CdY+2F_AzKxcTGwd+kBsrAmGx-U=ZHGgA@mail.gmail.com>
References: <CAKk8isrAmWOdioJe2CdY+2F_AzKxcTGwd+kBsrAmGx-U=ZHGgA@mail.gmail.com>
From:   Wink Saville <wink@saville.com>
Date:   Tue, 1 May 2018 10:11:37 -0700
Message-ID: <CAKk8isoEcgFo=z+_w8Ps_zF_5sPnb2zhO3CvFVS9UAt9MvpoXw@mail.gmail.com>
Subject: Re: Fetching tags overwrites existing tags
To:     Git List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

I'm going on vacation until May 17 and will have limited connectivity.
I've created a new patch series, "Optional sub hierarchy for remote tags" [1]
that I'd appreciate comments and if someone wants to take this over
in my absence that would be great. I'd sure like to see this continue to move
forward.

In v4 I've tweaked git tag -l and added a test, so for me it has the minimal
functionality I'd need to make use of it.

-- Wink

https://public-inbox.org/git/xmqqbme51rgn.fsf@gitster-ct.c.googlers.com/T/#m89df9b973ab55d85eae72dd749e038354ea3a250
