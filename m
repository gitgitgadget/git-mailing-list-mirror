From: David Turner <dturner@twopensource.com>
Subject: Re: [PATCH v2 00/13] Reference iterators
Date: Fri, 03 Jun 2016 14:02:12 -0400
Organization: Twitter
Message-ID: <1464976932.3988.13.camel@twopensource.com>
References: <cover.1464957077.git.mhagger@alum.mit.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Cc: Ramsay Jones <ramsay@ramsayjones.plus.com>,
	Eric Sunshine <sunshine@sunshineco.com>,
	Jeff King <peff@peff.net>,
	=?UTF-8?Q?Nguy=E1=BB=85n_Th=C3=A1i_Ng=E1=BB=8Dc?= Duy 
	<pclouds@gmail.com>, git@vger.kernel.org
To: Michael Haggerty <mhagger@alum.mit.edu>,
	Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Jun 03 20:02:23 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1b8tQK-0006Cr-Q3
	for gcvg-git-2@plane.gmane.org; Fri, 03 Jun 2016 20:02:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932423AbcFCSCQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 3 Jun 2016 14:02:16 -0400
Received: from mail-qk0-f173.google.com ([209.85.220.173]:34336 "EHLO
	mail-qk0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932074AbcFCSCP (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 3 Jun 2016 14:02:15 -0400
Received: by mail-qk0-f173.google.com with SMTP id s186so25665083qkc.1
        for <git@vger.kernel.org>; Fri, 03 Jun 2016 11:02:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=twopensource-com.20150623.gappssmtp.com; s=20150623;
        h=message-id:subject:from:to:cc:date:in-reply-to:references
         :organization:mime-version:content-transfer-encoding;
        bh=qbTNz0bEFWLklxOmF+p4XaGnYQ7Ohxpuk4YZsOEI/XY=;
        b=LiMOSJrGz/YsE++ewf8ptrkaMf3vp1ZaNiTFetqfDruBf8HtNCamWtd0VVEUW10awK
         ILv/NBE24p9DMqPAS9Ffj2wM0eTtLEtNsgVxTK8R4hImeYmRM998z1+wwEY6pYyBfDAp
         GBihWHTBjT3bS7NvEM1jYzNi7TeiD229tqbfmBG1xhj89IQERRfyINOk2D3j0AHmNzdw
         FKPDVW7c1JKr1ydWcCY4QKFwrfLOMbaFWdkuBzr75OQO+WkV8/WzIynkX/szldiz+fiA
         hjX5dQ+axcMIKbMOQSkldSzUHBOuv48/nDhyRcUftmZfEeZxO9bkwrg73DFid89gu8UN
         8chw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:organization:mime-version:content-transfer-encoding;
        bh=qbTNz0bEFWLklxOmF+p4XaGnYQ7Ohxpuk4YZsOEI/XY=;
        b=EBbuaS0faXEqruqK0B6MF3bE8z0ZozeEX1z5TEgik7QJ8EfDqpkdUTwjy23XJcR5KP
         ue53253ou1URy/1B1ud8IKJnvSCAA4ueXmWpeeBiF517tGrDmfgOrD69hQjAip/T4dwm
         zDigFScXNtMpCqlTYJ6qJWT0RwMbfDWn5Z0/Oqe5edBHHOB3/ZRv2naW+YB0Q5X3op1O
         8SzyuSsDv3ek775qD4RxKG5SNmAkvjLDjy0GZtD4FJsy560YQFw1hCbU7d4M4/AZGFxg
         dTAAKLbb+m8o0m2LbBrujATYddhcwbn5IRLUkkIEKq8E/pWXLjR0KSSkhODIFhqmwK7e
         j+eA==
X-Gm-Message-State: ALyK8tJbs4eNfG9GMxoJo1cZ44nlrecIVGMBvtcHykhC/4IESe3uPdhYEVNqunXFvurWZg==
X-Received: by 10.55.104.81 with SMTP id d78mr4392837qkc.189.1464976934493;
        Fri, 03 Jun 2016 11:02:14 -0700 (PDT)
Received: from ubuntu ([192.133.79.145])
        by smtp.gmail.com with ESMTPSA id a76sm231725qhc.22.2016.06.03.11.02.13
        (version=TLSv1/SSLv3 cipher=OTHER);
        Fri, 03 Jun 2016 11:02:13 -0700 (PDT)
In-Reply-To: <cover.1464957077.git.mhagger@alum.mit.edu>
X-Mailer: Evolution 3.16.5-1ubuntu3.1 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/296359>

On Fri, 2016-06-03 at 14:33 +0200, Michael Haggerty wrote:
> This is v2 of a patch series to implement iteration over references
> via iterators. Thanks to Ramsay, Eric, Junio, and David for their
> feedback about v1 [1]. I think I have addressed all of the points
> that
> were raised.

In case I didn't already say so, I think this concept and
implementation are good.
