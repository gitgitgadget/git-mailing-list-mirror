Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id BFF7A1F62E
	for <e@80x24.org>; Wed, 16 Jan 2019 17:16:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727050AbfAPRQT (ORCPT <rfc822;e@80x24.org>);
        Wed, 16 Jan 2019 12:16:19 -0500
Received: from mail-ua1-f49.google.com ([209.85.222.49]:46064 "EHLO
        mail-ua1-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726986AbfAPRQT (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 16 Jan 2019 12:16:19 -0500
Received: by mail-ua1-f49.google.com with SMTP id e16so2412241uam.12
        for <git@vger.kernel.org>; Wed, 16 Jan 2019 09:16:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to;
        bh=vlA3xVovVthjEVKV57R8lSqI3iflI+8iDD8D8YqifWY=;
        b=WFF5ionWYURS4g22tTZbxmqF1ICUtQkgLUnrIJdJejaCoCBTo4bT2z+AZf+rN+fhRH
         YNOzGzgAn58UH9oXZOdWczQMJlNEln+CTcgFpYL8iM9t0DjUTSZvsJiU3KpHrroWK+aM
         Kfj60V8G6Az5ELg7ybIcXBbjWr5aWvjn8mbQUIUwjXG6sMxDVSam1QZLUSHnbSSlwlYY
         6n+K17So/Ulbsye6d3v81hV4PP3V4KX/MMCPHeg5Vxq7wxSbJ1uFaksXrXaHGQmWq7Ag
         u0UCFZeebpOWdcnfYlS0/K7AFgN/6glCnUOr1V8jpsh9lQHwSgKQM42DSqEIcSbQhWm+
         F99Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to;
        bh=vlA3xVovVthjEVKV57R8lSqI3iflI+8iDD8D8YqifWY=;
        b=D1f12KGzzX6RkHteEeZn8ywKDICmC5CAPri/xUsGUn/kvmaLT/H0fidbGz3n8SYvDn
         87FfSlvgjcsCjz87BHgsqKvcJp9aBV2awnP+bSG3i5djm4bmKIai0Ki8AB/QHLewmoK3
         FVdabbljqdJYwezH2acTxZVb+freUJ1xqG3keChqftlyfIfeWR9GNFrptESNxHKEcF0Y
         WP1xgc/YFfh+vFredAsitg5t/ogczMSo9nGcJQ0dlEezFrSNFyPZQwVI9nLiMTHKRlHk
         Gt+FJRg+zQPypk7dBNeHfgmsfNz/3DEOmKvbMS4e2fsyqOCj17cFrzC1lE9lnBxvV2QE
         8OxA==
X-Gm-Message-State: AJcUukd6kZG2NKVrzxxym1ByizZaBdUFIbreexwDhnHwcTDZGsuCz/9q
        LyI0j//PvHQ27RBf2vdRC9bYOGF+ROwVLsoWf3pnN8ej
X-Google-Smtp-Source: ALg8bN6tmWodhL49ap24D50yPsDoPuV77jqOHWPE1SxfdzzzXcAZ6DZ2yDUPbAbHW9RfmlEnRVYg/pLiQ+l8TcARJtI=
X-Received: by 2002:ab0:44e7:: with SMTP id n94mr4195872uan.76.1547658978050;
 Wed, 16 Jan 2019 09:16:18 -0800 (PST)
MIME-Version: 1.0
References: <CAKuVd4Db8fo2oAFXV-X_ei495cAMPN98S6GFBTndR_bXX-sSkw@mail.gmail.com>
In-Reply-To: <CAKuVd4Db8fo2oAFXV-X_ei495cAMPN98S6GFBTndR_bXX-sSkw@mail.gmail.com>
From:   Tim Hutt <tdhutt@gmail.com>
Date:   Wed, 16 Jan 2019 17:16:07 +0000
Message-ID: <CAKuVd4ALL6=EUVnwPaJ-=CP7z_AAR_j2apod3NaLsOC1q_j2Bg@mail.gmail.com>
Subject: submodule.recurse should apply to clone
To:     git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

For some reason submodule.recurse applies to everything except clone.
Is there a reason for this strange inconsistency?

Cheers,

Tim
