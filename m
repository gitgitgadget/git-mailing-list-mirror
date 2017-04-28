Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id BBCA9207EB
	for <e@80x24.org>; Fri, 28 Apr 2017 09:55:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1424164AbdD1Jzf (ORCPT <rfc822;e@80x24.org>);
        Fri, 28 Apr 2017 05:55:35 -0400
Received: from mout.gmx.net ([212.227.15.19]:55529 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1424156AbdD1Jzd (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 28 Apr 2017 05:55:33 -0400
Received: from virtualbox ([37.201.193.73]) by mail.gmx.com (mrgmx001
 [212.227.17.190]) with ESMTPSA (Nemesis) id 0LqQnR-1dhTyD0WKv-00e3Yz; Fri, 28
 Apr 2017 11:55:28 +0200
Date:   Fri, 28 Apr 2017 11:55:27 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:     Junio C Hamano <gitster@pobox.com>
cc:     git@vger.kernel.org
Subject: Re: [PATCH 10/26] Check for EOF while parsing mails
In-Reply-To: <xmqqshkumlhw.fsf@gitster.mtv.corp.google.com>
Message-ID: <alpine.DEB.2.20.1704281155080.3480@virtualbox>
References: <cover.1493237937.git.johannes.schindelin@gmx.de> <1fb841cee32996ee9194c2bd33b9dfe74cc37726.1493237937.git.johannes.schindelin@gmx.de> <xmqqshkumlhw.fsf@gitster.mtv.corp.google.com>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:VWNWFX3wDhF1vZ9IddJ7yeseqJ33WADE2NR1tZarNGOJZ5grTUR
 S27hO/rCiilUYu3iA5y8WstXDnCevmp0K8EgFCgtm2BQ1PbmL4AjZq45DSP9BF/crt5dRb0
 BiJaQ475/t6sduhFA4LGiwT2e0MoElxd5nfzjqYS0tbaQRzIzBQUdkiVhb6/UmpUOc1O/7l
 Y6WEVXnozCIS6PC5/H+7w==
X-UI-Out-Filterresults: notjunk:1;V01:K0:XwCD4x1Mer4=:yPbkBhdiUZQu40lhEEVYa9
 sXOpax2onzlPBuTItiuGEWv5+Nbzy3d9BylJrMZfSzGZlmHhTBv7yLBysrVGP1ShJSILo8Vl9
 CICTlkSJgKHAgxWbIDbdyJzL59yVLKXz1SV8YZYvlK5GZISnF7uuyWcee+3wxHMjE1YT3qV5t
 ejlr6OSgmlwvrj1GmvlHGv0Ywi20Hpni8C8h4tZ7Hum6jOvMDzmEX4OXCYxVE6z8sddi07ct0
 PmiUAQy3rR0omNBCksBjjhAEDDQPBeriozOwWNwQYFUL/mhu7nj/X+pHFQzskZ+A18XgXU1P8
 hQGSsUSF3pVFt9d/p2c+wgKrXy6LU5GttbF1ufSALvRUWo+CACtPjIsDThq0wPsB8kxuwOvco
 1Uav4bXYijWM+VdH2FOVoZBk9nFRRzb7n3YX/QMDiYiv3ABVgWUxZVaQwpDF4/jcUR4D9S7TK
 1MNoO4EYYIHo/yftp6u7O1d75tr0RmUWfL9sTklL1q67l6wv7QOHkLwba8KOW/8ErJJ1m+/AT
 3qX3zZcJInd6v+Set5kpfLCqs5JOBhfYRS5yBXKn3n73qwrB5aqLWab86EvxU8bTbT3AxBhR6
 J9Pg8H+ZJRrD0UJfOVJK0jbnYZBsCqZpFIDm8HXUDr2PoVHy/Fm0/ueIH7BMR72YkhbQAcUIb
 IfzcU7Z8/j41SfHKd50HJRNWBOaUgaQ4nxmzTHKyALDjsAOm0K23yELFMjoyDpmati5OHf+5d
 y1Xd9VGwpCPlskUL+LngsrcwJBbXByvPslCTBwV/KbMczjQOoEowU+h4Sb6OW3vJOONt9eDJR
 gBAod97
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Junio,

On Wed, 26 Apr 2017, Junio C Hamano wrote:

> Johannes Schindelin <johannes.schindelin@gmx.de> writes:
> 
> > Reported via Coverity.
> >
> > Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
> > ---
> >  builtin/mailsplit.c | 2 +-
> >  mailinfo.c          | 2 +-
> >  2 files changed, 2 insertions(+), 2 deletions(-)
> 
> Good find.  I'd retitle with a prefix
> 
> 	mailinfo & mailsplit: check for EOF while parsing
> 
> so that it is clear that this patch is about lower level machinery
> (as oppose to something like "git am").

True. Will be fixed in the next iteration,
Dscho
