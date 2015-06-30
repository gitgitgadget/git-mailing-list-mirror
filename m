From: Stefan Beller <sbeller@google.com>
Subject: Re: [PATCH v4 00/44] Make git-am a builtin
Date: Mon, 29 Jun 2015 17:19:16 -0700
Message-ID: <CAGZ79kadaf7yGYpw3FRMGbybnzorDVFc9EoFY+ww_2ykpszrrw@mail.gmail.com>
References: <1435500366-31700-1-git-send-email-pyokagan@gmail.com>
	<CAGZ79kZyq_BrYKA=+=Qkg9xzXE=2fFr5U_DJFz6GQmm62MxVAA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: "git@vger.kernel.org" <git@vger.kernel.org>,
	Johannes Schindelin <johannes.schindelin@gmx.de>
To: Paul Tan <pyokagan@gmail.com>
X-From: git-owner@vger.kernel.org Tue Jun 30 02:19:22 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Z9jGk-0006FZ-52
	for gcvg-git-2@plane.gmane.org; Tue, 30 Jun 2015 02:19:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752634AbbF3ATR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 29 Jun 2015 20:19:17 -0400
Received: from mail-yk0-f174.google.com ([209.85.160.174]:35670 "EHLO
	mail-yk0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751398AbbF3ATQ (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 29 Jun 2015 20:19:16 -0400
Received: by ykdy1 with SMTP id y1so129861484ykd.2
        for <git@vger.kernel.org>; Mon, 29 Jun 2015 17:19:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=WUllGXNCRi02120+IwJa1sR4mD371heSgv2DHfFI9oM=;
        b=icwT2miuKkMkhrm+dnCvTYlTcoLPklUs0oxq3/SJVqHDUdLQ30rzDF2ZKRG6VlJGjD
         YaR98My3fom2wzKz0Rje4yzd4+MsVA/OGU5Gy0FcIJHSpJU2iZyLH5QPt19VDiEVvmyJ
         l50ASj/bCECizpSpfu9z5VUrXZE4BfBq0R9IWWMlCX2yTn/wZ3HgYQpm9/0AJXHqAXpU
         oIkdTMUcYUfqOZAoRPXH0AcWv/aJmee8sR57QWWRJ6BzrH392nqySV84SvnC4rWHknoI
         PjxJWIig5qDKvl8IDPZYA3eZHdfAh+TxnbIx4fntVxl9NTWz5YGENYhAeJuhomazbpHj
         bLtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type;
        bh=WUllGXNCRi02120+IwJa1sR4mD371heSgv2DHfFI9oM=;
        b=ht9cQZPajNeABdKbGxRV588OjZ3tT6FLePnq91iy6ixj/YhLyE5cv1jAKoFfxU4jFq
         wGn5mc7ihaypOG5PqztD0SVvo2Dvdo9MheyOStmEZLdgKkGjT+M9XCfFXmGmsgyUDp5a
         y7BkLsuSyd4kn50lYZutT8BInkComoEWs7hbdegV8lVt9bsQuMzzoKL+L38IKYHf0eKR
         G/zFOGsZCNR9vD6PCn+crXFb371D4IJwRUWHxp+ixIKWHrCTRIBfO4p+mEi84bwQBRzR
         GTg57rptPVmst/yRDhkhOlRmaqA5O0RXgw/1wRhCJa2lq48Ov8pieY/Hc3AhS+V86jmz
         8Nfw==
X-Gm-Message-State: ALoCoQlqA653PqI9C+Zf5h36pJlijHiFml+u92h2i0Hld0OIV66PXKc8bGsxKt5YcFDnJVqG5riZ
X-Received: by 10.129.111.65 with SMTP id k62mr22898781ywc.88.1435623556082;
 Mon, 29 Jun 2015 17:19:16 -0700 (PDT)
Received: by 10.37.4.80 with HTTP; Mon, 29 Jun 2015 17:19:16 -0700 (PDT)
In-Reply-To: <CAGZ79kZyq_BrYKA=+=Qkg9xzXE=2fFr5U_DJFz6GQmm62MxVAA@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/273031>

On Sun, Jun 28, 2015 at 10:01 PM, Stefan Beller <sbeller@google.com> wrote:
>> This is a re-roll of [WIP v3]. This patch series is now out of WIP, as ...
>
>> This WIP patch series rewrites git-am.sh into optimized C builtin/am.c, and is
>> part of my GSoC project to rewrite git-pull and git-am into C builtins[1].
>>
>
> I assume the later is just a left over from an old cover letter. :)

The series makes sense to me, all the comments were minor nits.
