Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B8EDF2021E
	for <e@80x24.org>; Wed,  9 Nov 2016 22:25:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753047AbcKIWZb (ORCPT <rfc822;e@80x24.org>);
        Wed, 9 Nov 2016 17:25:31 -0500
Received: from mail-wm0-f65.google.com ([74.125.82.65]:32943 "EHLO
        mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750980AbcKIWZ3 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 9 Nov 2016 17:25:29 -0500
Received: by mail-wm0-f65.google.com with SMTP id u144so32015849wmu.0
        for <git@vger.kernel.org>; Wed, 09 Nov 2016 14:25:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=subject:to:references:cc:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding;
        bh=RmezT+NBbhR4fiiHUPj+IGqdgjvJelJTvCS7ySB7BkI=;
        b=U/DZF0j9OqvwgvMIBwMUcJrwEVMXR1X1dMiRU5cYEt0uf+HgoZ1WbQktpSHTZYYqLx
         5RWqmImXr1fS13T5uGeW/OYTWJ1vP/N/dznfwgUbDT3s29qRdL7l0UnULXkAwY//p1zC
         bZZ23lSPxRQk8RTHIJLviD5ej50PhBYmQiXRDR5lJKsqZp7lcCOKZUcjw3ZfB0QjnIGw
         FsS+u6WD8oM16pPyAewPjK3IvwNtVJiPQPbGcUiSqqF1vhps19j5KqIDtp78iKWIBQDo
         StkUs6EAWLxZp/EO/8+MenJL359zBT7Q1ll32hF1wls5Hq+YoreIYOIlOJUTneIWbCIs
         U1mQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:subject:to:references:cc:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding;
        bh=RmezT+NBbhR4fiiHUPj+IGqdgjvJelJTvCS7ySB7BkI=;
        b=FXgf+S7zYqeiw5ui3YUnHMrPYsMih1SU9qCF00gQhbJYqsKro0y1B3wahSysfNZzai
         G/GLKXioV33TYx1326ncUJU5u8JTZY4o4Vv2IMXbURTuQMrL1Tr10c8QKHXTntsA+rid
         gVZRQsZveyAqcaZ/4vBJhUUZ1yFHwBAlxIawLohK69Wa0WQFKkwW3kyOLL+L2lwsfaqH
         22+nCL0b5QY1AA/gtdZnxM0MpMsJVEKXFd/hIkDTBthKlXuLtwIPNL8pySvzhWpscoyD
         BGalI98gCf7ox3TBy8DJWoDa4RwW18AQi4g/TDcKiYvUj8dcf2kvQvsmupuwMWLOERiD
         NKgA==
X-Gm-Message-State: ABUngvdG07YSM9WC38lCAvXkmftTIdLzpcOHAqF+qy/8QF5K2Tw4QZJWGoPTnhHjArri0Q==
X-Received: by 10.28.88.73 with SMTP id m70mr24809976wmb.19.1478730328294;
        Wed, 09 Nov 2016 14:25:28 -0800 (PST)
Received: from [192.168.1.26] (abpn127.neoplus.adsl.tpnet.pl. [83.8.55.127])
        by smtp.googlemail.com with ESMTPSA id n3sm1915741wjq.34.2016.11.09.14.25.27
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 09 Nov 2016 14:25:27 -0800 (PST)
Subject: Re: [PATCH v5 01/16] Git.pm: add subroutines for commenting lines
To:     Vasco Almeida <vascomalmeida@sapo.pt>,
        Junio C Hamano <gitster@pobox.com>
References: <20161108120823.11204-1-vascomalmeida@sapo.pt>
 <20161005172110.30801-1-vascomalmeida@sapo.pt>
 <20161108120823.11204-2-vascomalmeida@sapo.pt>
 <xmqqshr19oxp.fsf@gitster.mtv.corp.google.com>
 <1478710943.28771.4.camel@sapo.pt>
Cc:     git@vger.kernel.org, Jiang Xin <worldhello.net@gmail.com>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        =?UTF-8?Q?Jean-No=c3=abl_AVILA?= <jn.avila@free.fr>,
        David Aguilar <davvid@gmail.com>
From:   =?UTF-8?Q?Jakub_Nar=c4=99bski?= <jnareb@gmail.com>
Message-ID: <b01d0d90-f87c-f708-5d2a-79f6268b4f44@gmail.com>
Date:   Wed, 9 Nov 2016 23:25:23 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:45.0) Gecko/20100101
 Thunderbird/45.4.0
MIME-Version: 1.0
In-Reply-To: <1478710943.28771.4.camel@sapo.pt>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

W dniu 09.11.2016 o 18:02, Vasco Almeida pisze:
> A Ter, 08-11-2016 às 17:06 -0800, Junio C Hamano escreveu:
>> Vasco Almeida <vascomalmeida@sapo.pt> writes:

>>> +sub comment_lines {
>>> +	my $comment_line_char = config("core.commentchar") || '#';
>>> +	return prefix_lines("$comment_line_char ", @_);
>>> +}
>>> +
>>
>> This makes it appear as if comment_lines can take arbitrary number
>> of strings as its arguments (because the outer caller just passes @_
>> thru), but in fact because prefix_lines ignores anything other than
>> $_[0] and $_[1], only the first parameter given to comment_lineS sub
>> is inspected for lines in it and the prefix-char prefixed at the
>> beginning of each of them.
>>
>> Which is not a great interface, as it is quite misleading.
>>
>> Perhaps
>>
>> 	prefix_lines("#", join("\n", @_));
>>
>> or something like that may make it less confusing.
> 
> I prefer to have like this instead
> 
> sub prefix_lines {
>         my $prefix = shift;
>         my $string = join("\n", @_);
>         $string =~ s/^/$prefix/mg;
>         return $string;
> }
> 
> So both subroutines can take several strings as arguments.

I like the interface, but the implementation looks a bit inefficient.
Why not simply:

  sub prefix_lines {
          my $prefix = shift;
          return "$prefix" . join("\n$prefix", @_) . "\n";
  }

That is, if we can assume that those lines are not terminated by
newlines themselves.

If they can be (but cannot have embedded newlines), then

  sub prefix_lines {
          my $prefix = shift;
          return "$prefix" . join("\n$prefix", map(chomp, @_)) . "\n";
  }

If those strings can contain embedded newlines (so that they can be
called as in Junio example), then your solution is a must-be

  sub prefix_lines {
          my $prefix = shift;
          my $string = join("\n", @_);
          $string =~ s/^/$prefix/mg;
          return $string;
  }

Well, nevermind then
-- 
Jakub Narębski

