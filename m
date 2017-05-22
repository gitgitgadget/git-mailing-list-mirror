Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_MSPIKE_H3,
	RCVD_IN_MSPIKE_WL,RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD,T_DKIM_INVALID
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 39F9B2023D
	for <e@80x24.org>; Mon, 22 May 2017 22:27:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1758569AbdEVW1p (ORCPT <rfc822;e@80x24.org>);
        Mon, 22 May 2017 18:27:45 -0400
Received: from mail-pf0-f195.google.com ([209.85.192.195]:36237 "EHLO
        mail-pf0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1758434AbdEVW1p (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 22 May 2017 18:27:45 -0400
Received: by mail-pf0-f195.google.com with SMTP id n23so22834284pfb.3
        for <git@vger.kernel.org>; Mon, 22 May 2017 15:27:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-transfer-encoding;
        bh=uR9UKcy4STHRAST3kd265rtZdlgAU9oGzh5RgKfZTds=;
        b=N+UJZmfVIqyyG78KHZgX1ZCg+66khZ0YmDj3s5s/vwAOeI28o/bWt5kW77Maep/1QY
         89+P5C2EVxf/RJKUVUrCIUv3aAyXSKBSk5YiT8sppoe0HTwGLzyUbN2Ey//nyMsiWRVU
         JWIGn9HZKWm+JMQFZxb1bkH4bPB3eN8XadDjN86Qy8xw/BCszRmWMp5MtQWUkAJ1Bke1
         mfotabjON8qA+FQmLQAMcGM8ob6VX5GjzT+2WxoboVDohbD1tKKQDnnOuwhp2ive0G7w
         kaO31T7KWq3TUJgQ5FCBDDSGhtpe0ErelXDRcMBQTwl8O84n270Q1jlHt4EnTDJl5t01
         gS/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version
         :content-transfer-encoding;
        bh=uR9UKcy4STHRAST3kd265rtZdlgAU9oGzh5RgKfZTds=;
        b=p/thg2JwLF+Tq+eBkSFSRlqjG2c0XvJZVoKU73k8+9LncSRJV2W1dKmDq3qMsWH+pU
         lo6YJvqPFX8aGlDmnY4RjCmh14ynePyWjY4HYUIXVdzIVNOcsi/xjWEMLwkyGmDEjtMO
         wzM+kDNsQNtQ4pjsh3i5pn/ZxlAx9RwIdnXp3wfyAGLOLYayWbgKXemYNWA0AlOca7Cx
         AsvcCUoYkWLBfqaw2p5Of6+QObPRjJTUeUCx3jnvoE3KmXTfWad8ylStZEoIKjdBP5W+
         mNodNx+ESgP5qdoYw6Q5zFHn/94wVxQlxMZAE2Wb17KkmrHJqj4WEEa7c+9ypuiNG0+N
         QPQw==
X-Gm-Message-State: AODbwcBCZMXsxvr8SZN0YBP1DzKl6gSKDuGOkZnicBm9VZ7kFcrR4o/d
        5aCkvfrmyOog5A==
X-Received: by 10.99.96.3 with SMTP id u3mr27838048pgb.69.1495492064284;
        Mon, 22 May 2017 15:27:44 -0700 (PDT)
Received: from localhost ([2620:0:1000:8622:4439:f55c:c49b:d0dc])
        by smtp.gmail.com with ESMTPSA id l198sm34318370pga.50.2017.05.22.15.27.42
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Mon, 22 May 2017 15:27:42 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org, Marc Stevens <marc@marc-stevens.nl>,
        Michael Kebe <michael.kebe@gmail.com>,
        Jeff King <peff@peff.net>, Stefan Beller <sbeller@google.com>,
        Brandon Williams <bmwill@google.com>
Subject: Re: [PATCH v2 0/2] Update sha1dc from upstream & optionally make it a submodule
References: <xmqqpof3srw4.fsf@gitster.mtv.corp.google.com>
        <20170520115429.12289-1-avarab@gmail.com>
Date:   Tue, 23 May 2017 07:27:41 +0900
In-Reply-To: <20170520115429.12289-1-avarab@gmail.com> (=?utf-8?B?IsOGdmFy?=
 =?utf-8?B?IEFybmZqw7Zyw7A=?=
        Bjarmason"'s message of "Sat, 20 May 2017 11:54:27 +0000")
Message-ID: <xmqqbmqko7c2.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Ævar Arnfjörð Bjarmason  <avarab@gmail.com> writes:

> I liked the suggestion to make the URL a relative path, but this would
> require you to maintain a mirror in the same places you push git.git
> to, is that something you'd be willing to do?

After thinking about this a bit more, I know what I think we want a
bit better.

Relative URL (e.g. ../sha1collisiondetection that sits next to the
copy of git.git) may be a good way to go.  I can arrange to create
necessary repository next to git.git on k.org and github.com but I
need to double check about other places

Whether the submodule is referenced by a relative URL from the main
project, the submodule should not come directly from the upstream,
and various mirrors that sit next to git.git should not be blind and
automated "mirrors".  This is because I do not want us to trust the
security measures of https://github.com/cr-marcstevens/ repository.
The consumers already need to trust k.org/pub/scm/git/git.git and by
ensuring k.org/pub/scm/git/sha1dc is managed the same way, they do
not have to trust anything extra.

Another reason is that we want to make sure all commits in the
submodule that we bind to the superproject (i.e. git.git) are always
in the submodule, regardless of what our upstream does, and one way
to do so is to have control over _our_ canonical repository for the
submodule.  In normal times, it will faithfully follow the upstream
without doing anything else, but we'd keep the option of anchoring a
submodule commit that is referenced by the superproject history with
our own tag, if it is ever rewound away in the upstream history for
whatever reason.

Thanks.
