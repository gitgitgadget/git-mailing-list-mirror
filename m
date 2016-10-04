Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 05D6520986
	for <e@80x24.org>; Tue,  4 Oct 2016 20:50:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754271AbcJDUu4 (ORCPT <rfc822;e@80x24.org>);
        Tue, 4 Oct 2016 16:50:56 -0400
Received: from mail-wm0-f47.google.com ([74.125.82.47]:35995 "EHLO
        mail-wm0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754214AbcJDUuy (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 4 Oct 2016 16:50:54 -0400
Received: by mail-wm0-f47.google.com with SMTP id k125so229760144wma.1
        for <git@vger.kernel.org>; Tue, 04 Oct 2016 13:50:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=subject:to:references:cc:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding;
        bh=EsqcEqI9nYSbfyrQUnz32kQi/v1Mc7CXmjEy41qiI38=;
        b=AvOHz2JkI2WMM+sjSV+86xCBLnJJRQcpHpKFke2yy6BeVvcRAIaXId0224ZeGmxHsv
         1UzCu9RCWwEm3zi8XwmbmQwR+t3d0DYimDu9z48QG47N5fhkkR5E7lMOiubkf5HK3mo2
         jSv2EsBoK3LBzBH39XYErx5eqtyvB9FtTVKFMQI6r3q82jZRlC499BgnxBNEqJGsnaA4
         qvjCwzyvJ9q+LSYXqi8iQ6pn+PIEPpcSltNko0lee93uj/30a3yvCv/gl3hdLq/kotjI
         fl17L5Og8e43l3QxGNXrEiO6kGwwTgFs65tUWga8Eg1m6Y5srpXR//kM4ZdHiKM6cMgS
         Tyew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:subject:to:references:cc:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding;
        bh=EsqcEqI9nYSbfyrQUnz32kQi/v1Mc7CXmjEy41qiI38=;
        b=BKowN6p2YhxNf1mNujZ+3+5Ebrr7Kzz01Me2l0Z9RU63T9wexD8zFKfigXub8N67LO
         N8yDI/ecXOXn7OwSrznyyNNeLkwqgk8FCbck3F3CdeDqvtDQ4rlpjf8AdF8KlFf6meTp
         ijgjOqjjJw+r+i/biKyqYC1Aql2If2G6qQlVz5MdxLl3DKWVvf0VWSmBQL+lewEF3+cu
         wZaLQhI2N984Rpf7coR+ERH2rNE3OxSwflhke9E5djug+abse7lUuwLGORr3kq4x50Cd
         q6bNKpaUTcbExv3JCe3dTW5ek/GKb4rZXx8gXWZABS6I7lsfwT2I3ZNB3a1qhDlSWRsB
         Bg4Q==
X-Gm-Message-State: AA6/9Rk9soj9548sbgpUYkbSmQJ9DyffKKO8KexIUT/O8GB+RPOzsjoZj/FDZuJl5D+oUQ==
X-Received: by 10.28.139.145 with SMTP id n139mr17249785wmd.125.1475614253005;
        Tue, 04 Oct 2016 13:50:53 -0700 (PDT)
Received: from [192.168.1.26] (dbs112.neoplus.adsl.tpnet.pl. [83.23.44.112])
        by smtp.googlemail.com with ESMTPSA id c5sm5287847wjw.29.2016.10.04.13.50.50
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 04 Oct 2016 13:50:51 -0700 (PDT)
Subject: Re: [PATCH v8 11/11] convert: add filter.<driver>.process option
To:     Lars Schneider <larsxschneider@gmail.com>
References: <20160920190247.82189-1-larsxschneider@gmail.com>
 <20160920190247.82189-12-larsxschneider@gmail.com>
 <91589466-439e-7200-7256-b9288beae685@gmail.com>
 <4DE57A65-1020-4F17-81F2-9F319834BB2D@gmail.com>
Cc:     git <git@vger.kernel.org>, Jeff King <peff@peff.net>,
        Junio C Hamano <gitster@pobox.com>,
        Stefan Beller <sbeller@google.com>,
        Martin-Louis Bright <mlbright@gmail.com>,
        =?UTF-8?Q?Torsten_B=c3=b6gershausen?= <tboegi@web.de>,
        Ramsay Jones <ramsay@ramsayjones.plus.com>
From:   =?UTF-8?Q?Jakub_Nar=c4=99bski?= <jnareb@gmail.com>
Message-ID: <2c53b837-4690-dae8-60ff-e7907a9b13ef@gmail.com>
Date:   Tue, 4 Oct 2016 22:50:38 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:45.0) Gecko/20100101
 Thunderbird/45.3.0
MIME-Version: 1.0
In-Reply-To: <4DE57A65-1020-4F17-81F2-9F319834BB2D@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

[Some of answers may get invalidated by v9]

W dniu 30.09.2016 o 20:56, Lars Schneider pisze:
>> On 27 Sep 2016, at 00:41, Jakub Narębski <jnareb@gmail.com> wrote:
>>
>> Part first of the review of 11/11.

[...]
>>> +to read a welcome response message ("git-filter-server") and exactly
>>> +one protocol version number from the previously sent list. All further
>>
>> I guess that is to provide forward-compatibility, isn't it?  Also,
>> "Git expects..." probably means filter process MUST send, in the
>> RFC2119 (https://tools.ietf.org/html/rfc2119) meaning.
> 
> True. I feel "expects" reads better but I am happy to change it if
> you feel strong about it.

I don't have strong opinion about this.  I guess following the example
of pkt-line format description may be a good idea.  We are not writing
an RFC here... but having be explicit is better than be good read :-P

>>> +
>>> +After the version negotiation Git sends a list of supported capabilities
>>> +and a flush packet.
>>
>> Is it that Git SHOULD send list of ALL supported capabilities, or is
>> it that Git SHOULD NOT send capabilities it does not support, and that
>> it MAY send only those capabilities it needs (so for example if command
>> uses only `smudge`, it may not send `clean`, so that filter driver doesn't
>> need to initialize data it would not need).
> 
> "After the version negotiation Git sends a list of all capabilities that
> it supports and a flush packet."
> 
> Better?

Better.

I wonder if it is a matter of current implementation, namely that at
the point of code where Git is sending capabilities it doesn't know
which of them it will be using; at least in some of cases.

Because if it would be possible for Git to not send capabilities which
it supports, but is sure that it would not be using for a given operation,
then it would be good to do that.  It might be that filter driver must
do some prep work for each of capabilities, so skipping some of prep
would make git faster.  Though all this is for now theoretical musings...
it might be an argument for such description of protocol so it does
not prevent Git from sending only supported capabilities it needs.

>> I wonder why it is "<capability>=true", and not "capability=<capability>".
>> Is there a case where we would want to send "<capability>=false".  Or
>> is it to allow configurable / value based capabilities?  Isn't it going
>> a bit too far: is there even a hind of an idea for parametrize-able
>> capability? YAGNI is a thing...
> 
> Peff suggested that format and I think it is OK:
> http://public-inbox.org/git/20160803224619.bwtbvmslhuicx2qi@sigill.intra.peff.net/

It wouldn't kill you to summarize the argument, would it?

From what I understand the argument is that "<capability>=true" allows
for simplist parsing into a [intermediate] hash, while the other
proposal of using"capability=<capability>" would require something more
sophisticated.  And that it is better to be explicit rather than
use synonyms / shortcuts for "<capability>".

Though one can argue that "<foo>" is synonym / shortcut for "<foo>=true";
it would not complicate parsing much.

Nb. we don't use trick of 'parse metadata to hash' in neither example,
nor filter driver used in test...

[...]
>>> +
>>> +After the filter has processed a blob it is expected to wait for
>>> +the next "key=value" list containing a command. Git will close
>>> +the command pipe on exit. The filter is expected to detect EOF
>>> +and exit gracefully on its own.

Is this still true?

>>
>> Good to have it documented.  
>>
>> Anyway, as it is Git command that spawns the filter driver process,
>> assuming that the filter process doesn't daemonize itself, wouldn't
>> the operating system reap it after its parent process, that is the
>> git command it invoked, dies? So detecting EOF is good, but not
>> strictly necessary for simple filter that do not need to free
>> its resources, or can leave freeing resources to the operating
>> system? But I may be wrong here.
> 
> The filter process runs independent of Git.

Ah.  So without some way to tell long-lived filter process that
it can shut down, because no further data will be incoming, or
killing it by Git, it would hang indefinitely?

[...]
>>> +    }
>>> +    elsif ( $pkt_size > 4 ) {
>>
>> Isn't a packet of $pkt_size == 4 a valid packet, a keep-alive
>> one?  Or is it forbidden?
> 
> "Implementations SHOULD NOT send an empty pkt-line ("0004")."
> Source: Documentation/technical/protocol-common.txt

All right.  Not that we need keep-alive packet for communication
between two processes on the same host.

Though I wonder why this rule is here...

[...]
>>> +( packet_txt_read() eq ( 0, "git-filter-client" ) ) || die "bad initialize";
>>> +( packet_txt_read() eq ( 0, "version=2" ) )         || die "bad version";
>>> +( packet_bin_read() eq ( 1, "" ) )                  || die "bad version end";
>>
>> Actually, it is overly strict.  It should not fail if there
>> are other "version=3", "version=4" etc. lines.
> 
> True, but I think for an example this is OK. I'll add a note
> to the file header.

Anyway it would be better to have helper subroutine to get metadata
lines (packets till flush) and parse them into array or a hash...

>>> +
>>> +while (1) {
>>> +    my ($command)  = packet_txt_read() =~ /^command=([^=]+)$/;
>>> +    my ($pathname) = packet_txt_read() =~ /^pathname=([^=]+)$/;
>>
>> Do we require this order?  If it is, is that explained in the
>> documentation?
> 
> Git sends that order right now but the filter should not rely
> on that order.

...and the latter would make ignoring order of lines simpler.

Though I wonder if we can ensure in the protocol documentation
that those lines would always be send in this order.

Best,
-- 
Jakub Narębski

