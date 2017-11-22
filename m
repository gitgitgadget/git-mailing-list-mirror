Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_DKIM_INVALID,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 52FF0202F2
	for <e@80x24.org>; Wed, 22 Nov 2017 09:49:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751848AbdKVJtv (ORCPT <rfc822;e@80x24.org>);
        Wed, 22 Nov 2017 04:49:51 -0500
Received: from mail-wr0-f175.google.com ([209.85.128.175]:41476 "EHLO
        mail-wr0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751714AbdKVJtt (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 22 Nov 2017 04:49:49 -0500
Received: by mail-wr0-f175.google.com with SMTP id z14so13935336wrb.8
        for <git@vger.kernel.org>; Wed, 22 Nov 2017 01:49:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=1C8MOxzmGSmVXMknbdeavWrD75mcC7HrCRFucEKI3mY=;
        b=lL9hgN983IjsuU5YE88W3l7Z7P0p6qRpZzamXy+h4/jkFA8iuFZkcYQaTx2LfslpDu
         u2OOIBgeTFsUShqJeyZYOj3jSbBOgPAqFZmCSLBoDBIeR7g9OGnRwye9IeEwqvc2St1Y
         +1kI9VEHvb54DkJCCyrJyN8yY/N9ChHoOqzyLUYp0a788mzmyVixW62P+oSDXgwZJd/i
         Mck8qBnAeesxG5FeKasEKt+aUBZHEma7um+SJX6Mieo6/hdGxD24MjB65PvwNCzQU5Mh
         zDPRBEdl3woLdXQpM7Wiqsqa4FJOKGdzwTh3Rc0nXIBLs1DCPnb2vJ9gZLu0pmsJUMsc
         3wuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition
         :content-transfer-encoding:in-reply-to:user-agent;
        bh=1C8MOxzmGSmVXMknbdeavWrD75mcC7HrCRFucEKI3mY=;
        b=FzFjZTIVsxi6Wy8+vhgz/jVL+HAQbA2HjjRG+Xk5v8dPV/nwilOHHWmDxKIV2dbfQZ
         EHKBmd5O80m1ntAjNqNSIdBzQXyDzhUXYtTkFHctve7ePCRzn6oo6S5dJHytNSNJueDX
         o75/Z5oy4C2ZTYUpD65R4q78lgbbxKiNpyFD9568DoVTDrt8AqTp6BBlQP78LnpLZSpM
         AGqh0PWKUeSFyIeq3+RfJ7IOfTtGhoPq9OlqXTS3qG2PAqyJNh9v6aWjSLUHzVszZuCw
         +V/sElr+tv766GiBe31VRFzcOBI3y6O1/uZ9SMnzMU2dCccwJWVR7JViF6MNSvV462UK
         K/yA==
X-Gm-Message-State: AJaThX7YtA7c+gADD7W3VEyXMdwMsng8JWelmQ9RbA2a8hMjCICCimVw
        v+yPEVna8fkiC/T3ivxjYNA=
X-Google-Smtp-Source: AGs4zMapPl90KDQAhBhLDSYjEDA0J+DzAq1sJIziIC9fS8863H5SWv7hOXgFtEHDYylHI1jpxAhSjw==
X-Received: by 10.223.170.67 with SMTP id q3mr4693681wrd.193.1511344188200;
        Wed, 22 Nov 2017 01:49:48 -0800 (PST)
Received: from laptop ([213.123.51.170])
        by smtp.gmail.com with ESMTPSA id c3sm717974wrf.21.2017.11.22.01.49.47
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 22 Nov 2017 01:49:47 -0800 (PST)
Date:   Wed, 22 Nov 2017 09:49:46 +0000
From:   Thomas Adam <thomas@xteddy.org>
To:     Alex =?iso-8859-1?Q?Benn=E9e?= <alex.bennee@linaro.org>
Cc:     Matthieu Moy <Matthieu.Moy@univ-lyon1.fr>,
        Junio C Hamano <gitster@pobox.com>,
        Thomas Adam <thomas@xteddy.org>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Git List <git@vger.kernel.org>,
        Matthieu Moy <Matthieu.Moy@imag.fr>,
        Remi Lespinet <remi.lespinet@ensimag.grenoble-inp.fr>
Subject: Re: [PATCH] git-send-email: fix get_maintainer.pl regression
Message-ID: <20171122094945.2xgvzcdfom3yatpd@laptop>
References: <20171116154814.23785-1-alex.bennee@linaro.org>
 <CAPig+cTXq6jSN9f2_xyj=Jfv_cg2kUFUtA5uVkZDrRRSi2x7vg@mail.gmail.com>
 <87wp2jwe9o.fsf@linaro.org>
 <20171121205206.fvwjkkwhil4abmmk@laptop>
 <b131cc195280498ea3a77a37eff8444e@BPMBX2013-01.univ-lyon1.fr>
 <q7h97euiradu.fsf@orange.lip.ens-lyon.fr>
 <87vai2wumy.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <87vai2wumy.fsf@linaro.org>
User-Agent: NeoMutt/20171013-21-a9a9c7-dirty
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Nov 22, 2017 at 09:05:41AM +0000, Alex Bennée wrote:
> My hacky guess about GIT's perl use calls is:
> 
>    find . -iname "*.perl" -or -iname "*.pm" -or -iname "*.pl" | xargs grep -h  "use .*::" | sort | uniq | wc -l
>    88

So let us concentrate just on git-send-email.perl for now.  In the
Module::Extract::Use module (which happens to be what corelist uses), there's
an example script called 'extract_modules' which will statically analyse a
perl file and tell you the following information:

% perl extract_modules ./git-send-email.perl
Modules required by ./git-send-email.perl:
- Authen::SASL
- Cwd (first released with Perl 5)
- Email::Valid
- Error
- File::Spec::Functions (first released with Perl 5.00504)
- File::Temp (first released with Perl 5.006001)
- Getopt::Long (first released with Perl 5)
- Git
- Git::I18N
- IO::Socket::SSL
- MIME::Base64 (first released with Perl 5.007003)
- MIME::QuotedPrint (first released with Perl 5.007003)
- Net::Domain (first released with Perl 5.007003)
- Net::SMTP (first released with Perl 5.007003)
- Net::SMTP::SSL
- POSIX (first released with Perl 5)
- Sys::Hostname (first released with Perl 5)
- Term::ANSIColor (first released with Perl 5.006)
- Term::ReadLine (first released with Perl 5.002)
- Text::ParseWords (first released with Perl 5)
- strict (first released with Perl 5)
- warnings (first released with Perl 5.006)

Therefore, we have the following modules which are not standard:

- Email::Valid
- Error
- Git
- Git::I18N
- IO::Socket::SSL
- NET::SMTP::SSL

Looking at the code for git-send-email.perl, it seems most of those are
eval()d at the point they're needed, which seems in many cases to be fallback
responses to something we've written, or a means of ensuring we don't need to
explicitly handle the case of it not being present at run-time.

> Should the solution be to just make Mail::Address a hard dependency and
> not have the fallback?

This seems like a slight on ensuring a running script which may or may not
have additional functionality depending on which modules are installed.  Given
the pretty good state of packaging across those platforms which Git runs on, I
would argue we're now in a much better position to explicitly check for
non-core modules at BEGIN{} time, and moan loudly if they're not installed.

-- Thomas Adam
