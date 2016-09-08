Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5D98A20705
	for <e@80x24.org>; Thu,  8 Sep 2016 20:37:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1758946AbcIHUhh convert rfc822-to-8bit (ORCPT
        <rfc822;e@80x24.org>); Thu, 8 Sep 2016 16:37:37 -0400
Received: from iramx2.ira.uni-karlsruhe.de ([141.3.10.81]:45350 "EHLO
        iramx2.ira.uni-karlsruhe.de" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1758918AbcIHUhf (ORCPT
        <rfc822;git@vger.kernel.org>); Thu, 8 Sep 2016 16:37:35 -0400
Received: from irawebmail.ira.uni-karlsruhe.de ([141.3.10.230] helo=webmail)
        by iramx2.ira.uni-karlsruhe.de with esmtps port 25 
        iface 141.3.10.81 id 1bi64d-0000vv-UU; Thu, 08 Sep 2016 22:37:27 +0200
Received: from apache by webmail with local (Exim 4.84_2)
        (envelope-from <szeder@ira.uka.de>)
        id 1bi64d-0002CK-Rt; Thu, 08 Sep 2016 22:37:27 +0200
Received: from x4db0eeb3.dyn.telefonica.de (x4db0eeb3.dyn.telefonica.de
 [77.176.238.179]) by webmail.informatik.kit.edu (Horde Framework) with
 HTTPS; Thu, 08 Sep 2016 22:37:27 +0200
Date:   Thu, 08 Sep 2016 22:37:27 +0200
Message-ID: <20160908223727.Horde.jVOOJ278ssZ3qkyjkmyqZD-@webmail.informatik.kit.edu>
From:   SZEDER =?utf-8?b?R8OhYm9y?= <szeder@ira.uka.de>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Jeff King <peff@peff.net>, Leho Kraav <leho@conversionready.com>,
        =?utf-8?b?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>,
        git@vger.kernel.org
Subject: Re: [PATCH 4/5] versioncmp: pass full tagnames to
 swap_prereleases()
References: <20160906214550.Horde.ducOghtmsQb9pQ6lixxddVz@webmail.informatik.kit.edu>
 <20160907151251.30978-1-szeder@ira.uka.de>
 <20160907151251.30978-5-szeder@ira.uka.de>
 <xmqq7fami8nj.fsf@gitster.mtv.corp.google.com>
In-Reply-To: <xmqq7fami8nj.fsf@gitster.mtv.corp.google.com>
User-Agent: Horde Application Framework 5
Content-Type: text/plain; charset=utf-8; format=flowed; DelSp=Yes
MIME-Version: 1.0
Content-Disposition: inline
Content-Transfer-Encoding: 8BIT
X-ATIS-AV: ClamAV (iramx2.ira.uni-karlsruhe.de)
X-ATIS-Timestamp: iramx2.ira.uni-karlsruhe.de 1473367047.
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


Quoting Junio C Hamano <gitster@pobox.com>:

> SZEDER Gábor <szeder@ira.uka.de> writes:
>
>> - * Note that we don't have to deal with the situation when both p1 and
>> - * p2 start with the same suffix because the common part is already
>> + * Note that we don't have to deal with the situation when both s1 and
>> + * s2 contain the same suffix because the common part is already
>>   * consumed by the caller.
>
> "The common part is already consumed" was relevant while the
> function was fed p1 and p2, i.e. the first difference, but the whole
> point of passing the original s1 and s2 with ofs is so that the
> function can look behind ofs as necessary.  Is "already consumed"
> still correct (or relevant) with s/p/s/ you did to its calling
> convention?

Well, it's still correct in the sense that we don't have to worry about
finding the same suffix in both strings.  However, "consume" is not the
right word to use here, as incrementing an offset until it points past
the common part doesn't count as "consumption", so more rewording would
be necessary.

I'm not sure about the relevancy of this pararaph, or the relevancy of
the original version for that matter.  I mean, there is a different
character for sure, so it's really rather obvious that it can't
possibly be the same suffix in both, isn't it?  So I don't think it
adds much value, and don't mind deleting it in the reroll.


Best,
Gábor

