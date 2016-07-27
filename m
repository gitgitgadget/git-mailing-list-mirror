Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 82502203E2
	for <e@80x24.org>; Wed, 27 Jul 2016 10:14:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754480AbcG0KOc (ORCPT <rfc822;e@80x24.org>);
	Wed, 27 Jul 2016 06:14:32 -0400
Received: from mail-lf0-f45.google.com ([209.85.215.45]:36689 "EHLO
	mail-lf0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754062AbcG0KOb (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 27 Jul 2016 06:14:31 -0400
Received: by mail-lf0-f45.google.com with SMTP id g62so23751874lfe.3
        for <git@vger.kernel.org>; Wed, 27 Jul 2016 03:14:31 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:from:date:message-id:subject:to;
        bh=tX22EVBGYPa1hpr3ELrg+F0kRg/mWV6TbT2drkg5FFY=;
        b=hwliU3MjOtys7XAWezUXrbPblaoKRbI2gvFqoT2jvz+9zvwNwYJGP5gm1C9mVCUXds
         BT+Xs0BBjT7c17dlI+H7QlRBAXFLjCckz9Xwve/GF8liPomy6KlgXFKC5xIvVanTpFRG
         AEDJysIv5Lrdzf6zUq28tpjUIphgQeNRQuM8/+rOTDsQlR5DOO4EuiIc222YcGuT6zxa
         pLNSDBV04FtFshUXpNQy3j5wdqNxnd+rsGgRbc/uCZuuGwxJSKGjd+n7tQYIfzaGECJ9
         kZizbMvNfCFx+SvnNx0sM5E4NvwKQ/qWBmlfbFHokN+valm2i7/junvs9TLxWwST12JO
         GdgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=tX22EVBGYPa1hpr3ELrg+F0kRg/mWV6TbT2drkg5FFY=;
        b=Z24nh+7ExK1mZ0YLkbqohfuDDgUf4VyhakaNHWoxNENikW8JVYvXpf81Sb2dpZ6Bow
         V+jjF5Ba7+rE71/Lx/nSZ/32wyaJgb+CImF8NPZvm28+NVgXITU/3hEoG0Jv6MsYcCiL
         fXb1h/copTrrlWLH0RxwqjNsESK04bMwK9Nq64H0YDVxJd1KH1o1s9Ddh0h/Fex5c1Kr
         MY+G5sgn3Aq0mJ2ULv89ajI24Rrx/vhhKbu540TWe72zC/Ile63xGzl4CGCHQz2Ng+ii
         N0jad06yrif8qU+GGOrnwf4TB79OpbEiKru91187gkGiWWyT+XUY1hVmzlh2p59oLeP4
         WdxA==
X-Gm-Message-State: AEkoouse8hN56QC619k5xEzVK8JqUws83B5TDTAyZpoq+bUrPZskQ0vFkLa+TVAEcWuUDWkjFpSC9y/0y/rsVw==
X-Received: by 10.46.9.76 with SMTP id 73mr10275612ljj.61.1469614469561; Wed,
 27 Jul 2016 03:14:29 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.25.144.203 with HTTP; Wed, 27 Jul 2016 03:14:28 -0700 (PDT)
From:	Luis Gutierrez <luisgutz@gmail.com>
Date:	Wed, 27 Jul 2016 11:14:28 +0100
Message-ID: <CAD8hE_yzNZDPkxRy8s4Fy2_dZN5ppWzLM_2xc01C-VAdR1Pj_g@mail.gmail.com>
Subject: git-mergetool reverse file ordering
To:	git@vger.kernel.org
Content-Type: multipart/mixed; boundary=001a114b10266a5cf005389b4816
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

--001a114b10266a5cf005389b4816
Content-Type: text/plain; charset=UTF-8

Hi,

Attached is a potential patch for reversing the order on which
git-mergetool presents the files to merge.

Currently, when running git-mergetool, it performs a sort of the files
to merge by alphabetical ordering. When working on C, this has the
annoying effect of presenting the merge for a .c* files before the
header files; which is always a bit harder to do. Reading the header
first to figure out what the other dude changed is usually preferred.

The attach patch reverse the order (-r flag to sort) so *.h* are
merged before  *.c* files

PS, given the simplicity of the patch, I have not tested it.

Regards

Luis

--001a114b10266a5cf005389b4816
Content-Type: text/plain; charset=US-ASCII; name="sort-for-c-files.txt"
Content-Disposition: attachment; filename="sort-for-c-files.txt"
Content-Transfer-Encoding: base64
X-Attachment-Id: f_ir4qg6ou0

ZGlmZiAtLWdpdCBhL2dpdC1tZXJnZXRvb2wuc2ggYi9naXQtbWVyZ2V0b29sLnNoCmluZGV4IGJm
ODYyNzAuLmNjZTNiMGQgMTAwNzU1Ci0tLSBhL2dpdC1tZXJnZXRvb2wuc2gKKysrIGIvZ2l0LW1l
cmdldG9vbC5zaApAQCAtNDUzLDEwICs0NTMsMTAgQEAgdGhlbgogCXRoZW4KIAkJZmlsZXM9JChn
aXQgcmVyZXJlIHJlbWFpbmluZykKIAllbHNlCi0JCWZpbGVzPSQoZ2l0IGxzLWZpbGVzIC11IHwg
c2VkIC1lICdzL15bXgldKgkvLycgfCBzb3J0IC11KQorCQlmaWxlcz0kKGdpdCBscy1maWxlcyAt
dSB8IHNlZCAtZSAncy9eW14JXSoJLy8nIHwgc29ydCAtdSAtcikKIAlmaQogZWxzZQotCWZpbGVz
PSQoZ2l0IGxzLWZpbGVzIC11IC0tICIkQCIgfCBzZWQgLWUgJ3MvXlteCV0qCS8vJyB8IHNvcnQg
LXUpCisJZmlsZXM9JChnaXQgbHMtZmlsZXMgLXUgLS0gIiRAIiB8IHNlZCAtZSAncy9eW14JXSoJ
Ly8nIHwgc29ydCAtdSAtcikKIGZpCiAKIGlmIHRlc3QgLXogIiRmaWxlcyIK
--001a114b10266a5cf005389b4816--
