From: David Turner <dturner@twopensource.com>
Subject: Re: [PATCH v8 00/10] refs backend pre-vtable
Date: Mon, 16 Nov 2015 13:51:08 -0500
Organization: Twitter
Message-ID: <1447699868.5082.0.camel@twopensource.com>
References: <cover.1447154711.git.mhagger@alum.mit.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
	Lukas Fleischer <lfleischer@lfos.de>,
	Ronnie Sahlberg <ronniesahlberg@gmail.com>,
	Ramsay Jones <ramsay@ramsayjones.plus.com>, git@vger.kernel.org
To: Michael Haggerty <mhagger@alum.mit.edu>
X-From: git-owner@vger.kernel.org Mon Nov 16 19:51:28 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZyOs1-0001S3-6Y
	for gcvg-git-2@plane.gmane.org; Mon, 16 Nov 2015 19:51:18 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751526AbbKPSvM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 16 Nov 2015 13:51:12 -0500
Received: from mail-yk0-f170.google.com ([209.85.160.170]:35257 "EHLO
	mail-yk0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750958AbbKPSvL (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 16 Nov 2015 13:51:11 -0500
Received: by ykba77 with SMTP id a77so254834001ykb.2
        for <git@vger.kernel.org>; Mon, 16 Nov 2015 10:51:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=twopensource_com.20150623.gappssmtp.com; s=20150623;
        h=message-id:subject:from:to:cc:date:in-reply-to:references
         :organization:content-type:mime-version:content-transfer-encoding;
        bh=xTn6Y9zy0Bs9jByGw+miFsb/tE9kzWhxCxxJWCDzkiM=;
        b=XDDpSUCTRLQVOsdOJD1Y0jkIB24q3HZ67Bov6OwBhfz99LP96rp+zfH+P8YcfB1Ihz
         quJlEl04Tc0ObU7p7cw84wPOxgudLb7+hXAFvBlXMXYCGiyiw42Kn9MWRBXikXu3TZWp
         ED2jHkWCAmN/mb+HBDg3a2M3gBf+fmfCPejJeMovE9r/8HUSbRQ8Vhzk69C4uHuWl/Rw
         91UUA7Gf35dncGY9h+6qT6sByafcxqgSOUpTKHCj1iw/iT+sDBjji5k+GcsdEGpsXsKa
         4M9w/9q73ufT3s31DRofcfGt6N3gankx8gBtD7muhmZ8oaQVaQwoEndKHJ5H/QkPvXpW
         bf3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:organization:content-type:mime-version
         :content-transfer-encoding;
        bh=xTn6Y9zy0Bs9jByGw+miFsb/tE9kzWhxCxxJWCDzkiM=;
        b=Z5MWhKGqlooKsmSy7WybOXKwMSEWaq62VyX/6wh7/QRZU9UpThLpAds4pkFxUEMlr6
         O8VHiPQrv1Cjz/CKSG+dj82A9EZdLnYRcM26EkBS0z+oP4ZDSFVOFGPQx607f935sl2q
         bMOsZoFgF2uq11VpYGO3bZQCNndqOryOAxFbg3ZmLH4cT1ILqiOzP1AzH/4tOUgotW+C
         NhtCUOUXkkYGvmG4wSc5Lm+QOpZ6U2Fak+jnIwMHgGHi3w/X9DylXOxCa0zgl0UNjZXL
         yoWEAnYcPodJOfc1PRam528Dff4CZBMSUuTMfcJG0lSWToikpRPC1cQzbnArLES8/NKE
         x8Kg==
X-Gm-Message-State: ALoCoQlAP50+5gNLlRDADTcEq7Bm6lJeLILJPLedDx99VkIGBexfvl2njqilCQGJlQGVWP2/JV2s
X-Received: by 10.129.131.151 with SMTP id t145mr37699438ywf.266.1447699871127;
        Mon, 16 Nov 2015 10:51:11 -0800 (PST)
Received: from ubuntu ([192.133.79.145])
        by smtp.gmail.com with ESMTPSA id b186sm15965367ywc.50.2015.11.16.10.51.09
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 16 Nov 2015 10:51:10 -0800 (PST)
In-Reply-To: <cover.1447154711.git.mhagger@alum.mit.edu>
X-Mailer: Evolution 3.12.11-0ubuntu3 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/281351>

On Tue, 2015-11-10 at 12:42 +0100, Michael Haggerty wrote:
> Another re-roll of this patch series, to address the comments of
> Ramsay Jones (thanks!) about v7 [1].
> 
> This version has the following changes compared to v7:
> 
> * Drop "refs: make is_branch public" patch. This was already done
>   quite a while ago:
> 
>       e7e0f26 refs.c: add a public is_branch function (2014-07-15)
> 
> * Instead of having refs-internal.h include refs.h, have the "*.c"
>   files include both header files.
> 
> * Remove some unneeded includes from refs/files-backend.c.
> 
> Since patch 01/11 of v7 was omitted, the patches in this version are
> numbered differently. In particular, it is now patches 01 through 07
> that form the core of this patch series. The last three patches can
> easily be postponed if that will speed the progress of the first
> seven.
> 
> These patches are also available from my GitHub fork [2] as branch
> "refs-backend-pre-vtable".

This version looks good to me.
