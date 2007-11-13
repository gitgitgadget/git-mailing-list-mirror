From: Matthieu Moy <Matthieu.Moy@imag.fr>
Subject: Re: Cloning empty repositories, was Re: What is the idea for bare repositories?
Date: Tue, 13 Nov 2007 11:50:16 +0100
Message-ID: <vpqpryefmhj.fsf@bauges.imag.fr>
References: <Pine.LNX.4.64.0711121715090.4362@racer.site>
	<18232.35893.243300.179076@lisa.zopyra.com>
	<Pine.LNX.4.64.0711121727130.4362@racer.site>
	<vpq7iknqrtp.fsf@bauges.imag.fr>
	<Pine.LNX.4.64.0711121755460.4362@racer.site>
	<vpqy7d3pck0.fsf@bauges.imag.fr>
	<Pine.LNX.4.64.0711121804400.4362@racer.site>
	<vpqoddzpc88.fsf@bauges.imag.fr>
	<7v4pfr2kmh.fsf@gitster.siamese.dyndns.org>
	<vpqzlxiiii6.fsf@bauges.imag.fr> <20071113100209.GE14735@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Bill Lear <rael@zopyra.com>,
	Jan Wielemaker <wielemak@science.uva.nl>, git@vger.kernel.org
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Tue Nov 13 11:51:40 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IrtMq-0005X7-4V
	for gcvg-git-2@gmane.org; Tue, 13 Nov 2007 11:51:40 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752083AbXKMKvY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 13 Nov 2007 05:51:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751778AbXKMKvY
	(ORCPT <rfc822;git-outgoing>); Tue, 13 Nov 2007 05:51:24 -0500
Received: from imag.imag.fr ([129.88.30.1]:63527 "EHLO imag.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751328AbXKMKvX (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 13 Nov 2007 05:51:23 -0500
Received: from mail-veri.imag.fr (mail-veri.imag.fr [129.88.43.52])
	by imag.imag.fr (8.13.8/8.13.8) with ESMTP id lADAoV31023339
	(version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NO);
	Tue, 13 Nov 2007 11:50:31 +0100 (CET)
Received: from bauges.imag.fr ([129.88.43.5])
	by mail-veri.imag.fr with esmtps (TLS-1.0:RSA_AES_256_CBC_SHA:32)
	(Exim 4.50)
	id 1IrtLU-0002w5-OU; Tue, 13 Nov 2007 11:50:16 +0100
Received: from moy by bauges.imag.fr with local (Exim 4.63)
	(envelope-from <moy@imag.fr>)
	id 1IrtLU-0001Gc-Lx; Tue, 13 Nov 2007 11:50:16 +0100
In-Reply-To: <20071113100209.GE14735@spearce.org> (Shawn O. Pearce's message of "Tue\, 13 Nov 2007 05\:02\:09 -0500")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.1 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-3.0 (imag.imag.fr [129.88.30.1]); Tue, 13 Nov 2007 11:50:32 +0100 (CET)
X-IMAG-MailScanner-Information: Please contact IMAG DMI for more information
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: moy@imag.fr
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/64788>

"Shawn O. Pearce" <spearce@spearce.org> writes:

> So setting up an empty tree is basically that:
>
> 	mkdir foo && cd foo && git init &&
> 	git remote add origin $url

It is not.

The "git remote add" thing adds this to my .git/config:

[remote "origin"]
        url = /tmp/git1
        fetch = +refs/heads/*:refs/remotes/origin/*

While clone normally does a bit more:

[remote "origin"]
        url = /tmp/git1/.git
        fetch = +refs/heads/*:refs/remotes/origin/*
[branch "master"]
        remote = origin
        merge = refs/heads/master

So, it's really

$ git remote add origin url
$ $EDITOR .git/config    # or perhaps I missed the way to set the two
                         # options easily.

I find it so conveinient to have it for non-empty clones, it's
frustrating to have to do it by hand for empty clones.

-- 
Matthieu
