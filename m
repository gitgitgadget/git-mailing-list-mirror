From: Tom Anderson <thomasanderson@google.com>
Subject: Re: [PATCH] git-stash: add flag to skip "git reset --hard"
Date: Mon, 2 May 2016 13:53:57 -0700
Message-ID: <5727BE65.3040004@google.com>
References: <57267BBE.9010707@google.com>
 <xmqqeg9kti6x.fsf@gitster.mtv.corp.google.com> <5727A6DF.5020204@google.com>
 <xmqqh9egs04d.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon May 02 22:54:05 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1axKqy-0003fa-PJ
	for gcvg-git-2@plane.gmane.org; Mon, 02 May 2016 22:54:05 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754885AbcEBUyA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 2 May 2016 16:54:00 -0400
Received: from mail-pa0-f43.google.com ([209.85.220.43]:33174 "EHLO
	mail-pa0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753488AbcEBUx7 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 2 May 2016 16:53:59 -0400
Received: by mail-pa0-f43.google.com with SMTP id xk12so148204pac.0
        for <git@vger.kernel.org>; Mon, 02 May 2016 13:53:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=subject:to:references:cc:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding;
        bh=R1zySLrzzmBDvtbbHzXksHXQ+0mUj7XMakEmbl+A3Hc=;
        b=RPsWdi6KyoCSIxA4ZMCEMhezfneG6MmzaZFreGzXJySFRjySLU7JLNSCGYC1EkmLk0
         ZyXjz5/Z1K1yI2Gngv31TST5nwPkd/rTLeZUU4ntxTwtFHl//D7MaYMu6Y6LZ/s1Lonq
         yNjcR67Un5BOuV4GpVAIZKjtHIBaxxjguSS5aSA2Akcogv+Fd/X4nbKLy4joww4wEyl+
         +VbNf5OJ9Chgv6YqRhYZrK24bRMqlPHu1SfZ2bcOo3lemoX9W02lVz6nkkOi22GRizGG
         PGdRPrwHrHQGOpKX3QGIZ6Y5n94247F2QWj2bqpUZgQqpC/FFz2ZwsQb9XFDX8235MT5
         eJ4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:subject:to:references:cc:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding;
        bh=R1zySLrzzmBDvtbbHzXksHXQ+0mUj7XMakEmbl+A3Hc=;
        b=Us56Fv2hPhK7BFtB5nHP6ySloWQ4sc2C/0Gmcxv9cAu9DGIWBSn5Vflze7qj8617Y7
         39kjgLPzP8Wv/QE9LD65OpDjiYTZioUM7nATe5tGyosJDgcBX/2DdizlHKuR0D4HdUwX
         BK622xdGVOMueotYozrTJwFGzFeXf9iw0Q0dZ6LmU0pSFLpdYofp4v+L2oAefkBVlsb/
         MCiBYtaHTvk9iJy6JyFLiuOnkQlU746vCU9TIuIDXjpj1XbDFoEoCfkzfwpIP49l5yWf
         UFcPxvksobqHbBu9079Xr5zfVqaSRgiVAtVbq1rAfDufIk+/91flaIiiR8J9PlJWB6to
         4VzQ==
X-Gm-Message-State: AOPr4FVpDrAgaZ27ULBv3CJdHrwqCvbOZoz3jQMykmamVDdpCav6K73z0RDsxLR+UpXyVOwN
X-Received: by 10.66.78.104 with SMTP id a8mr4488320pax.88.1462222438447;
        Mon, 02 May 2016 13:53:58 -0700 (PDT)
Received: from thomasanderson.mtv.corp.google.com ([2620:0:1000:1600:a583:4c30:2a15:2c83])
        by smtp.gmail.com with ESMTPSA id dh4sm47927510pad.37.2016.05.02.13.53.57
        (version=TLSv1/SSLv3 cipher=OTHER);
        Mon, 02 May 2016 13:53:57 -0700 (PDT)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:38.0) Gecko/20100101
 Thunderbird/38.6.0
In-Reply-To: <xmqqh9egs04d.fsf@gitster.mtv.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/293289>

What I want can be achieved using "git stash store `git stash create`"

On 05/02/2016 12:58 PM, Junio C Hamano wrote:
> Tom Anderson <thomasanderson@google.com> writes:
>
>> Yes, but I like my stashes to be saved in the ref namespace.
> Isn't that something you can do so yourself with store_stash?
