From: Sitaram Chamarty <sitaramc@gmail.com>
Subject: git name-rev not accepting abbreviated SHA with --stdin
Date: Wed, 24 Jun 2015 08:59:09 +0530
Message-ID: <558A2405.2090709@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
To: "git@vger.kernel.org" <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Wed Jun 24 05:29:26 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Z7bNN-0005fw-3g
	for gcvg-git-2@plane.gmane.org; Wed, 24 Jun 2015 05:29:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753722AbbFXD3Q (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 23 Jun 2015 23:29:16 -0400
Received: from mail-pd0-f177.google.com ([209.85.192.177]:34890 "EHLO
	mail-pd0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751984AbbFXD3O (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 23 Jun 2015 23:29:14 -0400
Received: by pdbci14 with SMTP id ci14so20612047pdb.2
        for <git@vger.kernel.org>; Tue, 23 Jun 2015 20:29:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=message-id:date:from:user-agent:mime-version:to:subject
         :content-type:content-transfer-encoding;
        bh=1pBfBrz0BMzQl/iFBfWvS+Rdj45IIUmw+oqSNddM8m8=;
        b=S7jegGjXRJeR32q1DD/f4gQ5zoJ4X1l5yQJYUobg+IcpiYyt9xAcNLcamRAYWz20LO
         QGBSp1nHX1sBTZg7sX5JI3RajZ7r7VHPdbUB4aBsMXmQr0Fp4LnumdDhLDtY1U7N7Ilh
         0fLMwkovDXB1u7iLVu/aZGN0g7NkD3bBm5m5j6Dt9P95Kuwn/Lwebjt4z3u+e3Jg0JOq
         Vh4yCSrD51yRK2hHHFdyzKDZOsvpZ3bzSf3npqvW4X90UD1GUg1FaSdFT+v9pRXWktXH
         Ku7ApPS10k4xK6Vj8QFTTDLu51wET2PVVursU/YP6f0KDj9juG1FUPlW0zyXSTCJe6Dq
         JbeQ==
X-Received: by 10.66.159.68 with SMTP id xa4mr66244136pab.105.1435116554392;
        Tue, 23 Jun 2015 20:29:14 -0700 (PDT)
Received: from sita-lt.atc.tcs.com (atcmail.atc.tcs.com. [203.200.212.145])
        by mx.google.com with ESMTPSA id fp3sm24891294pdb.52.2015.06.23.20.29.12
        for <git@vger.kernel.org>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 23 Jun 2015 20:29:13 -0700 (PDT)
User-Agent: Mozilla/5.0 (X11; Linux i686; rv:31.0) Gecko/20100101 Thunderbird/31.7.0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/272528>

Hi all,

"git name-rev" does not accept abbreviated SHAs if --stdin is used,
though it works when the SHA is given directly on the command line:

    $ git version
    git version 2.4.3
    $ git name-rev --tags d73f544
    d73f544 tags/v3.6.3~29
    $ git name-rev --tags --stdin <<< d73f544
    d73f544

This *is* documented, but I'm curious why this distinction is made.  Is
it merely a matter of parsing or were there some other complications I
am unaware of, which forced this distinction to be made?

thanks
sitaram
