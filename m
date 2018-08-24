Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	FROM_EXCESS_BASE64,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 069001F404
	for <e@80x24.org>; Fri, 24 Aug 2018 14:39:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726511AbeHXSN4 (ORCPT <rfc822;e@80x24.org>);
        Fri, 24 Aug 2018 14:13:56 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:33268 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726277AbeHXSN4 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 24 Aug 2018 14:13:56 -0400
Received: by mail-wr1-f67.google.com with SMTP id v90-v6so7705963wrc.0
        for <git@vger.kernel.org>; Fri, 24 Aug 2018 07:38:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:user-agent:in-reply-to:date
         :message-id:mime-version;
        bh=EjQU+5xPZRUAMLvbIvmPAHnJ1xPQFeFRVxKlELlTBys=;
        b=RNC7IEiSKZZzlZP9OQ4HABOLzrQ2etCXyIQcs0QC9m+IYphE/JdAoCA0FahwhpNGut
         uJlF2h9diH+wf2C0v+hk3QKgorcM0q02au5fgea+emJRXT8vvRyFXIV5cXH9G+HR8zW9
         u38Kar4ZySbvMGQ+skkHEwU7w/ejtPqWbqNRU5H8UA80fPxf7n4CQY3LYAlB9ArATMzV
         dw7vMtgbP/CDINT0i1eY0xdKLCKlVfIdi4q4huM5hQ8SjmcblMELFwUdAqQ/Uvg81Nka
         NKkdviq5IexHCqlz5niKkkk5nT5170VikeZHhjg3UTKwa3q8Tny1JbXAZF8t2FYSp5GB
         luCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:user-agent
         :in-reply-to:date:message-id:mime-version;
        bh=EjQU+5xPZRUAMLvbIvmPAHnJ1xPQFeFRVxKlELlTBys=;
        b=tyPVDXwUR2TykdXDTaMsXi7j4fZ7Udt9mD9EX2+zKuHq7tgZrEix0J0wDyYzA9Wfi5
         bU9C4HNMNLh3UCIwr+yJn0v8ud8Iglek2bw1Aiz3upo8MhAJYZF3DqxSl8wfIqvv5c7Z
         anAr0Wo+vkpRZ865tflX1fMMTupW3vUCFDwJHhXdOt1k1yuAqqGPT3XJ+DqXEK0Yq4BR
         iLvQ7ZMvDUvgIeJZqV0XgzwVjHbdwkAMhjyYtqd13LHVwpSv85gv71BG99GKiXy0MTQL
         IP52iOiMBAshxvhAablIt0sdC60hIkqbgtpd2LljMX+eDOpBD++RweAGi8i3M5WsTZLp
         SmgQ==
X-Gm-Message-State: APzg51B80+a/Su59qWChNzfBrRNDm7oQNS4ngWyZeu91A2OqvLraKePo
        Pj2el/VIM5cBa5xwuYPPDKg=
X-Google-Smtp-Source: ANB0VdbJLbhRy+gUWIOBbufPIJ1PxEfSfDK3+Hxl4B4zEuHIsbMef0hF73d7IKxStRJs7oK9QuuOlw==
X-Received: by 2002:adf:ae01:: with SMTP id x1-v6mr1407555wrc.45.1535121538821;
        Fri, 24 Aug 2018 07:38:58 -0700 (PDT)
Received: from evledraar ([5.57.21.50])
        by smtp.gmail.com with ESMTPSA id k35-v6sm11602519wrc.14.2018.08.24.07.38.57
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 24 Aug 2018 07:38:58 -0700 (PDT)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Antonio Ospite <ao2@ao2.it>
Cc:     git@vger.kernel.org, Brandon Williams <bmwill@google.com>,
        Daniel =?utf-8?Q?Gra=C3=B1a?= <dangra@gmail.com>,
        Jonathan Nieder <jrnieder@gmail.com>,
        Richard Hartmann <richih.mailinglist@gmail.com>,
        Stefan Beller <sbeller@google.com>
Subject: Re: [PATCH v4 0/9] Make submodules work if .gitmodules is not checked out
References: <20180824132951.8000-1-ao2@ao2.it>
User-agent: Debian GNU/Linux testing (buster); Emacs 25.2.2; mu4e 1.1.0
In-reply-to: <20180824132951.8000-1-ao2@ao2.it>
Date:   Fri, 24 Aug 2018 16:38:57 +0200
Message-ID: <87va7zesn2.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Fri, Aug 24 2018, Antonio Ospite wrote:

> this series teaches git to try and read the .gitmodules file from the
> index (:.gitmodules) and the current branch (HEAD:.gitmodules) when it
> is not readily available in the working tree.

FWIW I didn't read any of the earlier series's, and I'm not that
familiar with the submodule code, but having skimmed this all (not live
tested at all) nothing jumped out at me as an issue, I just had some
minor style / potential memory leak nits on 1/9.
