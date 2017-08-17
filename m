Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E5911208CD
	for <e@80x24.org>; Thu, 17 Aug 2017 08:24:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751687AbdHQIYv (ORCPT <rfc822;e@80x24.org>);
        Thu, 17 Aug 2017 04:24:51 -0400
Received: from mout.web.de ([212.227.15.14]:50031 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751015AbdHQIYt (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 17 Aug 2017 04:24:49 -0400
Received: from localhost ([195.198.252.176]) by smtp.web.de (mrweb004
 [213.165.67.108]) with ESMTPSA (Nemesis) id 0MOlTq-1ddIIM1Gek-0067W8; Thu, 17
 Aug 2017 10:24:36 +0200
Date:   Thu, 17 Aug 2017 10:24:35 +0200
From:   Torsten =?iso-8859-1?Q?B=F6gershausen?= <tboegi@web.de>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org, asottile@umich.edu
Subject: Re: [PATCH/FIXUP 6/2] apply: clarify read_old_data() is about
 no-index case
Message-ID: <20170817082435.GA7508@tor.lan>
References: <xmqq4ltpsn42.fsf@gitster.mtv.corp.google.com>
 <20170813085106.1731-1-tboegi@web.de>
 <xmqqbmnfl5tm.fsf@gitster.mtv.corp.google.com>
 <20170817062450.GA28592@tor.lan>
 <xmqqbmneis63.fsf@gitster.mtv.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <xmqqbmneis63.fsf@gitster.mtv.corp.google.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
X-Provags-ID: V03:K0:mQmqcAg3IuQXpDsIILCstz1A5A1LOOFHxq9CZBfaXKSiarh7uPo
 h6Y5rpArOzKAmumXucaKnYOaiM5In5pxewSqXdQBiSNZs3ILYgI3NT/Dk7oXIT0G9sjqV4b
 GusG27lfZhYSlMRnusiHxn8znM1WrvLk/koCdjhcK7b8QmfiIO3U2DEHl9JYcOrO/yFGEW1
 CnrQAAbBWrcuFqV1AapYQ==
X-UI-Out-Filterresults: notjunk:1;V01:K0:KbiQvc3K5jY=:PBY35LQoJGLCtjFDzQf1OQ
 /CzvNp09imZOlBKxBG4HVbnhgYF4H2ktD8sR/6oQtALX+KqGUIzhgPU0omy0+LMkj8NUfv7K/
 BV6KADi9lDLImD9tF35ouldJKWzAwS7cgGDa/B0l9GvkjmChY6gmbThUF8GFJg2buA9BdOS6t
 QeAAYoxWp2vytR5Y4Vb3L4rvJ1HWbtFmKQnihy3nT/QRORmYaUzhX8on9FATIh7En4WHZWhI6
 sva9UUi2m9E0MqDvLnVYQjJPG55ISQM9Zti9Qmd3vYlkIW0VrocV2VwB5W4U7UQslWskrzU2C
 UAUv9FWWISGCfoM93LQGNV7tsEfqM5d4L6fIntFi6Jse815Y8HnZa74VWFDRI+s0YYWEGQt+8
 oVtzHsRBi4cjLKXlReigLQG2CGd33zBcsW8RAaNIcg2Nmdg+ACvLsQ7WAhoQcT/Aq3gAuFpcr
 8YYyU+1FTDK7zlno/q+wpw1uMyK3WtgTDuraqC8+iriabSimcZ5xKsQXiwhWPdKfDa8MkHXgN
 KXo0vgTcHm1ldkrWLFHTgVfvorUJE5vV6mAcncaSi6mziCggMSV07Ueztz6vUUJzu2BwoaHXU
 LDXWiAKPIoyYLzwVicX6+9p3MzjAu/zFwrjGOd9409hWH6PQ9E/dqpw2Frxg1oraXsyXdjgil
 rh9ffhoQmp4kkJk7c4Gjp96k4CNfApJGVsF77d+zpO9XKH5swVJex2ce1o6vblgIu7muilWmu
 M8LbKu42w/dkYRZwIyvVeOcEzvevvm3ywV/C4H88474pVsTw34j+oaESJii4Vw9aYJ2LkL+xs
 PyjqDK3kcMHq/RsVA0iDuXT0o1GfA==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Aug 17, 2017 at 12:12:36AM -0700, Junio C Hamano wrote:
> Torsten Bögershausen <tboegi@web.de> writes:
> 
> > Unless we re-define the meaning of "NULL" into "don't do CRLF conversions,
> > like SAFE_CRLF_KEEP_CRLF does.
> 
> My preference is not to use NULL as any hint.  Instead, the "flag"
> parameter we already pass to convert_to_git(), just like the updated
> read_old_data() uses SAFE_CRLF_KEEP_CRLF to tell it that it should
> not disturb existing CRLF without looking at the istate, should be
> used to tell convert_to_git() to do the opposite, but do so without
> looking at the istate.
> 
> Perhaps SAFE_CRLF_FALSE should be such a flag.  Or perhaps we need
> to invent another flag.  I dunno.

OK, message taken, in short:
I will come up with a new series in a couple of days - 
thanks for the input.
