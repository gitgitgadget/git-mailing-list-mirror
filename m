From: =?UTF-8?B?5oOg6L22576k?= <huiyiqun@gmail.com>
Subject: Re: [PATCH v3/GSoC 2/5] path.c: implement xdg_runtime_dir()
Date: Fri, 25 Mar 2016 22:23:04 +0800
Message-ID: <CAKqreuxFGXZuoBT=N48KKBkwft6aDQ-z7wOR4uUyK=3fbs-yRg@mail.gmail.com>
References: <1458728005-22555-1-git-send-email-huiyiqun@gmail.com>
	<1458728005-22555-2-git-send-email-huiyiqun@gmail.com>
	<20160325095923.GB8880@sigill.intra.peff.net>
	<CAKqreux8FHdJoKDishjQkbi9g1oUc265EUK4nOJ_sgeFivGSNA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git List <git@vger.kernel.org>, Your friend <pickfire@riseup.net>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Fri Mar 25 15:27:12 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ajSe3-0001V4-MC
	for gcvg-git-2@plane.gmane.org; Fri, 25 Mar 2016 15:23:24 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753298AbcCYOXG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 25 Mar 2016 10:23:06 -0400
Received: from mail-ob0-f194.google.com ([209.85.214.194]:34646 "EHLO
	mail-ob0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751831AbcCYOXF (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 25 Mar 2016 10:23:05 -0400
Received: by mail-ob0-f194.google.com with SMTP id c10so1297648obp.1
        for <git@vger.kernel.org>; Fri, 25 Mar 2016 07:23:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc;
        bh=7XwBfinzLbBWTUapASoD8uBBXDvxyS3ueqHuy949iIU=;
        b=TF9h1apTKKbhvQMg6R4ObIv62acoZBNu0wlSZDczh2jxe8LX3GoLWWfTvWPlSc4ytM
         Gy4HOIsqudxZZuy3ukWdsN3NoGO9ReIqmGe+42BkqqCMHfD2EH+tHvLvBMvgnbC/ef0W
         MkuJ0lE7CZCIlmnayvhGRAReUnseIdV/Selki83kdUr4UDJrAH2dKmYueIAMXj6OMfNI
         OJ7oih7X+izVUyRZ8AnE9Oi672cTq/cpnTK8+awueykNerEvBvMUlSTwhr89W0cSEY1e
         FBU1wGjk3Tc9cFE+1r/iQHtRRJSXpjSFU+tBYOAf2G13GMBeoWshcw6AfBAYp7OCDTA8
         gHYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc;
        bh=7XwBfinzLbBWTUapASoD8uBBXDvxyS3ueqHuy949iIU=;
        b=fk9hBJAKnmIqzyRv1fRKGd0Ku3GzE8bZGEV/7e7kRAh1T0dFfOu9UuCLKEEfxlJsG2
         mlKgnFPSwHxAQySu6qW/Mf7w5ocORPx8PVc8montU0ccElDZj+FZ3KPNxod8cjfRZlrR
         4MokoqQZbCvotxgHxUhEci4hmer8BCYiqHxF1Grp2k7tnT24b1WD5/OQLFn2TVF6SMTv
         wkMeA4CS8EvZBibDwX79mIZnHri4+6rU2oNF0xN7bM2cYiijwvqUUQDxKjynfQhPncwb
         EsK0IlJn9DE7u5sI/omB/OhBPowDtRulioi/sh4w9Co/GgNarb7dfabPKNobvydAiWKy
         ZUeQ==
X-Gm-Message-State: AD7BkJJpdrfsj98OJ+/h9nBd6UXgfOVXe0czs2nzwcIw7TFJB75BJ4Z7wY7eIorfgDszBWKzk8x4ZPRxt2Kisg==
X-Received: by 10.182.24.170 with SMTP id v10mr7188102obf.55.1458915784298;
 Fri, 25 Mar 2016 07:23:04 -0700 (PDT)
Received: by 10.157.27.250 with HTTP; Fri, 25 Mar 2016 07:23:04 -0700 (PDT)
In-Reply-To: <CAKqreux8FHdJoKDishjQkbi9g1oUc265EUK4nOJ_sgeFivGSNA@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/289888>

> I find there are some similar leakage in this file. I'll fix them in
> another patch.
>
> Do you think we need some additional comments for the release of strbuf?

For example, in strbuf.h.
