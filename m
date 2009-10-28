From: Clemens Buchacher <drizzd@aon.at>
Subject: Re: [PATCH/RFC 2/2] completion: allow use without compiling
Date: Wed, 28 Oct 2009 09:19:49 +0100
Message-ID: <20091028081949.GA25488@localhost>
References: <1256589116-6998-1-git-send-email-bebarino@gmail.com> <1256589116-6998-3-git-send-email-bebarino@gmail.com> <7vocntd7vt.fsf@alter.siamese.dyndns.org> <20091027003353.GA29205@localhost> <7v4opld631.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Stephen Boyd <bebarino@gmail.com>,
	"Shawn O. Pearce" <spearce@spearce.org>, git@vger.kernel.org,
	Sverre Rabbelier <srabbelier@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Oct 28 09:20:12 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1N33lL-0002u4-Fw
	for gcvg-git-2@lo.gmane.org; Wed, 28 Oct 2009 09:20:11 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932676AbZJ1IT6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 28 Oct 2009 04:19:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932652AbZJ1IT6
	(ORCPT <rfc822;git-outgoing>); Wed, 28 Oct 2009 04:19:58 -0400
Received: from ey-out-2122.google.com ([74.125.78.26]:48123 "EHLO
	ey-out-2122.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932647AbZJ1IT4 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 28 Oct 2009 04:19:56 -0400
Received: by ey-out-2122.google.com with SMTP id 9so139390eyd.19
        for <git@vger.kernel.org>; Wed, 28 Oct 2009 01:19:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=gamma;
        h=domainkey-signature:received:received:sender:received:date:from:to
         :cc:subject:message-id:references:mime-version:content-type
         :content-disposition:in-reply-to:user-agent;
        bh=weHiuJowTFpNP9llS0Uq6kn6S0cVkgrER0RdL/3ab/4=;
        b=ERip1Job+V2p6lbZqclNGUkl+GgegwLtmJjJh9wsF36ldhIsjoKpcz/TWj2q2zBZtI
         Xp4mkG3LR//70we1KGHhOwXLNSqhRp0Y1G8m3jW3sKZZYCJjOdkLfqY4pv4yDBUu7ktY
         V3tP5FfMB0O4l+NkY0bVFwvWkZAYyClTlSvRc=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=googlemail.com; s=gamma;
        h=sender:date:from:to:cc:bcc:subject:message-id:references
         :mime-version:content-type:content-disposition:in-reply-to
         :user-agent;
        b=nzVoWaAytHmubwZ0pvo/KGFB+aKe7jedjaop2k0awDmVZUy1V7iNxzfG8LsDgQjZZW
         kWy9UPgnAQPBE3Pis/ABevrZnGAL7RCOj4yha/JRpbUjFu2vqLoKwBS+SYYZO7z6yV0w
         CZJ2q8WKjdCcK965i+ADNaKtzQdfqdW4vG2mg=
Received: by 10.211.128.6 with SMTP id f6mr4852083ebn.15.1256717999497;
        Wed, 28 Oct 2009 01:19:59 -0700 (PDT)
Received: from darc.lan (p549A75A2.dip.t-dialin.net [84.154.117.162])
        by mx.google.com with ESMTPS id 6sm3983857ewy.52.2009.10.28.01.19.56
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Wed, 28 Oct 2009 01:19:57 -0700 (PDT)
Received: from drizzd by darc.lan with local (Exim 4.69)
	(envelope-from <drizzd@aon.at>)
	id 1N33kz-0007K6-5L; Wed, 28 Oct 2009 09:19:49 +0100
Content-Disposition: inline
In-Reply-To: <7v4opld631.fsf@alter.siamese.dyndns.org>
User-Agent: Mutt/1.5.18 (2008-05-17)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/131434>

On Mon, Oct 26, 2009 at 05:38:10PM -0700, Junio C Hamano wrote:
> Clemens Buchacher <drizzd@aon.at> writes:
> 
> > On Mon, Oct 26, 2009 at 04:59:18PM -0700, Junio C Hamano wrote:
> >
> >> Stephen Boyd <bebarino@gmail.com> writes:
> >> 
> >> >  This duplicates code, but I don't know of a way to re-use the dynamic
> >> >  code without sourcing a bash script and possibly breaking someone's build.
> >>
> >>  (1) If the script notices that there is a file that contains the command
> >>      list, it sources it; otherwise,
> >
> > Or we substitute the command list in-place, so that we still have the entire
> > completion script in one file.
> 
> That defeats the whole point of my suggestion, as you would be overwriting
> the tracked file.

Ok, not in-place then. What I meant is something like this.

git-completion.bash.in:

 completion script with placeholders for command list generation code and
 static command list

git-command-list.sh:

 bash-agnostic command list generation script

git-completion.bash.generate:

 run git-command-list.sh and replace static command list placeholder in
 git-completion.bash.in, also insert command list generation code into
 git-completion.bash.in, write result to git-completion.bash

Whether or not the command list should be loaded dynamically can be decided
on a per-user basis using a configuration option.

A downside of this approach is that even if we do not need the static
command list, we still need to generate the completion script. I therefore
recommend we make this part of the normal build process.

Alternatively, we could source the command list code. But it's inconvenient
to copy two completion scripts and it will probably cause confusion among
users.

Clemens
