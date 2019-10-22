Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 333941F4C0
	for <e@80x24.org>; Tue, 22 Oct 2019 16:51:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731325AbfJVQvQ (ORCPT <rfc822;e@80x24.org>);
        Tue, 22 Oct 2019 12:51:16 -0400
Received: from mail-qt1-f177.google.com ([209.85.160.177]:32897 "EHLO
        mail-qt1-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727885AbfJVQvQ (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 22 Oct 2019 12:51:16 -0400
Received: by mail-qt1-f177.google.com with SMTP id r5so27824269qtd.0
        for <git@vger.kernel.org>; Tue, 22 Oct 2019 09:51:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=date:from:to:subject:message-id:mail-followup-to:mime-version
         :content-disposition:user-agent;
        bh=ix/3EPAgSgVKsFNBNXVWhnHX2Flcpz5rreamjolzF1I=;
        b=dSJpl1rcqnU0eXUmC1y8bAidulqEmmFHpVnubqN9FYT9UJHBO0ilanJW+Z+2NsYPh0
         oYuzXpGczHQpAviJ587dy+K2+glDW0zK8fqz2CZbXrjbV9u1gMjgUlRy8cHU7GGo7bGf
         pW8lunR1BUTgMyfLYQ0Otd28y/r6x0ClumIsc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:subject:message-id:mail-followup-to
         :mime-version:content-disposition:user-agent;
        bh=ix/3EPAgSgVKsFNBNXVWhnHX2Flcpz5rreamjolzF1I=;
        b=qhPaMr2sN+IW9BK9EvXe0ya9LaLN5jPkPwSNu2+JvPRgyWDR8SPAUCFllkIkIf8Jtk
         PC+I1uiFY9kJ76bT7BJlJU3eb5g91606TDRvDCgp9FcjdPVjZEPMMauvhUxv2oVk/vbX
         6kOIADI4JpDUiDwPCCPMe2yyz+BjAsH+bUYnEBFxMjPTnFM/jFVSvcO8SLMD6qf09GMS
         PVmcOtrBvUJvUJ7SUL5JA4GTXht/l3yDesy4OYz6gdyV07bJUyOonpgWEugQX7hZGSq6
         Yvf6W1WeCgOcqaPFm5aDmDxgiY0i4i4plwK+Iafx6skneoYRZ5G+omCy+sDM6VxNxU4F
         6f+w==
X-Gm-Message-State: APjAAAU+tzovCWnO0irCYyyV+mtsuX3N3xqWx7EWKWg3ly0IuxK8L+1q
        pso4lzOEmekZx87Mry4Gsi8gN2xp/rk=
X-Google-Smtp-Source: APXvYqwvgd/m41dyTwHa0WOsdX801qL/8VMhPf6qCNQstzz2ySiJPE0sUSXn75xKJ6P8T1CiUlkJ9A==
X-Received: by 2002:a05:6214:1c9:: with SMTP id c9mr4215614qvt.128.1571763074746;
        Tue, 22 Oct 2019 09:51:14 -0700 (PDT)
Received: from chatter.i7.local (192-0-228-88.cpe.teksavvy.com. [192.0.228.88])
        by smtp.gmail.com with ESMTPSA id f35sm1813516qtd.35.2019.10.22.09.51.13
        for <git@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Oct 2019 09:51:13 -0700 (PDT)
Date:   Tue, 22 Oct 2019 12:51:12 -0400
From:   Konstantin Ryabitsev <konstantin@linuxfoundation.org>
To:     git@vger.kernel.org
Subject: is commitGraph useful on the server side?
Message-ID: <20191022165112.GA4960@chatter.i7.local>
Mail-Followup-To: git@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Disposition: inline
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi, all:

I've read the docs on commitGraph and it's not 100% clear to me if 
turning it on and generating commit graphs would be useful on the 
server-side. I know it's going to be enabled by default and 
automatically generated whenever "git gc" runs, so I'm trying to figure 
out if it'll be useful for git-daemon operations.

Thanks in advance for your help.

Best,
-K
