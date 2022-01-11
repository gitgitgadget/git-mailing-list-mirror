Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 62957C433EF
	for <git@archiver.kernel.org>; Tue, 11 Jan 2022 02:52:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232348AbiAKCwq (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 10 Jan 2022 21:52:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37044 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231590AbiAKCwn (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 10 Jan 2022 21:52:43 -0500
Received: from mail-io1-xd31.google.com (mail-io1-xd31.google.com [IPv6:2607:f8b0:4864:20::d31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4252AC06173F
        for <git@vger.kernel.org>; Mon, 10 Jan 2022 18:52:43 -0800 (PST)
Received: by mail-io1-xd31.google.com with SMTP id u8so20538132iol.5
        for <git@vger.kernel.org>; Mon, 10 Jan 2022 18:52:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20210112.gappssmtp.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=THtxUPVMDYykbFMa2MrNUn7ZyjIXM2NGTSJYc315LzI=;
        b=JRFfa4mX/frIrTw2jcaafWo4M68G3iMxcPhOMdgMGQvb0sZ04hsIy6p9ls9hstXwop
         Ije5vDQfXHp1P6bnw642kZLUwy63KKZXqtpKsy+Ng+VJp2ysWmGSe/zjtHITiR7rS8BS
         eQqNeIv9D2SyD7Zs0d5kIUvT5w4PZn1jGl/PGQLYKyr3YQLrGSC5PA1Eucqilh1qGyyM
         2MK3OUPRzfA4jifsmWZh6zoi/G8T+H6XDfuqJjomTbDFqBo1W8kNHpXdKpjv4e2Y+oBh
         kzK0rgamZtXeV2WZwwMIig7nUAw/7l+zuf1cCwcQ/yIaNGyjtTfT2mr5qLhgMVNJXdyo
         4ozA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=THtxUPVMDYykbFMa2MrNUn7ZyjIXM2NGTSJYc315LzI=;
        b=a7YrJIti9c80CV4SfZgHspCi93l+Ve5Q7O9efIKRx2FGJQQ/MQhpFGpZeodjTS5Oqn
         oW77BqBarCLQ0gWSuOc+Ak8gjr0Cv3mhqx+7M6Ny+NDUZLmWxVF0WrtEHWjFdF8cMZjo
         bh8nySjKMRNQcyZzsjpthCtLxqzgThdlusqDjW9x8XcPmC0xd3JjM30O4Tf4f1tXdaGn
         DJlqVO2s3RnGkDkvlGa9iCaS7OyZw2nJZoPa/DOwAJosTIb/JEZ67rp170hSuuMET/fv
         eh9XzcCvHW0OL89+6bHdESXxRbOvCISZJbFpYYRrV8opMeQsqklG17c8FHyXLOYObcIU
         0G4Q==
X-Gm-Message-State: AOAM532i6fOTvr7mWNtz+ZsV+4FUVes1vAzTPvHB1XUcD2qRpNimNXJw
        IOmRdlZB2b4j2OopYGaAoD4QTcoXppwFwA==
X-Google-Smtp-Source: ABdhPJwLF0feemcoX7nW/0HN3myQKnJVas1VdgBXCXNl9JU5xQACyAByORFjbCYsKKC9051CxW5PNw==
X-Received: by 2002:a02:9308:: with SMTP id d8mr1214610jah.52.1641869562700;
        Mon, 10 Jan 2022 18:52:42 -0800 (PST)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id l3sm3485905ilo.17.2022.01.10.18.52.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Jan 2022 18:52:42 -0800 (PST)
Date:   Mon, 10 Jan 2022 21:52:41 -0500
From:   Taylor Blau <me@ttaylorr.com>
To:     rsbecker@nexbridge.com
Cc:     git@vger.kernel.org
Subject: Re: [BUG] Re: Git 2.35.0-rc0
Message-ID: <Ydzw+RqR6IfbT/oM@nand.local>
References: <00fd01d80691$c87e3ad0$597ab070$@nexbridge.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <00fd01d80691$c87e3ad0$597ab070$@nexbridge.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Jan 10, 2022 at 09:20:15PM -0500, rsbecker@nexbridge.com wrote:
> Hi All,
>
> Git 2.35.0-rc0 is not portable:
>
> uncompress2(uncompressed + block_header_skip, &dst_len,
>                    ^
> "/home/ituglib/randall/jenkins/.jenkins/workspace/Git_Pipeline/reftable/bloc
> k.c", line 213: error(114):
>           identifier "uncompress2" is undefined
>
> This is not a POSIX compliant call.

uncompress2() isn't a POSIX thing, it's part of zlib IIUC. The new
caller is in the reftable code, which provides a build knob
NO_UNCOMPRESS2 that you can use if your version of zlib does not have
uncompress2().

uncompress2() was added to zlib back in 37281ac (Add uncompress2()
function, which returns the input size used., 2016-11-15), which first
appeared in version 1.2.9.

If your system doesn't have a modern-ish zlib, you may try building with
that knob, or upgrading your system's copy of zlib. And if NonStop
doesn't have a modern zlib available at all, we should modify the
NonStop section of config.mak.uname.

Thanks,
Taylor
