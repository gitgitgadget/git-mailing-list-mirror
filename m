Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0D7F6C11F68
	for <git@archiver.kernel.org>; Fri,  2 Jul 2021 16:32:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E15576140E
	for <git@archiver.kernel.org>; Fri,  2 Jul 2021 16:32:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229720AbhGBQf3 (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 2 Jul 2021 12:35:29 -0400
Received: from mx3.wp.pl ([212.77.101.10]:32231 "EHLO mx3.wp.pl"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229499AbhGBQf3 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 2 Jul 2021 12:35:29 -0400
X-Greylist: delayed 399 seconds by postgrey-1.27 at vger.kernel.org; Fri, 02 Jul 2021 12:35:29 EDT
Received: (wp-smtpd smtp.wp.pl 24761 invoked from network); 2 Jul 2021 18:26:13 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wp.pl; s=1024a;
          t=1625243173; bh=e5G600bnihbhxWJ+vHWp+q7wnMDynrlU+zdo5bOm3u8=;
          h=From:To:Subject;
          b=sItBDmO78Ek4KUMRADCBZ7VNPDc6CCZkzrYMSc1Y9W7u/roBftyiRsLzei1FCcmQl
           EPnMvyQSQgRr9HMDAP3VSMkP/wRlRdcKl//n6Xh22kiJtHfByv6DQ10z9IgDteFTGR
           Nqc0oeQnuDED1/7Sta+Vv3ad13S/FwA4Or3sDsIE=
Received: from 188-163-45-233.broadband.kyivstar.net (HELO [192.168.1.42]) (skottkuk@wp.pl@[188.163.45.233])
          (envelope-sender <skottkuk@wp.pl>)
          by smtp.wp.pl (WP-SMTPD) with AES256-SHA encrypted SMTP
          for <git@vger.kernel.org>; 2 Jul 2021 18:26:13 +0200
Date:   Fri, 2 Jul 2021 19:25:55 +0300
From:   skottkuk@wp.pl
X-Priority: 3 (Normal)
Message-ID: <1932019063.20210702192555@wp.pl>
To:     git@vger.kernel.org
Subject: Logical bug during MERGE or REBASE
MIME-Version: 1.0
Content-Type: multipart/mixed;
 boundary="----------0A01D60962F2984A6"
X-WP-MailID: 2f495211790e7d693b6ce88430342da8
X-WP-AV: skaner antywirusowy Poczty Wirtualnej Polski
X-WP-SPAM: NO 0000004 [MafS]                               
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

------------0A01D60962F2984A6
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit

Hello.

I got a strange result in the process of "merge" and/or "rebase".

I'm not a git professional, so maybe this is not a bug, but a feature.
But as for me, it would be logical to consider the construction inside {} as something whole, and not just put all the changes into one heap with notification what all OK, no conflicts.

All the details are inside the git-bugreport-2021-07-02-1737.txt.
I hope this log will be useful. Feel free to write me for extra details.  

Best regards,
Skott
------------0A01D60962F2984A6
Content-Type: text/plain;
 name="git-bugreport-2021-07-02-1737.txt"
Content-transfer-encoding: base64
Content-Disposition: attachment;
 filename="git-bugreport-2021-07-02-1737.txt"

VGhhbmsgeW91IGZvciBmaWxsaW5nIG91dCBhIEdpdCBidWcgcmVwb3J0IQpQbGVhc2UgYW5z
d2VyIHRoZSBmb2xsb3dpbmcgcXVlc3Rpb25zIHRvIGhlbHAgdXMgdW5kZXJzdGFuZCB5b3Vy
IGlzc3VlLgoKV2hhdCBkaWQgeW91IGRvIGJlZm9yZSB0aGUgYnVnIGhhcHBlbmVkPyAoU3Rl
cHMgdG8gcmVwcm9kdWNlIHlvdXIgaXNzdWUpCgpJIGRpZDoKJGdpdCBpbml0CiRnaXQgYWRk
IFByb2dyYW0uY3MKSW5zaWRlOgp7CiBDb25zb2xlLldyaXRlbGluZSgiMSIpOwogQ29uc29s
ZS5SZWFkbGluZSgpOwp9CiRnaXQgY29tbWl0IC1tICJJbml0IGNvbW1pdCIKCiRnaXQgY2hl
Y2tvdXQgLWIgZGV2CkRpZCB0aGlzIGNoYW5nZXMgaW4gUHJvZ3JhbS5jczoKewogQ29uc29s
ZS5Xcml0ZWxpbmUoIjEiKTsKIENvbnNvbGUuUmVhZGxpbmUoKTsKIENvbnNvbGUuUmVhZGxp
bmUoKTsKIENvbnNvbGUuUmVhZGxpbmUoKTsKfQokZ2l0IGNvbW1pdCAtYSAtbSAiZGV2IGNv
bW1pdCIKCiRnaXQgY2hlY2tvdXQgbWFzdGVyCkRpZCB0aGlzIGNoYW5nZXMgaW4gUHJvZ3Jh
bS5jczoKewogQ29uc29sZS5Xcml0ZWxpbmUoIjEiKTsKIENvbnNvbGUuV3JpdGVsaW5lKCIy
Iik7CiBDb25zb2xlLlJlYWRsaW5lKCk7CiBDb25zb2xlLlJlYWRsaW5lKCk7Cn0KJGdpdCBj
b21taXQgLWEgLW0gIm1hc3RlciBjb21taXQiCgpBbmQgSSBnZXQgYSBsb2dpY2FsIGJ1ZyBp
bnNpZGUgUHJvZ3JhbS5jcyB3aGVuIEkgd2FudCBtZXJnZSBvciByZWJhc2U6CjEpZ2l0IG1l
cmdlIGRldgpPUgoyKWdpdCByZWJhc2UgZGV2CiAKV2hhdCBkaWQgeW91IGV4cGVjdCB0byBo
YXBwZW4/IChFeHBlY3RlZCBiZWhhdmlvcikKSSBleHBlY3RlZCBjb25mbGljdCBpbiBteSBQ
cm9ncmFtLmNzIGxpa2U6CnsKIENvbnNvbGUuV3JpdGVsaW5lKCIxIik7Cjw8PDw8PDwgSEVB
RAogQ29uc29sZS5Xcml0ZWxpbmUoIjIiKTsKPT09PT09PQogQ29uc29sZS5SZWFkbGluZSgp
Owo+Pj4+Pj4+IGRldgogQ29uc29sZS5SZWFkbGluZSgpOwogQ29uc29sZS5SZWFkbGluZSgp
Owp9CgpXaGF0IGhhcHBlbmVkIGluc3RlYWQ/IChBY3R1YWwgYmVoYXZpb3IpCkp1c3Qgc3Vt
IG9mIDIgY29tbWl0cyB3aXRob3V0IGFueSBjb25mbGljdHM6CnsKIENvbnNvbGUuV3JpdGVs
aW5lKCIxIik7CiBDb25zb2xlLldyaXRlbGluZSgiMiIpOwogQ29uc29sZS5SZWFkbGluZSgp
OwogQ29uc29sZS5SZWFkbGluZSgpOwogQ29uc29sZS5SZWFkbGluZSgpOwogQ29uc29sZS5S
ZWFkbGluZSgpOwp9CgpXaGF0J3MgZGlmZmVyZW50IGJldHdlZW4gd2hhdCB5b3UgZXhwZWN0
ZWQgYW5kIHdoYXQgYWN0dWFsbHkgaGFwcGVuZWQ/CkV4dHJhIGxpbmVzIHdhcyBhZGRlZCBp
biAic2lsZW50IiBtb2RlIHdpdGhvdXQgYW55IG5vdGlmaWNhdGlvbi4KCkFueXRoaW5nIGVs
c2UgeW91IHdhbnQgdG8gYWRkOgpOb3cgbmVjZXNzYXJ5IHRvIHJldmljZSBhbGwgbGluZXMs
IGV2ZW4gaWYgdGhlcmUgYXJlIG5vIGFueSBjb25mbGljdHMgOigKCltTeXN0ZW0gSW5mb10K
Z2l0IHZlcnNpb246CmdpdCB2ZXJzaW9uIDIuMzIuMC53aW5kb3dzLjEKY3B1OiB4ODZfNjQK
YnVpbHQgZnJvbSBjb21taXQ6IDRjMjA0OTk4ZDBlMTU2ZDEzZDgxYWJlMWQxOTYzMDUxYjE0
MThmYzAKc2l6ZW9mLWxvbmc6IDQKc2l6ZW9mLXNpemVfdDogOApzaGVsbC1wYXRoOiAvYmlu
L3NoCmZlYXR1cmU6IGZzbW9uaXRvci0tZGFlbW9uCnVuYW1lOiBXaW5kb3dzIDYuMSA3NjAx
IApjb21waWxlciBpbmZvOiBnbnVjOiAxMC4zCmxpYmMgaW5mbzogbm8gbGliYyBpbmZvcm1h
dGlvbiBhdmFpbGFibGUKJFNIRUxMICh0eXBpY2FsbHksIGludGVyYWN0aXZlIHNoZWxsKTog
PHVuc2V0PgoKCltFbmFibGVkIEhvb2tzXQo=
------------0A01D60962F2984A6--

