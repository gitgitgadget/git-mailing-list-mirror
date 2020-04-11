Return-Path: <SRS0=KYeX=53=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7372CC2BA2B
	for <git@archiver.kernel.org>; Sat, 11 Apr 2020 12:51:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2B9242084D
	for <git@archiver.kernel.org>; Sat, 11 Apr 2020 12:51:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="f86PhvHO"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726069AbgDKMv1 (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 11 Apr 2020 08:51:27 -0400
Received: from mail-ed1-f46.google.com ([209.85.208.46]:44433 "EHLO
        mail-ed1-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726037AbgDKMv1 (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 11 Apr 2020 08:51:27 -0400
Received: by mail-ed1-f46.google.com with SMTP id cb27so5620463edb.11
        for <git@vger.kernel.org>; Sat, 11 Apr 2020 05:51:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to;
        bh=Alsm7v8dC5HrN1ZIcAS7vAjAu+E+F775SsIox1FId3U=;
        b=f86PhvHOlrcvhODXJKYgY9TTCskd6vU9G6No9EeWU0PLWFCajiGBS5QlnIevhaFPIx
         pbGTofmktigATcLrDgVl8Lmvk4li1aPjArVTwwI0puFaZaH7mg7xuBzKTdkoyAy/iOiC
         A8LQ9/5ETG8uP2/NgzOqyOB9kB62LcEXs5nUVfgTnMkDsDXpaNongObXZ5xm4ILkViiR
         GuZgW/RsFwlv+SYFaaT0sT+nq5numEGw0QGFnto1Fe5yEiUxjnDzAWy3M8SJD0ID/YT3
         A7RoQsvt4w4/chO3LNz9Ig4sKl4piFxAEnWepC0nuXuddQyKJGmqRnB0ctv9wZtK/8ke
         0fjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=Alsm7v8dC5HrN1ZIcAS7vAjAu+E+F775SsIox1FId3U=;
        b=kk1MgMJrJKMmUNFLt/3lpT/MPyg9sPHU9p1RPMBO4xakz4tKtSNyrWHrAQhRkKJiFR
         oOqsqIkJZ99a+Du/FL+jqC8pJJMP2N9VRaRkpn1gF33fLRwieiJiXCDlNygjYkAk1Pbf
         DduL8uw7RyzyiSB9AJ86SVvVZKfyTJ4AnCx+8ZoKTeCL72B4sNqAovENIDnMjn96mwJb
         DSAN62GmCi3l27I0O5chogCvYIyVTqXsE5t+9YpKAGSyyBOM5vQrz7jILxr8Ak42midG
         klHu+ZWNeSjBXstVLUsMkWgKELIhAJSEOHXYKV7pMG9pWpJqaqCHfD5YtaCBGgHt8Tyv
         1S3w==
X-Gm-Message-State: AGi0Pua9twU3ItgczJp8EyIRINpJimsXdYIuUOLoOLAjPc9ZOulE2gme
        TpVWegDqQGKPfdtv07Cm9oQ8pztAIzFtDEYSOgIkZypc
X-Google-Smtp-Source: APiQypKoPy6TiSMz67awLuleg6jdp5OFsHDi17nb8A0op4yNT+D5VKQLASf5GcFltOWFBETRUTPlQ2rlEnJoq/69/Rk=
X-Received: by 2002:aa7:d588:: with SMTP id r8mr9263634edq.17.1586609486440;
 Sat, 11 Apr 2020 05:51:26 -0700 (PDT)
MIME-Version: 1.0
From:   rupert THURNER <rupert.thurner@gmail.com>
Date:   Sat, 11 Apr 2020 14:51:15 +0200
Message-ID: <CAJs9aZ-iXUtZoumnMzTFPrc=mtz2+s4EDUKhxw_KQp42h3mxBw@mail.gmail.com>
Subject: configure remote/local as mine/theirs
To:     git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

hi,

the git documentation is so clear withcalling changes "mine" or
"theirs". when configuring a mergetool e.g. kdiff3, and doing a
rebase, these names are not used. instead it is "local", which
is theirs in the rebase case, and remote, which is mine. not
that this is rocket science, and i understand the technical
reason why the names are like this. but anyway i get a nod in
my brain about it sometimes. can i somehow configure git so it
would use "mine" and "theirs" only?

rupert
