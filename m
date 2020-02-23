Return-Path: <SRS0=MMY4=4L=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4C938C35666
	for <git@archiver.kernel.org>; Sun, 23 Feb 2020 15:06:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0B1DE206ED
	for <git@archiver.kernel.org>; Sun, 23 Feb 2020 15:06:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="aTvAk4vj"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726953AbgBWPG1 (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 23 Feb 2020 10:06:27 -0500
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:21978 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726678AbgBWPG0 (ORCPT
        <rfc822;git@vger.kernel.org>); Sun, 23 Feb 2020 10:06:26 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1582470385;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=1wZZh3VlIApbJ9tTPKFNJfnz6eADoP8nvxjz7fE4PYw=;
        b=aTvAk4vjkvlfSX1vLJ4fSDhDc0/eJpBunpbC4/ShbHCjK9MWIl/SDlq5lmJEdBsUpJegT6
        XSvDEyVMZDfjQNvFik3GcEJRu17KLNUAQqIR770sJFTebpor7Ir0TFYhUSOfYiTQgjV3Bh
        OYDa0AdO5CNc5rz/0Zg0e/9y3G5W9Y0=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-356-z5LfrN9LPKWEkRO2P4hxcw-1; Sun, 23 Feb 2020 10:06:21 -0500
X-MC-Unique: z5LfrN9LPKWEkRO2P4hxcw-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id CBCDE18A5500;
        Sun, 23 Feb 2020 15:06:20 +0000 (UTC)
Received: from lacos-laptop-7.usersys.redhat.com (ovpn-116-53.ams2.redhat.com [10.36.116.53])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 3882F398;
        Sun, 23 Feb 2020 15:06:19 +0000 (UTC)
To:     public git mailing list <git@vger.kernel.org>
Cc:     Paul Mackerras <paulus@ozlabs.org>
From:   Laszlo Ersek <lersek@redhat.com>
Subject: gitk feature requests: (1) "diff.orderFile" and (2)
 "--function-context"
Message-ID: <d972c1f1-c49a-f644-ab1c-6a3e26c43ee3@redhat.com>
Date:   Sun, 23 Feb 2020 16:06:19 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hello,

as of commit c1a63459ed73 ("gitk: Preserve window dimensions on exit
when not using ttk themes", 2019-12-15), gitk seems to lack two features
that I consider "killer" ones, for reviewing patches (including my own
patches, of course):

- support for the "--function-context" ("-W") option,
- support for the "-O<orderfile>" (aka "diff.orderFile") setting.

These flags are in fact mentioned in the gitk source code, going back to
historical commit ee66e089c1d4 ("gitk: Make updates go faster", 2008-05-09).

The options are stashed in vdflags($n), and then summarily ignored. A
comment says, "These request or affect diff output, which we don't
want", and I don't understand why; I would very much like them, please :)

Why I'm not proposing patches myself: my knowledge of Tcl/Tk is weaker
than my knowledge of Perl. My knowledge of Perl is... well, let's change
the topic. :) I have basically zero idea what "gitk" source does, for
the most part.

Could someone please write gitk patches for honoring "diff.orderFile"
and "--function-context"?

Accepting "--find-copies-harder" too would be the icing on the cake.

Thank you!
Laszlo

