Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 63BDB1FE4E
	for <e@80x24.org>; Fri, 18 Nov 2016 21:49:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752335AbcKRVts (ORCPT <rfc822;e@80x24.org>);
        Fri, 18 Nov 2016 16:49:48 -0500
Received: from mail-wm0-f65.google.com ([74.125.82.65]:36792 "EHLO
        mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751527AbcKRVtr (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 18 Nov 2016 16:49:47 -0500
Received: by mail-wm0-f65.google.com with SMTP id m203so10345637wma.3
        for <git@vger.kernel.org>; Fri, 18 Nov 2016 13:49:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=subject:to:references:cc:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding;
        bh=a4OHCCBNndRwxLjz8t/pViJheZTvJqZ5/56NjjvOPQI=;
        b=XWW9GHW57LTknztuHEYNR79P1xDRREO+pEpQfUiHhaNNwn1or7YLmKI2Ta3nEPmxl5
         ee3UPxd7vX3HP0qhbANYqxw7Md7ZH/b/ybaJCmo993AcaXMCC65TxA4IhRLY+AQWxPtE
         3+iEvNmpv16+RN9lMwWMXDtS25nOBELRXn6h8+qBH0C/yfBWcjVxaUksQAf7PD0WZpHF
         AX9cfp0wGQueWC6Oi8a+0CmGNqdjHs52avqmNBvmRNUkCBuGw4bZrqanKQaRulCVkofB
         VUKXVzjfvP71SO+rwDhqJrnzTnRMc2Lv4z/9ibKJ+e4QfhjOFHhZOjN3MG99WhWcAn/C
         BkQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:subject:to:references:cc:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding;
        bh=a4OHCCBNndRwxLjz8t/pViJheZTvJqZ5/56NjjvOPQI=;
        b=mnm0gYcLfZnj56WDc/jhcQEUHruCYn2cOiYc7YqAYe8v7d9WugeeRGZJs4p3Houpex
         sMoUZym5XQmEm0OJ2a2ZepXq+0Ij6A5lJHKON4Lrm8w31FSMlqj5MUkqNsfxLMhMJcy9
         PjiBc77WaPzMVchC80zsntdRbfVWuoBxbcgTjltbouHbSfrazgWSTTnF5CTjWyUdwvcD
         BMue1lCpreTPA4ces9Be1pIpkjkH0g/Nlk3o+o/kg+x9511np10itAL875jeQUJSRybz
         IvhDFd9prHwIYFyhpRJJxixJDlXjWWgpbGzfI2IBninvgF6uSpaH42CAwOxxx3l+2ZHf
         5qGQ==
X-Gm-Message-State: AKaTC00wyG5xMB1MbYNAHbskO7yNLcSdzB2ug6KWlm9bexuU6zDeL+dROUh1ZHXVYSdOlQ==
X-Received: by 10.28.218.129 with SMTP id r123mr457087wmg.137.1479505786117;
        Fri, 18 Nov 2016 13:49:46 -0800 (PST)
Received: from [192.168.1.26] (acuy2.neoplus.adsl.tpnet.pl. [83.11.104.2])
        by smtp.googlemail.com with ESMTPSA id jx8sm10924115wjc.2.2016.11.18.13.49.45
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 18 Nov 2016 13:49:45 -0800 (PST)
Subject: Re: [PATCH v7 13/17] ref-filter: add `:dir` and `:base` options for
 ref printing atoms
To:     Junio C Hamano <gitster@pobox.com>,
        Jacob Keller <jacob.keller@gmail.com>
References: <20161108201211.25213-1-Karthik.188@gmail.com>
 <20161108201211.25213-14-Karthik.188@gmail.com>
 <CA+P7+xqHKVUfNm+jCsbMNazHpVhB46h60k75JzS35CrkR-d-UQ@mail.gmail.com>
 <CAOLa=ZTWFuzWBjGUX_nV4rVVDRpaabmj0-M6S7aJkX3w+dK2Jw@mail.gmail.com>
 <xmqq60nqzuye.fsf@gitster.mtv.corp.google.com>
 <CAOLa=ZSFuq2+6xsrJ=CcXuOVbTnbDirbRtu7Fonfk+9EdRpbxg@mail.gmail.com>
 <xmqqy40lx2k8.fsf@gitster.mtv.corp.google.com>
 <CAOLa=ZQepW9GiUrKEWXojpy10B86K-jb84G_dJeL=mqtjZ4AWg@mail.gmail.com>
 <CA+P7+xo6OqcpLZ7v_m1EPm85eK2xCPD_LCw1Ly2RSPeSC0Ei7g@mail.gmail.com>
 <xmqq4m38vdw4.fsf@gitster.mtv.corp.google.com>
Cc:     Karthik Nayak <karthik.188@gmail.com>,
        Git mailing list <git@vger.kernel.org>
From:   =?UTF-8?Q?Jakub_Nar=c4=99bski?= <jnareb@gmail.com>
Message-ID: <20d067ef-9e2c-0d1f-f81a-06c154e95e4f@gmail.com>
Date:   Fri, 18 Nov 2016 22:49:44 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:45.0) Gecko/20100101
 Thunderbird/45.5.0
MIME-Version: 1.0
In-Reply-To: <xmqq4m38vdw4.fsf@gitster.mtv.corp.google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

W dniu 15.11.2016 o 18:42, Junio C Hamano pisze:
> Jacob Keller <jacob.keller@gmail.com> writes:
> 
>> dirname makes sense. What about implementing a reverse variant of
>> strip, which you could perform stripping of right-most components and
>> instead of stripping by a number, strip "to" a number, ie: keep the
>> left N most components, and then you could use something like
>> ...
>> I think that would be more general purpose than basename, and less confusing?
> 
> I think you are going in the right direction.  I had a similar
> thought but built around a different axis.  I.e. if strip=1 strips
> one from the left, perhaps we want to have rstrip=1 that strips one
> from the right, and also strip=-1 to mean strip everything except
> one from the left and so on?.  I think this and your keep (and
> perhaps you'll have rkeep for completeness) have the same expressive
> power.  I do not offhand have a preference one over the other.
> 
> Somehow it sounds a bit strange to me to treat 'remotes' as the same
> class of token as 'heads' and 'tags' (I'd expect 'heads' and
> 'remotes/origin' would be at the same level in end-user's mind), but
> that is probably an unrelated tangent.  The reason this series wants
> to introduce :base must be to emulate an existing feature, so that
> existing feature is a concrete counter-example that argues against
> my "it sounds a bit strange" reaction.

If it is to implement the feature where we select if to display only
local branches (refs/heads/**), only remote-tracking branches
(refs/remotes/**/**), or only tags (refs/tags/**), then perhaps
':category' or ':type' would make sense?

As in '%(refname:category)', e.g.

  %(if:equals=heads)%(refname:category)%(then)...%(end)

-- 
Jakub Narębski

