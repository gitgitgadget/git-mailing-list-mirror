Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C2AE720248
	for <e@80x24.org>; Wed, 17 Apr 2019 02:37:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731078AbfDQCh6 (ORCPT <rfc822;e@80x24.org>);
        Tue, 16 Apr 2019 22:37:58 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:36025 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727063AbfDQCh6 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 16 Apr 2019 22:37:58 -0400
Received: by mail-wr1-f65.google.com with SMTP id y13so29796767wrd.3
        for <git@vger.kernel.org>; Tue, 16 Apr 2019 19:37:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=I2riZUlAN5214Ss1XeNhLz14mev4Lc9guTteHMhgPG8=;
        b=lY1y1xRUPfdRWnGTIYyvEZL6eoL5hOZOQkig0juzlsyLUcXJF3KDvKC64edYVKM61t
         qhyc7oHaBYTQ7YZiEP2GSxzcGf5tPazR7Z0+828zRnq0I5hbd+x5Qb2ZJPm0YG0MMdpU
         XJXWvxxx0h38TUpZjv8ZajKoRT9hhJ7eVb0cKMIF5eS6/wz+xm9ubSzg3jSM0bS8Tq/d
         kprm8I8QMKttqnQ0yMCpKXe0YNE7Iz7OBqA8Kn0/E+MshvvIQnTkc/S7hzTrQGNb27k3
         BIkocM/czz/dE48lRRJtnrBNvMTaDE8zkNl+KG0/H3Jio8Nkox9FlnlcnZns/VhuCTHe
         nepQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=I2riZUlAN5214Ss1XeNhLz14mev4Lc9guTteHMhgPG8=;
        b=OZOzCi9zfvVrwQid+EBXOI0Mh2TET2flDvMJ4jA/mqPHN9SLYJOe+9YlaoYfX3gK7T
         Zup3lQRR83DREmUk2f6fq5s/livHjyX9UrcHVdYFYlnc80kRT3ExXMdzfbPO45g9ExTa
         BPcn452Ym+NPtQbcTn9UJU+6lYHcNAteYNg3+R9pFaTpzf/YLVP0bhjZdf3yYcb/mlbg
         pSsgzvqWn8xbOIKwLQh2vWI1MsPPc3S4DTTQPENybg00oWO5uY7w49AnZBQt4WqcSwFR
         YDemLcIdTUTGsa8gDSEcvX3Ufo/or6z//Olvb54BPg+hJvpIlkdg0vMja+4LZRC2X9c4
         9LgA==
X-Gm-Message-State: APjAAAXXbQmqo3ZspGdK/geYsLegvKZFHWPKmh15RUHF+CxnlTa1G9BH
        DMMSQFJphbdcBGYmsc3RqS8=
X-Google-Smtp-Source: APXvYqyDzN57ZqcBB1djuvnycQDB27+7+JAqPTy4gfXPyI/n4JgewWhC+IQTqvkemcJo3QgVG+oeFQ==
X-Received: by 2002:adf:f70e:: with SMTP id r14mr54797043wrp.37.1555468675919;
        Tue, 16 Apr 2019 19:37:55 -0700 (PDT)
Received: from localhost (141.255.76.34.bc.googleusercontent.com. [34.76.255.141])
        by smtp.gmail.com with ESMTPSA id h18sm66951682wrt.97.2019.04.16.19.37.54
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 16 Apr 2019 19:37:55 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Ben Peart <peartben@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: What's cooking in git.git (Apr 2019, #03; Tue, 16)
References: <xmqqef62ozny.fsf@gitster-ct.c.googlers.com>
        <a65a261d-a8dd-7610-bcaf-47071df1d659@gmail.com>
Date:   Wed, 17 Apr 2019 11:37:54 +0900
In-Reply-To: <a65a261d-a8dd-7610-bcaf-47071df1d659@gmail.com> (Ben Peart's
        message of "Tue, 16 Apr 2019 11:27:41 -0400")
Message-ID: <xmqq5zrdpda5.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Ben Peart <peartben@gmail.com> writes:

>> * bp/post-index-change-hook (2019-02-15) 1 commit
>>    (merged to 'next' on 2019-03-11 at cb96d1d7c4)
>>   + read-cache: add post-index-change hook
>>
>>   Originally merged to 'next' on 2019-02-23
>>
>>   A new hook "post-index-change" is called when the on-disk index
>>   file changes, which can help e.g. a virtualized working tree
>>   implementation.
>>
>>   Will cook in 'next'.
>
> Anything in particular this is waiting for?

The second user, other than the originating party, who jumps up and
down asking for it to be in the upcoming release, preferrably with
their own use case to reenforce the justification why it is a good
idea to have the hook.  

That is what I've been hoping to see, so that I can point fingers at
you and that second person when it turns out that the hook was a bad
idea for whatever reason ;-)

Not that any feature must have support from multiple parties.  It
was just that waiting for the second one was the easiest way to
gauge the interest.
