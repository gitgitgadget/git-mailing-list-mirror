Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 797411F404
	for <e@80x24.org>; Tue, 14 Aug 2018 18:28:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727873AbeHNVQf (ORCPT <rfc822;e@80x24.org>);
        Tue, 14 Aug 2018 17:16:35 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:39170 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726158AbeHNVQf (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 14 Aug 2018 17:16:35 -0400
Received: by mail-pf1-f193.google.com with SMTP id j8-v6so9623693pff.6
        for <git@vger.kernel.org>; Tue, 14 Aug 2018 11:28:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=ubxrS7oPqYOlUuM+X9A4yfwWO3xQFNwvdRlTlQdorKA=;
        b=b852IPYBUT9lTw/oeXvckDlCdk+u8Xa8SzkjLywnCrT+6KLJ165cbc6mqbJLKeZgJW
         fxp9TWnfjjpco0+zbHll5T6hUVMB9GHm/XzXbujk4Oz7lgokaZ9Ke18X040ysAyjZRyj
         fG25xW8OGsJrtbDHP4ZD4WwggIEVBjJ6iYT5lmPdf7+js8WG8qKj+0B/vO4h1gxJ9/DJ
         xJ+mhdvPU3PUG5OlGFSqiogaxNbARccCj0pDl9dATLrqtonXqzztKLZGWgwK6L9IYos1
         0HR97+V+gcuX28QRrKvpRjhbAkeFgdOlTlHTM3xsCovGQ6JzXVSL5tj4CKnNXgNDMd+y
         STXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=ubxrS7oPqYOlUuM+X9A4yfwWO3xQFNwvdRlTlQdorKA=;
        b=A/pggYfd8UxlvsIAeuF+6WuVTW+OdnKsyWXQ1wqxNCrAiFVRrXVGp4NSj4LPyXkdIY
         H0W+d+A5/F96lH/BL5O3p+WPOISVO0F5gznpsSl7B+zuMUFAW1tNyGZs+gmikBEZ1ebM
         7EsrbDJLd+rbDBo0iAl8ynT6Bo2+BERG9ix7LaymfD8Yn2g3nGWZ8UvrrcCeQasJasAC
         40ulyk8a5I7tOybSND7wBEyalqhtIkwrwzbzmfiNoZllJc9w8amyLiJoo9KQk7QO+R+h
         9fEkGAfJM8eI2/F30+qAhHJtYmmdopm2wg9+rLLp9QBxu0DMZQFbA4TkyvXDb3Jine9A
         Nu8g==
X-Gm-Message-State: AOUpUlGkUN/U9N4Oz/yULJqxKUU0/Q2p73CsyAhJcUZ42e7rjI0UBqV7
        DsSHhu78pcH8CshRFzKO3ZI=
X-Google-Smtp-Source: AA+uWPxzJUoc66uhwpTPmqaZYp4J6+BlfqpNZck6qbGvXyIzENrC9DpEpjve2yUL//IKBCjLeTA+5g==
X-Received: by 2002:a63:82c7:: with SMTP id w190-v6mr22145549pgd.253.1534271289779;
        Tue, 14 Aug 2018 11:28:09 -0700 (PDT)
Received: from aiede.svl.corp.google.com ([2620:0:100e:422:4187:1d6c:d3d6:9ce6])
        by smtp.gmail.com with ESMTPSA id n12-v6sm45175912pfh.146.2018.08.14.11.28.08
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 14 Aug 2018 11:28:09 -0700 (PDT)
Date:   Tue, 14 Aug 2018 11:28:07 -0700
From:   Jonathan Nieder <jrnieder@gmail.com>
To:     Stefan Beller <sbeller@google.com>
Cc:     jochen.kuehner@gmx.de, git@vger.kernel.org
Subject: Re: [PATCH] git-submodule.sh: accept verbose flag in cmd_update to
 be non-quiet
Message-ID: <20180814182807.GA142615@aiede.svl.corp.google.com>
References: <929572FA-6B1D-4EC7-825B-93B96053A82C@gmx.de>
 <20180814182202.59442-1-sbeller@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180814182202.59442-1-sbeller@google.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Stefan Beller wrote:

>  git-submodule.sh | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/git-submodule.sh b/git-submodule.sh
> index 8b5ad59bdee..f7fd80345cd 100755
> --- a/git-submodule.sh
> +++ b/git-submodule.sh
> @@ -438,6 +438,9 @@ cmd_update()
>  		-q|--quiet)
>  			GIT_QUIET=1
>  			;;
> +		-v)
> +			GIT_QUIET=0
> +			;;

Reviewed-by: Jonathan Nieder <jrnieder@gmail.com>

Thanks.
