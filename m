Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2DF05CA0ECA
	for <git@archiver.kernel.org>; Tue, 12 Sep 2023 12:12:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235071AbjILMMY (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 12 Sep 2023 08:12:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48516 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235114AbjILMMQ (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 12 Sep 2023 08:12:16 -0400
Received: from out03.mta.xmission.com (out03.mta.xmission.com [166.70.13.233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 19D2610E7
        for <git@vger.kernel.org>; Tue, 12 Sep 2023 05:12:05 -0700 (PDT)
Received: from in01.mta.xmission.com ([166.70.13.51]:33500)
        by out03.mta.xmission.com with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <ebiederm@xmission.com>)
        id 1qg2FQ-002ubU-2Q; Tue, 12 Sep 2023 06:12:04 -0600
Received: from ip68-227-168-167.om.om.cox.net ([68.227.168.167]:35892 helo=email.froward.int.ebiederm.org.xmission.com)
        by in01.mta.xmission.com with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <ebiederm@xmission.com>)
        id 1qg2FO-006mzV-Tq; Tue, 12 Sep 2023 06:12:03 -0600
From:   "Eric W. Biederman" <ebiederm@xmission.com>
To:     Oswald Buddenhagen <oswald.buddenhagen@gmx.de>
Cc:     Junio C Hamano <gitster@pobox.com>,
        "brian m. carlson" <sandals@crustytoothpaste.net>,
        git@vger.kernel.org
References: <87sf7ol0z3.fsf@email.froward.int.ebiederm.org>
        <20230908231049.2035003-2-ebiederm@xmission.com>
        <ZP3UCQf+9D/J3wqT@tapette.crustytoothpaste.net>
        <xmqqy1hdi6hp.fsf@gitster.g>
        <87sf7kd5xg.fsf_-_@email.froward.int.ebiederm.org>
        <87ledcb7ec.fsf_-_@email.froward.int.ebiederm.org>
        <ZQAZ19gyvt8ab7f6@ugly>
Date:   Tue, 12 Sep 2023 07:11:26 -0500
In-Reply-To: <ZQAZ19gyvt8ab7f6@ugly> (Oswald Buddenhagen's message of "Tue, 12
        Sep 2023 09:57:11 +0200")
Message-ID: <87msxr8uc1.fsf@email.froward.int.ebiederm.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-XM-SPF: eid=1qg2FO-006mzV-Tq;;;mid=<87msxr8uc1.fsf@email.froward.int.ebiederm.org>;;;hst=in01.mta.xmission.com;;;ip=68.227.168.167;;;frm=ebiederm@xmission.com;;;spf=pass
X-XM-AID: U2FsdGVkX196VxF9YsbG12ssFWCbJIznltdJKzxNV9Q=
X-SA-Exim-Connect-IP: 68.227.168.167
X-SA-Exim-Mail-From: ebiederm@xmission.com
Subject: Re: [PATCH v3 02/32] doc hash-function-transition: Augment
 compatObjectFormat with readCompatMap
X-SA-Exim-Version: 4.2.1 (built Sat, 08 Feb 2020 21:53:50 +0000)
X-SA-Exim-Scanned: Yes (on in01.mta.xmission.com)
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Oswald Buddenhagen <oswald.buddenhagen@gmx.de> writes:

> On Mon, Sep 11, 2023 at 06:46:19PM -0500, Eric W. Biederman wrote:
>>+The difference between compatObjectFormat and readCompatMap would be that
>>+compatObjectFormat would ask git to read existing maps, but would not ask
>>+git to write or create them.
>> 
> the argument makes sense, but the asymmetry in the naming bugs me. in particular
> "[read]compatMap" seems too non-descript.

I am open to suggestions for better names.

From a code point of view I am intending readCompatMap only supporting
the things that can be support with just the mapping functions aka
repo_oid_to_algop for the "readComatMap" case.

While the compatObjectFormat case includes what can be done with using
the compatible hash algorithm and convert_object_file.

There is quite a large variation.  So there is some fundamental
asymmetry in the implementation.   I am just not certain how to name it.

Eric

