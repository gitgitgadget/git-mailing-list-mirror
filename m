From: Scott Schmit <i.grok@comcast.net>
Subject: Re: [PATCH] pretty: Provide a strict ISO8601 date format
Date: Fri, 29 Aug 2014 16:29:16 -0400
Message-ID: <20140829202916.GB10274@odin.ulthar.us>
References: <1409248189-31409-1-git-send-email-bbolli@ewanet.ch>
 <xmqq61hc8bvq.fsf@gitster.dls.corp.google.com>
 <20140829174439.GA10274@odin.ulthar.us>
 <xmqq1trz6sv0.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Beat Bolli <bbolli@ewanet.ch>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Aug 29 22:29:26 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XNSnV-0002Km-Ti
	for gcvg-git-2@plane.gmane.org; Fri, 29 Aug 2014 22:29:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751259AbaH2U3W (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 29 Aug 2014 16:29:22 -0400
Received: from qmta10.westchester.pa.mail.comcast.net ([76.96.62.17]:41064
	"EHLO qmta10.westchester.pa.mail.comcast.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750788AbaH2U3V (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 29 Aug 2014 16:29:21 -0400
Received: from omta04.westchester.pa.mail.comcast.net ([76.96.62.35])
	by qmta10.westchester.pa.mail.comcast.net with comcast
	id kk0S1o0040ldTLk5AkVL3k; Fri, 29 Aug 2014 20:29:20 +0000
Received: from odin.ulthar.us ([IPv6:2001:470:8c86:0:225:64ff:fe8b:c2f2])
	by omta04.westchester.pa.mail.comcast.net with comcast
	id kkVJ1o00R2Ekl4801kVK07; Fri, 29 Aug 2014 20:29:20 +0000
Received: from odin.ulthar.us (localhost [127.0.0.1])
	by odin.ulthar.us (8.14.7/8.14.5) with ESMTP id s7TKTHrx014849;
	Fri, 29 Aug 2014 16:29:17 -0400
Received: (from draco@localhost)
	by odin.ulthar.us (8.14.7/8.14.7/Submit) id s7TKTGdH014848;
	Fri, 29 Aug 2014 16:29:16 -0400
Content-Disposition: inline
In-Reply-To: <xmqq1trz6sv0.fsf@gitster.dls.corp.google.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=comcast.net;
	s=q20140121; t=1409344160;
	bh=G6/52fAs3t1J8RvaiL1riPcjz8xaXnE0mowpp4RDVLE=;
	h=Received:Received:Received:Received:Date:From:To:Subject:
	 Message-ID:MIME-Version:Content-Type;
	b=PeCruAtoV6mpn9TrzDpl6kNMSbDSkf1N2SuIlJfMLe20B00aRIVEwsJ2AGJVcpIkE
	 C+zsrRbLGas3PmPKUqWFhFUiVg2/cBfZIkTpZF+p9bnraY5HttRJwXtSZbTjGYKHJh
	 oFGzdEK8llS0aHX4kFBR8TX/ssBBCcN8SP2eRam31tp6Y9SKFeG/UcBO7cYhP7Y9cW
	 feCQTOJibcH6lIkv0VRpfPFpJhh0U42od4N5EW5JjGbtshk47YOza+FsCbn3NdFjeb
	 yB0kKxHer66BWJXHXrOeSQumtFvXAwwnVizbqLU9CNfoKi5XNwD7ODz+cdPIAQ4gmd
	 h6MKa3K+2V/bw==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/256187>

On Fri, Aug 29, 2014 at 11:41:39AM -0700, Junio C Hamano wrote:
> You feed tz/100 to "%+03d:" (the "sign and hour" part of the
> timezone).  What if tz is -30, i.e. less than an hour but still a
> negative offset?  tz/100 would be zero and tz % 100 would be -30.
> 
>     tz = -30;
>     printf("%+03d:%02d", tz / 100, abs(tz % 100));
> 
> would show what?

+00:30 because zero can't be negative in two's complement arithmetic.

The "-30 / 100 = 0" part didn't click for some reason.  Sorry for the
noise.
