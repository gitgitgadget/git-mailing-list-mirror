Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD,T_DKIM_INVALID shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 087D01F4F8
	for <e@80x24.org>; Tue, 11 Oct 2016 20:13:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752720AbcJKUNE (ORCPT <rfc822;e@80x24.org>);
        Tue, 11 Oct 2016 16:13:04 -0400
Received: from mail-wm0-f51.google.com ([74.125.82.51]:36010 "EHLO
        mail-wm0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752553AbcJKUND (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 11 Oct 2016 16:13:03 -0400
Received: by mail-wm0-f51.google.com with SMTP id o81so6850610wma.1
        for <git@vger.kernel.org>; Tue, 11 Oct 2016 13:13:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:from:date:message-id:subject:to;
        bh=WfIJFPTH0KXnW1gqRdsB1e7dymOUad2eUH5l9YKTypo=;
        b=DOrVRiOyiZ+gfw/Pdy3drVfJVJyM3Ac5HSohpDhiTNMzbAzP63KH2CztCijRdCrOfM
         lQZV34BxZhdq8FnDxYjLaboz0JBgv4PzosmOKAZsIN47fg+knMWAqwx5jHs+pIwpP3ND
         FL8OII37H1aFJo35f7BNBEIlxZRzcatRMf9mCgJrckTyVAIjfKjiDu7sQpYd9zK8C1Ri
         jKHiMEMYdw7BH37pf0S2J4G5pAUqz0EKrMrVum94471hEOtKwHb+w5rzHRBsV2jt3Arl
         099PUiYz3Av8rV/1CpOCjkTZ4ZqVUYY9y5bN6AIQRawZCqVs09kWyt9aeTZoVPbeH8O2
         vC4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:sender:from:date:message-id:subject
         :to;
        bh=WfIJFPTH0KXnW1gqRdsB1e7dymOUad2eUH5l9YKTypo=;
        b=DoEzNr8Av7NyQa1I+7RH/TreNv+RwA8lwTGnVVj15hu8YtWMZWkpA5BLTLofcONyen
         G90eM3dffrWPD0AGGnnyInrLdNBOZ956eIFLomft7ftndDKj3Wd0YOFaUt9QWQJtoMke
         I46yxQM3zRD6LoC+nhsrN4idkQetyAbOQXF+giUXnfaVpEk92WgNrnD3h5KjFQWzUKaO
         6aA8TUzf2TKMRZePFp0c1A8IZCA9tkKBysmClVlnIFkHhMYR+8E7Pn8J4dCSPAE8huFa
         a9M09UGMWLkrKdtJ0Sf/qOoOWUawtnOR5JhKPy1aZSliZ8S2KbjY+YrLWFjx0TGyDKho
         eW8w==
X-Gm-Message-State: AA6/9RkPbDDjNYOSDwyooRzuLnHfgZahUb8V0TgA/H/GyR66vYX29YtUX+VGxYFxIuRrAcJmrF74mZgJQdze/A==
X-Received: by 10.28.52.74 with SMTP id b71mr359746wma.85.1476216782065; Tue,
 11 Oct 2016 13:13:02 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.80.154.66 with HTTP; Tue, 11 Oct 2016 13:12:41 -0700 (PDT)
From:   Ram Rachum <ram@rachum.com>
Date:   Tue, 11 Oct 2016 23:12:41 +0300
X-Google-Sender-Auth: EP8qJ_PsACPBaf0u8oUGlKnXMMc
Message-ID: <CANXboVZvfPkTQ10PWop+LgPFpc2bD3-u-e5ix0itGawiwCxOuQ@mail.gmail.com>
Subject: Make `git fetch --all` parallel?
To:     git@vger.kernel.org
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi everyone!

I have a repo that has a bunch of different remotes, and I noticed
slowness when doing `git fetch --all`. Is it currently made
sequentially? Do you think that maybe it could be done in parallel so
it could be much faster?

Thanks,
Ram.
