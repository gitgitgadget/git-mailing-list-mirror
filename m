From: Sverre Rabbelier <srabbelier@gmail.com>
Subject: Re: GSoC 2010
Date: Fri, 12 Feb 2010 17:41:21 +0100
Message-ID: <fabb9a1e1002120841o71651f82h782eab46206df402@mail.gmail.com>
References: <fabb9a1e1002101223o6a00f7eavb84567c1119c8ebc@mail.gmail.com> 
	<20100212080620.GA31719@dcvr.yhbt.net> <alpine.DEB.1.00.1002121000290.20986@pacific.mpi-cbg.de> 
	<fabb9a1e1002120103j3f37d417ka5b7b7ca3ae8edd@mail.gmail.com> 
	<20100212091635.GA22942@glandium.org> <alpine.DEB.1.00.1002121034320.20986@pacific.mpi-cbg.de> 
	<fabb9a1e1002120132q157d2d4dqd7c81d766bd933f6@mail.gmail.com> 
	<alpine.LNX.2.00.1002120923060.14365@iabervon.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Mike Hommey <mh@glandium.org>,
	Eric Wong <normalperson@yhbt.net>, Jeff King <peff@peff.net>,
	"Shawn O. Pearce" <spearce@spearce.org>,
	Git List <git@vger.kernel.org>
To: Daniel Barkalow <barkalow@iabervon.org>
X-From: git-owner@vger.kernel.org Fri Feb 12 17:41:48 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NfyaR-0007ZC-L4
	for gcvg-git-2@lo.gmane.org; Fri, 12 Feb 2010 17:41:48 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757179Ab0BLQln (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 12 Feb 2010 11:41:43 -0500
Received: from mail-gx0-f224.google.com ([209.85.217.224]:63575 "EHLO
	mail-gx0-f224.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756930Ab0BLQlm (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 12 Feb 2010 11:41:42 -0500
Received: by gxk24 with SMTP id 24so2552486gxk.1
        for <git@vger.kernel.org>; Fri, 12 Feb 2010 08:41:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :from:date:message-id:subject:to:cc:content-type;
        bh=3w7V8FXxT879vS7U0gpB7DmS/MftGpFKw+dsai3NdAU=;
        b=VHXOKgqCT3rLhyma91+5kkQ3nP8+vcw9oA6oTxFAfyYoPkBlKbHP7yaC2+e9rd3Jdn
         v4A4oJiVZO0hRQ9Eb3acW39um8PBE4TzVxumvW6lr4m4oVdVYOtKU6hO+nJ65PV+fsYk
         SCnpXn2woWGEpYSZGuAuMrLxzEJiINfyEUGTY=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        b=unHZq+3hSIR24lA0+6r4Q1YU4PJz624+Ty67N/AtQAjlRzqi+pyZJCS3g4u0jDNzbW
         5fho3yMowyjBwQ1L+Xc9LxzGHFYE+wv3CKElr/bshYz/1mccXMt8khC4TsjuKJ6OBKrC
         RalLW+QoVsO4+w0bu4QKQsDEoTEHYfmt+BS1c=
Received: by 10.142.250.22 with SMTP id x22mr1074801wfh.222.1265992901108; 
	Fri, 12 Feb 2010 08:41:41 -0800 (PST)
In-Reply-To: <alpine.LNX.2.00.1002120923060.14365@iabervon.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/139723>

Heya,

On Fri, Feb 12, 2010 at 17:10, Daniel Barkalow <barkalow@iabervon.org> wrote:
> Also note that the current helper protocol is definitely insufficient to
> replace git-svn ('export' isn't actually specified, although I think
> everyone who guesses how it works guesses the same thing),

I've finally started implementing this yesterday.

> and the
> transport code needs to be extended to handle the "dcommit" situation
> (when you push a commit, the state that you see on the remote changes
> based on the semantics of what you sent, but it does not change to have
> the same hash as what you pushed).

So basically what you want to do is after you push, automagically do a
'git reset --hard @{u}'? That could be handled by a specific response
from the helper to the 'export'/'push' command, perhaps it could list
which refs need to be updated?

-- 
Cheers,

Sverre Rabbelier
