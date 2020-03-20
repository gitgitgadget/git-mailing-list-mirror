Return-Path: <SRS0=v+yc=5F=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5CFABC4332B
	for <git@archiver.kernel.org>; Fri, 20 Mar 2020 06:37:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 282102072D
	for <git@archiver.kernel.org>; Fri, 20 Mar 2020 06:37:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="j2rPpHPt"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726728AbgCTGhc (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 20 Mar 2020 02:37:32 -0400
Received: from mail-qk1-f170.google.com ([209.85.222.170]:39248 "EHLO
        mail-qk1-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726603AbgCTGhc (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 20 Mar 2020 02:37:32 -0400
Received: by mail-qk1-f170.google.com with SMTP id t17so5816332qkm.6
        for <git@vger.kernel.org>; Thu, 19 Mar 2020 23:37:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to;
        bh=5d8XNVxx8A6V3Fw7O4xMe+vD7uQ746rSmijV15z07b4=;
        b=j2rPpHPtvOPgsHjkq1LUFE9RmzLKgs2AGGx5YwTQmeTxpbynkCr64q/3/Y03luTLWK
         PIxm3VwBTXEhOZfi7sZXHBUfzZF+5uT14X5k4V6PI2aWaIgg/qrcXWfCAeu4nUXU3NWI
         cpcMSY47sJZIPZqwaKuQrRrT4xASXNyRjWjf0HN9gE94Slhg4GsDM/wRQWfUyTJ1bwfk
         t2oi1cW5jKIKA6GT961+plfDYBtb7e9hV2gSt1xYrHPpDV48syO0YJgWct/NZILP3DxD
         LlFttHbIR0bjgeKNGYYvOStjRUsuo/fG8zjxlitm6ncivpu4HCn8tM+gJffrU/GPpw/q
         v1TA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=5d8XNVxx8A6V3Fw7O4xMe+vD7uQ746rSmijV15z07b4=;
        b=ZktYxerY+4sENRG7SgyOaloFGH1hDsmpstI2pw6Ifxo0CkiyXJV+vDZtASSVUa3GR3
         qVoGTB0250jo3d3OiJhL9dg+DhjY7/eRcmSTGqGUdD9b8cE0bXYRdumASa0K6zLK1TaC
         o1kR6XyscTHd9eCLDReoSdlofNSu0VgkunM54hWQCokrwI5/ADm6vpPL6d0as7Ib0808
         nR8xVAtBI9zGRnVJ9sz4bhwWPtBGLP3mMof63BULlvp46fqcTX3IMAPZMO8k/voBHcUQ
         f6o8UVGI3gTq6uiyfmni2SMU0xV4sv8rLBAihr0CvzClflXmjXoTuUDtylmKdrX+TjJk
         nZKg==
X-Gm-Message-State: ANhLgQ0x1MD4+NNK4N9F9iqToj6fF6eRT0N0aQNXvA2fxbm49325WppT
        VvZzJEDHawpyEdMYYHaeCuH9lQLiOKlnfV3kozgzad2DtAY=
X-Google-Smtp-Source: ADFU+vvwj9keNPGIL32UbtLjEAuN477LUUK86uhqZLaJ0hNT71dS2+O7cmc0dCz0BDdvkv7nhQaHrZenhJjQVvuk96I=
X-Received: by 2002:a37:64c6:: with SMTP id y189mr6742983qkb.12.1584686251382;
 Thu, 19 Mar 2020 23:37:31 -0700 (PDT)
MIME-Version: 1.0
From:   Shanthanu Rai <shanthanu.s.rai9@gmail.com>
Date:   Fri, 20 Mar 2020 12:07:20 +0530
Message-ID: <CAGNOEmugZDWpvAHsOzmm_Fqo_Vj5GcC--GfTg3JHPm701HjBXA@mail.gmail.com>
Subject: [GSoC] Query regarding Microproject
To:     git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi, I am a 3rd Computer Science Undergrad at National Institute of
Technology Surathkal, India. I wish to apply to git for GSoC.

I am currently working on the microproject titled "Avoid pipes in git
related commands in test scripts". I found 't/t9116-git-svn-log.sh' to
have some commands wherein output of git is redirected to grep (using
pipe). So shall I go ahead and make the required changes, i.e., redirect
the output of git to a file and grep this file, in the relevant commands?

--
Regards,
Shanthanu S Rai
