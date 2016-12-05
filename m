Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-6.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B2C971FBB0
	for <e@80x24.org>; Mon,  5 Dec 2016 19:29:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751515AbcLET3Z (ORCPT <rfc822;e@80x24.org>);
        Mon, 5 Dec 2016 14:29:25 -0500
Received: from mail-pg0-f50.google.com ([74.125.83.50]:33105 "EHLO
        mail-pg0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751500AbcLET3V (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 5 Dec 2016 14:29:21 -0500
Received: by mail-pg0-f50.google.com with SMTP id 3so139768693pgd.0
        for <git@vger.kernel.org>; Mon, 05 Dec 2016 11:29:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=y7fa06JIhTE/uay8KoS+EtfRuD66uPRxjjdR4MEy8ls=;
        b=EsueQp3zH1FcYD5RO5t8vhxj8+0JHhAiAfm9Facuh8gvH5N/174rxKJnMmr8hiFlWc
         9MZkOVfoyy+tAngcOKd0WgQViBLoR6DTWrbO35DR4GSF+TPefw6mcTKsrpiNtBbnHxYI
         nYEFHs3hMNevY/ezsCxfaM3rcF8ZC/CF5qefz6kaS5+a0iKkj+MAtHxA5Y5Mh+kjBOxr
         8dUR/nJTvL6hnAxjBGEwkt70DzuCHHdaXltrzwTro0eOiOK3b8+8HTc1TnC/uCTKUyIN
         sATowXlyyG0iA8LI0ex1UjtWHX51wE4XFZh7gv6GhXHdfs5dpbTLJH9TzWb73tp4GO6i
         YAsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=y7fa06JIhTE/uay8KoS+EtfRuD66uPRxjjdR4MEy8ls=;
        b=SOnoK8oTGYT2vFZVMJnciuBw0WELVdnHP6h2RLx1E1XOhdxMoHh/f4qS0BF5ieD5Ke
         +RbYsEXUfZ1gYO5rKWuclDOlhVmaHaZ7mHwZYi9FFcOxPCBZOpJ60MLxYK1qxOwngk9I
         VNN1UcM+jGAXHodJMHJVb0CkvrO02vX4v+gQk0qONtnzffnNfSb/c828LSi4SK1nlx9b
         wydvrQKZueLN676wjSQ9mDU51m4v3Pko5YL/6pYbQiGJagFpf07F9kzMUrnQ/bAGQUOj
         PrkYbGF/8bSzA/vgq0lwP+f80E76iPxoweE+TCfjqRLgoII0MuiDtoBbYZjzdZokD/jj
         U1AA==
X-Gm-Message-State: AKaTC01FAbvDvNno+pjxmHvKn0AJ9/al0NhaQalsMyqHQtxCMnD1ApaIaVxTnYEzxSkeI1E1
X-Received: by 10.84.209.173 with SMTP id y42mr125428687plh.94.1480966160553;
        Mon, 05 Dec 2016 11:29:20 -0800 (PST)
Received: from google.com ([2620:0:1000:5b00:20ca:c78:1a67:9579])
        by smtp.gmail.com with ESMTPSA id w17sm29400176pgm.18.2016.12.05.11.29.19
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Mon, 05 Dec 2016 11:29:19 -0800 (PST)
Date:   Mon, 5 Dec 2016 11:29:18 -0800
From:   Brandon Williams <bmwill@google.com>
To:     Stefan Beller <sbeller@google.com>
Cc:     David.Turner@twosigma.com, git@vger.kernel.org,
        sandals@crustytoothpaste.net, hvoigt@hvoigt.net, gitster@pobox.com
Subject: Re: [RFC PATCHv2 17/17] checkout: add config option to recurse into
 submodules by default
Message-ID: <20161205192918.GB68588@google.com>
References: <20161203003022.29797-1-sbeller@google.com>
 <20161203003022.29797-18-sbeller@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20161203003022.29797-18-sbeller@google.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 12/02, Stefan Beller wrote:
> +test_expect_success 'option checkout.recurseSubmodules updates submodule' '
> +	test_config checkout.recurseSubmodules 1 &&
> +	git checkout base &&
> +	git checkout -b advanced-base &&
> +	git -C submodule commit --allow-empty -m "empty commit" &&
> +	git add submodule &&
> +	git commit -m "advance submodule" &&
> +	git checkout base &&
> +	git diff-files --quiet &&
> +	git diff-index --quiet --cached base &&
> +	git checkout advanced-base &&
> +	git diff-files --quiet &&
> +	git diff-index --quiet --cached advanced-base &&
> +	git checkout --recurse-submodules base
> +'
> +

This test doesn't look like it looks into the submodule to see if the
submodule has indeed changed.  Unless diff-index and diff-files recurse
into the submodules?
-- 
Brandon Williams
