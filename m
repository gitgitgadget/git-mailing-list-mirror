Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D97D0C61DA4
	for <git@archiver.kernel.org>; Fri,  3 Feb 2023 12:30:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232835AbjBCMaL (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 3 Feb 2023 07:30:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39366 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232827AbjBCMaJ (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 3 Feb 2023 07:30:09 -0500
Received: from mail-ej1-x62b.google.com (mail-ej1-x62b.google.com [IPv6:2a00:1450:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F3EB468AE3
        for <git@vger.kernel.org>; Fri,  3 Feb 2023 04:30:06 -0800 (PST)
Received: by mail-ej1-x62b.google.com with SMTP id ud5so14926118ejc.4
        for <git@vger.kernel.org>; Fri, 03 Feb 2023 04:30:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=AdRK3Nb8KtLpmkWNQ8kkkPvtzcCquZe1yo2WbDUVKoM=;
        b=IOeXsjaVUkjLUcHLmwxtNu5E5gxjT95iurBdJoF4EaYc3po7WOuf4RKzRRfANX+iwR
         qJGyyiYZkgSyWYvkhH428r+oF3fy3Ec/6KZaCKDsG3b0CCCgTUPaHSmzy4THUSr977ho
         HluhWwcbEKGnVAN7b5qZXjaqmH/NIUd9jmkcgMEe+mMD5JFIn9RdAcBZo/90lzjnSErE
         BX7tXBPBy4iT6rka5iWIkNdqKDRI2688qYszl7mhSFdI1B8eU0EcZX6PhtyfmjIp2ivj
         7tiT+XsmGGqLZn4RjoOfPjhlHZyhWpThSztcCLsCuHk3z8Brw/L+SA8GyjESjlFJeWIO
         +cCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=AdRK3Nb8KtLpmkWNQ8kkkPvtzcCquZe1yo2WbDUVKoM=;
        b=NZdUAI4iisASjtJvZn+u0FBZo4qNyVvnugEdVJfha1GCao5Whtyp9A4yY8cLwaTAER
         2XOv0z5JX0XFWw3/4QpBJiD6oHGwmfOuW4viBBTwLlq6EFbAOymbvCvOrGW/ZDRE0lkL
         aAiqS71NQF/KAM5PNXhCBDcYoN+/0ZVuVE+hCl6YU9l456i1Y1icsAuZErWUN4gWSOqz
         oEm1/PJn0I6beNI9iey9TP+iGrm5Iydp957/VEeZzSm9JJRTdnNXsmf83QRkr+0tA/a/
         m2gxsgd6ylwutbfPSEVp+za4IVY63Yq54FGATH72kfE/KFkZXz4TZKUCEZYwXMPpvWSY
         t9tw==
X-Gm-Message-State: AO0yUKUDBIqhXYjsN2+59S+edHuZDp9YWUrAh4cNtAf4eRC5/npE4d//
        w62xEYVKAeUQi5UCk5aY5TCfk9Gwv+8eLhVF/nvIHmWcfCs=
X-Google-Smtp-Source: AK7set+ZcLVwiUaGICn/UA0hUb4jxrFVHUef8A40FjYghIpBFvglHpYQVWsrj/7c5MEKpuU1O283idqZzBFIiC8KBgA=
X-Received: by 2002:a17:907:2cd0:b0:883:24a7:17b1 with SMTP id
 hg16-20020a1709072cd000b0088324a717b1mr2929715ejc.63.1675427405520; Fri, 03
 Feb 2023 04:30:05 -0800 (PST)
MIME-Version: 1.0
From:   Diogo Fernandes <diogoabfernandes@gmail.com>
Date:   Fri, 3 Feb 2023 13:29:29 +0100
Message-ID: <CADPR2CUgrO6ius5ss9Mgk8Zktf+4zQDq0vP4EEKOMku7K=V6FA@mail.gmail.com>
Subject: Bug Report: Superfluous Tab Characters
To:     git@vger.kernel.org
Content-Type: multipart/mixed; boundary="0000000000005a77e405f3cad712"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

--0000000000005a77e405f3cad712
Content-Type: text/plain; charset="UTF-8"

Dear git team,

I have run into a bug where git seems to be adding superfluous tabs to
the end of filenames that contain a space. I have attached the output
of `git bugreport` for your review. Feel free to have a look
https://github.com/trufflesecurity/trufflehog/issues/1060 for
additional context.

Thanks.

Regards,
Diogo Fernandes

--0000000000005a77e405f3cad712
Content-Type: text/plain; charset="US-ASCII"; name="git-bugreport-2023-02-02-1145.txt"
Content-Disposition: attachment; 
	filename="git-bugreport-2023-02-02-1145.txt"
Content-Transfer-Encoding: base64
Content-ID: <f_ldoi3ztc0>
X-Attachment-Id: f_ldoi3ztc0

VGhhbmsgeW91IGZvciBmaWxsaW5nIG91dCBhIEdpdCBidWcgcmVwb3J0IQpQbGVhc2UgYW5zd2Vy
IHRoZSBmb2xsb3dpbmcgcXVlc3Rpb25zIHRvIGhlbHAgdXMgdW5kZXJzdGFuZCB5b3VyIGlzc3Vl
LgoKV2hhdCBkaWQgeW91IGRvIGJlZm9yZSB0aGUgYnVnIGhhcHBlbmVkPyAoU3RlcHMgdG8gcmVw
cm9kdWNlIHlvdXIgaXNzdWUpCgokIG1rZGlyIHRlc3QKJCBjZCB0ZXN0CiQgZ2l0IGluaXQKJCBl
Y2hvIGZvbyA+ICJmaWxlbmFtZSAyIgokIGdpdCBhZGQgImZpbGVuYW1lIDIiCiQgZ2l0IGNvbW1p
dCAtbSAidGVzdCIKJCBnaXQgbG9nIC1wIHwgZ3JlcCAiKysrIiB8IHh4ZCAgIyAweDA5IGlzIGEg
XHQgY2hhcmFjdGVyIHRoYXQgaXMgYmVpbmcgYWRkZWQgdG8gYSBmaWxlbmFtZSB3aXRoIGEgc3Bh
Y2UKCjAwMDAwMDAwOiAyYjJiIDJiMjAgNjIyZiA2NjY5IDZjNjUgNmU2MSA2ZDY1IDIwMzIgICsr
KyBiL2ZpbGVuYW1lIDIKMDAwMDAwMTA6IDA5MGEgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgLi4KCldoYXQgZGlkIHlvdSBleHBlY3QgdG8gaGFwcGVuPyAoRXhwZWN0ZWQgYmVo
YXZpb3IpCgokIGVjaG8gImZvbyIgPiBmaWxlbmFtZTIKNCBnaXQgYWRkIC4KJCBnaXQgY29tbWl0
IC1tICJ0ZXN0IgokIGdpdCBsb2cgLXAgfCBncmVwICIrKysiIHwgeHhkCgowMDAwMDAwMDogMmIy
YiAyYjIwIDYyMmYgNjY2OSA2YzY1IDZlNjEgNmQ2NSAzMjBhICArKysgYi9maWxlbmFtZTIuCgpX
aGF0IGhhcHBlbmVkIGluc3RlYWQ/IChBY3R1YWwgYmVoYXZpb3IpCgpBIHRhYiBjaGFyYWN0ZXIg
aXMgYmVpbmcgYXBwZW5kZWQgdG8gZmlsZW5hbWVzLgoKV2hhdCdzIGRpZmZlcmVudCBiZXR3ZWVu
IHdoYXQgeW91IGV4cGVjdGVkIGFuZCB3aGF0IGFjdHVhbGx5IGhhcHBlbmVkPwoKQSB0YWIgY2hh
cmFjdGVyIHNob3VsZCBub3QgYmUgYXBwZW5kZWQgdG8gZmlsZW5hbWVzLgoKQW55dGhpbmcgZWxz
ZSB5b3Ugd2FudCB0byBhZGQ6IE5vLgoKUGxlYXNlIHJldmlldyB0aGUgcmVzdCBvZiB0aGUgYnVn
IHJlcG9ydCBiZWxvdy4KWW91IGNhbiBkZWxldGUgYW55IGxpbmVzIHlvdSBkb24ndCB3aXNoIHRv
IHNoYXJlLgoKCltTeXN0ZW0gSW5mb10KZ2l0IHZlcnNpb246CmdpdCB2ZXJzaW9uIDIuMzkuMQpj
cHU6IGFybTY0Cm5vIGNvbW1pdCBhc3NvY2lhdGVkIHdpdGggdGhpcyBidWlsZApzaXplb2YtbG9u
ZzogOApzaXplb2Ytc2l6ZV90OiA4CnNoZWxsLXBhdGg6IC9iaW4vc2gKZmVhdHVyZTogZnNtb25p
dG9yLS1kYWVtb24KdW5hbWU6IERhcndpbiAyMS42LjAgRGFyd2luIEtlcm5lbCBWZXJzaW9uIDIx
LjYuMDogTW9uIERlYyAxOSAyMDo0MzowOSBQU1QgMjAyMjsgcm9vdDp4bnUtODAyMC4yNDAuMTh+
Mi9SRUxFQVNFX0FSTTY0X1Q2MDAwIGFybTY0CmNvbXBpbGVyIGluZm86IGNsYW5nOiAxNC4wLjAg
KGNsYW5nLTE0MDAuMC4yOS4yMDIpCmxpYmMgaW5mbzogbm8gbGliYyBpbmZvcm1hdGlvbiBhdmFp
bGFibGUKJFNIRUxMICh0eXBpY2FsbHksIGludGVyYWN0aXZlIHNoZWxsKTogL2Jpbi96c2gKCgpb
RW5hYmxlZCBIb29rc10K
--0000000000005a77e405f3cad712--
