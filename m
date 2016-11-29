Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 895EB1FF6D
	for <e@80x24.org>; Tue, 29 Nov 2016 09:52:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756703AbcK2JwF (ORCPT <rfc822;e@80x24.org>);
        Tue, 29 Nov 2016 04:52:05 -0500
Received: from mail-wj0-f169.google.com ([209.85.210.169]:35323 "EHLO
        mail-wj0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751522AbcK2Jv5 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 29 Nov 2016 04:51:57 -0500
Received: by mail-wj0-f169.google.com with SMTP id v7so139951437wjy.2
        for <git@vger.kernel.org>; Tue, 29 Nov 2016 01:51:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:from:date:message-id:subject:to;
        bh=GmG0PuNnP4siJvdMb0MXoIPVv9a72rKQx/evu5rkn8o=;
        b=emyEqD/Th8EkZ7xY5CGYNOFwxt5SQEqYu5MTawJ2qqK+jTp15ZDaD8ObScCxEYUfHd
         xnKKHvYpX4AeP1pt5/JHrMye6MfZW/09a2silBRnNlD2UR+DAWupe3eWtslzp3CaBpmn
         D8VcEJUEDd/BfHTJfyNUACIWDp3NygHfxKeTsLou3rtlb7GA5FfUv5zu7tiNewWaKEIi
         WhQdcfwpJR/tvoZJ+bYaDZOzHtK293d5G3dT7bsdbvnniOz+UVmLM4ELzTThiOStXZjx
         2jMAw0gt4b6JAYsyTVHAD9c9w0MXLfPC7xvFVbwSQvhLIKR+Fqd2qKSuS356T3B/h4JG
         cURQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=GmG0PuNnP4siJvdMb0MXoIPVv9a72rKQx/evu5rkn8o=;
        b=YhVzEnKj9cJ5Yad4VF18FhotYMKxdz7Kcv7dDOVgi+vBGS2TF3CyvJsbyHVMVwyDvo
         39u2CXgaOa/EOsCYgE2PKyt3wJSvYydt76a1ekp1EiiGgFDM0Tl8yP+XhOUO0VyM5mcf
         3M+iMIw+XmnQxMQzV2bwpnaYvRGZ9j95qenDvZBmehjD7GLZxOtbWdHMeC8mUXUqqcso
         ZoQ2qjOsoVCJN5XZxEaad08bG3mDmQ9gRn7OgqYQ3xtluLIXBf10W2ur0QDO97AqrIvP
         STempz0Btw1DwgEmJY8tKoGoLx8zCtpbYRTlq82ajhyX4fOtR/4dTPbLQ365s1va7o9M
         Gl1Q==
X-Gm-Message-State: AKaTC02lgINAgwYJHr2EY3N37f0FwqVNJEkCMPqpCKoNWeQwvtlSEbOFQx11VFn0X2c7Ecr6omCASz6ek/GH0Q==
X-Received: by 10.194.246.170 with SMTP id xx10mr3231558wjc.174.1480413116065;
 Tue, 29 Nov 2016 01:51:56 -0800 (PST)
MIME-Version: 1.0
Received: by 10.80.183.136 with HTTP; Tue, 29 Nov 2016 01:51:55 -0800 (PST)
From:   Alessandro Renieri <a.renieri@gmail.com>
Date:   Tue, 29 Nov 2016 10:51:55 +0100
Message-ID: <CAKXGFGMGqnGJSEBx8=FXfG3pGEcpFGjLNUH23VTo4LEo75kTKg@mail.gmail.com>
Subject: gitk crashes on RHEL
To:     git@vger.kernel.org
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Redhat Enterprise gitk returns the following error when launched:

Error in startup script: unknown color name "lime"
    (processing "-fill" option)
    invoked from within
"$progresscanv create rect -1 0 0 $h -fill lime"
    (procedure "makewindow" line 201)
    invoked from within
"makewindow"
    (file "/..../bin/git-exe/bin/gitk" line 12434)

The fix is to change lime with {lime green}

Regards
