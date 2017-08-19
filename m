Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.5 required=3.0 tests=AWL,BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD,T_DKIM_INVALID shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C5F8E1F667
	for <e@80x24.org>; Sat, 19 Aug 2017 19:17:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751626AbdHSTRu (ORCPT <rfc822;e@80x24.org>);
        Sat, 19 Aug 2017 15:17:50 -0400
Received: from mail-wm0-f43.google.com ([74.125.82.43]:35469 "EHLO
        mail-wm0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751533AbdHSTRt (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 19 Aug 2017 15:17:49 -0400
Received: by mail-wm0-f43.google.com with SMTP id m85so21686374wma.0
        for <git@vger.kernel.org>; Sat, 19 Aug 2017 12:17:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc:content-transfer-encoding;
        bh=iFDeNsAsEASjqrKTnXQapkTDt+UeMxw0lvlVJe5BQUg=;
        b=TgRlScYZGLSeJHQXpYirPnibIkt9eEsNUAFaWeXXOZO3eogBYuTrAlhIhAPRPW2J5I
         gGfYr6/vtdAUAX6IkHufAkWzFyYQw50embLcR3Oz+9rtk5FkI7kB6nXX22WLReF7CvkQ
         5HGljsWHiVUxx3AZ1pGpH4KEx6duk4+LekFjnMokmlFjaRHhyTnwxfFlHOGtPcM1C4Gk
         c10JoV52X2hP+rmX8f0eFPUkU0ni8H7pgmMyKQIER5oSiJ61L5XvS0G2y38zhkk2n87C
         6rvUXzSrxonkygPEcWdPjS74WZXwItU28pH9GcAka9TB09sIu+5tGnzqlS8m6yfzQ2AA
         kwdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:from
         :date:message-id:subject:to:cc:content-transfer-encoding;
        bh=iFDeNsAsEASjqrKTnXQapkTDt+UeMxw0lvlVJe5BQUg=;
        b=QRv4SNPMTpBVK1RZzJk+EIisrpVaiANKVc89qOUwgRTOk0/C0d6I0scPPsT1Fcrbh+
         EZ+reLrbg6PaHdP1kS8lW4HyI/EJxdP696lgaAJX8ImiDwU2KmCPwUlGIVj7CP8LJkQH
         89IUhp/Cq7av0d47TzG2HAcOyHD5XVhQTvBhShcnKeNUT+622swdtxkm8LFGnbNGnY4+
         XndWpzqPM2gGl40u1zOsr3caxhst7p5a9fqVk1sBVeGMp/oIDWQQMhHADeP6c9+2lGpK
         j6Ggy1gEFbwEvxvtZ0bGc7uIj8fL7lbO7JcgjmniRyhV0MNqWGpoAgqDriTOqFvurtiP
         xFiQ==
X-Gm-Message-State: AHYfb5iTEwRT+kx7eWYIVp4Agf8mX6m9F4L4/Cgrk2kQbP0tP0P95BFV
        Z54iD7ewUE3INAn9aZTnEKaAeEHtPA==
X-Received: by 10.28.30.77 with SMTP id e74mr3593254wme.172.1503170268458;
 Sat, 19 Aug 2017 12:17:48 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.28.24.130 with HTTP; Sat, 19 Aug 2017 12:17:18 -0700 (PDT)
In-Reply-To: <CAH8yC8mpPRN2y1k07_Jk9QP88=gpLKNWfV3W0QQwXTWxyL5STQ@mail.gmail.com>
References: <CAH8yC8=i33rtopVt=sgg0k+P4JQO+1EVpPJ+u5CPGEXKvZ+PBA@mail.gmail.com>
 <xmqqbmnba50e.fsf@gitster.mtv.corp.google.com> <CAH8yC8mpPRN2y1k07_Jk9QP88=gpLKNWfV3W0QQwXTWxyL5STQ@mail.gmail.com>
From:   Patryk Obara <patryk.obara@gmail.com>
Date:   Sat, 19 Aug 2017 21:17:18 +0200
X-Google-Sender-Auth: nZIcOlP6mmRcoDVMURWBblnS_fI
Message-ID: <CAJfL8+QbMPutRLjKMkNaEmvb1pr+8S3-wR-xhk1Y=LgXsW0DLg@mail.gmail.com>
Subject: Re: Please fix the useless email prompts
To:     noloader@gmail.com
Cc:     Git List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Why you can't just set username as name and username@hostname as mail?
You'll do it once and it will be preserved for future. If you use
various accounts for testing, use --system flag for config to store
the values in /etc. If you don't want to modify the environment, use
--local (or no flag) to preserve name in your cloned repository only.

--=20
| =E2=86=90 Ceci n'est pas une pipe
Patryk Obara
