From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH] git-compat-util: Avoid strcasecmp() being inlined
Date: Wed, 11 Sep 2013 11:29:21 -0700
Message-ID: <20130911182921.GE4326@google.com>
References: <523094F0.9000509@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Karsten Blees <karsten.blees@gmail.com>
To: Sebastian Schuberth <sschuberth@gmail.com>
X-From: git-owner@vger.kernel.org Wed Sep 11 20:29:31 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VJpAQ-0002VN-RT
	for gcvg-git-2@plane.gmane.org; Wed, 11 Sep 2013 20:29:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756604Ab3IKS31 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 11 Sep 2013 14:29:27 -0400
Received: from mail-pa0-f52.google.com ([209.85.220.52]:43113 "EHLO
	mail-pa0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754129Ab3IKS3Z (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 11 Sep 2013 14:29:25 -0400
Received: by mail-pa0-f52.google.com with SMTP id kq13so9554943pab.25
        for <git@vger.kernel.org>; Wed, 11 Sep 2013 11:29:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=xMh2sfOJvO8IwwmLeZJC/N3LYWixj8eV/V0ucZOMZFc=;
        b=QTzLvx9LaeYkvUkIvBkaAYErQ7coEwyePyNvT+xgwxEIqSTUWItISgpMVIfiUjsSDT
         zfmcK/ifbjM7duAXSmVJ+R7Y60YuUH1ExUNlAltPwMTlOWoGbdiOC76vwBS9Y6Ryc2/f
         rnxRonDJnZgqQu6/eto44e3ItR/ATpfmljQIk7sHJf1rgNzE5kyWMBk15bXos0nGRLIp
         qaWm/DHwr2KMGMScoPUE1VbrqU73JQBHmWpFjiNfcxE7AqM9Y0mW2gtZ0hPhI0HywQdg
         LyeaNEylVFN2qkPP2MbGfRTHCOJ7/XE3ZnvBFHN7Y0xBWiptXlNftYImE2/7nu5Kw9Sz
         EIOA==
X-Received: by 10.66.190.198 with SMTP id gs6mr5132350pac.49.1378924164682;
        Wed, 11 Sep 2013 11:29:24 -0700 (PDT)
Received: from google.com ([2620:0:1000:5b00:b6b5:2fff:fec3:b50d])
        by mx.google.com with ESMTPSA id w6sm31299041pbt.32.1969.12.31.16.00.00
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Wed, 11 Sep 2013 11:29:23 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <523094F0.9000509@gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/234594>

Sebastian Schuberth wrote:

> This is necessary so that read_mailmap() can obtain a pointer to the
> function.

Hm, what platform has strcasecmp() as an inline function?  Is this
allowed by POSIX?  Even if it isn't, should we perhaps just work
around it by providing our own thin static function wrapper in
mailmap.c?

Curious,
Jonathan
