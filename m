Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	FROM_EXCESS_BASE64,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5B7A51F62E
	for <e@80x24.org>; Wed, 16 Jan 2019 10:34:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389200AbfAPKen (ORCPT <rfc822;e@80x24.org>);
        Wed, 16 Jan 2019 05:34:43 -0500
Received: from mail-wr1-f66.google.com ([209.85.221.66]:40477 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731965AbfAPKen (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 16 Jan 2019 05:34:43 -0500
Received: by mail-wr1-f66.google.com with SMTP id p4so6295844wrt.7
        for <git@vger.kernel.org>; Wed, 16 Jan 2019 02:34:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=mSHcmnqnFdF6o74JzYbdYfiJDjVBI6sMsjI0lvAGW0w=;
        b=czVEWhTMeDYr/dTtVBw64QYDeEgWd9uMpO5pkZIZGwiQhTZ8sknRU3TTts+WAc+Re3
         KLg91MG//iLAnsZsvYWo89I+xZxKg6GVvxe2I0sKqLUOeiNeNibuWyq3dq4vIPQAu4cY
         h7TjbcHoy7glRhsuJ046VaQJMp2fQqxkjCflLgFbU1GAskAP7x9L2AbsW9mw5N2YGWbY
         /WwHXjblpGetKbWINLbeIEqVpM1XkoeEso45m00vIyZscLmFKBOtRkcwLVDPG7NiZ1Yl
         teHrwcUJSFO8it7JyWf/Onvd+5T2EU/AJUd8vpm9wCBf0hL7Pt2D/WWkFV1eSppkWWSR
         0FkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=mSHcmnqnFdF6o74JzYbdYfiJDjVBI6sMsjI0lvAGW0w=;
        b=YvK4Ie4VybUoS9EqDJZPBeX7eFi6N7KwHiveiMIPIXs7V1bhDLYCLnWbvmDQuuY6Ic
         GAM6TGzXiVglAvUcp1yU+Iw4llbvmRX64DaULg5Omrq9INpGYUjkIf4oLiCOIF0otW08
         bFvM4AHwK+TqCZY6eh5cLnx1vtY9gPiac5HhDD1wVvqKx1teLkKkGnNG3JJPn/P/pMcD
         keYAAVOF8s01sEuKqRbTBGeEcWcTY5Ha+YqDUidImMS7OpTvaepwZlPL+lZUw4Qrzrr2
         La6lMfAa8hVLUmApm3dBnnjVwrRosPdTJ8h2oaPBxiC+8nDvtHvkHhjhbGDxv9jWs59K
         eAlw==
X-Gm-Message-State: AJcUukc6KOY3gUfnCdqAqfolDeb8ABWhmbdry8ROLEBnScYFbfKsLcqH
        ekywcYwMGcnO0Bmb9LxKyBs=
X-Google-Smtp-Source: ALg8bN6/3qgw07NugxrfKF1RzsANIm/E5Jr1HvluiUimKDMHk3SwQry/qUiVLy5yYxNhSXoteECpgg==
X-Received: by 2002:adf:f308:: with SMTP id i8mr6676291wro.219.1547634881255;
        Wed, 16 Jan 2019 02:34:41 -0800 (PST)
Received: from szeder.dev (x4db4a994.dyn.telefonica.de. [77.180.169.148])
        by smtp.gmail.com with ESMTPSA id 129sm58257414wmd.18.2019.01.16.02.34.39
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 16 Jan 2019 02:34:40 -0800 (PST)
Date:   Wed, 16 Jan 2019 11:34:38 +0100
From:   SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>
To:     Jonathan Tan <jonathantanmy@google.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH v2 2/4] sideband: reverse its dependency on pkt-line
Message-ID: <20190116103438.GG840@szeder.dev>
References: <cover.1547244620.git.jonathantanmy@google.com>
 <cover.1547581039.git.jonathantanmy@google.com>
 <5aa5d047c828a0db10544c706dd595f09db3215d.1547581039.git.jonathantanmy@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <5aa5d047c828a0db10544c706dd595f09db3215d.1547581039.git.jonathantanmy@google.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Jan 15, 2019 at 11:40:28AM -0800, Jonathan Tan wrote:
> A subsequent patch will teach struct packet_reader a new field that, if
> set, instructs it to interpret read data as multiplexed. This will
> create a dependency from pkt-line to sideband.
> 
> To avoid a circular dependency, split recv_sideband() into 2 parts: the
> reading loop (left in recv_sideband()) and the processing of the
> contents (in demultiplex_sideband()), and move the former into pkt-line.
> This reverses the direction of dependency: sideband no longer depends on
> pkt-line, and pkt-line now depends on sideband.

In the last couple of days I noticed occasional but frequent failures
in the test 'leading space' in 't5409-colorize-remote-messas.sh' on
'pu' and on this topic.  Bisect suggests that this patch is the
culprit, but of course bisecting an occasional test failure can't be
completely trusted.

The trace output of the failing test looks like this:

  + git --git-dir child/.git -c color.remote=always push -f origin HEAD:refs/heads/leading-space
  + cat output
  remote: error: error        
  remote: ERROR: also highlighted        
  remote: hint: hint        
  remote: hinting: not highlighted        
  remote: success: success        
  remote: warning: warning        
  remote: prefixerror: error        
  remote:   
  remote: error: leading space        
  remote:             
  remote: Err        
  To /<...>/trash directory.t5409-colorize-remote-messages.stress-4/.
   * [new branch]      HEAD -> leading-space
  + test_decode_color
  + awk 
  < ... snip enormous awk script ... >
  + grep   <BOLD;RED>error<RESET>: leading space decoded
  error: last command exited with $?=1
  not ok 6 - leading space

Notice how that "error: leading space" lines up with the other
messages.  On 'master' that line looks like this:

  remote:   error: leading space        


