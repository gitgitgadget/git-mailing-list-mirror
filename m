Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5D19AC433EF
	for <git@archiver.kernel.org>; Sun,  6 Mar 2022 11:11:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233238AbiCFLL4 (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 6 Mar 2022 06:11:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48954 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230380AbiCFLLz (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 6 Mar 2022 06:11:55 -0500
Received: from mail-pg1-x535.google.com (mail-pg1-x535.google.com [IPv6:2607:f8b0:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5683A5F4E1
        for <git@vger.kernel.org>; Sun,  6 Mar 2022 03:11:03 -0800 (PST)
Received: by mail-pg1-x535.google.com with SMTP id bc27so11266283pgb.4
        for <git@vger.kernel.org>; Sun, 06 Mar 2022 03:11:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=vIPPGVIsksu1I841zJApVdgjP3iCVrjhUno+ftb7RIc=;
        b=fs8Uad2wrEh+PWpwJ177ZGmApq/w+J9Ewm+TU/ZEX8ByqyBYQfakoZRpX8bi1YIt9H
         M4wWX0er6Nv/DdWl1FTnAaP7GNaMruI6iNg5aRTTTKERnPHzTO+2pAxz+OBcd06v+arH
         AwVekznSjhSCmRBsLLy5DauQfU3krKMCBjzkCjm/wsVZFUWM5eol0uRmaBjHAr6ADYlg
         xF86MRgeNNQI1ZG8F5MudTIUQlWpefi6vBXy9TR4mDBjpg3pkivcvJW0Ba/v+3WP+keu
         H0NxNcXjT65rxSHRxFj9Flq+Ya+4liOZDpL/K9iJy1bS903BNM8Kq6m3dQrCg2NGzgWg
         Cc9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=vIPPGVIsksu1I841zJApVdgjP3iCVrjhUno+ftb7RIc=;
        b=irWwB3+tEJfkr5kdMcLw6QEW2s1VSSwzI9ngAfvho3FiyayZFk8NoY6Rn0fd1tmspj
         D/AHaW0wwq2kBN53S5DErISYZHFVQZAz/OO5excD4rjLx/T+uC2AnE3IgtwVOAmiIK8Q
         0+nTgo6aRfQHdJK7GOANT7zVuDXRD/11EB+cWbmNnmSA7sUBfVRqfJJzgDbnEI3fxBlI
         B+FZVu3xH04N7tCGSZsH3WEj0S7qvM7DWbouDkksNBFK94ALMOKzIeHcT3DomEzBIEs/
         0sUPKQcRdJZwXfPLPtplWN+t5+/86Q7g9wRLyt79IrmgYgdgmF/CPH+rCz8Sho3ggT9X
         T9cw==
X-Gm-Message-State: AOAM531w+eP16UiV8fi6a6q39OVG4BGcProGeNsJpDiZ6baLPpfcJ4A5
        Tu5bwHcpZGBAapRYEtFP9GFEZrd1idnFFCWT
X-Google-Smtp-Source: ABdhPJzdUvHV4jkTu5xvZ24lIGy/z4oYZ7KhpKTaFtUu94GFytxWBupYsT3c6fLIymzIGsVKzeQLUQ==
X-Received: by 2002:a63:4a4c:0:b0:375:6898:f6b6 with SMTP id j12-20020a634a4c000000b003756898f6b6mr5839845pgl.83.1646565062696;
        Sun, 06 Mar 2022 03:11:02 -0800 (PST)
Received: from localhost.localdomain ([2405:201:a800:4df9:5194:c9b1:2d1f:598e])
        by smtp.gmail.com with ESMTPSA id u12-20020a17090a890c00b001b8efcf8e48sm15639258pjn.14.2022.03.06.03.11.00
        for <git@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 06 Mar 2022 03:11:02 -0800 (PST)
From:   Jaydeep P Das <jaydeepjd.8914@gmail.com>
To:     git@vger.kernel.org
Subject: 
Date:   Sun,  6 Mar 2022 16:40:30 +0530
Message-Id: <20220306111031.335489-1-jaydeepjd.8914@gmail.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220301070226.2477769-1-jaydeepjd.8914>
References: <20220301070226.2477769-1-jaydeepjd.8914>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This patch removes the previously implemented regex
for matching method calls and adds a new regex
for specially matching floating numbers starting with
a decimal point. 

Added some more compound operators and their tests.

--
Thanks :-]
Jaydeep


