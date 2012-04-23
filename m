From: Pete Wyckoff <pw@padd.com>
Subject: Re: [PATCHv2] git-remote-testgit: fix race when spawning fast-import
Date: Mon, 23 Apr 2012 07:35:05 -0400
Message-ID: <20120423113505.GA22513@padd.com>
References: <20120415114518.GB9338@ecki>
 <4F8AB7F1.1020705@gmail.com>
 <20120415125140.GA15933@ecki>
 <20120419233445.GA20790@padd.com>
 <4F9145A1.6020201@gmail.com>
 <20120421201524.GA18419@padd.com>
 <20120421234555.GA11808@padd.com>
 <xmqqty0cxtcd.fsf@junio.mtv.corp.google.com>
 <20120422203058.GA17290@padd.com>
 <xmqq4nsbmapw.fsf@junio.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Stefano Lattarini <stefano.lattarini@gmail.com>,
	Sverre Rabbelier <srabbelier@gmail.com>, git@vger.kernel.org,
	Clemens Buchacher <drizzd@aon.at>
To: Junio C Hamano <junio@pobox.com>
X-From: git-owner@vger.kernel.org Mon Apr 23 13:35:16 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SMHY4-0001uq-B0
	for gcvg-git-2@plane.gmane.org; Mon, 23 Apr 2012 13:35:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752293Ab2DWLfK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 23 Apr 2012 07:35:10 -0400
Received: from honk.padd.com ([74.3.171.149]:46323 "EHLO honk.padd.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752088Ab2DWLfJ (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 23 Apr 2012 07:35:09 -0400
Received: from arf.padd.com (unknown [50.55.145.32])
	by honk.padd.com (Postfix) with ESMTPSA id 5F35BD27;
	Mon, 23 Apr 2012 04:35:08 -0700 (PDT)
Received: by arf.padd.com (Postfix, from userid 7770)
	id 9314A313E3; Mon, 23 Apr 2012 07:35:05 -0400 (EDT)
Content-Disposition: inline
In-Reply-To: <xmqq4nsbmapw.fsf@junio.mtv.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/196112>

junio@pobox.com wrote on Sun, 22 Apr 2012 19:40 -0700:
> Pete Wyckoff <pw@padd.com> writes:
> 
> > Clemens suggested disabling the test by default, as I've done
> > here.  I think it would be okay to remove it entirely, too.
> 
> Ok.
> 
> > +# Generally, skip this test.  It demonstrates a now-fixed
> > +# race in git-remote-testgit, but is too slow to leave in
> > +# for general use.
> > +test_expect_success DEBUG_TESTGIT_RACE 'racily pushing to local repo' '
> > +	cp -a server server2 &&
> > +	git clone "testgit::${PWD}/server2" localclone2 &&
> > +	test_when_finished "rm -rf server2 localclone2" &&
> 
> Shouldn't test_when_finished come before these two commands?  Otherwise
> server2 or localclone2 directories will be left behind when they fail
> before control reaches it...

Yes, you're right.

		-- Pete
