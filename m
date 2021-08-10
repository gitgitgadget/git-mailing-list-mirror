Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8F9B5C4338F
	for <git@archiver.kernel.org>; Tue, 10 Aug 2021 14:45:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7391760F38
	for <git@archiver.kernel.org>; Tue, 10 Aug 2021 14:45:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241831AbhHJOqF (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 10 Aug 2021 10:46:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39938 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241845AbhHJOqE (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 10 Aug 2021 10:46:04 -0400
Received: from eggs.gnu.org (eggs.gnu.org [IPv6:2001:470:142:3::10])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 20134C061799
        for <git@vger.kernel.org>; Tue, 10 Aug 2021 07:45:42 -0700 (PDT)
Received: from fencepost.gnu.org ([2001:470:142:3::e]:51908)
        by eggs.gnu.org with esmtp (Exim 4.90_1)
        (envelope-from <tsdh@gnu.org>)
        id 1mDT0f-0002Yi-2J
        for git@vger.kernel.org; Tue, 10 Aug 2021 10:45:41 -0400
Received: from auth2-smtp.messagingengine.com ([66.111.4.228]:52391)
        by fencepost.gnu.org with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.90_1)
        (envelope-from <tsdh@gnu.org>)
        id 1mDT0e-0005CH-V2
        for git@vger.kernel.org; Tue, 10 Aug 2021 10:45:40 -0400
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
        by mailauth.nyi.internal (Postfix) with ESMTP id 97F1327C0054
        for <git@vger.kernel.org>; Tue, 10 Aug 2021 10:45:40 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute5.internal (MEProxy); Tue, 10 Aug 2021 10:45:40 -0400
X-ME-Sender: <xms:FJESYZUrfrIvbbQzAaGrfp0WMARlEWNsGXLaezTOxdQhZxHRVCSfCw>
    <xme:FJESYZmIMgZXNnNVKKKAA12lvVifbvuTa16sBHIGtkncyFfzCbNJeTFIPkwtu7qIl
    yf9pseEbwUWOg>
X-ME-Received: <xmr:FJESYVb3qZyCHsn-0rPRfZ2YkdyUejT0FF0jw7PVyYcaQMrooRaKPz_-EaEeSyfOyqnFXGdFXJrFwv35ODzf0R-iSGX6Rvw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvtddrjeelgdektdcutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecunecujfgurhepfhgfhffvufffjgfkgggtsehttdertd
    dtredtnecuhfhrohhmpefvrghsshhilhhoucfjohhrnhcuoehtshguhhesghhnuhdrohhr
    gheqnecuggftrfgrthhtvghrnhepfedutedujeevfeeuueeuvdeghedvvdfhueevtdehvd
    ehueejteffkeelvdevhfeknecuffhomhgrihhnpehuthhilhdruggrthgvnecuvehluhhs
    thgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepthhhohhrnhdomhgvsh
    hmthhprghuthhhphgvrhhsohhnrghlihhthidqkeeijeefkeejkeegqdeifeehvdelkedq
    thhsughhpeepghhnuhdrohhrghesfhgrshhtmhgrihhlrdhfmh
X-ME-Proxy: <xmx:FJESYcX_wESEPgOQ4hQh2xXun5jBDcXhrWH3uKShe7CdOEDUgpsjNg>
    <xmx:FJESYTmp14eq_zPVLrpfZPXGSMRuh-Qw77x8mUIVzkgABrOL55Z6AA>
    <xmx:FJESYZffTojPekG2pcOkPNWjNhRijET7ZmCfv4xNE2gZ0_8YQhKHaA>
    <xmx:FJESYZTVO2TkK05WTuROKeDZ_bo7AA5NbDb1U4N4cICLCH_UAKksZw>
Received: by mail.messagingengine.com (Postfix) with ESMTPA for
 <git@vger.kernel.org>; Tue, 10 Aug 2021 10:45:40 -0400 (EDT)
References: <20210810082757.219007-1-tsdh@gnu.org>
User-agent: mu4e 1.6.2; emacs 28.0.50
From:   Tassilo Horn <tsdh@gnu.org>
To:     git@vger.kernel.org
Subject: Re: [PATCH v2] userdiff: improve java regex for generic return types
Date:   Tue, 10 Aug 2021 16:44:13 +0200
In-reply-to: <20210810082757.219007-1-tsdh@gnu.org>
Message-ID: <878s19mk8c.fsf@gnu.org>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Skip that one.  I've just got aware that also qualified return types
won't work, e.g.,

  private java.util.Date foo() {
    ...
  }

so patch version v3 is unterway.

Bye,
Tassilo
