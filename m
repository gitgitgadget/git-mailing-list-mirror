From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: git-svn SVN 1.7 fix, take 2
Date: Tue, 24 Jul 2012 23:53:27 -0500
Message-ID: <20120725045327.GD3055@burratino>
References: <500F17A3.60307@pobox.com>
 <20120724220207.GA15969@burratino>
 <500F26BF.7090501@pobox.com>
 <20120724233128.GD16333@burratino>
 <7va9yoenb2.fsf@alter.siamese.dyndns.org>
 <500F4530.7030207@pobox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	"Robin H. Johnson" <robbat2@gentoo.org>,
	Eric Wong <normalperson@yhbt.net>,
	Ben Walton <bwalton@artsci.utoronto.ca>
To: Michael G Schwern <schwern@pobox.com>
X-From: git-owner@vger.kernel.org Wed Jul 25 06:53:40 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SttbO-00018n-Ho
	for gcvg-git-2@plane.gmane.org; Wed, 25 Jul 2012 06:53:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751108Ab2GYExd (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 25 Jul 2012 00:53:33 -0400
Received: from mail-gh0-f174.google.com ([209.85.160.174]:57584 "EHLO
	mail-gh0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750968Ab2GYExd (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 25 Jul 2012 00:53:33 -0400
Received: by ghrr11 with SMTP id r11so323737ghr.19
        for <git@vger.kernel.org>; Tue, 24 Jul 2012 21:53:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=35rH6cbdTzB3jVYcTFc8G/8uxvC+fWFgRRTMpXwRYs0=;
        b=u/PYdNmooi5NWW4fo2wkqtXcEXsL2o7MB4Zk5K1rIgHIlu1YBL0N/3Ser+SmwZH9Fb
         Y5lcf+bHlqhiIrkYlju4LCSw9MY7zslFGnODlJtcJF3etbI4wssq9dWwuKF8k6hl61OK
         IhwjuIG4vhRQQ27HL/1vzKiDRqgKykuNLnt3El+tUkECdiXksUEkkr2t9WjcSahRyUgR
         jAjd0BJVvREj/r6ST5rUFPZG/5nFcNqGAYwgqy02kHsiexhs/koEntBuj4B28bqsrL7y
         /AjSG7V053gORbbtvOpjlX/54bk3MB8862bGxQsBYMX7W2k7etWEIUn9tC97l8+ccy7x
         rg7w==
Received: by 10.42.41.11 with SMTP id n11mr21253884ice.13.1343192012117;
        Tue, 24 Jul 2012 21:53:32 -0700 (PDT)
Received: from burratino (cl-1372.chi-02.us.sixxs.net. [2001:4978:f:55b::2])
        by mx.google.com with ESMTPS id fe7sm681143igc.14.2012.07.24.21.53.30
        (version=SSLv3 cipher=OTHER);
        Tue, 24 Jul 2012 21:53:31 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <500F4530.7030207@pobox.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/202120>

Michael G Schwern wrote:

> No, now it's just canonicalizing as early as possible.  Preferably within the
> object accessor rather than at the point of use.  So in the code below,
> $full_url is already escaped/canonicalized.

Let's start with this.

Is svn_path_canonicalize() idempotent?  What does it do when it
encounters a percent-sign?

Thanks,
Jonathan
