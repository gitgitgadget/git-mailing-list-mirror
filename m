Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5B17EC433EF
	for <git@archiver.kernel.org>; Tue,  5 Jul 2022 07:19:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229724AbiGEHTU (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 5 Jul 2022 03:19:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48300 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229640AbiGEHTS (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 5 Jul 2022 03:19:18 -0400
X-Greylist: delayed 441 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Tue, 05 Jul 2022 00:19:15 PDT
Received: from cstnet.cn (smtp21.cstnet.cn [159.226.251.21])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id BBFF638AB
        for <git@vger.kernel.org>; Tue,  5 Jul 2022 00:19:15 -0700 (PDT)
Received: from [10.0.20.65] (unknown [106.120.127.5])
        by APP-01 (Coremail) with SMTP id qwCowADn7xc15MNip5RuDA--.13353S2;
        Tue, 05 Jul 2022 15:11:50 +0800 (CST)
Message-ID: <17411d88-b27a-2d20-623d-85c49dc7754e@mails.ucas.ac.cn>
Date:   Tue, 5 Jul 2022 15:11:49 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Content-Language: en-US
To:     git@vger.kernel.org
From:   wuzhouhui <wuzhouhui14@mails.ucas.ac.cn>
Subject: How to display "HEAD~*" in "git log"
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: qwCowADn7xc15MNip5RuDA--.13353S2
X-Coremail-Antispam: 1UD129KBjvdXoW7Wr48tr47CFWfKF17JrWDArb_yoWxZFX_Cr
        n8ZF1UC397Xw47Zrn8Jr4rZ3yaga4UArn5A3y7G3W3tw4fuF48WFZ3XasxWry5J3y2kry5
        CrsrJFn2k3s3CjkaLaAFLSUrUUUUUb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
        9fnUUIcSsGvfJTRUUUbskYjsxI4VW3JwAYFVCjjxCrM7AC8VAFwI0_Jr0_Gr1l1xkIjI8I
        6I8E6xAIw20EY4v20xvaj40_Wr0E3s1l1IIY67AEw4v_Jr0_Jr4l8cAvFVAK0II2c7xJM2
        8CjxkF64kEwVA0rcxSw2x7M28EF7xvwVC0I7IYx2IY67AKxVW5JVW7JwA2z4x0Y4vE2Ix0
        cI8IcVCY1x0267AKxVW8JVWxJwA2z4x0Y4vEx4A2jsIE14v26F4UJVW0owA2z4x0Y4vEx4
        A2jsIEc7CjxVAFwI0_Cr1j6rxdM2vYz4IE04k24VAvwVAKI4IrM2AIxVAIcxkEcVAq07x2
        0xvEncxIr21l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj6xIIjxv20xvE14v26r1j6r18Mc
        Ij6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IY64vIr41lc7I2
        V7IY0VAS07AlzVAYIcxG8wCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8Jw
        C20s026c02F40E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAF
        wI0_Jr0_JrylIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI42IY6xIIjx
        v20xvEc7CjxVAFwI0_Jr0_Gr1lIxAIcVCF04k26cxKx2IYs7xG6rW3Jr0E3s1lIxAIcVC2
        z280aVAFwI0_Jr0_Gr1lIxAIcVC2z280aVCY1x0267AKxVWUJVW8JbIYCTnIWIevJa73Uj
        IFyTuYvjxU4oUDDUUUU
X-Originating-IP: [106.120.127.5]
X-CM-SenderInfo: xzx2x05xkxxi2u6ptx1ovo3u1dvotugofq/1tbiAwoSAWKY1jEuRQAAss
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi

I frequently use "git rebase" to move commit to a specific location, to
know which commit ID as param of "git rebase", I have to list all commits
by "git log --oneline", then copy specific commit ID, and executing "git
rebase" as

   git rebase -i <copied commit ID>~

because SHA sum is hard to memorize, so I have to use copy and past,
which is too boring. So, I wonder if there is a way to let "git log"
display commits like following:

   HEAD   <one line commit message>
   HEAD~1 <one line commit message>
HEAD~2 <one line commit message>
HEAD~3 <one line commit message>
   ...

With these "HEAD~*", I can easily directly type them and no need to
move my fingers out of keyboard.

Thanks.

