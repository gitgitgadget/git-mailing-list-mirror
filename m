From: Alexey Shumkin <Alex.Crezoff@gmail.com>
Subject: [PATCH v3 0/5] Reroll patches. Pretty print truncate does not work
Date: Mon, 19 May 2014 19:28:15 +0400
Message-ID: <cover.1400513063.git.Alex.Crezoff@gmail.com>
References: <xmqqfvk9a797.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Cc: Alexey Shumkin <Alex.Crezoff@gmail.com>, git@vger.kernel.org,
	"brian m. carlson" <sandals@crustytoothpaste.net>,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon May 19 17:28:51 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WmPUg-0003rD-BF
	for gcvg-git-2@plane.gmane.org; Mon, 19 May 2014 17:28:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754538AbaESP2q (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 19 May 2014 11:28:46 -0400
Received: from mail-lb0-f171.google.com ([209.85.217.171]:33857 "EHLO
	mail-lb0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753420AbaESP2p (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 19 May 2014 11:28:45 -0400
Received: by mail-lb0-f171.google.com with SMTP id 10so4205411lbg.30
        for <git@vger.kernel.org>; Mon, 19 May 2014 08:28:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rarus.ru; s=google;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=GemmLdyfIzsh3mK6ti8bp5r6xVJHorw2iaz9xdZEuOc=;
        b=ZSVFf4BsWci+hxBm90EjbwrRfuRp4ZsqChsrTwJ5CWZI4PAoMwijwzwn99twJlEy2m
         YQB2ZjjtQ7fO4UbZk5mH5PJNhOeXvc9vHUmxs47I2eSRPK2xGMmFTACZtsH1weio3NJh
         ypd/WjuV0JHFj9J+KR3u/bOkf0p7hVyzWKiQg=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=GemmLdyfIzsh3mK6ti8bp5r6xVJHorw2iaz9xdZEuOc=;
        b=jy/LcDb5T9Txi7PgGkgeDFhnPyV3PTuj+PTh4D9E/CuVAzmSHoDLAxT2H2XPBdWpGW
         bj2T8NIr0W4JUOCfjLFdKRImv835WNdMjNX1cqes2Ufn34U2UjXArUUuvAmMO7ucUyv2
         dKfSEmXoDK/1MhXdwno/zGej4XKSBCB1GLFyJS0Szjh5iLMSzAc8q1lkFiEr3HRb9vHm
         ZQaSlz3A2KJZHecrU7HzWPMyu4SX5HDF3NEc0hVeDo7vA/l1RqRmzIn680DTSGYM3+Wb
         dR0bLM0A1N/0GHkA02MlOzGchXMKHcbEwa7rW/PjH8tje6HmfBeDWS8EEJLRhwAdGdrn
         VKLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references:mime-version:content-type
         :content-transfer-encoding;
        bh=GemmLdyfIzsh3mK6ti8bp5r6xVJHorw2iaz9xdZEuOc=;
        b=e3CnMxq+4LahKiC/wbR+8TuJ4ZSVl5x3pKbrWmY7eeve2kGE5cysX8QyBvBg+l8s3Z
         byTwnXbzV6EioH1+rd6WAVuNAOvJmaXm084yhpxly9202+XEqPoBnqRl2D3dlEB7UNXh
         u6P3M1lLz9pxpZLVzbWfnS637kTpBaHDBCbAlh9qnMr9xJJEHjC8HjR9WxwWZxDXEUHP
         bX2OQX3CBbEielVjajWdyuf6mIG5tCI7zocwuGPobylkFcI2d4bFsqE802uIobxJpuzC
         sGqvdKd/Cko3xdDNSS0aPStqJf03raImPboEldHs3+cdskLH7pI3ZJy6IjPv3b0crjj0
         IJrw==
X-Gm-Message-State: ALoCoQmM32ZeSQd6it30pkt0AJ8HgmpbGiPsogqFmQAJtoYurPyrogEVZVqUGhLG2tv/xhFciBHH
X-Received: by 10.152.242.164 with SMTP id wr4mr27340913lac.38.1400513323659;
        Mon, 19 May 2014 08:28:43 -0700 (PDT)
Received: from localhost (ppp91-77-214-38.pppoe.mtu-net.ru. [91.77.214.38])
        by mx.google.com with ESMTPSA id q2sm20125901laj.9.2014.05.19.08.28.40
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 19 May 2014 08:28:42 -0700 (PDT)
X-Mailer: git-send-email 1.9.2-15
In-Reply-To: <xmqqfvk9a797.fsf@gitster.dls.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/249584>

This patch series differs from the previous (v2) version in the following:
t4205 refactored: hardcoded SHA-1 digests replaced with variabled
Tested encoding `iso8859-1` replaced with variable (and uppercased to be in line
  in other tests)
Usage of `format` + `echo` replaced with `tformat`

brian m. carlson <sandals@crustytoothpaste.net> CCed as he committed 5e1361c
(log: properly handle decorations with chained tags, 2013-12-17)

Alexey Shumkin (5):
  t4205 (log-pretty-formats): don't hardcode SHA-1 in expected outputs
  t4041, t4205, t6006, t7102: Don't hardcode tested encoding value
  t4205 (log-pretty-format): Use `tformat` rather than `format`
  t4205, t6006: Add failing tests for the case when
    i18n.logOutputEncoding is set
  pretty.c: format string with truncate respects logOutputEncoding

 pretty.c                         |   7 +-
 t/t4041-diff-submodule-option.sh |   7 +-
 t/t4205-log-pretty-formats.sh    | 217 ++++++++++++++++++++++++++++++---------
 t/t6006-rev-list-format.sh       | 110 ++++++++++++++++----
 t/t7102-reset.sh                 |  13 ++-
 5 files changed, 282 insertions(+), 72 deletions(-)

-- 
1.9.2-15
