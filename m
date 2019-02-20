Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,RCVD_IN_RP_RNBL shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id EED5E1F453
	for <e@80x24.org>; Wed, 20 Feb 2019 00:06:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730241AbfBTAGC (ORCPT <rfc822;e@80x24.org>);
        Tue, 19 Feb 2019 19:06:02 -0500
Received: from mail-pl1-f169.google.com ([209.85.214.169]:44865 "EHLO
        mail-pl1-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730121AbfBTAFm (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 19 Feb 2019 19:05:42 -0500
Received: by mail-pl1-f169.google.com with SMTP id c4so6192583pls.11
        for <git@vger.kernel.org>; Tue, 19 Feb 2019 16:05:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=exactasystems-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:from:date:message-id:subject:to;
        bh=te8BsjZZSRH6rdYl01qimlPZ46ry2nBmNLge+1yQ918=;
        b=pbpnskTAYU8wOeEMvM6RMIoBnm7T//IXCNfRw9C3YZeClcQDje4xDZrzvprHxvASY9
         0dbhyb1E7IV/dZt5ibAtAMafDELne4aBu05jOGjQtdFV4QxuVTOVRP6Sw/cwZW3WSIGj
         eS/qJgCFKqRYi/zUHhL7BeoBhIFZHZRS9XrBYikkIbhToiug37nbrXDSlNtazJMMnint
         otTdIeK1nzXh/6SFmuDHQ701Aelg03c82+eGs67AHh0ISA9QqrrQlyG4pBFb0Bzedf8I
         9Z0kwgDMqPLJxLZNzaEq0lHCUWXSrRRUklG4dOju+UP4vVc7nDJiw3WXUaBEgcOyvOE5
         h6AQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=te8BsjZZSRH6rdYl01qimlPZ46ry2nBmNLge+1yQ918=;
        b=dqzuD/eVejfFXR2NC9QZ9zuXPqLZSkzzzWZR4LgYD9ESGhc7XuZsb1ODrcczFa5wZx
         QYAUiDFMDGDuS/iVc/+KFqq4pHI4De/PZoqdknHlKi6Io9m/Ahamo+sbJEYl+Fhusc7e
         w3Y3OQLCxb/TAj3qzF/GVLvNeY8sjTm5Z97fJb0uAsvnDrEggBiPDXYx6olZ/iZkSQM0
         z/Xwse99JNl9JuywG+yJrKZfDqx88c2BpZQp5xAaoblylo4mqrTGAlcVxNcHWrwbhQ7A
         ghxdVIMFZHKeypkKLN336GMlG7oAOcod93gFn/5Pn/Ak4ZG6iO+ex7bdDDTjhxaGsySC
         3Haw==
X-Gm-Message-State: AHQUAub1+WeoovGv9VyyhQTC23//+NIsX7Lf+BoIJZ+VefVm3cCph0PM
        9HI1tYw4Yzr8KgQD+8P8dQOrPE69AjyrvTTtxlyKLZW8PrQ=
X-Google-Smtp-Source: AHgI3IZ+xTZjkw6UHHzfrWATTy3PYfGC+hRDfnCFWNUwclp/Crf8JoaCs8BWbXqusNMntt16J5fcg4546tf2n4ZX6J8=
X-Received: by 2002:a17:902:a7:: with SMTP id a36mr33567489pla.295.1550621141305;
 Tue, 19 Feb 2019 16:05:41 -0800 (PST)
MIME-Version: 1.0
From:   Joe Enzminger <joe.enzminger@exactasystems.com>
Date:   Tue, 19 Feb 2019 18:05:30 -0600
Message-ID: <CAApa7v-F7Y_WR11V-3jc-R4Y1qSv5PPof6GWvJuF_XMeTcC2zw@mail.gmail.com>
Subject: Feature Request git clone shallow-include
To:     git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Currently, git clone supports shallow-exclude=<tag-name>.  The client
will clone up to, but not including, the commit with the tag.

It would be useful to have the ability to include the commit with the
tag.  The suggestion would be to add a "shallow-include" options to
clone to support this behavior.

I have tried to use shallow-exclude with a follow on git fetch
--deepen=1, but it always returns "fatal: error in object; unshallow
<sha1>"
