From: Joshua N Pritikin <jpritikin@pobox.com>
Subject: Re: etoys - binary blob in GIT
Date: Fri, 9 Feb 2007 23:50:03 +0530
Message-ID: <20070209182003.GE13381@always.joy.eth.net>
References: <20070208095523.GE3708@always.joy.eth.net>
	<u7ius5te9.wl%yoshiki@squeakland.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, sugar@laptop.org
To: Yoshiki Ohshima <yoshiki@squeakland.org>
X-From: sugar-bounces@laptop.org Fri Feb 09 19:20:30 2007
Return-path: <sugar-bounces@laptop.org>
Envelope-to: glls-sugar@m.gmane.org
Received: from pedal.laptop.org ([18.85.2.148])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HFaMF-0002hH-CI
	for glls-sugar@m.gmane.org; Fri, 09 Feb 2007 19:20:27 +0100
Received: from pedal.laptop.org (localhost.localdomain [127.0.0.1])
	by pedal.laptop.org (Postfix) with ESMTP id 23009EF81B7;
	Fri,  9 Feb 2007 13:20:26 -0500 (EST)
X-Original-To: sugar@laptop.org
Delivered-To: sugar@laptop.org
Received: from spam.laptop.org (spam.laptop.org [18.85.46.23])
	by pedal.laptop.org (Postfix) with ESMTP id B85FBEF81B1
	for <sugar@laptop.org>; Fri,  9 Feb 2007 13:20:24 -0500 (EST)
X-ASG-Debug-ID: 1171045223-28c900040000-3Xmyjt
X-Barracuda-URL: http://18.85.46.23:8000/cgi-bin/mark.cgi
X-Barracuda-Connect: sceptre.pobox.com[207.106.133.20]
X-Barracuda-Start-Time: 1171045223
Received: from sceptre.pobox.com (sceptre.pobox.com [207.106.133.20])
	by spam.laptop.org (Spam Firewall) with ESMTP id 13D76D6F9
	for <sugar@laptop.org>; Fri,  9 Feb 2007 13:20:24 -0500 (EST)
Received: from sceptre.pobox.com (localhost.localdomain [127.0.0.1])
	by sceptre.pobox.com (Postfix) with ESMTP id A87D2D24;
	Fri,  9 Feb 2007 13:20:45 -0500 (EST)
Received: from emit.nirmalvihar.info (house.nirmalvihar.info [61.17.90.7])
	by sceptre.sasl.smtp.pobox.com (Postfix) with ESMTP id 611622704D;
	Fri,  9 Feb 2007 13:20:30 -0500 (EST)
Received: by emit.nirmalvihar.info (sSMTP sendmail emulation);
	Fri, 9 Feb 2007 23:50:03 +0530
X-ASG-Orig-Subj: Re: [sugar] etoys - binary blob in GIT
Content-Disposition: inline
In-Reply-To: <u7ius5te9.wl%yoshiki@squeakland.org>
X-PGP-Key: 06E3 3D22 D307 AAE6 ACB4  6B44 A9CA A794 A4A6 0BBD
User-Agent: Mutt/1.5.13 (2006-08-11)
X-Barracuda-Bayes: INNOCENT GLOBAL 0.0000 1.0000 -2.0210
X-Barracuda-Virus-Scanned: by Barracuda Spam Firewall at laptop.org
X-Barracuda-Spam-Score: -2.02
X-Barracuda-Spam-Status: No, SCORE=-2.02 using global scores of TAG_LEVEL=3.5
	QUARANTINE_LEVEL=1000.0 KILL_LEVEL=5.5 tests=
X-Barracuda-Spam-Report: Code version 3.1, rules version 3.1.8209
	Rule breakdown below
	pts rule name              description
	---- ----------------------
	--------------------------------------------------
X-BeenThere: sugar@laptop.org
X-Mailman-Version: 2.1.5
Precedence: list
List-Id: "Discussion of OLPC design,
	desktop platform and user experience" <sugar.laptop.org>
List-Unsubscribe: <http://mailman.laptop.org/mailman/listinfo/sugar>,
	<mailto:sugar-request@laptop.org?subject=unsubscribe>
List-Archive: <http://mailman.laptop.org/pipermail/sugar>
List-Post: <mailto:sugar@laptop.org>
List-Help: <mailto:sugar-request@laptop.org?subject=help>
List-Subscribe: <http://mailman.laptop.org/mailman/listinfo/sugar>,
	<mailto:sugar-request@laptop.org?subject=subscribe>
Sender: sugar-bounces@laptop.org
Errors-To: sugar-bounces@laptop.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/39189>

On Fri, Feb 09, 2007 at 04:41:34AM +0900, Yoshiki Ohshima wrote:
> > I suggest starting a new GIT repository without the image. Those who are 
> > interested in history can create a graft to the old repository.
> 
>   Then, from now on, we are going to manage the "history" of the image
> in not-so-well-managed manner (i.e., just a bunch of hand-numbered
> files in a directory).  Which is more or less ok, I think.

Yah, that's exactly what I suggest.

You might store the current image number in GIT if you want to keep 
track of which image goes with which commit.

>   What the Etoys team actually uses for our own change management is
> called "update stream" mechanism.  That is a sequence of small patches
> in text.  These patches are kept on an FTP/HTTP or WebDAV/HTTP server,
> and the developers submit the patches via FTP or WebDAV, and other
> users and developers fetches them via WebDAV or HTTP into their EToys
> image.  The image in the git repository is made in this way.  95% of
> the case, it is enough to recreate a "practically" identical image by
> merely fetching the patches.

95%? Just curious, why not 100%?

>   These small files are the result of "real development work" and
> should probably be kept as the record.

Agreed.

I think the proper way to do that is to clean the upgrade directory 
after each commit so that the upgrade directory only keeps patches for 
the current changeset.  I'm going to CC the GIT mailing list just to 
make sure since you could get stuck with this history for a long time.

>   We are not keen on changing the "fetch" part of it, as it is so nice
> to be able to download directly into the OLPC image.  That means
> that it would be nice to have a directory on a server that looks like:
> 
> http://squeakalpha.org/swupdates/external/updates/
> 
> and available via HTTP.  To push a patch, one could imagine to use git
> and then some server side process copy the file to the directory.

Ivan should be able to do that easily with an update-hook.

-- 
Make April 15 just another day, visit http://fairtax.org
