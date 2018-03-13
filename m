Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 309E11FAE2
	for <e@80x24.org>; Tue, 13 Mar 2018 08:11:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752186AbeCMILv (ORCPT <rfc822;e@80x24.org>);
        Tue, 13 Mar 2018 04:11:51 -0400
Received: from mail-qk0-f182.google.com ([209.85.220.182]:41695 "EHLO
        mail-qk0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751769AbeCMILv (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 13 Mar 2018 04:11:51 -0400
Received: by mail-qk0-f182.google.com with SMTP id s78so4858928qkl.8
        for <git@vger.kernel.org>; Tue, 13 Mar 2018 01:11:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=Zgzr1NrFJJgHsO0/Q/O/vr/XLkeHPCpKfxgWPxD6bGw=;
        b=fdS8k4rUiXynJTPib2e6fSvFNCy+CcF++QbM+CvResfJ1YWIOxZUGINJEijKD9VNt+
         bz4sykoMrtdPjdQdevd0cZV0D+eS8aTnho5JQnnciJq9H4pNgp8ggn3aQalLOo6Yjl6r
         YdoFkmTuVmZm3sWT/5L5sB686HgOhiRxBdQ2JMJZ3kH/68pwa13WaYbtfI8adCxexEgZ
         OaE8LtoFOyWqd6Rf+y9vCU9R1rdt+aD06KVic1jcuVkW3oFchRJXswcLKsvGNSasS6dP
         3VGbBk+QF+/4PPqF1V7DhyzfwFXGhJmfZaeZQZNJa/nnrVgljhQhNx3y+Fk1PvK6hHN6
         L4fg==
X-Gm-Message-State: AElRT7EGo5PqF1ViCTMvMjWyJHbefnXM/9rZPmCbhGuxqjxdR9N/U/5h
        drMsTCNGh7wH/jOXUDKiySARFtiB+EpEnqFprGwegZ0R
X-Google-Smtp-Source: AG47ELtwJfYPuocCtW7U21X/yiNTCFxBolHxKDzAzRC9/H3tgCtc3/x8w38kJZKj7ELF1NqRj7sYo1TrJ/ugXCfi38Q=
X-Received: by 10.55.20.149 with SMTP id 21mr15501707qku.66.1520928710152;
 Tue, 13 Mar 2018 01:11:50 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.200.42.235 with HTTP; Tue, 13 Mar 2018 01:11:49 -0700 (PDT)
From:   Michal Novotny <clime@redhat.com>
Date:   Tue, 13 Mar 2018 09:11:49 +0100
Message-ID: <CANT8FXTF41-4zvqvrEek262D8OZRhA4nsiPguyNTL9mwF1+mkg@mail.gmail.com>
Subject: allow "~" to be present in a tag name
To:     git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hello,

currently, if I try to create a tag that has tilde "~"  in name, an
error is raised. E.g.

$ git tag rpkg-util-1.4~rc1
fatal: 'rpkg-util-1.4~rc1' is not a valid tag name.

Now, actually it would be very cool if tilde was allowed in a tag name
because we would like to use it for tagging pre-releases of (not-only
rpm) packages.

Is there some deep technical reason why tilde cannot be present in a
tag name? I tried that e.g.

git tag rpkg-util-1.4%rc1

but percentage sign does not seem to be particular fitting for
pre-release marking.

Thank you
clime
