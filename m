Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD,T_DKIM_INVALID
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C9A651F71B
	for <e@80x24.org>; Mon,  1 Aug 2016 09:09:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752065AbcHAJJ3 (ORCPT <rfc822;e@80x24.org>);
	Mon, 1 Aug 2016 05:09:29 -0400
Received: from mail-vk0-f49.google.com ([209.85.213.49]:36186 "EHLO
	mail-vk0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750997AbcHAJJ2 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 1 Aug 2016 05:09:28 -0400
Received: by mail-vk0-f49.google.com with SMTP id n129so94506108vke.3
        for <git@vger.kernel.org>; Mon, 01 Aug 2016 02:09:27 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:sender:from:date:message-id:subject:to;
        bh=zPr82h1RyHbLliNgMNk4gjbiInPWhS2vSbZ2ZQgoa+s=;
        b=PUiy2VlphbvDcxtGyBD3rmwbJnpTLTJh87NEH2Lzend4ojIiR5WsOYNRAAGh4YYau3
         T+7FanGz13CX7u77XNLGoNw5edoC2jkxkLH9y5KEmJbRRebYNkvIIK5C6fmeHmgS3zId
         UNmddmJi5yw0vx/WXBQMAHIidkz6ExVl58sz7J1AxeB5VkQh6kO5RZxgnhjUoN9fs6sM
         jUPL1Ijz20ZHFUkWRS7HRUmwM+StWCS/kFHgqAHHTuuiA7Y2hFx21AZywNq+bqvw7AaF
         X4PxM0+6Ni0rNSBH2VoLxkQZdQ2v4jNcJQl0zer0oKgzMlur6kFsWJ9xH0hYnTeopVbx
         mLTg==
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:sender:from:date:message-id:subject:to;
        bh=zPr82h1RyHbLliNgMNk4gjbiInPWhS2vSbZ2ZQgoa+s=;
        b=JLj7MGuezwf4/idVCmWE8aRgvGeCC1VZhJqDskmuMLCAZB6XgJNDU1GZUo04a16Puc
         ERy37VR54tamFxL3THej90RwHGDYEwPXu8VJDwv0dITON3VKXSuac18HgFlowxm1fIAO
         KnRSwQ6QVF46IJfFWHnmg8Vl3y3ns9Mja1mLo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:sender:from:date:message-id:subject
         :to;
        bh=zPr82h1RyHbLliNgMNk4gjbiInPWhS2vSbZ2ZQgoa+s=;
        b=OYuGaJ+ElbT7MEOx4NUAfYowrperhFX74M2yuLbJD6VO/9ftCSvDF5V6dMS5dtoR0w
         ykwuV9+Xxj0cfwYSfaWbnOeJA07R3Ui+XwmSmQhGHWF7q/jpMytekaYhUp5JgbrLFspf
         aJhzlHJDwYrM4XjRpsRW8XjZqYqbJSoNk8DbEh9raV2g1B+TcqP4Va2Zn/c3rvnn3zCL
         EdckOWOZEZclNCQJIqMq0KkZ10YM7uOGNtI49t9v1jNvJZPKX0lpKB3ItET3ixr6kyaA
         dSixwCUWmI9hpqewUb/rPTET1czVvDR+lNTHSoBxxKOz8FA9rDaL5/ffdvJn1iqIY9MQ
         vHiA==
X-Gm-Message-State: AEkoouvN8IIZQEnbWhq3bjHX78oBU4rUkCliJeCEK/EBpJwGgTWrhgKfuaqDy2BoY7xDnfxg+zcey441dorGLblx
X-Received: by 10.31.188.203 with SMTP id m194mr26029599vkf.120.1470042566927;
 Mon, 01 Aug 2016 02:09:26 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.159.34.167 with HTTP; Mon, 1 Aug 2016 02:09:07 -0700 (PDT)
From:	Michael Giuffrida <michaelpg@chromium.org>
Date:	Mon, 1 Aug 2016 02:09:07 -0700
X-Google-Sender-Auth: n0YUGuV4iUuyFVK6KWy6ukDsUs8
Message-ID: <CACi5S_0QGEgnijGyaBeZxOSobdwfA+d-wa-jrHs64Va097mnRQ@mail.gmail.com>
Subject: git grep -P is multiline for negative lookahead/behind
To:	git@vger.kernel.org
Content-Type: text/plain; charset=UTF-8
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

Negative lookahead/lookbehind with `git grep -P` considers the
surrounding lines of an otherwise positive match. This differs from
`grep -P` behavior. It does not repro for *positive*
lookahead/lookbehind.

Example:
$ echo -e 'Bar\nBar Baz\nBat' > test.txt && git add test.txt
$ git grep -P 'Bar(?!\sB)' test.txt  # Find 'Bar' not followed by '\sB'

With regular grep, this works:

$ grep -P 'Bar(?!\sB)' test.txt
Bar

Because \s includes \n, the negative lookahead unexpectedly finds the
B on line 2, and therefore line 1 fails to match the full expression.

Positive lookahead works like `grep -P`, in that it isn't unexpectedly
multiline:

$ git grep -P 'Bar(?=\sB)' test.txt  # Find 'Bar' followed by '\sB'
test.txt:Bar Baz
$ grep -P 'Bar(?=\sB)' test.txt
Bar Baz

Is this expected behavior, and if so, why/where is this documented?

git: git version 2.8.0.rc3.226.g39d4020, also 2.9.2.517.gf8f7adc, both
with libpcre
grep: grep (GNU grep) 2.16
