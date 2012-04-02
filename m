From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: GSOC Proposal draft: git-remote-svn
Date: Mon, 2 Apr 2012 17:29:59 -0500
Message-ID: <20120402222958.GD13969@burratino>
References: <11292500.AVmZFUUvNi@flobuntu>
 <CALkWK0nW91PE2810qrZUbL0x-_YTTA_2tLFVhvXBJ2NFGvVxog@mail.gmail.com>
 <2148933.pnpYo0xMAP@flomedio>
 <2487557.B8qfnaixh3@flomedio>
 <4F7A258C.5000200@pileofstuff.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Florian Achleitner <florian.achleitner@student.tugraz.at>,
	Ramkumar Ramachandra <artagnon@gmail.com>,
	David Barr <davidbarr@google.com>,
	Git Mailing List <git@vger.kernel.org>,
	Sverre Rabbelier <srabbelier@gmail.com>,
	Dmitry Ivankov <divanorama@gmail.com>
To: Andrew Sayers <andrew-git@pileofstuff.org>
X-From: git-owner@vger.kernel.org Tue Apr 03 00:30:27 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SEplT-0001Jl-Rm
	for gcvg-git-2@plane.gmane.org; Tue, 03 Apr 2012 00:30:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753692Ab2DBWaM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 2 Apr 2012 18:30:12 -0400
Received: from mail-iy0-f174.google.com ([209.85.210.174]:36985 "EHLO
	mail-iy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753254Ab2DBWaK (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 2 Apr 2012 18:30:10 -0400
Received: by iagz16 with SMTP id z16so4698242iag.19
        for <git@vger.kernel.org>; Mon, 02 Apr 2012 15:30:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=YZ+PnormlSCqUQoKLadCzQv4UlmxUS/pp5IjQBVij0Y=;
        b=mfg7TXgKO1NyI5tJUEeEUYJJZHnvTUp5995mg/KAtgBtuFmmCwIMQZOPNL7Yx5X4zI
         7HUNcIspgH0M0L14h1HefsVe77UiSQSsPeLJgJnINvyqYE9J+1Fd5ybEu4f1+O5F238W
         NCwG52UW1H5vgLqryOBsMTbrtCOQx9zQhEv2KUk3aiUuu1Z+69oC8aw6HgSglfjml/tR
         seG9KcKbqwA7dcLynHQtt4SSaIr53Jzlr56KrJ+P+HFQCUA7nYaMgVUnKbiFwA26GjoH
         PThD9INW1uT5Fa79e0Mbsc2zk18qexvBAVMsZKzpHVEve3oEGCSSZrHsddous76luxXE
         Szgg==
Received: by 10.50.153.132 with SMTP id vg4mr7035371igb.2.1333405810210;
        Mon, 02 Apr 2012 15:30:10 -0700 (PDT)
Received: from burratino (c-24-1-56-9.hsd1.il.comcast.net. [24.1.56.9])
        by mx.google.com with ESMTPS id re5sm110062igb.0.2012.04.02.15.30.08
        (version=SSLv3 cipher=OTHER);
        Mon, 02 Apr 2012 15:30:09 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <4F7A258C.5000200@pileofstuff.org>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/194572>

Hi Andrew,

Andrew Sayers wrote:
> On 02/04/12 09:30, Florian Achleitner wrote:

>> The remote helper has to convert the foreign protocol and data (svn) to the 
>> git-fast-import format.
>
> As discussed on IRC, I'd like to see some discussion of solutions that
> use plumbing directly (e.g. git-commit-tree) if you choose to focus on
> branch import.

Do you mean that fast-import is not a plumbing command?

>From the IRC log[1]:

> andrew_sayers	From my reading of the protocol, you'd have to pass
>              	all the files in for each branch.
> andrew_sayers	For each commit.

I'm a little confused by this.  Do you mean that a fast-import stream
is not allowed to use multiple branches, or that when a fast-import
stream represents a commit that changes one file, it needs to list
all files rather than the one that changed?  Neither is true.

The fast-import tool started as a tool to write objects to pack
directly, or in other words to save time by avoiding the step of
writing loose objects.  That is still one of its main benefits.

[...]
>> 3. Add output capabilities to vcs-svn. Currently the code in vcs-svn can only 
>> convert svn to git. To push to svn we also need conversion and mapping from 
>> git to svn. The actual mapping code for branches should also be placed here 
>> {??} and called by the remote helper.
>
> I agree with Jonathan and Ram that we're not ready for this yet.

Just to be clear, I never said such a thing. :)

Thanks for some useful clarifications.
Jonathan

[1] http://colabti.org/irclogger/irclogger_log/git-devel?date=2012-04-02#l153
