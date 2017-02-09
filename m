Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD,T_DKIM_INVALID shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 615F91FCC7
	for <e@80x24.org>; Thu,  9 Feb 2017 19:30:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753162AbdBITaP (ORCPT <rfc822;e@80x24.org>);
        Thu, 9 Feb 2017 14:30:15 -0500
Received: from mail-pg0-f68.google.com ([74.125.83.68]:33888 "EHLO
        mail-pg0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752603AbdBITaO (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 9 Feb 2017 14:30:14 -0500
Received: by mail-pg0-f68.google.com with SMTP id v184so1048120pgv.1
        for <git@vger.kernel.org>; Thu, 09 Feb 2017 11:28:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=2ct3UEpYrMpO/XtFQSry4BCBGrwS6x6nBB4l2rxi3hw=;
        b=udn5eWdXcKr+oEs5fhOHKxCZxvY1+7pju8pWrsi+JQB9wtlBK5568BR0IUmKUwfxA3
         Kop0xMbVWEzpF9ilpfnBtQANXAz7bjlhRFPodJ+XGlXtUxdfS6+2GnurjSz7dWjTPWOz
         6ctRYxl+SrmgQJ2NcEdxIqpw8RiZA8Kd/n1+oa50unC0YBfMEJUy1wcmT323iyage787
         RAQk/8orFJi+bl6cqYdnq3HAs28EGmT2u/m6C0UY2KPXfMEM/V877yut8NdngWfhiTS6
         p16d1nHlJ5jD+PYhQDjyMPxPDpxISoCWfp3XMz40g+Xx4OWCJIms1xeGbCeTosaPFBCH
         uK9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=2ct3UEpYrMpO/XtFQSry4BCBGrwS6x6nBB4l2rxi3hw=;
        b=Ko/muHAI9BU4+6Hh4RTQdBla+ZpgfNGaZ/Oka0PHOGXXD5irTM9EeugriZ02cCXNwD
         RvdkMzxoFYAKYQtHldopSKgA6JqNRs0gzmkN4WjBrHeWWUh0N0U648mYHv8gTvrYO2g+
         FdzCcV0DMfrt5YZhqR+D1Fm3IRSlIzpLUx0AFvDjxc4tBR/Spl7TEHTwN7kfX96OENEi
         s9eVTBOk9EWfWnYMWDlAGaYebwtvPIB2Jq06x+01EZfTouoLEaeiPSi223RWWo+eCuiR
         WycoCzE3O6yW4llAl3YJXc2f6hw98n0OMkxlDPZbz8eilvZZCcqcrPXkSBUsg11HXVRE
         J6qA==
X-Gm-Message-State: AMke39lJOUUsGSPcJkGILgVImke3haRE265bLdlSVz9VcDEUD77lgIUNoRc0bd+bi7xB9A==
X-Received: by 10.84.241.10 with SMTP id a10mr6125616pll.47.1486667905002;
        Thu, 09 Feb 2017 11:18:25 -0800 (PST)
Received: from localhost ([2620:0:1000:8622:704f:61dd:c9f4:9782])
        by smtp.gmail.com with ESMTPSA id a2sm30820780pfc.72.2017.02.09.11.18.23
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Thu, 09 Feb 2017 11:18:24 -0800 (PST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Michael Haggerty <mhagger@alum.mit.edu>
Cc:     git@vger.kernel.org
Subject: Re: What's cooking in git.git (Feb 2017, #02; Mon, 6)
References: <xmqqzihzymn3.fsf@gitster.mtv.corp.google.com>
        <2f67fc21-92f9-a03e-1b09-a237af6dbc46@alum.mit.edu>
Date:   Thu, 09 Feb 2017 11:18:23 -0800
In-Reply-To: <2f67fc21-92f9-a03e-1b09-a237af6dbc46@alum.mit.edu> (Michael
        Haggerty's message of "Thu, 9 Feb 2017 17:08:13 +0100")
Message-ID: <xmqq37fnqikg.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1.91 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Michael Haggerty <mhagger@alum.mit.edu> writes:

> On 02/06/2017 11:34 PM, Junio C Hamano wrote:
>> [...]
>> --------------------------------------------------
>> [Stalled]
>> [...]
>> * mh/ref-remove-empty-directory (2017-01-07) 23 commits
>> 
>>  Deletion of a branch "foo/bar" could remove .git/refs/heads/foo
>>  once there no longer is any other branch whose name begins with
>>  "foo/", but we didn't do so so far.  Now we do.
>> 
>>  Expecting a reroll.
>>  cf. <5051c78e-51f9-becd-e1a6-9c0b781d6912@alum.mit.edu>
>
> I think you missed v4 of this patch series [1], which is the re-roll
> that you were waiting for. And I missed that you missed it...
>
> Michael
>
> [1] http://public-inbox.org/git/cover.1483719289.git.mhagger@alum.mit.edu/

Great.  Thanks.
