From: =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Subject: Re: [PATCH v4 12/16] index-helper: kill mode
Date: Sat, 16 Apr 2016 18:08:19 +0200
Message-ID: <CACBZZX4VxyrO+B+MQYbR32-Dp_KpEABeFA67g22DNzX-YKzmXg@mail.gmail.com>
References: <1460507589-25525-1-git-send-email-dturner@twopensource.com> <1460507589-25525-13-git-send-email-dturner@twopensource.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git <git@vger.kernel.org>,
	=?UTF-8?B?RHV5IE5ndXnhu4Vu?= <pclouds@gmail.co>,
	Ramsay Jones <ramsay@ramsayjones.plus.com>
To: David Turner <dturner@twopensource.com>
X-From: git-owner@vger.kernel.org Sat Apr 16 18:08:49 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1arSm8-00016L-Im
	for gcvg-git-2@plane.gmane.org; Sat, 16 Apr 2016 18:08:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751611AbcDPQIk (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 16 Apr 2016 12:08:40 -0400
Received: from mail-qk0-f193.google.com ([209.85.220.193]:35558 "EHLO
	mail-qk0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751596AbcDPQIj (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 16 Apr 2016 12:08:39 -0400
Received: by mail-qk0-f193.google.com with SMTP id u190so5727857qkh.2
        for <git@vger.kernel.org>; Sat, 16 Apr 2016 09:08:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=dUpnrfISbnjYz5Hu5sQK4vV51Mkj3WYl/tiP+y4lC2Q=;
        b=tMNC04SelRTBEXm7z+oga9ywSAxTOgd0RKWrJy1VP6TVk2UQz7nZVkft7W60YqFLMq
         4igRD1xDnAt5BkXd7mMXRPTuw2BBWFVakgQtMg7eqm/a+0CECEdUbl5jElxWKHR4h1qT
         iWVhxYYS5/lVIBI2/Iit5AdvBjUcb1DzqRxaQi7OGg/Qj1gBnT6RNKVtEy6jJO2gxG7G
         4qE64y/01xv0K1x7Y6D086oacVtIZ6eMfAMDCvj7xbtXIFyPq5eQMRwEqcoAG3qTxTEs
         5c+SvgEB6bHq4l6Q61rSp/F4hzscgfZvRgB5c/1hF42w3hQqtQG4JkKRPDAQH9OMgKim
         eadg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=dUpnrfISbnjYz5Hu5sQK4vV51Mkj3WYl/tiP+y4lC2Q=;
        b=VnmreCG+Y9a4vW5SLAGaKIa00h40BuNalXsJCY4weq2xaxJvmi19LrgDNqF1Av8QXk
         pXtTtDeliRrgLiH6kynFYt7KgeVomTmmlSku+YBuiMjFfaOZpSzWsZEa30bCw66ZOx9t
         z7aqhJb8qS3qt1eR2QwCUCnLFLAI066j4rdQhkT6qqPlq+S1fg+g+3pEfJIpsZKLIymM
         MKWGOe5UaRr4BUleaHhZtw2s/KM8BZd4abb+7UANEnhIt77t6wChdSniYLbkbOlGUlMy
         xrPgW1tpHRlOODxCQHTGN68yyaolVmCNG0G73OwHOubTqc2vIJkuq5Q7it9tqCj5rS51
         3r7Q==
X-Gm-Message-State: AOPr4FWS5ktr9tnEwTH0jgKQ+s1gx8SPX4UCPs86/HhLHe8l8RB7LUtioi0+JFwMT/D1Vux2wdyjF7T1XEkMgA==
X-Received: by 10.55.16.12 with SMTP id a12mr32485125qkh.31.1460822918680;
 Sat, 16 Apr 2016 09:08:38 -0700 (PDT)
Received: by 10.55.77.82 with HTTP; Sat, 16 Apr 2016 09:08:19 -0700 (PDT)
In-Reply-To: <1460507589-25525-13-git-send-email-dturner@twopensource.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/291728>

On Wed, Apr 13, 2016 at 2:33 AM, David Turner <dturner@twopensource.com> wrote:
> Add a new command (and command-line arg) to allow index-helpers to
> exit cleanly.
>
> This is mainly useful for tests.

Both --kill and --autorun are missing documentation in
Documentation/git-index-helper.txt.
