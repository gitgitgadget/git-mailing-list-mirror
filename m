From: Pete Wyckoff <pw@padd.com>
Subject: Re: [PATCH] Fix git-p4 submit in non --prepare-p4-only mode
Date: Wed, 11 Jun 2014 09:36:02 -0400
Message-ID: <20140611133602.GA17043@padd.com>
References: <20140110181807.GA29164@nekage>
 <20140112222946.GA13519@padd.com>
 <20140113121011.GA9711@nekage>
 <20140114000613.GA11594@padd.com>
 <20140524013942.GA29751@nekage>
 <20140524135215.GA9386@padd.com>
 <20140524174034.GA7560@nekage>
 <20140610121446.GA25634@nekage>
 <20140610223958.GA10049@padd.com>
 <20140611130658.GA29245@nekage>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
To: Maxime Coste <frrrwww@gmail.com>
X-From: git-owner@vger.kernel.org Wed Jun 11 15:36:14 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WuihJ-0000Cn-8G
	for gcvg-git-2@plane.gmane.org; Wed, 11 Jun 2014 15:36:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755400AbaFKNgH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 11 Jun 2014 09:36:07 -0400
Received: from honk.padd.com ([71.19.245.7]:47414 "EHLO honk.padd.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755253AbaFKNgG (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 11 Jun 2014 09:36:06 -0400
Received: from arf.padd.com (unknown [50.105.4.164])
	by honk.padd.com (Postfix) with ESMTPSA id CC03A5B41;
	Wed, 11 Jun 2014 06:36:04 -0700 (PDT)
Received: by arf.padd.com (Postfix, from userid 7770)
	id 71702201EF; Wed, 11 Jun 2014 09:36:02 -0400 (EDT)
Content-Disposition: inline
In-Reply-To: <20140611130658.GA29245@nekage>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/251368>

frrrwww@gmail.com wrote on Wed, 11 Jun 2014 14:06 +0100:
> On Tue, Jun 10, 2014 at 06:39:58PM -0400, Pete Wyckoff wrote:
> > frrrwww@gmail.com wrote on Tue, 10 Jun 2014 13:14 +0100:
> > > b4073bb387ef303c9ac3c044f46d6a8ae6e190f0 broke git p4 submit, here
> > > is a proper fix, including proper handling for windows end of lines.
> > 
> > I guess we don't have test coverage for these cases?  Is this
> > something that should get put into a maintenance release, quickly?
> 
> We have test cases for that, however we need to create a link to git-p4.py
> named git-p4 in order for them to work. I did not run the first patch through
> the tests (see my previous email) because of that. Sorry about that.

The secret is to "build" the code before running tests, just like
when working on .c files.  I tend to do something like:

    make git-p4 && (cd t ; make T="$(echo t98*)") ; pkill p4d

Thanks for catching the problem quickly and fixing it.

		-- Pete
