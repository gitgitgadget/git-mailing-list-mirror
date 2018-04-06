Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	FROM_EXCESS_BASE64,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0D3E21F42D
	for <e@80x24.org>; Fri,  6 Apr 2018 18:23:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752075AbeDFSXO (ORCPT <rfc822;e@80x24.org>);
        Fri, 6 Apr 2018 14:23:14 -0400
Received: from mail-wm0-f43.google.com ([74.125.82.43]:54868 "EHLO
        mail-wm0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752069AbeDFSXN (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 6 Apr 2018 14:23:13 -0400
Received: by mail-wm0-f43.google.com with SMTP id r191so5169544wmg.4
        for <git@vger.kernel.org>; Fri, 06 Apr 2018 11:23:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:user-agent:in-reply-to:date
         :message-id:mime-version:content-transfer-encoding;
        bh=b8ISOH3x3HzCjdVw+3oBjjAusANE/Z5/2VZduP7uS74=;
        b=hIES4VGJYnr/JPQb9NHFjQRev7jykN6hMfpaVsOCYTlzXKWRga4THftBYk1wjwVD5M
         Rmg0m08jN9kw+JXlmMl2FSnpnSr37DCbscEQWUlJ8NWgrjwYnMc+Zx3F+7fdERVgUQxo
         1/10lyQnWQt8Mp7qIUAiWNIoBYt+JcgCBanuMCXbDBF94a1xCgdysf/iHC+qekVjQDdB
         PYs//kzqFfyT04GnYYk7c4mkRAt8OEk+Flj6EZcrfSl0vvwGW0ZrUb97tW5aUPIJ5ADe
         2ZBmGkjdS7zjTeKZnZBRl0Qiexkxv8GgjAUTlqfaxaswqEjK6xFCh77cR4guH1EGIx3r
         2TEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:user-agent
         :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
        bh=b8ISOH3x3HzCjdVw+3oBjjAusANE/Z5/2VZduP7uS74=;
        b=ZjISnzvQexoae9UlwHzU5tkrlBUxLa++/Liwrj28rN9MJ2/wPKZDaEYlQTFCi+fN1s
         +6sJN3G87t4rMCXHFm4xECZwWG5uYpChbjdSI7rmPgAs4NWL/vWk6z2dLJuhB51l5hGb
         wPiJEfCp+qx4RZRuNlYMeW7lc0TP8b+Ofta7XDZTAPKBZJSsmtdw0BmiW14ApY7nVIzf
         NHBIbeCwo6lSo4j7pjERtg9kp0Myow0VW1U/qUAy+oimpSGkFDyJ1GSqPYfyI3wNmQgh
         wknz8V8ro3ve1JPhEZcW+0S5TfucH4WXAd8sWIrSolA7XFche8sg+Om9QgLxhx4Dvyor
         iblw==
X-Gm-Message-State: ALQs6tBt50MgFq8N0SRiDdS7kqD7djaVxKUun17fcW2wq6NrZQDAaCec
        9OSDTWQPv6XEnIvujFudQc8=
X-Google-Smtp-Source: AIpwx48GNCGtlCKKuhl9mgeDIskBuUlF4j8Z2ZuX2thYuek3ObM17HJUtRYr4+/JeqmJy+bqel7LAw==
X-Received: by 10.80.182.121 with SMTP id c54mr8040371ede.112.1523038991957;
        Fri, 06 Apr 2018 11:23:11 -0700 (PDT)
Received: from evledraar (dhcp-089-098-184-206.chello.nl. [89.98.184.206])
        by smtp.gmail.com with ESMTPSA id i48sm6547994ede.39.2018.04.06.11.23.10
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 06 Apr 2018 11:23:11 -0700 (PDT)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Eric Wong <e@80x24.org>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Joseph Mingrone <jrm@ftfl.ca>, garga@FreeBSD.org,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Ben Caradoc-Davies <ben@transient.nz>, 894997@bugs.debian.org
Subject: Re: [PATCH] git-svn: avoid warning on undef readline()
References: <86h8oobl36.fsf@phe.ftfl.ca> <20180406131514.740-1-avarab@gmail.com> <20180406165618.GA6367@80x24.org>
User-agent: Debian GNU/Linux 9.4 (stretch); Emacs 25.1.1; mu4e 1.1.0
In-reply-to: <20180406165618.GA6367@80x24.org>
Date:   Fri, 06 Apr 2018 20:23:10 +0200
Message-ID: <87y3i0yz1t.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Fri, Apr 06 2018, Eric Wong wrote:

> Ævar Arnfjörð Bjarmason <avarab@gmail.com> wrote:
>> See https://public-inbox.org/git/86h8oobl36.fsf@phe.ftfl.ca/ for the
>> original report.
>
> Thanks for taking a look at this.  Also https://bugs.debian.org/894997
>
>> --- a/perl/Git.pm
>> +++ b/perl/Git.pm
>> @@ -554,7 +554,7 @@ sub get_record {
>>  	my ($fh, $rs) = @_;
>>  	local $/ = $rs;
>>  	my $rec = <$fh>;
>> -	chomp $rec if defined $rs;
>> +	chomp $rec if defined $rs and defined $rec;
>
> I'm struggling to understand the reason for the "defined $rs"
> check.  I think it was a braino on my part and meant to use:
>
> 	chomp $rec if defined $rec;

Whether this makes any sense is another question, but you seem to have
explicitly meant this at the time. The full function definition with
documentation:

    =item get_record ( FILEHANDLE, INPUT_RECORD_SEPARATOR )

    Read one record from FILEHANDLE delimited by INPUT_RECORD_SEPARATOR,
    removing any trailing INPUT_RECORD_SEPARATOR.

    =cut

    sub get_record {
    	my ($fh, $rs) = @_;
    	local $/ = $rs;
    	my $rec = <$fh>;
    	chomp $rec if defined $rs;
    	$rec;
    }

It doesn't make to remove the trailing record separator if it's not
defined, otherwise we'd be coercing undef to "\n" while at the same time
returning multiple records. But then of course the only user of this
with an "undef" argument just does:

    chomp($log_entry{log} = get_record($log_fh, undef));

So we could also remove that chomp(), adn not check defined $rs, but IMO
it's cleaner & more consistent this way.
