Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_DKIM_INVALID,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6B64E1F407
	for <e@80x24.org>; Thu, 14 Dec 2017 20:35:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752302AbdLNUfP (ORCPT <rfc822;e@80x24.org>);
        Thu, 14 Dec 2017 15:35:15 -0500
Received: from mail-qk0-f181.google.com ([209.85.220.181]:41021 "EHLO
        mail-qk0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752026AbdLNUfO (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 14 Dec 2017 15:35:14 -0500
Received: by mail-qk0-f181.google.com with SMTP id r184so192424qke.8
        for <git@vger.kernel.org>; Thu, 14 Dec 2017 12:35:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=hdfddXqmvlGF+vqopV9cwcTfnO5hCZZ9vjZrXAuhSLc=;
        b=MqX4V+vq1ojnwiawF0YgUfmgXD0ntvPLCu8oJYFZsLHvU1ZmzO/GJd462WozmYPpTd
         HCscOOdTM6cSyhTsjl66YxBNwyHzSqAy0NuF8JEkO5TQp5vEAsU+dL/ORKkVh3I2ZH5p
         5EklqDukSXbw1TMgELAsPjac2tPnKkqxtVrBeO4YLUT50SXIA2RCCw8kGmrVJkhyE/ol
         BpUbXo9r/h0IKaJZrWrEbYPNMMuQ1ucNuXyeyZ6F3Yt5dB6VCLZrvlca1maNrJ8IQ2YO
         wh9B9msm6v078prS8k2sB1YgdBT2a3w8Q78VsR7jJhvoWoGmRlIiBHbbwEntCWvwNSl+
         670w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=hdfddXqmvlGF+vqopV9cwcTfnO5hCZZ9vjZrXAuhSLc=;
        b=Ny2gbRVov1ItgJY+Du8jqFCeGMhxi3fbK2QrzaUeRj1UbYxP60mWWVjMdW86zv6CVJ
         WxoK+84L4grIAxvbD3wC8Yjn8UvcFZAwWnM8PQrYudjudjdzLG0+4zBMoIhmOcjh3ZBD
         Vi9PRTPunIdIevlT1Y2y6sVvX0oc1tOF3yE02ZN7Oo9mvbYZTlI8sZVLoX2V67iA7evR
         ipkPk6YgxbMKwDJIBP4fbg9sGdd12IUceXYUVA/ZRpEGxJ5Ps8Y7UlpPF1qXYYsmbVy4
         A23R32RurdA0OqwtjChFD8bScpRJD7k3rHUHTSTagHTvvBIHSjjdB5pr+UL88bQTqGq+
         ocnA==
X-Gm-Message-State: AKGB3mJTHYPZK+jh/EAttlvk9VqUKcHWqYHo/5obWEUM3KHVeWGS3a6X
        QX6AeSpC35GGa8SH1ONcefs=
X-Google-Smtp-Source: ACJfBovYLx+hPeNJfanzWmTUAbT0dm2ft/bB+ZumW10/sYF+xHIjafZEaxCH129jxDfb5blS/Z+sDw==
X-Received: by 10.55.149.196 with SMTP id x187mr16587179qkd.51.1513283713379;
        Thu, 14 Dec 2017 12:35:13 -0800 (PST)
Received: from zaya.teonanacatl.net (pool-173-67-181-41.hrbgpa.fios.verizon.net. [173.67.181.41])
        by smtp.gmail.com with ESMTPSA id n64sm3062008qkf.49.2017.12.14.12.35.11
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Thu, 14 Dec 2017 12:35:12 -0800 (PST)
Date:   Thu, 14 Dec 2017 15:35:09 -0500
From:   Todd Zullinger <tmz@pobox.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org, Eric Wong <e@80x24.org>,
        Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH 0/2] t/lib-git-svn.sh: improve svnserve tests with
 parallel make test
Message-ID: <20171214203509.GD3693@zaya.teonanacatl.net>
References: <20171214181949.GC3693@zaya.teonanacatl.net>
 <xmqqshcdtagw.fsf@gitster.mtv.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqqshcdtagw.fsf@gitster.mtv.corp.google.com>
User-Agent: Mutt/1.9.1 (2017-09-22)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano wrote:
> Todd Zullinger <tmz@pobox.com> writes:
>> I wanted to check if this minor patch series had slipped
>> under your radar.
> 
> Totally.  Queued.
> 
> As they come with Ack by the area maintainer, I'll fast-track them
> down to 'master' (other topics typically cook at least for a week in
> 'next').
> 
> Thanks for pinging.

Thank you, as always.

-- 
Todd
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
There is considerable overlap between the intelligence of the smartest
bears and the dumbest tourists.
  -- Park ranger yro.slashdot.org/comments.pl?sid=191810&cid=15757347

