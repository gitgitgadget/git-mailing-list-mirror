From: Kirill Smelkov <kirr@navytux.spb.ru>
Subject: Re: [PATCH 7/8] combine-diff: Fast changed-to-all-parents paths
 scanning
Date: Thu, 6 Feb 2014 00:22:48 +0400
Organization: NAVYTUX.SPB.RU
Message-ID: <20140205202248.GB4695@mini.zxlink>
References: <cover.1391430523.git.kirr@mns.spb.ru>
 <c0ad49d850377aedffa0a593fef8738112019b01.1391430523.git.kirr@mns.spb.ru>
 <xmqqk3dbbwwf.fsf@gitster.dls.corp.google.com>
 <xmqqeh3jbwbt.fsf@gitster.dls.corp.google.com>
 <20140204163400.GA20436@tugrik.mns.mnsspb.ru>
 <xmqq4n4eafmj.fsf@gitster.dls.corp.google.com>
 <20140205165119.GA18558@tugrik.mns.mnsspb.ru>
 <xmqqfvnx5umg.fsf@gitster.dls.corp.google.com>
 <20140205191427.GA3923@mini.zxlink>
 <xmqq61ot4a8e.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, kirr@mns.spb.ru
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Feb 05 21:30:49 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WB97R-0003C8-6H
	for gcvg-git-2@plane.gmane.org; Wed, 05 Feb 2014 21:30:49 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932704AbaBEUal (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 5 Feb 2014 15:30:41 -0500
Received: from forward9.mail.yandex.net ([77.88.61.48]:53979 "EHLO
	forward9.mail.yandex.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932433AbaBEUai (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 5 Feb 2014 15:30:38 -0500
X-Greylist: delayed 625 seconds by postgrey-1.27 at vger.kernel.org; Wed, 05 Feb 2014 15:30:38 EST
Received: from smtp9.mail.yandex.net (smtp9.mail.yandex.net [77.88.61.35])
	by forward9.mail.yandex.net (Yandex) with ESMTP id B9B84CE0B2E;
	Thu,  6 Feb 2014 00:20:08 +0400 (MSK)
Received: from smtp9.mail.yandex.net (localhost [127.0.0.1])
	by smtp9.mail.yandex.net (Yandex) with ESMTP id 61BD61520084;
	Thu,  6 Feb 2014 00:20:08 +0400 (MSK)
Received: from unknown (unknown [78.25.120.235])
	by smtp9.mail.yandex.net (nwsmtp/Yandex) with ESMTPSA id d4pmfaZBhQ-K7CaUQHO;
	Thu,  6 Feb 2014 00:20:07 +0400
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(Client certificate not present)
X-Yandex-Uniq: e6aecf4a-a923-4a11-9fd0-990c52c3a3cb
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=navytux.spb.ru; s=mail;
	t=1391631607; bh=yahpnHRsENEuz6zEXhznBRklUF10Z3TSym0+ciuzfeE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To:Organization:
	 User-Agent;
	b=htgHjCduqYmFCkPc+yMJ4Va0H4IalP3EHlzHRt/nZy8vxx8pWKEysL6IkgFhVq05q
	 Ad/AxsMwFhuLxHLFzL06VvNkRZu649acXw5v+bFLmH/gh6fneiLDRufwtN5tCREoiU
	 ipZy74yHR4pI/vHVVXrGq/Rf3xjQASwzjwO8Ypec=
Authentication-Results: smtp9.mail.yandex.net; dkim=pass header.i=@navytux.spb.ru
Received: from kirr by mini.zxlink with local (Exim 4.82)
	(envelope-from <kirr@mini.zxlink>)
	id 1WB8zg-0001E2-CF; Thu, 06 Feb 2014 00:22:48 +0400
Content-Disposition: inline
In-Reply-To: <xmqq61ot4a8e.fsf@gitster.dls.corp.google.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/241652>

On Wed, Feb 05, 2014 at 11:42:41AM -0800, Junio C Hamano wrote:
> Kirill Smelkov <kirr@navytux.spb.ru> writes:
> 
> > I agree object data should be immutable for good. The only thing I'm talking
> > about here is mode, which is parsed from a tree buffer and is stored in
> > separate field:
> 
> Ah, I do not see any problem in that case, then.
> 
> Thanks.

Thanks, that simplifies things for me.
