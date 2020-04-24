Return-Path: <SRS0=LF8V=6I=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9AF45C54FD0
	for <git@archiver.kernel.org>; Fri, 24 Apr 2020 22:18:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8004720736
	for <git@archiver.kernel.org>; Fri, 24 Apr 2020 22:18:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726050AbgDXWSn (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 24 Apr 2020 18:18:43 -0400
Received: from 1.mo68.mail-out.ovh.net ([46.105.41.146]:45300 "EHLO
        1.mo68.mail-out.ovh.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726022AbgDXWSn (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 24 Apr 2020 18:18:43 -0400
X-Greylist: delayed 605 seconds by postgrey-1.27 at vger.kernel.org; Fri, 24 Apr 2020 18:18:42 EDT
Received: from player792.ha.ovh.net (unknown [10.110.115.36])
        by mo68.mail-out.ovh.net (Postfix) with ESMTP id C32C51647D5
        for <git@vger.kernel.org>; Fri, 24 Apr 2020 23:59:52 +0200 (CEST)
Received: from RCM-web2.webmail.mail.ovh.net (ip-209.net-89-3-147.rev.numericable.fr [89.3.147.209])
        (Authenticated sender: postmaster@rapsys.eu)
        by player792.ha.ovh.net (Postfix) with ESMTPSA id 9A5D311C6C241
        for <git@vger.kernel.org>; Fri, 24 Apr 2020 21:59:52 +0000 (UTC)
MIME-Version: 1.0
Content-Type: multipart/mixed;
 boundary="=_ece8d1de3aca9cbd289f2896cce8b5aa"
Content-Transfer-Encoding: 8bit
Date:   Fri, 24 Apr 2020 23:59:52 +0200
From:   =?UTF-8?Q?Rapha=C3=ABl_Gertz?= <git@rapsys.eu>
To:     git@vger.kernel.org
Subject: gitweb:fix tests on uninitialized hash indexes to avoid uninitialized
 value warnings in server log
User-Agent: Roundcube Webmail/1.4.2
Message-ID: <faf4b0a3988513f0ca3745bd0564fb94@rapsys.eu>
X-Sender: git@rapsys.eu
X-Originating-IP: 89.3.147.209
X-Webmail-UserID: postmaster@rapsys.eu
X-Ovh-Tracer-Id: 7014356421767958237
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: 0
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgeduhedrhedvgddtfecutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfqggfjpdevjffgvefmvefgnecuuegrihhlohhuthemucehtddtnecunecujfgurhepgggtgfffhffvufgfkfigihesmhekjhertderjeenucfhrhhomheptfgrphhhrgotlhgpifgvrhhtiicuoehgihhtsehrrghpshihshdrvghuqeenucffohhmrghinhepghhithhhuhgsrdgtohhmnecukfhppedtrddtrddtrddtpdekledrfedrudegjedrvddtleenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhhouggvpehsmhhtphdqohhuthdphhgvlhhopehplhgrhigvrhejledvrdhhrgdrohhvhhdrnhgvthdpihhnvghtpedtrddtrddtrddtpdhmrghilhhfrhhomhepghhithesrhgrphhshihsrdgvuhdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhg
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

--=_ece8d1de3aca9cbd289f2896cce8b5aa
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset=UTF-8;
 format=flowed

Hi,

It's happened that I tried to solve lots of meaningless warnings
in web server error log.

I think it makes no sense to spam error log with warnings about
uninitialized value when trying to run careless tests on undefined
hash indexes.

This is a simple fix that I did long ago that check carefully the
index before running tests on it.

I added myself as warning fix author as well.

My goal is to avoid re-applying the patch on each distribution update.

The warning message fixed in web server error log :
Use of uninitialized value $params{"action"} in string eq at gitweb.cgi
line 1377

Pull request was done here against "maint" branch :
https://github.com/gitgitgadget/git/pull/617

Pull request was done here against "master" branch if required :
https://github.com/git/git/pull/767

The change patch is attached if required.

May you plz merge my change ?

Best regards

Raphaël Gertz <git@rapsys.eu>:
  gitweb/README: add myself as warning fix author
  gitweb/gitweb.perl: fix careless test on undefined hash indexes

  gitweb/README      | 3 +++
  gitweb/gitweb.perl | 4 ++--
  2 files changed, 5 insertions(+), 2 deletions(-)

Signed-off-by: Raphaël Gertz <git@rapsys.eu>
--=_ece8d1de3aca9cbd289f2896cce8b5aa
Content-Transfer-Encoding: base64
Content-Type: text/x-diff; charset=us-ascii;
 name=gitweb.cgi.rapsys.patch
Content-Disposition: attachment;
 filename=gitweb.cgi.rapsys.patch;
 size=1377

ZGlmZiAtdXJOcCBnaXR3ZWIvZ2l0d2ViLnBlcmwub3JpZyBnaXR3ZWIvZ2l0d2ViLnBlcmwKLS0t
IGdpdHdlYi9naXR3ZWIucGVybC5vcmlnCTIwMTktMTEtMTQgMDc6Mzk6MjQuMjQ0NzA0NzQ0ICsw
MTAwCisrKyBnaXR3ZWIvZ2l0d2ViLnBlcmwJMjAxOS0xMS0xNCAwNzozMzo1MC42NDE2MDI4Mjkg
KzAxMDAKQEAgLTEzNzQsNyArMTM3NCw3IEBAIHN1YiBocmVmIHsKIAogCQkjIHNpbmNlIHdlIGRl
c3RydWN0aXZlbHkgYWJzb3JiIHBhcmFtZXRlcnMsIHdlIGtlZXAgdGhpcwogCQkjIGJvb2xlYW4g
dGhhdCByZW1lbWJlcnMgaWYgd2UncmUgaGFuZGxpbmcgYSBzbmFwc2hvdAotCQlteSAkaXNfc25h
cHNob3QgPSAkcGFyYW1zeydhY3Rpb24nfSBlcSAnc25hcHNob3QnOworCQlteSAkaXNfc25hcHNo
b3QgPSBkZWZpbmVkICRwYXJhbXN7J2FjdGlvbid9ICYmICRwYXJhbXN7J2FjdGlvbid9IGVxICdz
bmFwc2hvdCc7CiAKIAkJIyBTdW1tYXJ5IGp1c3QgdXNlcyB0aGUgcHJvamVjdCBwYXRoIFVSTCwg
YW55IG90aGVyIGFjdGlvbiBpcwogCQkjIGFkZGVkIHRvIHRoZSBVUkwKQEAgLTU5NTksNyArNTk1
OSw3IEBAIHN1YiBnaXRfaGlzdG9yeV9ib2R5IHsKIAkJICAgICAgJGNnaS0+YSh7LWhyZWYgPT4g
aHJlZihhY3Rpb249PiRmdHlwZSwgaGFzaF9iYXNlPT4kY29tbWl0LCBmaWxlX25hbWU9PiRmaWxl
X25hbWUpfSwgJGZ0eXBlKSAuICIgfCAiIC4KIAkJICAgICAgJGNnaS0+YSh7LWhyZWYgPT4gaHJl
ZihhY3Rpb249PiJjb21taXRkaWZmIiwgaGFzaD0+JGNvbW1pdCl9LCAiY29tbWl0ZGlmZiIpOwog
Ci0JCWlmICgkZnR5cGUgZXEgJ2Jsb2InKSB7CisJCWlmIChkZWZpbmVkICRmdHlwZSAmJiAkZnR5
cGUgZXEgJ2Jsb2InKSB7CiAJCQlwcmludCAiIHwgIiAuCiAJCQkgICAgICAkY2dpLT5hKHstaHJl
ZiA9PiBocmVmKGFjdGlvbj0+ImJsb2JfcGxhaW4iLCBoYXNoX2Jhc2U9PiRjb21taXQsIGZpbGVf
bmFtZT0+JGZpbGVfbmFtZSl9LCAicmF3Iik7CiAKZGlmZiAtdXJOcCBnaXR3ZWIvUkVBRE1FLm9y
aWcgZ2l0d2ViL1JFQURNRQotLS0gZ2l0d2ViL1JFQURNRS5vcmlnCTIwMTktMTEtMTQgMDc6Mzk6
MjQuMjQ0NzA0NzQ0ICswMTAwCisrKyBnaXR3ZWIvUkVBRE1FCTIwMTktMTEtMTQgMDc6MzM6NTAu
NjQxNjAyODI5ICswMTAwCkBAIC02Niw1ICs2Niw4IEBAIEFVVEhPUlMKIE9yaWdpbmFsbHkgd3Jp
dHRlbiBieToKICAgS2F5IFNpZXZlcnMgPGtheS5zaWV2ZXJzQHZyZnkub3JnPgogCitQZXJsIHdh
cm5pbmcgZml4OgorICBSYXBoYcOrbCBHZXJ0eiA8Z2l0QHJhcHN5cy5ldT4KKwogQW55IGNvbW1l
bnQvcXVlc3Rpb24vY29uY2VybiB0bzoKICAgR2l0IG1haWxpbmcgbGlzdCA8Z2l0QHZnZXIua2Vy
bmVsLm9yZz4K
--=_ece8d1de3aca9cbd289f2896cce8b5aa--
