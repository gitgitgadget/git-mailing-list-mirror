From: Paul Smith <paul@mad-scientist.net>
Subject: Re: Building Git with HTTPS support: avoiding libcurl?
Date: Tue, 22 Dec 2015 12:30:16 -0500
Organization: I may be mad, but I am a professional!
Message-ID: <1450805416.11255.58.camel@mad-scientist.net>
References: <1450798780.11255.22.camel@mad-scientist.net>
	 <CAD0k6qT+s4e_7y1DxVTN63V0tO_xFv-9i-Fmq5O0SrpQAyAzVA@mail.gmail.com>
Reply-To: paul@mad-scientist.net
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
To: git <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Tue Dec 22 18:37:21 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aBQs7-0006rH-J3
	for gcvg-git-2@plane.gmane.org; Tue, 22 Dec 2015 18:37:15 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752627AbbLVRhJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 22 Dec 2015 12:37:09 -0500
Received: from gproxy1-pub.mail.unifiedlayer.com ([69.89.25.95]:53595 "HELO
	gproxy1-pub.mail.unifiedlayer.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1752117AbbLVRhI (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 22 Dec 2015 12:37:08 -0500
X-Greylist: delayed 398 seconds by postgrey-1.27 at vger.kernel.org; Tue, 22 Dec 2015 12:37:08 EST
Received: (qmail 5548 invoked by uid 0); 22 Dec 2015 17:30:28 -0000
Received: from unknown (HELO cmgw2) (10.0.90.83)
  by gproxy1.mail.unifiedlayer.com with SMTP; 22 Dec 2015 17:30:28 -0000
Received: from box531.bluehost.com ([74.220.219.131])
	by cmgw2 with 
	id whWL1r00v2qhmhE01hWP2r; Tue, 22 Dec 2015 10:30:26 -0700
X-Authority-Analysis: v=2.1 cv=dqRIVTQ4 c=1 sm=1 tr=0
 a=GcR8MKwCKDX7fzHfRD/fNg==:117 a=GcR8MKwCKDX7fzHfRD/fNg==:17 a=cNaOj0WVAAAA:8
 a=f5113yIGAAAA:8 a=pBbsfl06AAAA:8 a=IkcTkHD0fZMA:10 a=cdVwids0oJMA:10
 a=O5GnRg5U9jgA:10 a=wUQvQvOEmiQA:10 a=fze2SJ_1vAKKzIULzLkA:9 a=QEXdDO2ut3YA:10
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mad-scientist.net; s=default;
	h=Content-Transfer-Encoding:Mime-Version:Content-Type:References:In-Reply-To:Date:To:Reply-To:From:Subject:Message-ID; bh=/MB6pbr7CouA3skTrjtAoQhvBycdMOB5r7LY6hFQeh0=;
	b=CIuAiBaru8PgQOdByoD22pigOAIg9f9oxSMyrHWd/1Q1641jf2wOYKtn3pNKu/fSjviJEOf01x4IkmpUEMfqXkRo1Ssbw1GuHssBwvaHOdQ1MBEzk1trUlEMMTlc+LcY;
Received: from [96.237.233.6] (port=46478 helo=homebase)
	by box531.bluehost.com with esmtpsa (TLSv1.2:AES128-GCM-SHA256:128)
	(Exim 4.84)
	(envelope-from <paul@mad-scientist.net>)
	id 1aBQlS-0006ig-BL
	for git@vger.kernel.org; Tue, 22 Dec 2015 10:30:22 -0700
In-Reply-To: <CAD0k6qT+s4e_7y1DxVTN63V0tO_xFv-9i-Fmq5O0SrpQAyAzVA@mail.gmail.com>
X-Mailer: Evolution 3.16.5-1ubuntu3.1 
X-Identified-User: {678:box531.bluehost.com:madscie1:mad-scientist.us} {sentby:smtp auth 96.237.233.6 authed with paul+mad-scientist.us}
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/282890>

On Tue, 2015-12-22 at 09:08 -0800, Dave Borowitz wrote:
> Well, IIUC one of the reasons for Git's fork-everything strategy is to
> avoid having to dynamically link the core git binary against large
> libraries like libcurl, so the dependency size has been taken into
> account at least in that sense.

Sure, and it's great that I still get most Git even if I don't have
libcurl.

But without support for cloning https remotes there's a significant hole
in Git functionality...

I grok that Git doesn't want to re-invent the wheel and that libcurl is
convenient.  I just wonder if anyone knows of another wheel, that
doesn't come attached to an entire tractor-trailer, that could be used
instead :).
