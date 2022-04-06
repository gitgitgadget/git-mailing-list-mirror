Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8A33AC433F5
	for <git@archiver.kernel.org>; Wed,  6 Apr 2022 16:31:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237682AbiDFQcZ (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 6 Apr 2022 12:32:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50362 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237382AbiDFQcO (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 6 Apr 2022 12:32:14 -0400
X-Greylist: delayed 948 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Wed, 06 Apr 2022 06:51:47 PDT
Received: from mut-mta1-se01b-zose1-fr.yulpa.io (mut-mta1-se01b-zose1-fr.yulpa.io [185.49.22.247])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 30B32C90D8
        for <git@vger.kernel.org>; Wed,  6 Apr 2022 06:51:46 -0700 (PDT)
Received: from [185.217.155.54] (helo=mut-zose1-mta-hub-outmua01a-fr.yulpa.io)
        by mut-mta1-se01b-fr.yulpa.io with esmtps (TLSv1.2:AES128-GCM-SHA256:128)
        (Exim 4.92)
        (envelope-from <git@matthieu-moy.fr>)
        id 1nc5pB-000WGI-P0; Wed, 06 Apr 2022 15:35:55 +0200
Received: from localhost (localhost [127.0.0.1])
        by mut-zose1-mta-hub-outmua01a-fr.yulpa.io (Postfix) with ESMTP id 8EDCD20F39;
        Wed,  6 Apr 2022 15:35:53 +0200 (CEST)
Received: from mut-zose1-mta-hub-outmua01a-fr.yulpa.io ([127.0.0.1])
        by localhost (mut-zose1-mta-hub-outmua01a-fr.yulpa.io [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id wLaGpYyEMNa6; Wed,  6 Apr 2022 15:35:52 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
        by mut-zose1-mta-hub-outmua01a-fr.yulpa.io (Postfix) with ESMTP id 0AA3D20F58;
        Wed,  6 Apr 2022 15:35:52 +0200 (CEST)
X-Virus-Scanned: amavisd-new at mut-zose1.yulpa.io
Received: from mut-zose1-mta-hub-outmua01a-fr.yulpa.io ([127.0.0.1])
        by localhost (mut-zose1-mta-hub-outmua01a-fr.yulpa.io [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id lA0A7b98_WUG; Wed,  6 Apr 2022 15:35:51 +0200 (CEST)
Received: from [140.77.13.114] (dhcp-13-114.lip.ens-lyon.fr [140.77.13.114])
        (Authenticated sender: matthieu.moy@matthieu-moy.fr)
        by mut-zose1-mta-hub-outmua01a-fr.yulpa.io (Postfix) with ESMTPSA id AA89E20F39;
        Wed,  6 Apr 2022 15:35:51 +0200 (CEST)
Message-ID: <84f77a5b-5721-3583-8ed8-9d360928cf35@matthieu-moy.fr>
Date:   Wed, 6 Apr 2022 15:35:51 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH V1 1/1] contrib/vscode/: debugging with VS Code and gdb
Content-Language: en-US
To:     COGONI Guillaume <cogoni.guillaume@gmail.com>,
        matthieu.moy@univ-lyon1.fr
Cc:     derrickstolee@github.com, git.jonathan.bressat@gmail.com,
        git@vger.kernel.org
References: <6f4b924d-0a13-b267-6766-a3620936b686@univ-lyon1.fr>
 <20220405224502.38544-1-cogoni.guillaume@gmail.com>
 <20220405224502.38544-2-cogoni.guillaume@gmail.com>
From:   Matthieu Moy <git@matthieu-moy.fr>
In-Reply-To: <20220405224502.38544-2-cogoni.guillaume@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: 185.217.155.54
X-yulPa-Domain: mut-zose1.yulpa.io
X-yulPa-Username: 185.217.155.54
Authentication-Results: yulpa.io; auth=pass smtp.auth=185.217.155.54@mut-zose1.yulpa.io
X-yulPa-Outgoing-Class: ham
X-yulPa-Outgoing-Evidence: Combined (0.03)
X-Recommended-Action: accept
X-Filter-ID: Pt3MvcO5N4iKaDQ5O6lkdGlMVN6RH8bjRMzItlySaT9p8jXmdWHF5NEnstjZdTJhPUtbdvnXkggZ
 3YnVId/Y5jcf0yeVQAvfjHznO7+bT5wHzaN0z0Ug1scQLleVAb4gFAkmY/L1vp+E+d4RSLO7Kd2D
 dpTGFSx+xQOKH8nOUl2dumA+0IBxei0LAzz3JMDV47TzsmUDHzMkiNko+IXxSF1zjlrKRNh1Oj4H
 PDTzoRYDyHKfJKnhVIKX8Yq8nfvn1y4uVu1VH1tBUKHklzXsdf6ZM0JQVdm1T9bshXNP7sHhtIdB
 kUNQyNMiiqabnglhDWn7DaW7rUVLB0WTrPq7+lY+5adZvWXoGLcQcb78Eui0IJNXBQXnMUXGoxGc
 h392Wa66MXU858iPFrZCv/0JMqbFc2bT9AciiKU48+dSpFeZAwEzl1K4UZNqPRuuhnzfOHylLosN
 P/1dYIrW9rhoJjCKx+YBIxO5jv+fSijtd+3yaKrk007dYZTthwA01fJk0EuxhEHVRSxhzQ28OWjf
 zM5xFf6sLi4v8CS69SSVWadhMKS+BEY488JlJ2GXtEI2tdAVHnqc7pbT78AQaKJAkG2mwVrPlsYu
 a4FzDkflpnOCNvw8IepRO18X4jnddV21vrR9xqolseqIJhRvy/RVfrqj3OyESjjTvtbrvZR7kATj
 mvts2ooxVjoUBkOallUbtuVgQg9QBU9AFVgaYlq79vgPneWh5kublaxZVQoA47wpOMQJvQ/Ck3ii
 U+4DQAj3DhYpgwxEDQuH7GNpv2Hu1pCNdOIMyAMy1g7JF/2/OJcFjpUuKAw6OGir22J8YDsOsTCE
 wbcniLv7YpCNIrwmeHOeNyNT8IVfimIzskWYEElzieQgnzmNLPeYVnNnjarCBdStkPv/bFOIg+dt
 /S6i46SDmfnaId2rHiZL4vBd40ghOl2/oiHk8nOTUjVk3fdlaNvrrXaJ62JO1NPxNyHTSAdJAaRu
 zWrTIwhXWfCVkE5RXxKF5tPxTxfD0dMN+t5ZhF195V5vRMgguM+VrdmvjUMaaOamSzvlpAbjNI4B
 29HxSQ8lc4dDv86Crg9YFude/ETTbAb6lAg37czIhgXAye+dw45pqJ0ba/bG0A5ag+M5Dy0kIn1S
 +xE6dEa4ITSOJrg/p8xxEs5FlB+xGa5t6U+MD7fzqSChs+4uwiFVOMIoggaqweLzJh6Y5sesEwwc
 S5TMxvd8NdRV1gKYQ/ojqrhVQosHyUOZ/y3J4HSjzd8=
X-Report-Abuse-To: spam@mut-mta1-se01a-fr.yulpa.io
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 4/6/22 00:45, COGONI Guillaume wrote:
> The externalConsole=true setting is broken for many users (launching the
> debugger with such setting results in VS Code waiting forever without
> actually starting the debugger). Also, this setting is a matter of user
> preference, and is arguably better set in a "launch" section in the
> user-wide settings.json than hardcoded in our script. Remove the line to
> use VS Code's default, or the user's setting.
> 
> Add useful links in contrib/vscode/README.md to help the user to
> configure VS Code and how to use the debugging feature.
> 
> Add a mention to the README and the init.sh in Documentation/MyFirstContribution.txt
> and a part to convince a newcomer that VS Code can help him.

You may avoid the gender-specific formulation here, women should be as 
interested as men in the document.

> --- a/Documentation/MyFirstContribution.txt
> +++ b/Documentation/MyFirstContribution.txt
> @@ -1265,3 +1265,14 @@ against the appropriate GitGitGadget/Git branch.
>   If you're using `git send-email`, you can use it the same way as before, but you
>   should generate your diffs from `<topic>..<mybranch>` and base your work on
>   `<topic>` instead of `master`.
> +
> +[[Bonus-useful-tools]]
> +== Bonus - useful tools
> +
> +=== VS Code
> +
> +Using the integrate debugger can be particularly helpful to understand how Git works internally.
> +It can be used to isolate some parts of code, with this you may be able to ask more precises
> +question when you are stuck. (See getting-help sections).
> +A script that creates the configuration files is available in contrib/vscode/init.sh. Useful links
> +and explanation of how to use the script are available in contrib/vscode/README.md.

I'd start with the last sentence. People already familiar with VS Code 
may find the first line boring, and stop reading before reaching the 
important information.

With or without changes, this is

Acked-by: Matthieu Moy <git@matthieu-moy.fr>

--
Matthieu Moy
https://matthieu-moy.fr/
