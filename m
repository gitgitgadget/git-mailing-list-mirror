From: David Turner <dturner@twopensource.com>
Subject: Re: [PATCH 2/2] introduce "preciousObjects" repository extension
Date: Tue, 23 Jun 2015 17:31:14 -0400
Organization: Twitter
Message-ID: <1435095074.28466.74.camel@twopensource.com>
References: <20150623105042.GA10888@peff.net>
	 <20150623105411.GB12518@peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Tue Jun 23 23:32:47 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Z7VoD-0005QF-Tk
	for gcvg-git-2@plane.gmane.org; Tue, 23 Jun 2015 23:32:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932909AbbFWVb2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 23 Jun 2015 17:31:28 -0400
Received: from mail-qc0-f171.google.com ([209.85.216.171]:36856 "EHLO
	mail-qc0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754754AbbFWVbQ (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 23 Jun 2015 17:31:16 -0400
Received: by qcet6 with SMTP id t6so7030259qce.3
        for <git@vger.kernel.org>; Tue, 23 Jun 2015 14:31:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:organization:content-type:mime-version
         :content-transfer-encoding;
        bh=wd1hJNTc395sADQk04JPBH/C3fSk4iPS8z5LsSFh9zY=;
        b=S89mRCbMaIkzUlM5tj1JVgZMZzDyDmZY3OxwXIIG3pTKGnm/OQEBZSAqcJgNpK67VL
         Wbs4S8ZhRJWogtplZeHjqLTG+e5DwyQjsQVHB2zkC+wIC4Rad0XsMRO8BMFuX+jBx3O1
         g7oCG5XjGXZNWTjyG8GmoaSv3DHiUmcf8ByKbiApf5QKmMCCLueq1H07+LofRDwK8pLF
         hok/bZvAH6CNox5Y2bl2L/QC0uFkHivknNfG6Rau09kFeGJKnMZuxtMJ4eNJm31xooXn
         xxueA4jNNZNtfGFxY4jPNyAkKxIiNdxqhG2WG8xFRgBurcuRCgoMPnAUFs9S6jZ1MlGr
         41hQ==
X-Gm-Message-State: ALoCoQmVFw7NpltFdGlVDrWoomwBm1ZbwxDZPaDJgQgrzUg7T3GSbDhhKEgGBY1tZiYNF9/yOQit
X-Received: by 10.55.22.130 with SMTP id 2mr79278201qkw.45.1435095076208;
        Tue, 23 Jun 2015 14:31:16 -0700 (PDT)
Received: from ubuntu ([192.133.79.145])
        by mx.google.com with ESMTPSA id g6sm2134650qgd.10.2015.06.23.14.31.14
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 23 Jun 2015 14:31:15 -0700 (PDT)
In-Reply-To: <20150623105411.GB12518@peff.net>
X-Mailer: Evolution 3.12.10-0ubuntu1~14.10.1 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/272520>

On Tue, 2015-06-23 at 06:54 -0400, Jeff King wrote:
> +	mkconfig 1 preciousObjects >.git/config &&

nit: I think it's better to use git config rather than manually writing
config files.  git config is more future-proof if we up switching config
backends; it's also more composable with other configs (making this test
easier to copy and manipulate), and more explicit.

Other than that it looks good to me.
