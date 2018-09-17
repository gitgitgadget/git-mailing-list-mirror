Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIM_INVALID shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id F3E361F404
	for <e@80x24.org>; Mon, 17 Sep 2018 16:44:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728437AbeIQWMq (ORCPT <rfc822;e@80x24.org>);
        Mon, 17 Sep 2018 18:12:46 -0400
Received: from mail-wm1-f42.google.com ([209.85.128.42]:50536 "EHLO
        mail-wm1-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727124AbeIQWMp (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 17 Sep 2018 18:12:45 -0400
Received: by mail-wm1-f42.google.com with SMTP id s12-v6so10430960wmc.0
        for <git@vger.kernel.org>; Mon, 17 Sep 2018 09:44:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=L8a2G0VxHiMiXCJKlEBu79xM09/qhJ/uaafGJVzyins=;
        b=gVtwY25g2svH/CDGxg2s+sZmn+pbMkoHmRAU0rnfTUy6/qpUgsM7z34PcVnjwIw+r6
         lttuCykJuqqeJS4lEeVnbriw3eMOD3mshSztbe3k7ZaE5Z5VIHPkNC6ZiOq403tQp8sB
         XnCcFjnoCGabG0TYsOJIb3z1Zi2qQDZzhOi9WX+FWnf47ycYIeayRk6DIZ9f8HR9fClQ
         vwAGIwTMh8hSaCPmZdHPjkJmY+K+le9//1jC/ccw0QmRqNCdLTVm2STHWbyshZTJiRVv
         C3p56HW0oeeCyOFtSNPmXgEXEkoo7O6rnGtMHBcycDpE/FL/ySibo3WsCZU4UBFJT6IH
         oqsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=L8a2G0VxHiMiXCJKlEBu79xM09/qhJ/uaafGJVzyins=;
        b=hTfERE1uhu8P/4VpXrYX399MIOiURgiKwzv/71yYLZh+gIwkGi/xD8GKhJcEHqyd6M
         sOGqr0lN/HcTzaHloAy9KKvsE7HOhKxQFQHZNn6xuNCh/NHKbSk0vezT5EQS+8bAolMg
         hfOcZnzk4OzbC+L51BCFASBcqJjmXWyHyiKHp6O4GCPfEVeQDyZMETpMuSBa+fM/egMG
         s+9L295SEEtmfol0Z2bCj5Vsn1/RbeXnjAqykslGrPyIsBeOXpXyLtNsER6gwCO7pEmI
         rQEsS6WSHs4fw3Ie29vC8jGa0G+GfEIB/aTI7ahwFG9go14AzOkil/ZG/kBsgvczwTYu
         OLSA==
X-Gm-Message-State: APzg51BFLvZmucn8SVf0R+vhK4LP5kpPm2oQxL+3ThW7LUJWSoIqAUQE
        Gzl9UCmkvJ5RXgCwrlCPmTI=
X-Google-Smtp-Source: ANB0VdYgIkD6iCgBh6BtIYl2w6Wy9bEeHAt5QyeMMqiPCup2g7BncfgyRbUMaFSmLfaZf0Iuo63qmw==
X-Received: by 2002:a1c:cf8a:: with SMTP id f132-v6mr12036633wmg.0.1537202674631;
        Mon, 17 Sep 2018 09:44:34 -0700 (PDT)
Received: from localhost (112.68.155.104.bc.googleusercontent.com. [104.155.68.112])
        by smtp.gmail.com with ESMTPSA id s2-v6sm19508320wrn.83.2018.09.17.09.44.33
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 17 Sep 2018 09:44:33 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     David Aguilar <davvid@gmail.com>
Cc:     "H.Merijn Brand" <h.m.brand@xs4all.nl>, git@vger.kernel.org
Subject: Re: Feature request: be able to pass arguments to difftool command
References: <20180828175711.3a0aeacc@pc09.procura.nl>
        <xmqqpny2ffjv.fsf@gitster-ct.c.googlers.com>
        <20180829091838.2eee8a6a@pc09.procura.nl>
        <20180916062800.GA18517@gmail.com>
Date:   Mon, 17 Sep 2018 09:44:33 -0700
In-Reply-To: <20180916062800.GA18517@gmail.com> (David Aguilar's message of
        "Sat, 15 Sep 2018 23:28:00 -0700")
Message-ID: <xmqqfty8845q.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

David Aguilar <davvid@gmail.com> writes:

> While I do see the utility, it would be just as easy to configure a 2nd
> and 3rd variant of the same difftool and use those as needed instead.
>
> "git difftool -t ccdiff2" or "-t ccdiff3" is the simplest, and there's
> nothing stopping the user from creating aliases to shorten it further.
> ...
> We already have two mechanisms for controlling the inner command that's
> launched by difftool.  IMO we don't need more.

OK, fair enough.
