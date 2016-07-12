Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.5 required=3.0 tests=BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 56B421F744
	for <e@80x24.org>; Tue, 12 Jul 2016 02:24:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932786AbcGLCYa (ORCPT <rfc822;e@80x24.org>);
	Mon, 11 Jul 2016 22:24:30 -0400
Received: from mout.web.de ([212.227.15.4]:65478 "EHLO mout.web.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932496AbcGLCY3 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 11 Jul 2016 22:24:29 -0400
Received: from [172.20.5.167] ([209.5.235.18]) by smtp.web.de (mrweb003) with
 ESMTPSA (Nemesis) id 0MVu2q-1btkYy0CLo-00X5vz; Tue, 12 Jul 2016 04:24:16
 +0200
Subject: Re: [PATCH v3 3/3] correct ce_compare_data() in a middle of a merge
To:	Junio C Hamano <gitster@pobox.com>
References: <xmqq37nyb4kp.fsf@gitster.mtv.corp.google.com>
 <1467100876-2803-1-git-send-email-tboegi@web.de>
 <xmqqh9cc55wm.fsf@gitster.mtv.corp.google.com>
 <62eb3d75-126e-427b-8701-d490e80e3501@web.de>
 <xmqq8txlvwip.fsf@gitster.mtv.corp.google.com>
 <574692d1-c8ae-9c2f-6b99-a01545b15051@telia.com>
 <xmqqa8huvmpv.fsf@gitster.mtv.corp.google.com>
 <c36fe487-b8dc-9767-7fae-bee513dac0b2@web.de>
 <xmqqr3b5p9v0.fsf@gitster.mtv.corp.google.com>
 <2cbf12a6-2dca-8180-323b-f79638aa03bd@web.de>
 <xmqqmvlsm6hu.fsf@gitster.mtv.corp.google.com>
 <f78fa94d-abd2-05a2-c411-15e2ffdb7dae@web.de>
 <xmqqoa68kl7n.fsf@gitster.mtv.corp.google.com>
 <xmqqk2gvlur5.fsf@gitster.mtv.corp.google.com>
 <xmqqinwc7xbb.fsf@gitster.mtv.corp.google.com>
Cc:	git@vger.kernel.org
From:	=?UTF-8?Q?Torsten_B=c3=b6gershausen?= <tboegi@web.de>
Message-ID: <51079140-98c8-ee0c-72d2-af5c348c19fd@web.de>
Date:	Tue, 12 Jul 2016 04:23:47 +0200
User-Agent: Mozilla/5.0 (X11; Linux i686; rv:45.0) Gecko/20100101
 Icedove/45.1.0
MIME-Version: 1.0
In-Reply-To: <xmqqinwc7xbb.fsf@gitster.mtv.corp.google.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K0:nuE+59R/QgGie/NJKHB4miH4+2VfiO/uDdrwtfr5fvfIEr6brtO
 nWMkcgPdQVWXvP37vptyTTSUG+hIj/vuU9mJ+6hE45B5/Tle1cFP4zGzRpzhIALtIMGAef1
 Df1wioRY+8k5GN4SDnZpU43sQhZqLwy5hoIwFy5XrsWZn8EdU6Xk7VOLSyv4n3ofKu31Rw4
 wPYD2/ukPVi8UUIskva1w==
X-UI-Out-Filterresults:	notjunk:1;V01:K0:1yRDI+MGwLY=:SNbBsmii6eD59yhGBz4UID
 ljSzgMGUsBvpa5ggPafRtQHsWbSHLAxLrfEAjALBd+e8hjAYNPlgSc566u90O1H2rkKKsNdw9
 CDKew/vt6UfA6BX4qYHXiDmveiJr3Hd/ZrQCU1buLS2nSyYe3/LCPojx0lOw5d02Tm2JCwLqa
 Z2jiOStwODZXljUs2wRrYjiJJYuNvdj9pfrdsbDomH/LVcmfNMNx8Dv6ZOmPMo/xWKPQ+BO3u
 2ZerU3DDX3G+da5+3Eb3iKFfXywWC/y02wCCDWyX0nI0yzz5mbM/FM9jWwJTZjVRjZjw9Dv/Z
 olv1AKEo27w2bQY20fvn6sxzjOTQw+4Eo8m+JC9RIywr+NS3mMTjGy8PWYLj8LymDF45tGJXG
 VRVFV3bjJ/C6aC2E935GeDbb+l5qcysXjtrVwWznUKsG7HZglgg6MtorJVxB3zn7wwDiYqJRj
 qR8SnE5ypLOnaRonE35zm7edfTp+yHsoySUDa/AjlzpxtJnOIUlTRY0R2YLWl4eZavHUpjvZ4
 ilPBE3RT2LxwzoUXLzi74sRN7+4lEPIZixfmal2q4oI7EF/XsmIkiOtfGppLICjmNU1QlrYmx
 KD1FFODyxMi3/g8SCeEU5AW882xXm+OP2+NwrZQvtAM7kBti1I8ZU1d4LPbDZ7kmeCtR+IA6B
 IaZn8OmZLc2YWrEu1arNjBBiAEiI60e8zRtVj+qhhHVju+VsKBlbpohvh/5a/SkBPyA5orZUE
 SWLDn+le0rNQ+WpNSMj4o6xjnkxdg5BajLWSpWhwM3ss7+Vk2yk8IE3/Z0faHvnaDuLxXs4/Q
 k/sttQr
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

>
> How do things look at this point?  This version is what I ended up
> queuing in 'pu', but I took your "Thanks" in $gmane/299120 to only
> mean "Thanks for feeding some ideas to help me move forward", not
> necessarily "Tnanks that looks like the right approach." yet, so
> right now both topics are stalled and waiting for an action from
> you.
Yes, the code looks good to me.
And the commit message does explain what is going on.

For my taste, these 3 lines don't explain too much,may be remove them ?
 > The test update was taken from a series by Torsten Bögershausen
 > that attempted to fix this with a different approach (which was a
 > lot more intrusive).
So thanks for your efforts, ack from my side.
