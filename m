Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 09B87C433EF
	for <git@archiver.kernel.org>; Mon,  3 Jan 2022 18:08:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235217AbiACSIZ (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 3 Jan 2022 13:08:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33914 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234580AbiACSIY (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 3 Jan 2022 13:08:24 -0500
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com [IPv6:2a00:1450:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2489FC061761
        for <git@vger.kernel.org>; Mon,  3 Jan 2022 10:08:24 -0800 (PST)
Received: by mail-wr1-x42e.google.com with SMTP id d9so71458910wrb.0
        for <git@vger.kernel.org>; Mon, 03 Jan 2022 10:08:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:message-id:date:mime-version:user-agent:content-language:to
         :from:subject;
        bh=y2ZhzfAWL3wHtVwug90bdxiRYx8DFblGlC9pa8oFqVw=;
        b=RZuPgOOMnqhlpN9j8Vgad/bYVtgq/G5l8hyAmlhZA9RGEK1ka6dpwXyk0n6H7fSb3G
         yvi4IjWEobH9SJ5howNltM+Jrb1e+1mItvQzWgBZjF90b0IEyfOIMmMAthnK0yYtczh1
         WGJDSb9iFTvpUfwDfWegZmPWNvHNv4dvi7BlfxtKICQP1yDpxbOoyYMr3UjQEcYd8EWC
         2WcfPQEEP39zclkmp+/4v+xXZJ5e+CY75fN0gH3NGpemruUnNwh80osgXuJuFuh5S8Gs
         KO2LcI4hUHA35zQ4ubfzoIiew3fg7UTaXLXcD5qqmw5/dN4uBHkAHFleYAglzFDBAxw+
         jguQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:message-id:date:mime-version:user-agent
         :content-language:to:from:subject;
        bh=y2ZhzfAWL3wHtVwug90bdxiRYx8DFblGlC9pa8oFqVw=;
        b=FM/z9TnLjLxv2w8VOFbsexdh95cQnezxeUwqsarrNsjkt/9Mm357q7UaRk+0n6Xde/
         xzvmsUkMGfEvig4ELdnilO2z0WryCIxfGe1S4kFadbh8j7O1cs9cFdL0E+dF2qdT9rdx
         I9QsSvwh7Zq1vTcvV8ic9PoKIXs4kWVrxQUeOt9OGNiMmJdmOkbGlYNTs6lvWCMJMe/G
         xz6SuYPvXwZd1fj71NK4arxzJZFqPBs4mI6Bh8E78e1CkVuul/Aa2iEB9CJW+Tr4ARjK
         qUncD/CJXh3EboMr8JgPN8EN7/VYvvpnGWdHASgsfgB2dpPH+CbJX9OI4fCSOXCYQPHP
         wLXw==
X-Gm-Message-State: AOAM5301fxa48tX0SJumATnvVjy78smwuWB0ygImoeIKzHHh4PC8Qdyc
        iTzYldLdxS8oaB37xG+P+DPmiz8S0Wo=
X-Google-Smtp-Source: ABdhPJyiLcRsVv0IYnLpKIFwtz3YFSrQXEI9yL1unOgsFh/MMx50zmdvViCUOR+JEkzsGHE1LdzTJg==
X-Received: by 2002:a05:6000:168e:: with SMTP id y14mr40675844wrd.492.1641233302716;
        Mon, 03 Jan 2022 10:08:22 -0800 (PST)
Received: from ?IPV6:2003:d3:c71b:f700::bc3? (p200300d3c71bf7000000000000000bc3.dip0.t-ipconnect.de. [2003:d3:c71b:f700::bc3])
        by smtp.gmail.com with ESMTPSA id g5sm36062996wru.48.2022.01.03.10.08.21
        for <git@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 03 Jan 2022 10:08:22 -0800 (PST)
Sender: Tilman Vogel <tilman.vogel@gmail.com>
Content-Type: multipart/mixed; boundary="------------6MkZvaZlbjZ0kkx94sEQrAyj"
Message-ID: <9749fa2c-b08d-c08b-ce43-041d13852d02@web.de>
Date:   Mon, 3 Jan 2022 19:08:21 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.4.1
Content-Language: en-US
To:     git@vger.kernel.org
From:   Tilman Vogel <tilman.vogel@web.de>
Subject: [BUG] git pull --rebase ignores rebase.autostash config when
 fast-forwarding
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This is a multi-part message in MIME format.
--------------6MkZvaZlbjZ0kkx94sEQrAyj
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi git-people,

I ran into strange behavior when having rebase.autostash enabled and
doing a git pull --rebase:

> git config rebase.autostash true
> git pull --rebase
Updating cd9ff8a..f3c9840
error: Your local changes to the following files would be overwritten by
merge:
        content
Please commit your changes or stash them before you merge.
Aborting

Confusingly, this fixes the issue:

> git config merge.autostash true
> git pull --rebase
Updating cd9ff8a..f3c9840
Created autostash: c615fda
Fast-forward
 content | 1 +
 1 file changed, 1 insertion(+)
Applied autostash.

Leaving me wonder why merge config options fix rebase behavior.

So, in order to make it easier to check the problem, I added some
test-cases to the git test-suite. Please see the attached patch.

Or here:
https://github.com/tvogel/git/commit/bc941f9357518a34cfa11788dfb8e7fa7f711705

I did not try to find the root-cause as I am not experienced with the
code-base but if there are questions, let me know.

Best regards,

Tilman

--------------6MkZvaZlbjZ0kkx94sEQrAyj
Content-Type: text/x-patch; charset=UTF-8;
 name="git-pull-rebase-autostash-problem.patch"
Content-Disposition: attachment;
 filename="git-pull-rebase-autostash-problem.patch"
Content-Transfer-Encoding: base64

RnJvbSBiYzk0MWY5MzU3NTE4YTM0Y2ZhMTE3ODhkZmI4ZTdmYTdmNzExNzA1IE1vbiBTZXAg
MTcgMDA6MDA6MDAgMjAwMQpGcm9tOiBUaWxtYW4gVm9nZWwgPHRpbG1hbi52b2dlbEB3ZWIu
ZGU+CkRhdGU6IE1vbiwgMyBKYW4gMjAyMiAxODozMTo1OSArMDEwMApTdWJqZWN0OiBbUEFU
Q0hdIHQ1NTIxOiBTaG93IGluY29uc2lzdGVudCByZWJhc2UgYmVoYXZpb3IgKC0tYXV0b3N0
YXNoIHZzLgogcmViYXNlLmF1dG9zdGFzaCkKCldoZW4gcHVsbCAtLXJlYmFzZSBjYW4gYmUg
ZG9uZSBhcyBhIGZhc3QtZm9yd2FyZCwgdGhlIHJlYmFzZS5hdXRvc3Rhc2gKY29uZmlnIGlz
IG5lZ2xlY3RlZCBzdWNoIHRoYXQgdGhlIHNlY29uZCB0ZXN0LWNhc2UgYWRkZWQgaW4gdGhp
cyBjb21taXQKd2lsbCBmYWlsIHRvIGF1dG9zdGFzaCBhbmQgc3VjY2VlZC4KSW4gZmFjdCwg
c2V0dGluZyBtZXJnZS5hdXRvc3Rhc2ggYXMgYSB3b3JrYXJvdW5kIHdvdWxkIGNhdXNlIGF1
dG9zdGFzaCB0bwpiZSBkb25lLgoKVGhlIG90aGVyIHRocmVlIHRlc3QtY2FzZXMgYWRkZWQg
aW4gdGhpcyBjb21taXQgZG9jdW1lbnQgdGhhdCBhdXRvc3Rhc2hpbmcKd29ya3MgYXMgZXhw
ZWN0ZWQgd2hlbiBlaXRoZXIgcmVxdWVzdGVkIGV4cGxpY2l0bHkgd2l0aCAtLWF1dG9zdGFz
aCBvciB3aGVuCnB1bGwgLS1yZWJhc2UgY2Fubm90IGJlIGRvbmUgYXMgYSBmYXN0LWZvcndh
cmQuCgpTaWduZWQtb2ZmLWJ5OiBUaWxtYW4gVm9nZWwgPHRpbG1hbi52b2dlbEB3ZWIuZGU+
Ci0tLQogdC90NTUyMS1wdWxsLW9wdGlvbnMuc2ggfCA1MiArKysrKysrKysrKysrKysrKysr
KysrKysrKysrKysrKysrKysrKysrKwogMSBmaWxlIGNoYW5nZWQsIDUyIGluc2VydGlvbnMo
KykKCmRpZmYgLS1naXQgYS90L3Q1NTIxLXB1bGwtb3B0aW9ucy5zaCBiL3QvdDU1MjEtcHVs
bC1vcHRpb25zLnNoCmluZGV4IDY2Y2ZjYjA5YzUuLjQwNDZhNzRjYWQgMTAwNzU1Ci0tLSBh
L3QvdDU1MjEtcHVsbC1vcHRpb25zLnNoCisrKyBiL3QvdDU1MjEtcHVsbC1vcHRpb25zLnNo
CkBAIC0yNTIsNCArMjUyLDU2IEBAIHRlc3RfZXhwZWN0X3N1Y2Nlc3MgJ2dpdCBwdWxsIC0t
bm8tdmVyaWZ5IC0tdmVyaWZ5IHBhc3NlZCB0byBtZXJnZScgJwogCXRlc3RfbXVzdF9mYWls
IGdpdCAtQyBkc3QgcHVsbCAtLW5vLWZmIC0tbm8tdmVyaWZ5IC0tdmVyaWZ5CiAnCiAKK3Rl
c3RfZXhwZWN0X3N1Y2Nlc3MgJ2dpdCBwdWxsIC0tcmViYXNlIC0tYXV0b3N0YXNoIHN1Y2Nl
ZWRzIG9uIGZmJyAnCisJdGVzdF93aGVuX2ZpbmlzaGVkICJybSAtZnIgc3JjIGRzdCBhY3R1
YWwiICYmCisJZ2l0IGluaXQgc3JjICYmCisJdGVzdF9jb21taXQgLUMgc3JjICJpbml0aWFs
IiBmaWxlICJjb250ZW50IiAmJgorCWdpdCBjbG9uZSBzcmMgZHN0ICYmCisJdGVzdF9jb21t
aXQgLUMgc3JjIC0tcHJpbnRmICJtb3JlX2NvbnRlbnQiIGZpbGUgIm1vcmUgY29udGVudFxu
Y29udGVudFxuIiAmJgorCWVjaG8gImRpcnR5IiA+PmRzdC9maWxlICYmCisJZ2l0IC1DIGRz
dCBwdWxsIC0tcmViYXNlIC0tYXV0b3N0YXNoID5hY3R1YWwgMj4mMSAmJgorCWdyZXAgLXEg
IkZhc3QtZm9yd2FyZCIgYWN0dWFsICYmCisJZ3JlcCAtcSAiQXBwbGllZCBhdXRvc3Rhc2gu
IiBhY3R1YWwKKycKKwordGVzdF9leHBlY3Rfc3VjY2VzcyAnZ2l0IHB1bGwgLS1yZWJhc2Ug
d2l0aCByZWJhc2UuYXV0b3N0YXNoIHN1Y2NlZWRzIG9uIGZmJyAnCisJdGVzdF93aGVuX2Zp
bmlzaGVkICJybSAtZnIgc3JjIGRzdCBhY3R1YWwiICYmCisJZ2l0IGluaXQgc3JjICYmCisJ
dGVzdF9jb21taXQgLUMgc3JjICJpbml0aWFsIiBmaWxlICJjb250ZW50IiAmJgorCWdpdCBj
bG9uZSBzcmMgZHN0ICYmCisJdGVzdF9jb21taXQgLUMgc3JjIC0tcHJpbnRmICJtb3JlX2Nv
bnRlbnQiIGZpbGUgIm1vcmUgY29udGVudFxuY29udGVudFxuIiAmJgorCWVjaG8gImRpcnR5
IiA+PmRzdC9maWxlICYmCisJdGVzdF9jb25maWcgLUMgZHN0IHJlYmFzZS5hdXRvc3Rhc2gg
dHJ1ZSAmJgorCWdpdCAtQyBkc3QgcHVsbCAtLXJlYmFzZSAgPmFjdHVhbCAyPiYxICYmCisJ
Z3JlcCAtcSAiRmFzdC1mb3J3YXJkIiBhY3R1YWwgJiYKKwlncmVwIC1xICJBcHBsaWVkIGF1
dG9zdGFzaC4iIGFjdHVhbAorJworCit0ZXN0X2V4cGVjdF9zdWNjZXNzICdnaXQgcHVsbCAt
LXJlYmFzZSAtLWF1dG9zdGFzaCBzdWNjZWVkcyBvbiBub24tZmYnICcKKwl0ZXN0X3doZW5f
ZmluaXNoZWQgInJtIC1mciBzcmMgZHN0IGFjdHVhbCIgJiYKKwlnaXQgaW5pdCBzcmMgJiYK
Kwl0ZXN0X2NvbW1pdCAtQyBzcmMgImluaXRpYWwiIGZpbGUgImNvbnRlbnQiICYmCisJZ2l0
IGNsb25lIHNyYyBkc3QgJiYKKwl0ZXN0X2NvbW1pdCAtQyBzcmMgLS1wcmludGYgInNyY19j
b250ZW50IiBmaWxlICJzcmMgY29udGVudFxuY29udGVudFxuIiAmJgorCXRlc3RfY29tbWl0
IC1DIGRzdCAtLWFwcGVuZCAiZHN0X2NvbnRlbnQiIGZpbGUgImRzdCBjb250ZW50IiAmJgor
CWVjaG8gImRpcnR5IiA+PmRzdC9maWxlICYmCisJZ2l0IC1DIGRzdCBwdWxsIC0tcmViYXNl
IC0tYXV0b3N0YXNoID5hY3R1YWwgMj4mMSAmJgorCWdyZXAgLXEgIlN1Y2Nlc3NmdWxseSBy
ZWJhc2VkIGFuZCB1cGRhdGVkIHJlZnMvaGVhZHMvbWFpbi4iIGFjdHVhbCAmJgorCWdyZXAg
LXEgIkFwcGxpZWQgYXV0b3N0YXNoLiIgYWN0dWFsCisnCisKK3Rlc3RfZXhwZWN0X3N1Y2Nl
c3MgJ2dpdCBwdWxsIC0tcmViYXNlIHdpdGggcmViYXNlLmF1dG9zdGFzaCBzdWNjZWVkcyBv
biBub24tZmYnICcKKwl0ZXN0X3doZW5fZmluaXNoZWQgInJtIC1mciBzcmMgZHN0IGFjdHVh
bCIgJiYKKwlnaXQgaW5pdCBzcmMgJiYKKwl0ZXN0X2NvbW1pdCAtQyBzcmMgImluaXRpYWwi
IGZpbGUgImNvbnRlbnQiICYmCisJZ2l0IGNsb25lIHNyYyBkc3QgJiYKKwl0ZXN0X2NvbW1p
dCAtQyBzcmMgLS1wcmludGYgInNyY19jb250ZW50IiBmaWxlICJzcmMgY29udGVudFxuY29u
dGVudFxuIiAmJgorCXRlc3RfY29tbWl0IC1DIGRzdCAtLWFwcGVuZCAiZHN0X2NvbnRlbnQi
IGZpbGUgImRzdCBjb250ZW50IiAmJgorCWVjaG8gImRpcnR5IiA+PmRzdC9maWxlICYmCisJ
dGVzdF9jb25maWcgLUMgZHN0IHJlYmFzZS5hdXRvc3Rhc2ggdHJ1ZSAmJgorCWdpdCAtQyBk
c3QgcHVsbCAtLXJlYmFzZSA+YWN0dWFsIDI+JjEgJiYKKwlncmVwIC1xICJTdWNjZXNzZnVs
bHkgcmViYXNlZCBhbmQgdXBkYXRlZCByZWZzL2hlYWRzL21haW4uIiBhY3R1YWwgJiYKKwln
cmVwIC1xICJBcHBsaWVkIGF1dG9zdGFzaC4iIGFjdHVhbAorJworCiB0ZXN0X2RvbmUKLS0g
CjIuMzQuMQoK

--------------6MkZvaZlbjZ0kkx94sEQrAyj--
