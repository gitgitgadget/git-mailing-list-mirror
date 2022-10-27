Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7613DFA3742
	for <git@archiver.kernel.org>; Thu, 27 Oct 2022 11:53:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235407AbiJ0LxX (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 27 Oct 2022 07:53:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51564 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234933AbiJ0LxW (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 27 Oct 2022 07:53:22 -0400
Received: from mail-pj1-x102d.google.com (mail-pj1-x102d.google.com [IPv6:2607:f8b0:4864:20::102d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E235EA87B5
        for <git@vger.kernel.org>; Thu, 27 Oct 2022 04:53:21 -0700 (PDT)
Received: by mail-pj1-x102d.google.com with SMTP id c15-20020a17090a1d0f00b0021365864446so1216450pjd.4
        for <git@vger.kernel.org>; Thu, 27 Oct 2022 04:53:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=OrLPaBvMCA905qdnXxLbIHK8sG48JFkhnfrK6SBnaxA=;
        b=PWWYB7GdtrEdFFuYWxjlxVrukOibddUncz3Fs+x7fmmpNKu28QogyLr6u8hR/hRPI8
         vwCH7je2SbNQ8WE17vmgMixvoQWa81IuhQGeKeBJ2yV6K20sFyZiKP9hdzXHzPbRaktf
         gXfXriSJOWHtPBtKbRCd6qdYwRgtPOXTNhhvllBw3nrpjCpKqbmXQrY+YSCPBq85gUy2
         XwZyuRTsNtQ9VIhjRPGsadYcIN4FtwAeVbXhnOaHnUSSOnZUC6OypMzkr7Bjo6IHNRLX
         uuriD+27VpJzU8if3AdIvSp2Y2YQrZHqEGkvo5rnmlqeK6SDST/D05BKHzVfompU9w+B
         WfUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=OrLPaBvMCA905qdnXxLbIHK8sG48JFkhnfrK6SBnaxA=;
        b=5OGkCxeo6ktSI+fcLVKyxLzyI+afTAciw2oBX2iDlQN7PonsPQL+ik+Q/0AdodK5oZ
         AejZASBHolQVLb2IDSY24T0XmHZ2e8sk0ZwDNmSbNuwMKiItfUvP+Uc9uXyr515OFNZd
         FKtjGrr/EsUbPjXYFKUus96CKtN2SnRHraNVK2C5qf8GhJcBNV+BqS7wa5KUTKf+5SCV
         sfwcTgEqVQrj2J4RJAKkKkajwrt+a3i9Zj7IUk09bpcdfQ1T6OkLY+dM+q14Pu3k58j/
         J+lDejNA9lRkkLlzG74ahKrPMF81DK1ISEjldHmZq0dzafAFthEWjDqV1xtXR/ySYneP
         SKsg==
X-Gm-Message-State: ACrzQf2mtrWUW0tttdpgChABuYd65oDtVJVuVh5B5cXk4myHuKcYOhiX
        0m28UhkhOkaT1Bv3PDpRmeZtC2f6HDck42XeSxcqtxwWlD4=
X-Google-Smtp-Source: AMsMyM4BWIeBpwRd+QRzhAnXuXFRu9XNO5VH8XFTez1HBwCERICOPzAUGVPTsOlY84rDfadR2WmaGO6CxEhcmaQxyjU=
X-Received: by 2002:a17:90b:1d8a:b0:20f:95f9:ff34 with SMTP id
 pf10-20020a17090b1d8a00b0020f95f9ff34mr9878455pjb.227.1666871601286; Thu, 27
 Oct 2022 04:53:21 -0700 (PDT)
MIME-Version: 1.0
From:   Angelo Borsotti <angelo.borsotti@gmail.com>
Date:   Thu, 27 Oct 2022 13:53:09 +0200
Message-ID: <CAB9Jk9Ay2PPEYKve3DXVmG__yZjO1mgh1MxaKA+wfsF0ZvKRqA@mail.gmail.com>
Subject: Git add documentation error
To:     git <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hello,

the reference manual for the "git add" command does not
specify what that command does when applied to an
unmodified file.
By testing this, I have seen that it does not add the file
to the index, and consequently it does not add it when a
subsequent commit is done.
I think that this should be documented.

Thank you
-Angelo Borsotti
