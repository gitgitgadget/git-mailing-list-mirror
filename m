Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CA32DC4332F
	for <git@archiver.kernel.org>; Fri, 21 Oct 2022 06:07:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229976AbiJUGHE (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 21 Oct 2022 02:07:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39970 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229864AbiJUGHC (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 21 Oct 2022 02:07:02 -0400
Received: from mail-ej1-f53.google.com (mail-ej1-f53.google.com [209.85.218.53])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 850B81F8130
        for <git@vger.kernel.org>; Thu, 20 Oct 2022 23:06:59 -0700 (PDT)
Received: by mail-ej1-f53.google.com with SMTP id bj12so4559462ejb.13
        for <git@vger.kernel.org>; Thu, 20 Oct 2022 23:06:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=QZZvyaZPW18MjptjsRbk0tNqYQwJwabDtYUc5frIZuE=;
        b=wDbz3GZPLXdbtd6rxSxNCYVFW0W3/ffw7Hly/kfhq8zC6VLLzf8dkwmjRtUQPXV+5E
         CDMfYkqFsD0GowtgtnvOziOaRk77H5Q2E4qz7aHaZgmy70JVi+hq51CN/Cd3dJmkYXnT
         3w722WhHa3H3llH8q9VsDA4ey0GoslHLUj0I447No5iKy4AQpPQcnzvduBMHkKEYGoez
         UbW5SFiwxdDwsJ450yKr4oPgxT+qnjjQyMoBykIgKauy/HV/PRt7DtAMSbDcTKuYYabG
         qYkLWbN8RGJy51SiiTnQkb0M9mqd/BrdWvE/wfeHroVMtVgst4totI2Db7yyi0dfQNPv
         wPFw==
X-Gm-Message-State: ACrzQf04ETyKmSu3WzLORTnrlaj5eBjRGeDm2vAVEaaPkFn7k5Wh/Gmj
        3uZQekbssqc6myJ4L32zTOK9Sl4weyOF1HcNqRQ=
X-Google-Smtp-Source: AMsMyM6SiT5ZoocZVfXE+ILq/dIvwcrwcYaLYRg3utXZl42ShZG0Qugb6XrBWSD22IpxA5BIbI+qaVqmEfkfA8UuZhc=
X-Received: by 2002:a17:907:60c7:b0:78e:1cc:57de with SMTP id
 hv7-20020a17090760c700b0078e01cc57demr14079872ejc.33.1666332417613; Thu, 20
 Oct 2022 23:06:57 -0700 (PDT)
MIME-Version: 1.0
References: <5E2E10BE-6EEB-4C78-A489-5899400DA937@gmail.com>
 <CA+JQ7M-NA9UYafMurb9MAo5bp6djdzRP7ChAbdmzU+nmrkXTNw@mail.gmail.com>
 <DB5611E0-6B1C-4711-BB9F-72F6E8F39506@gmail.com> <CA+JQ7M92x03FPWM6qWjG=FYPxCYs8xcC_HRWLnkwj4iqA9KK=w@mail.gmail.com>
 <46A1CB40-BBEE-43FC-9626-588718518B4A@gmail.com>
In-Reply-To: <46A1CB40-BBEE-43FC-9626-588718518B4A@gmail.com>
From:   Erik Cervin Edin <erik@cervined.in>
Date:   Fri, 21 Oct 2022 08:06:21 +0200
Message-ID: <CA+JQ7M-7qEu8ooQp_g1+5pownA13VbPvJQSb-snKP3=7yfyCEw@mail.gmail.com>
Subject: Re: Cloning remotely under git for Windows not working
To:     "W. Ekkehard Blanz" <ekkehard.blanz@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Oct 21, 2022 at 12:00 AM W. Ekkehard Blanz
<ekkehard.blanz@gmail.com> wrote:
>
> How do I convince git to use Powershell as its shell of choice when it arrives over ssh at my target Windows box?  Unfortunately,
>     git help clone
> Does not give me any indication how to do that.

AFAIK, the remote choses the default shell of ssh sessions so you
either change that or somehow launch a different subshell with the
client. The former should be easier
https://learn.microsoft.com/en-us/windows-server/administration/openssh/openssh_server_configuration
the latter is talked about somewhere in here
https://github.com/PowerShell/Win32-OpenSSH/issues/752
if my memory serves me correctly. I chose the former
