Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 932A51F87F
	for <e@80x24.org>; Tue, 13 Nov 2018 18:01:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732146AbeKNEAJ (ORCPT <rfc822;e@80x24.org>);
        Tue, 13 Nov 2018 23:00:09 -0500
Received: from mail-yb1-f169.google.com ([209.85.219.169]:45354 "EHLO
        mail-yb1-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730995AbeKNEAJ (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 13 Nov 2018 23:00:09 -0500
Received: by mail-yb1-f169.google.com with SMTP id 131-v6so5729621ybe.12
        for <git@vger.kernel.org>; Tue, 13 Nov 2018 10:00:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=WXoJbSTP8MrK6NLhioZt/Ut3BONkUCocy89AJO4mxmc=;
        b=ns98uT6Z/iZwMohKL5MUgiVjXxyPosCeQK0AGnTZrlFMhOJqybH2iBJ/2JXy8LgOYl
         gn17l/I5Bu52xGvaWJWXKi43FSxGAa4mTb/FZ36db2TzPWQ7acGHVC3n9CtNCy7c0g8B
         7FJa1f/336G35NGRupdUPS4HXRrhDinE+CIlzD4qqycf/XPoIDUhtg3yGwCQxnYQk2Fi
         knMxFhNbAi6S44pSGf0WRpmPIm1VFU97yo1p6bGAvosUsg1cfI1ae8Bd2TElVsHQzRM6
         UsD43WJG1XgKkJ8lj9UyZtPT5AeP4PELFWpTRM6SaIafFhmDxGTDsjyNvBGQ+HImDdm7
         kU+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=WXoJbSTP8MrK6NLhioZt/Ut3BONkUCocy89AJO4mxmc=;
        b=pYeHcNqCAWDZ/PpnJOVD0bLzz4N468HQHv6zJLlikugVTW4fASgBYRjv2ikveYLuRH
         L35Ks+ufn+T9tzAfCR7PsHknUxmzyMULJ33f1yS9YfFFyXGOJQ8C6Zs5EGLFB7P+KWni
         4AaaFCeyq2cm3GcDPP5NtNVDhF6voohaFF04il1F13cmrdr/psuJP5vmcIVeU6ElV27C
         9bGE0QZAD4jcRNkbnCZpNkMblwPHel+JLlbWVgAm0v/wK/spSrcjwM71LaR8Xltj1pKk
         8d6DLjA9DBOLMl6hLDFxvJVeoItytLzoVPur7qrGXsG2pPtC5K+wabfLoLq4TNclYYhQ
         pLQg==
X-Gm-Message-State: AGRZ1gKI5IdHTi8aRxSORPkugloxxY4NTiqdZjAneTP0ZYtZkEpbKVR1
        iC5V/WX39Ymyc7rsbWXZSjMlBvcw
X-Google-Smtp-Source: AJdET5eF+0/oTJhleNsAIbrKiPEYJ+W8hmh5L9qxWsxBJIi2Ti73hXHLwX4IZF6eGYxxCp3HxpmDTw==
X-Received: by 2002:a25:cc4d:: with SMTP id l74-v6mr5806161ybf.125.1542132052749;
        Tue, 13 Nov 2018 10:00:52 -0800 (PST)
Received: from localhost ([2620:10d:c091:200::6:e2a7])
        by smtp.gmail.com with ESMTPSA id h82-v6sm4000320ywh.17.2018.11.13.10.00.51
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 13 Nov 2018 10:00:52 -0800 (PST)
Date:   Tue, 13 Nov 2018 10:00:49 -0800
From:   Tejun Heo <tj@kernel.org>
To:     git@vger.kernel.org, Junio C Hamano <jch2355@gmail.com>,
        Jeff King <peff@peff.net>
Cc:     kernel-team@fb.com
Subject: Re: [RFC] cherry-pick notes to find out cherry-picks from the origin
Message-ID: <20181113180049.GL2509588@devbig004.ftw2.facebook.com>
References: <20181017143921.GR270328@devbig004.ftw2.facebook.com>
 <20181024122401.GD4182586@devbig004.ftw2.facebook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181024122401.GD4182586@devbig004.ftw2.facebook.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Oct 24, 2018 at 05:24:01AM -0700, Tejun Heo wrote:
> Ping, thanks.

Ping again.  Any comments?  Wasn't this the direction you guys were
suggesting?

Thanks.

-- 
tejun
