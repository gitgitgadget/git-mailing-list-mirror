Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7589D1F424
	for <e@80x24.org>; Tue, 17 Apr 2018 08:32:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752624AbeDQIcL (ORCPT <rfc822;e@80x24.org>);
        Tue, 17 Apr 2018 04:32:11 -0400
Received: from mail-yw0-f182.google.com ([209.85.161.182]:41242 "EHLO
        mail-yw0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752592AbeDQIcJ (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 17 Apr 2018 04:32:09 -0400
Received: by mail-yw0-f182.google.com with SMTP id o8so1607299ywb.8
        for <git@vger.kernel.org>; Tue, 17 Apr 2018 01:32:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=hkdobrev.com; s=google;
        h=mime-version:from:date:message-id:subject:to;
        bh=rNeQGSM/UKrFpCA3vz8hj+ntke+d5Y9V0+quTfi9l44=;
        b=HYqd6IrHWg44r22kMKgdGy8AL1ZKGNUUcVm4WE5ufBM8IJ/biHCmupJHGMNQ3w+xAd
         g2NsxMb3aK/b61EeaAxLvvpgu+Kjr+qdu5AOX9KHOkUXwKGFe3Mxyj96RqoCQQbvY1DW
         OvVTiBCNPynP+OqH/azMdFP98FXNs8eMgUHso3tJ0RXtPVIFaK4rZn8a56znz7oBO4IH
         BLILyJZbvJG8hiSjjPgR+Eqz713kv5I6tT9GotA5oyDCZ5N1xp+QOJYMqIfQRkFIXeXa
         aH6QlRfOcIjh55sB8rR/HcboAml55cxVTKyUucbaoQy8GiOZM2lOEIzfvtaTMLGTRifv
         S9EA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=rNeQGSM/UKrFpCA3vz8hj+ntke+d5Y9V0+quTfi9l44=;
        b=Xo7Yr7C3ZB4pGreQOBeGXOgEiVQl4AM6cHIDb0MTp6uC5ycIKUul46Y5WsoTa0W48z
         22xdZaHgtUqVEQtRrgzMZqHkBCoAknisYHptLYui8rfzDSK7yQLQdgg9CxatwVsRQzAR
         q1zEEGc/it4RMAdPIMeODIqJsMJIxuSAT2TVxzBln4xKGMjxFl4GjWpSJrWGpAvmxdGg
         7UP4SZ2S0Keb1vKYAaJm8ihH0X3+v8yEUVBfAjO4xuQ3jsX++eBXiu00VOWNlNf1P0tf
         v5X7D2SYcoj0tu3F0if2yoM168P+YEdhiDAkp56ykm6zaW6uz1U7ddNWTBHfeACHrTK2
         +ImA==
X-Gm-Message-State: ALQs6tCFJvtGeMNeKem6GRvRo7kqgCK+RZJ701dQWtFZ3JCr12DojvY1
        8ABXPDUkbB9OrKEYygt/qaNSjfKbLq2Ydnck/a+IyqZwWohCEtG1MaufDrgBVELDtMCBOxU57MT
        FVJMCKjA6QQ6IpmIF7E2DEv7MrADz6b4t4SMaMamryckTdJ5IBoF7NIASK8+Qhg==
X-Google-Smtp-Source: AIpwx483/g3XdfE1a1RFWQmAhIJJy5CDFUtC3yISenbi83M2jVSk13bbDu6HdNgrxFwG4lihHEHHuw==
X-Received: by 10.129.24.214 with SMTP id 205mr500871ywy.31.1523953928834;
        Tue, 17 Apr 2018 01:32:08 -0700 (PDT)
Received: from mail-qk0-f182.google.com (mail-qk0-f182.google.com. [209.85.220.182])
        by smtp.gmail.com with ESMTPSA id w5sm6240419ywl.38.2018.04.17.01.32.08
        for <git@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 17 Apr 2018 01:32:08 -0700 (PDT)
Received: by mail-qk0-f182.google.com with SMTP id v2so19475240qkh.10
        for <git@vger.kernel.org>; Tue, 17 Apr 2018 01:32:08 -0700 (PDT)
X-Received: by 10.233.244.65 with SMTP id z1mr1414133qkl.112.1523953928242;
 Tue, 17 Apr 2018 01:32:08 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.200.51.172 with HTTP; Tue, 17 Apr 2018 01:31:37 -0700 (PDT)
From:   Haralan Dobrev <harry@hkdobrev.com>
Date:   Tue, 17 Apr 2018 11:31:37 +0300
X-Gmail-Original-Message-ID: <CANu1nimmRCkudQyW8fksg9LRu3tdoSV93S6PD7U_tJ82Vk4kZA@mail.gmail.com>
Message-ID: <CANu1nimmRCkudQyW8fksg9LRu3tdoSV93S6PD7U_tJ82Vk4kZA@mail.gmail.com>
Subject: git-checkout -B resets branch not showing last revision
To:     git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

I recently had the following case:

1. I have a local branch called `foo` which I haven't checkout recently.
2. Due to a bad alias I ran the following command:

    git-checkout -B foo

This checked out and reset the foo branch. Which is according to the
documentation.
However, the output of the command does not show the previous state of
the foo branch
unlike what `git-reset --hard` does for some time.

The previous revision is not present in the `reflog` either as I
haven't checked it out.

I think it would be beneficial to Git users to show the previous
revision in all operations
resulting in reseting a branch.

Thanks,
Harry
