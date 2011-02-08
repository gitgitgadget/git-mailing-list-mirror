From: Martin von Zweigbergk <martin.von.zweigbergk@gmail.com>
Subject: Re: [1.8.0] git checkout refs/heads/foo checks out branch foo
Date: Mon, 7 Feb 2011 19:31:12 -0500 (EST)
Message-ID: <alpine.DEB.1.10.1102071925440.3788@debian>
References: <alpine.DEB.1.10.1102062234010.3788@debian> <20110207205934.GD13461@sigill.intra.peff.net> <AANLkTinmqTi4cYbR6PtSxt6itCvFQDuT_sE1tjx45a3h@mail.gmail.com> <20110207220030.GA19357@elie> <7vaai7s9g4.fsf@alter.siamese.dyndns.org>
 <20110207234526.GA28336@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Junio C Hamano <gitster@pobox.com>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Sverre Rabbelier <srabbelier@gmail.com>,
	Martin von Zweigbergk <martin.von.zweigbergk@gmail.com>,
	git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Tue Feb 08 01:31:22 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PmbUI-0005WW-3Y
	for gcvg-git-2@lo.gmane.org; Tue, 08 Feb 2011 01:31:22 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755426Ab1BHAbR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 7 Feb 2011 19:31:17 -0500
Received: from mail-qw0-f46.google.com ([209.85.216.46]:41071 "EHLO
	mail-qw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755396Ab1BHAbQ (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 7 Feb 2011 19:31:16 -0500
Received: by qwa26 with SMTP id 26so3789320qwa.19
        for <git@vger.kernel.org>; Mon, 07 Feb 2011 16:31:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:date:from:x-x-sender:to:cc:subject:in-reply-to
         :message-id:references:user-agent:mime-version:content-type;
        bh=X6IEGEUNKC9SQHwDDd6afU8fEHk/RIevwpKYylGXlgk=;
        b=XEySQXTj5xh3XRqDq5cvxDx6uHe4PufpPOSJGGfUY/Ioys0Ew73cDQ6ouZXor6e3wj
         XsfqLOl8Uh7UXLx5QI2LbDfMwol8DKv9uAfJXv/l3DFzamypH5l9Zn56w7PXRGIuFjY1
         ZVANxO2Rsl/g1CYtnx6Y067Lyk8NQGCDh/xts=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:x-x-sender:to:cc:subject:in-reply-to:message-id
         :references:user-agent:mime-version:content-type;
        b=iVYfuSiQOclT7WE4a8E3MjSo0GPi2YR4zU8WC/MFCdmmxwSD58mGSWJOwpf8lWitmb
         GniMrBAOiLoTPAAoarYLU1aA56dV8aSYcqiG+g1xTMzw7s1g0fspDiiPImFtEtOMG2nv
         d8+urzPCOfASAPae1gxOwJThaFU+3aaq0jtqs=
Received: by 10.224.37.146 with SMTP id x18mr14932673qad.157.1297125075551;
        Mon, 07 Feb 2011 16:31:15 -0800 (PST)
Received: from [192.168.1.104] (modemcable151.183-178-173.mc.videotron.ca [173.178.183.151])
        by mx.google.com with ESMTPS id s21sm2889045qct.8.2011.02.07.16.31.13
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Mon, 07 Feb 2011 16:31:14 -0800 (PST)
X-X-Sender: martin@debian
In-Reply-To: <20110207234526.GA28336@sigill.intra.peff.net>
User-Agent: Alpine 1.10 (DEB 962 2008-03-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/166315>

On Mon, 7 Feb 2011, Jeff King wrote:

> On Mon, Feb 07, 2011 at 03:37:15PM -0800, Junio C Hamano wrote:
> 
> > > Subject: commit: document --detach synonym for "git checkout foo^{commit}"
> > >
> > > For example, one might use this when making a temporary merge to test
> > > that two topics work well together.
> > >
> > > This patch just documents the option.  It is not meant for application
> > > without an implementation and tests for the option.
> > 
> > On top of v1.7.3.5-1-g0cb6ad3 (uk/checkout-ambiguous-ref)...
> 
> Well, I started on tests and your email came just as I was about to
> actually implement. So here are the tests. We didn't seem to have any
> explicit checkout-detached tests before, so I tried to cover existing
> methods in addition to the new option (which means Martin will need to
> tweak one of the tests below when implementing his proposal).

Oops, I didn't know writing a proposal meant signing up to do it as
well ;-). But seriously, this seems like a relatively small change, so
it will hopefully be a good reason for me to push myself to get
started with the C code as well.
