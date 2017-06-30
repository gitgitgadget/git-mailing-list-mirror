Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7372A202A7
	for <e@80x24.org>; Fri, 30 Jun 2017 06:00:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751913AbdF3GAR (ORCPT <rfc822;e@80x24.org>);
        Fri, 30 Jun 2017 02:00:17 -0400
Received: from mail-wm0-f43.google.com ([74.125.82.43]:35457 "EHLO
        mail-wm0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751895AbdF3GAR (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 30 Jun 2017 02:00:17 -0400
Received: by mail-wm0-f43.google.com with SMTP id w126so100078900wme.0
        for <git@vger.kernel.org>; Thu, 29 Jun 2017 23:00:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=playrix-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:from:date:message-id:subject:to;
        bh=aSNCtH6KNyyP0Zg1CuiDqwFU5nlsnfu7B3OYwe6k8Ig=;
        b=udWbDILS9bkmAjzfXTmPO+os6a+BHyD2/9iQ/XBU00FYUYWIaIWMhmDygOqNnREWYJ
         P3WbvZ4TnAudkQIPTlvlwFYLe/B0b9PyGeLKm8fS+54Uu8oIFBcMU8pcczYm5cNRPWxe
         xCKrAnPfK5x898YOq39i0cM/u4YhlcVaAhVoTD3OL0GgZvI6an4tFsJOeYntpsiedhs1
         8tKgKhPfzlJEWZ52ey6sbWb+ie3rjdHp/QMJw4h8hTVvsMUqrjS2S2y1zQK0i3y5Qa+t
         6LJG+JmRhoL8pZfuP5eE8J0zlaLxHOc/9L+pJTtNMwgwdzizOvYxuQsoL7msZJirXj49
         xsfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=aSNCtH6KNyyP0Zg1CuiDqwFU5nlsnfu7B3OYwe6k8Ig=;
        b=EE+IKmXdAdcvZMr9f3lxBqLzjTm3gHktXgFo/FYi/S8zsh4KI/7uz5L/fAolAY1enJ
         DYnNWt+iyqH0mX+TBhf6Kzhf+Qe+xjQFq+bYSl3EJZ2Ps9uKdv+Rx99iyUOu4yrHh14Y
         dcA5v8mO6uZ5AWSbCvTdSGpLMcWZUK1NEA4O5KAq0Evy6eChNHEBnnzEv6TYmVtjeX1j
         JZjaHtA+qp8LsjNr+uQ3LIhccBapgSNcheAigQjKInouD0W3EmEgyKINlaG66+kY5nbT
         q6Vlk5e1gpnhivZNVr17RzafzP4HHMMLpVsVR/ASyBwvcbq8sGifJ/kORN+DAfZr/VWb
         XSiQ==
X-Gm-Message-State: AKS2vOyL/8iVhGEQSs3tPOnIp3lvxQcxQyRzHaXQK1ZMNuvz9qDXSBgY
        iqLlILn8Al3YP+igfpB/nn0kYVwBDU98UffqvA==
X-Received: by 10.28.180.70 with SMTP id d67mr4555567wmf.121.1498802415416;
 Thu, 29 Jun 2017 23:00:15 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.223.162.213 with HTTP; Thu, 29 Jun 2017 23:00:14 -0700 (PDT)
From:   =?UTF-8?B?0KHQtdGA0LPQtdC5INCo0LXRgdGC0LDQutC+0LI=?= 
        <s_shestakov@playrix.com>
Date:   Fri, 30 Jun 2017 09:00:14 +0300
Message-ID: <CAM1TZMGXiDpzt3uhpDaE41KR8GWyjMq=+Mcvz5Zrj0EffNrGrw@mail.gmail.com>
Subject: Bug with automated processing of git status results
To:     git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi!

I am trying to make an automated processing of "git status" results.
I execute the command

git status -z -uno

I expect that it has stable output format. However, it still can print
warnings like

warning: CRLF will be replaced by LF in somefile.xml

I understand that we can turn off core.safecrlf, but it's
inconvinient. It would be better if "git status" command had an
optional parameter that disables any other output besides changed
files.

Thanks!
Sergey Shestakov
Playrix
