Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD,T_DKIM_INVALID shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 43A4B201A7
	for <e@80x24.org>; Fri, 12 May 2017 22:36:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756193AbdELWgp (ORCPT <rfc822;e@80x24.org>);
        Fri, 12 May 2017 18:36:45 -0400
Received: from mail-pf0-f194.google.com ([209.85.192.194]:36354 "EHLO
        mail-pf0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751975AbdELWgo (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 12 May 2017 18:36:44 -0400
Received: by mail-pf0-f194.google.com with SMTP id n23so7288574pfb.3
        for <git@vger.kernel.org>; Fri, 12 May 2017 15:36:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=EkDs+Lk1553JLr2diEcFf/ykg3B6tuap8amIktAoPrc=;
        b=dPXjki3G4szI1ARGbGv3KpnzCkzV/ZkenAF++um7Avo+LXp5Zd1ILhqdlVzSaxQHvT
         4Gu5AI3Tog3ap5UsSVyAvnkWniFDnr8z0wfl+eHD/16FcrDsx4OcD9QVUnhNs+L51uOS
         tzzB1/7CphYi6wF49vOpf1kmhdYJBiP4ioeY+46aX0Y+PIoJJw8uDEpsGjsi+kFZutVB
         ZL5JOfVcTGb/Z+GvUDvREeQE1sYMsoRymwNjL0jWcxQWVe/k0HQs0UVG1XmlfRJv5Rdx
         bHpoAbJ+uOMHEnq3T/K+UpKegmxJs0ZF2iyhUwVazl7dGLK1R2IDZD3CllJs4vJTmwsU
         UsFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=EkDs+Lk1553JLr2diEcFf/ykg3B6tuap8amIktAoPrc=;
        b=Gt++dTz3QUBa9UlsI2LTQ07/kNhiBXHDdhGZgCLrvRoxdagtwq/awvcgEoQGSwk0Vt
         DmUKkOBLM1ytFV9CARv5FUTPPhK92G0+mhY1vNW7OmHYbaolQiNVNvhHR4W4WMMwWXgn
         otx7v3TUsB5NU0MzdmxNHH6basOKGNwB31aNWygYtb8FZlBe0fyejywmtfCPM5oktFua
         NC+CJB/YNdmc/Qd/klCsYq6a6BcOXheu3+xwlLIwAR9POBBdCjnHamwvP8t0Rup3/kYA
         Si0hdYs3AsiZ5tS0zxxXFpLkzM33fI1AXrGbuF6v51eMXcPAZb7JWlvt71D5l06UmSLO
         Y3Gw==
X-Gm-Message-State: AODbwcDaNDGCxeG+QuKqEXzLeBhjOOLp+3y/DhyaVZnmv7zrQ4zrQh1z
        Rbz8epCIvo9QFA==
X-Received: by 10.98.147.199 with SMTP id r68mr6902717pfk.168.1494628603683;
        Fri, 12 May 2017 15:36:43 -0700 (PDT)
Received: from localhost ([2620:0:1000:8622:954c:c08b:c855:8b7f])
        by smtp.gmail.com with ESMTPSA id q24sm8179085pgn.58.2017.05.12.15.36.42
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Fri, 12 May 2017 15:36:42 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jean-Noel Avila <jn.avila@free.fr>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH v4 1/3] usability: don't ask questions if no reply is required
References: <20170503162931.30721-1-jn.avila@free.fr>
        <20170512130317.25832-1-jn.avila@free.fr>
Date:   Sat, 13 May 2017 07:36:42 +0900
In-Reply-To: <20170512130317.25832-1-jn.avila@free.fr> (Jean-Noel Avila's
        message of "Fri, 12 May 2017 15:03:15 +0200")
Message-ID: <xmqqpofd4s91.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Thanks, all three patches look good.  Will queue.

Let's merge them to 'next' soonish and eventually down to 'master'
and 'maint'.

Thanks.
