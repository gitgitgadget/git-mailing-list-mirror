Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0187620285
	for <e@80x24.org>; Wed, 30 Aug 2017 18:02:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751693AbdH3SCq (ORCPT <rfc822;e@80x24.org>);
        Wed, 30 Aug 2017 14:02:46 -0400
Received: from mail-pg0-f47.google.com ([74.125.83.47]:34980 "EHLO
        mail-pg0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751549AbdH3SCq (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 30 Aug 2017 14:02:46 -0400
Received: by mail-pg0-f47.google.com with SMTP id 63so21870199pgc.2
        for <git@vger.kernel.org>; Wed, 30 Aug 2017 11:02:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=CcvAOQO7BwL/QLerVoiyqFttP2gn7eEPKkCR6BFnmhM=;
        b=AbBNw3HJxa00ztbE3MG1p59wI5sfMmKfMz0P5o11POI+QG8Ccwx5kzxbapCYyDQqFG
         8j8JiUni9fXNEyxJOK290NWbWX007hQ8s6WT1mJvIm/x/3tml+XGSxPMUmQ41Mj93xow
         OX3ljnk/aAEj+Bt2WY01IbBlHHcYM2MqrI4wAsBFTg4v2D7MSjeIhomv/ELYWhQLtOhw
         kstnNTN9HHtr0+90FfeWQhxwGMElAH7e6FIySYm5AJW4pkPcdrfka+YSSO6lNC7xFnek
         qaNr43UsDhasxx8a/C8fJuiyPku8zUwOGL9fa5nCtC2Lla/0xyODEjaoEEhbzLsd0YtC
         IUJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=CcvAOQO7BwL/QLerVoiyqFttP2gn7eEPKkCR6BFnmhM=;
        b=Jngcn5TcLrWZM+wVO0dPX6fgs6twPHRPZfDnIuwV+cTOa0nf33hsTNzvKrYZy3NM7N
         plQF7Y64t4YxzBf1MMlLhm2UeW3nBcursUf8feNZA2orI0x3IqiK4Vnxe6RMJp7CTUIl
         8ZevNfvtmzXAnRJUZYL6lE+pLTcMT+fl64BGgCOKCWNxvpEWXwUix0EzRHZ9VokCjyYp
         NAic2eZHnLN47KduQ6ogzOCisEPU8vOedS/dEhZkqUvZ2lMGG3aVlLIH8r+0ttI75Tou
         n+Jouv23ZmVflS76z3WFMcpIhzf1IsaJhclVwv5IodBBlRad7Pl6Hok8lDrfVEXQF8f6
         i+wA==
X-Gm-Message-State: AHYfb5j2TJxD6TG3ag0xZdsmetEMu2qvJAyFsuckG4ZysWGgAZUSlrjI
        LtZXAdpLSHXZmHx80i9DgCHReOefxw==
X-Received: by 10.98.111.136 with SMTP id k130mr2423529pfc.122.1504116165461;
 Wed, 30 Aug 2017 11:02:45 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.100.182.197 with HTTP; Wed, 30 Aug 2017 11:02:44 -0700 (PDT)
In-Reply-To: <91e365b5-6a5d-1e1c-ab7a-579efa7c1ae8@alum.mit.edu>
References: <CAN0heSqn59sFF3A-eQ593G+ZDWnO9pKM5F=sgiSQk+prUr-nSQ@mail.gmail.com>
 <4b4c0d178ad2216eecbc49fb6f54dd8a1d1ac119.1504024261.git.martin.agren@gmail.com>
 <91e365b5-6a5d-1e1c-ab7a-579efa7c1ae8@alum.mit.edu>
From:   =?UTF-8?Q?Martin_=C3=85gren?= <martin.agren@gmail.com>
Date:   Wed, 30 Aug 2017 20:02:44 +0200
Message-ID: <CAN0heSqa8OnPnkd1xbyZ=QN9qg_8OaxBYnwzOZDDA3g+uGE71g@mail.gmail.com>
Subject: Re: [PATCH v3 1/3] refs/files-backend: add longer-scoped copy of
 string to list
To:     Michael Haggerty <mhagger@alum.mit.edu>
Cc:     Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 30 August 2017 at 04:52, Michael Haggerty <mhagger@alum.mit.edu> wrote:
> v3 looks good to me. Thanks!
>
> Reviewed-by: Michael Haggerty <mhagger@alum.mit.edu>

Thank _you_ for very helpful feedback on the earlier versions.

Martin
