From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: Converting to Git using svn-fe (Was: Speeding up the initial
 git-svn fetch)
Date: Mon, 18 Oct 2010 12:28:10 -0500
Message-ID: <20101018172810.GA6877@burratino>
References: <AANLkTimn99ErpLNfX-Jxn2t6cKCOoKFb91g1_m3TypOf@mail.gmail.com>
 <12137268.486377.1287073355267.JavaMail.root@mail.hq.genarts.com>
 <20101018051702.GD22376@kytes>
 <20101018073102.GA3979@burratino>
 <20101018163836.GI22376@kytes>
 <AANLkTik-OAZWBkKM1zNyeZpC6K4ZjvF8WfXOJrNkXayt@mail.gmail.com>
 <20101018165631.GA6718@burratino>
 <AANLkTimZU_q3KJYpq7zQU7o5H-M8=efDUDL9Zoy7LuZg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Ramkumar Ramachandra <artagnon@gmail.com>,
	Stephen Bash <bash@genarts.com>,
	Matt Stump <mstump@goatyak.com>, git@vger.kernel.org,
	David Michael Barr <david.barr@cordelta.com>,
	Tomas Carnecky <tom@dbservice.com>
To: Sverre Rabbelier <srabbelier@gmail.com>
X-From: git-owner@vger.kernel.org Mon Oct 18 19:32:01 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1P7tYz-0003Xk-Sy
	for gcvg-git-2@lo.gmane.org; Mon, 18 Oct 2010 19:31:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754783Ab0JRRbw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 18 Oct 2010 13:31:52 -0400
Received: from mail-gw0-f46.google.com ([74.125.83.46]:42912 "EHLO
	mail-gw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753667Ab0JRRbv (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 18 Oct 2010 13:31:51 -0400
Received: by gwj19 with SMTP id 19so67286gwj.19
        for <git@vger.kernel.org>; Mon, 18 Oct 2010 10:31:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :in-reply-to:user-agent;
        bh=GsNZ+IHC5gvTpJmCs7AfzE4l7O0npSccI6S8xijy1ww=;
        b=Ek3y0BLIP+z/CxwXe9pHIqvXsKx/UdyGHxmz02FxbV+lMFZQ6uSRT4FltYFNCzIOIZ
         +fYyX46Ms8d2Dtoh503R97yIjn/RvmdUWMXxEBhioj/CXoX97xpTV4WdgSRcaL5MrzVA
         ffauzTf/RSPYWwW3AE1TBOBw3qnEdlWaghxoM=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=cJvr1UjTzN49VRwHhlnAK+ouxDPJM8G1GKNH6Vy1cmW59rmd0lKFneKAIvSscAZ5rQ
         y+2E4L+ml0B/cJYL8FZMcUqgdXDLJmUk0fVbnlvsroMQrxN/mRJ5fZi/yCt9FjJw2Exe
         eJQX4SjSAIGU9KJlyQC2i11R3AgfVwYwGhvBY=
Received: by 10.103.223.19 with SMTP id a19mr2854478mur.24.1287423110060;
        Mon, 18 Oct 2010 10:31:50 -0700 (PDT)
Received: from burratino (adsl-68-255-106-176.dsl.chcgil.sbcglobal.net [68.255.106.176])
        by mx.google.com with ESMTPS id 10sm4366732fax.18.2010.10.18.10.31.47
        (version=SSLv3 cipher=RC4-MD5);
        Mon, 18 Oct 2010 10:31:49 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <AANLkTimZU_q3KJYpq7zQU7o5H-M8=efDUDL9Zoy7LuZg@mail.gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/159271>

Sverre Rabbelier wrote:
> On Mon, Oct 18, 2010 at 11:56, Jonathan Nieder <jrnieder@gmail.com> wrote:

>> FWIW I just wanted to make sure people don't forget about the
>> incompatible object models.
>
>> Pulling from svn is a harder problem but luckily the single-upstream
>> case is the usual case (so object model mismatches are easier to cope
>> with as long as one can find the corresponding svn rev number for a
>> given git object easily).
>
> I think I'm missing something. What do you mean with this?

I mean that rejecting a fetch because upstream has weird history
would make no one happy.
