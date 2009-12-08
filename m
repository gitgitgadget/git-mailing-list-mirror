From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: [RFC/PATCHv10 01/11] fast-import: Proper notes tree
	manipulation
Date: Mon, 7 Dec 2009 17:59:08 -0800
Message-ID: <20091208015908.GB17588@spearce.org>
References: <1260185254-1523-1-git-send-email-johan@herland.net> <1260185254-1523-2-git-send-email-johan@herland.net> <20091207164311.GE17173@spearce.org> <200912080255.17568.johan@herland.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, gitster@pobox.com
To: Johan Herland <johan@herland.net>
X-From: git-owner@vger.kernel.org Tue Dec 08 02:59:17 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NHpMD-00049B-9x
	for gcvg-git-2@lo.gmane.org; Tue, 08 Dec 2009 02:59:17 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965038AbZLHB7G (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 7 Dec 2009 20:59:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965022AbZLHB7F
	(ORCPT <rfc822;git-outgoing>); Mon, 7 Dec 2009 20:59:05 -0500
Received: from mail-yw0-f198.google.com ([209.85.211.198]:42899 "EHLO
	mail-yw0-f198.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S965020AbZLHB7F (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 7 Dec 2009 20:59:05 -0500
Received: by ywh36 with SMTP id 36so4968356ywh.15
        for <git@vger.kernel.org>; Mon, 07 Dec 2009 17:59:11 -0800 (PST)
Received: by 10.150.129.25 with SMTP id b25mr12664322ybd.308.1260237551135;
        Mon, 07 Dec 2009 17:59:11 -0800 (PST)
Received: from localhost (george.spearce.org [209.20.77.23])
        by mx.google.com with ESMTPS id 8sm2249093ywg.19.2009.12.07.17.59.09
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Mon, 07 Dec 2009 17:59:10 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <200912080255.17568.johan@herland.net>
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/134801>

Johan Herland <johan@herland.net> wrote:
> On Monday 07 December 2009, Shawn O. Pearce wrote:
> > > +	if (fanout >= 20)
> > > +		die("Too large fanout (%u)", fanout);
> > 
> > Shouldn't convert_num_notes_to_fanout have a guard to prevent this
> > case from happening?
> 
> Well, it sort of already does (unless uintmax_t is more than 19 * 8 = 152 
> bits wide... ;)

Oh, good point.  :-)
 
> Not sure what you're getting at:
> 
> - Should I add a "&& fanout < 19" condition to the while loop in 
> convert_num_notes_to_fanout()? 

That's what I was thinking.  But given the 19 * 8 = 152 case above,
this is pointless.

-- 
Shawn.
