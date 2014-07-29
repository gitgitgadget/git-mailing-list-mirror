From: Tanay Abhra <tanayabh@gmail.com>
Subject: Re: [PATCH v4 3/6] rewrite git_config() to use the config-set API
Date: Tue, 29 Jul 2014 17:05:21 +0530
Message-ID: <53D786F9.9070002@gmail.com>
References: <1406633302-23144-1-git-send-email-tanayabh@gmail.com> <1406633302-23144-4-git-send-email-tanayabh@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Ramkumar Ramachandra <artagnon@gmail.com>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jul 29 13:35:41 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XC5gy-0005gT-Tz
	for gcvg-git-2@plane.gmane.org; Tue, 29 Jul 2014 13:35:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753366AbaG2Lff (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 29 Jul 2014 07:35:35 -0400
Received: from mail-pd0-f179.google.com ([209.85.192.179]:48729 "EHLO
	mail-pd0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753251AbaG2Lfd (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 29 Jul 2014 07:35:33 -0400
Received: by mail-pd0-f179.google.com with SMTP id ft15so11305186pdb.24
        for <git@vger.kernel.org>; Tue, 29 Jul 2014 04:35:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-type:content-transfer-encoding;
        bh=xJheBDcttTXbFTikYsR+M5o89PtCxdebu5uExr1YEC4=;
        b=Zx5gnj5kTaY/xQOpxDqEDAUPn5Y6M6ez56zqcWAeeheBhn4ArRJ1xyaFlKL0gOAIvy
         Nxw+MSrM9wxWIn22ycaLoCeMa69agwHAmTiYH55qWsDpVLNAp1yiewDqM9Ui460yT5x0
         wkNeZCPWk14kHFue+J2YG13QGeCRRoR7DWe0aAgIboOqfoa8gbRr6Oy6HsxnGJ9FICWj
         +GNZM69UGqXbO8q9Ztf8YJj+aC5G6Hazi8exCFX3PLMNBt0+71+f6gQBwvFbfgOvXTza
         LsBoqc2dV0BPQ31IdRCUtQYQzUCmWEBu1yvbckLJsmLypY+2T9XNmghPM9K9+BDu79gS
         X5pw==
X-Received: by 10.68.252.7 with SMTP id zo7mr1481925pbc.102.1406633732423;
        Tue, 29 Jul 2014 04:35:32 -0700 (PDT)
Received: from [127.0.0.1] ([223.184.138.24])
        by mx.google.com with ESMTPSA id x5sm20499852pbw.26.2014.07.29.04.35.26
        for <multiple recipients>
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Tue, 29 Jul 2014 04:35:31 -0700 (PDT)
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:24.0) Gecko/20100101 Thunderbird/24.6.0
In-Reply-To: <1406633302-23144-4-git-send-email-tanayabh@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/254419>

> diff --git a/t/t4055-diff-context.sh b/t/t4055-diff-context.sh
> index cd04543..741e080 100755
> --- a/t/t4055-diff-context.sh
> +++ b/t/t4055-diff-context.sh
> @@ -79,7 +79,7 @@ test_expect_success 'non-integer config parsing' '
>  test_expect_success 'negative integer config parsing' '
>  	git config diff.context -1 &&
>  	test_must_fail git diff 2>output &&
> -	test_i18ngrep "bad config file" output
> +	test_i18ngrep "bad config variable" output
>  '
>
>  test_expect_success '-U0 is valid, so is diff.context=0' '
>

This was a minor fixup with only a changed word, so I didn't flip it and
fix after in the series as you said yesterday. Dunno if it's alright.
