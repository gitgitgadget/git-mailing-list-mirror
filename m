From: "Marco Costalba" <mcostalba@gmail.com>
Subject: Re: how to display file history?
Date: Mon, 15 May 2006 19:22:01 +0200
Message-ID: <e5bfff550605151022m7b9ddcd9y53cd745e16ff6b22@mail.gmail.com>
References: <CFF307C98FEABE47A452B27C06B85BB670F4FD@hdsmsx411.amr.corp.intel.com>
	 <7v64k7wzzf.fsf@assigned-by-dhcp.cox.net>
	 <m1ejyv7077.fsf@ebiederm.dsl.xmission.com>
	 <Pine.LNX.4.64.0605150900510.3866@g5.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
	format=flowed
Content-Transfer-Encoding: 7BIT
Cc: "Eric W. Biederman" <ebiederm@xmission.com>,
	"Junio C Hamano" <junkio@cox.net>,
	"Brown, Len" <len.brown@intel.com>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon May 15 19:22:41 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Ffglu-0004GI-M1
	for gcvg-git@gmane.org; Mon, 15 May 2006 19:22:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965005AbWEORWG (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 15 May 2006 13:22:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965006AbWEORWF
	(ORCPT <rfc822;git-outgoing>); Mon, 15 May 2006 13:22:05 -0400
Received: from wr-out-0506.google.com ([64.233.184.236]:31173 "EHLO
	wr-out-0506.google.com") by vger.kernel.org with ESMTP
	id S965000AbWEORWC convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 15 May 2006 13:22:02 -0400
Received: by wr-out-0506.google.com with SMTP id i12so4235wra
        for <git@vger.kernel.org>; Mon, 15 May 2006 10:22:01 -0700 (PDT)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=tHeqoYQ1yGIB+gBLDojy31jdo4cV2XPyA+i+5uwXT2LdtEO8Q1keoTa4p9DEdz7nXD8z3LkkuERd7hl2mfG2GfV5k+bj3bCO+wd292jc2qRRX/6T3dHybdEEFE3s/SrEFOfTtwwxguHH37aW244o+7zk+5QQwfjdUjKiZFnsob4=
Received: by 10.65.197.9 with SMTP id z9mr4009405qbp;
        Mon, 15 May 2006 10:22:01 -0700 (PDT)
Received: by 10.64.131.11 with HTTP; Mon, 15 May 2006 10:22:01 -0700 (PDT)
To: "Linus Torvalds" <torvalds@osdl.org>
In-Reply-To: <Pine.LNX.4.64.0605150900510.3866@g5.osdl.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/20068>

>
> So
>
>         gitk --all --since=1.month -15 -- t/
>
> will show at most fifteen commits from _any_ branch that changed the
> test subdirectory in the last month.
>
> And yeah, maybe that isn't a very interesting query, but it's easy to
> explain and understand, so it's worth explaining early.
>
> And it should be equally obvious to everybody that if it works for "gitk",
> that means that it works for "qgit", "git log" and "git whatchanged" too,

For qgit it doesn't work :-)

Well, it works but the nice boundary circles are not shown, and qgit
always adds  --boundary to command line args to feed git-rev-list, but
in this case it seems the --boundary option didn't do his job.

$git-rev-list --topo-order --boundary --parents --all --since=1.month -15 -- t/
ea892b27b15fbc46a3bb3ad2ddce737dc6590ae5
b0121fb3f279a9cf13aff9da060e742aef3a83fa
8d48ad62a902556b523ee892a3fbe4206d576d3f
8d48ad62a902556b523ee892a3fbe4206d576d3f
2c49009dbe98a26505891d3c680da73baf0b4f81
d14f776402d9f7040cc71ff6e3b992b2e019526a
b0121fb3f279a9cf13aff9da060e742aef3a83fa
7f498065e9bf85f6f3e954ec57dedf56fec29e01
6bd20358a9b831b3b545284188871bc844245c25
6bd20358a9b831b3b545284188871bc844245c25
9af0b8dbe2fb252262412a11254e2bcc6ffb87bb
7f498065e9bf85f6f3e954ec57dedf56fec29e01
c2b9e6994d044b218e59abf6d19f7751c4aa13e3
dd05ea1799656024a45017238bbd4857b5256370
c2b9e6994d044b218e59abf6d19f7751c4aa13e3
aadc81c13bbb103e7db759ba9a98a6f9509831f1
bd886fd3ea49b726493255d4adf5d20b31681713
aadc81c13bbb103e7db759ba9a98a6f9509831f1
42d0ee8302c361a0e3bde7bc59858eda94bc13a4
22293b9c41778bb60f3b07355e1b8e421a503702
2c49009dbe98a26505891d3c680da73baf0b4f81
143f4d94c6e2188a6bedfdfa268e66b579e3fbf9
dd05ea1799656024a45017238bbd4857b5256370
dd05ea1799656024a45017238bbd4857b5256370
fd60acaced6de16ebfb66959067e2b29f99a133e
143f4d94c6e2188a6bedfdfa268e66b579e3fbf9
2fc240a7b21c060529c1d2e19d6b483361f81f2a
22293b9c41778bb60f3b07355e1b8e421a503702
22293b9c41778bb60f3b07355e1b8e421a503702
83e77a25dc194933c0fb7908ab6d9fb84a5045e2
83e77a25dc194933c0fb7908ab6d9fb84a5045e2
2fa9a0fb31cbf01e8318a02c3e222d7fd3fd0a83
2fc240a7b21c060529c1d2e19d6b483361f81f2a
fd60acaced6de16ebfb66959067e2b29f99a133e
42d0ee8302c361a0e3bde7bc59858eda94bc13a4
42d0ee8302c361a0e3bde7bc59858eda94bc13a4
2fa9a0fb31cbf01e8318a02c3e222d7fd3fd0a83
fd60acaced6de16ebfb66959067e2b29f99a133e
bd886fd3ea49b726493255d4adf5d20b31681713
cf9dc65368113caa28f2829e2ada5477fbb031ec


       Marco
