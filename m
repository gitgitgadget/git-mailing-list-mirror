From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH 0/2] log/ format-patch improvements
Date: Wed, 25 Aug 2010 15:54:16 -0500
Message-ID: <20100825205416.GB2319@burratino>
References: <1282422531-29673-1-git-send-email-artagnon@gmail.com>
 <20100825084416.GC3280@kytes>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git Mailing List <git@vger.kernel.org>,
	Thomas Rast <trast@student.ethz.ch>,
	Jakub Narebski <jnareb@gmail.com>,
	Junio C Hamano <gitster@pobox.com>
To: Ramkumar Ramachandra <artagnon@gmail.com>
X-From: git-owner@vger.kernel.org Wed Aug 25 22:56:27 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OoN1E-0001hZ-53
	for gcvg-git-2@lo.gmane.org; Wed, 25 Aug 2010 22:56:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754156Ab0HYU4C (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 25 Aug 2010 16:56:02 -0400
Received: from mail-ww0-f44.google.com ([74.125.82.44]:57139 "EHLO
	mail-ww0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752233Ab0HYU4A (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 25 Aug 2010 16:56:00 -0400
Received: by wwb28 with SMTP id 28so339179wwb.1
        for <git@vger.kernel.org>; Wed, 25 Aug 2010 13:55:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :in-reply-to:user-agent;
        bh=YU4Tf/MJ5uC5cDF/k9RgOizt5MfekYmNkmXvGEDpAjo=;
        b=aOkBWGuuGNQ/jVDk6AYLHM57spqCsZ97Zha4Xv23owrlYK+wMJizI0C9fPSS02rjz6
         fFB4yN5Yiw/QUo0lj8TDCOYuZihsyYUOAoW3GWdRqkmKtgX6TEeyzfpv5qrXJPMA3OiO
         2EGN/TJ/ZaAA8hD9NmLxc08/sKCInetB3ZGZc=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=CrK44e9lV8zBxozR0EGw3muJKakMOCfM4QhZtEZ/lwlhJej+6JIozFvbYHRX/lRJZD
         rNne4qRe0JyHllgcC1JnfdhfTmT3xpmAgLBTR6q+QURw1Usbz364X0dk10WWB9fE1LTb
         oQmzn25KhBygO5o8AgyE9GskFMplRCRg7NsMk=
Received: by 10.227.138.146 with SMTP id a18mr7350527wbu.151.1282769759206;
        Wed, 25 Aug 2010 13:55:59 -0700 (PDT)
Received: from burratino (dhcp-11-17.cs.uchicago.edu [128.135.11.176])
        by mx.google.com with ESMTPS id a1sm1555680wbb.8.2010.08.25.13.55.56
        (version=SSLv3 cipher=RC4-MD5);
        Wed, 25 Aug 2010 13:55:57 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20100825084416.GC3280@kytes>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/154472>

Ramkumar Ramachandra wrote:
> Ramkumar Ramachandra writes:

>> The second patch clarifies the meaning of the `-<n>` option. We should
>> also probably force the mutual exclusivity of `-<n>` and <revision
>> range> to avoid confusion.
[...]
> Do you see value in this patch or is it just unnecessary baggage?

I see value in avoiding confusion.  Maybe one solution would be to make
format-patch use --no-merges by default.

 $ git log --oneline --no-merges -3 ab/test..origin/pu
 70256a3 shell: Rewrite documentation and improve error message
 9c46c05 rev-parse: tests git rev-parse --verify master@{n}, for various n
 eedce78 sha1_name.c: use warning in preference to fprintf(stderr
