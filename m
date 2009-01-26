From: Jay Soffian <jaysoffian@gmail.com>
Subject: Re: backwards compatibility, was Re: [PATCH v1 1/3] Introduce config 
	variable "diff.primer"
Date: Mon, 26 Jan 2009 14:49:15 -0500
Message-ID: <76718490901261149xfedc415j8f5dab677b90d693@mail.gmail.com>
References: <1232904657-31831-1-git-send-email-keith@cs.ucla.edu>
	 <1232904657-31831-2-git-send-email-keith@cs.ucla.edu>
	 <7v1vurf7lq.fsf@gitster.siamese.dyndns.org>
	 <alpine.GSO.2.00.0901251345240.12651@kiwi.cs.ucla.edu>
	 <20090126031206.GB14277@sigill.intra.peff.net>
	 <alpine.DEB.1.00.0901261154330.14855@racer>
	 <20090126111605.GB19993@coredump.intra.peff.net>
	 <76718490901260729m21ba140dke157d1d461aed2d5@mail.gmail.com>
	 <20090126184829.GA27543@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Keith Cascio <keith@cs.ucla.edu>,
	Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Mon Jan 26 20:51:45 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LRXTn-0001l0-M1
	for gcvg-git-2@gmane.org; Mon, 26 Jan 2009 20:50:44 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752950AbZAZTtR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 26 Jan 2009 14:49:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751884AbZAZTtR
	(ORCPT <rfc822;git-outgoing>); Mon, 26 Jan 2009 14:49:17 -0500
Received: from rv-out-0506.google.com ([209.85.198.231]:46348 "EHLO
	rv-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751500AbZAZTtR (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 26 Jan 2009 14:49:17 -0500
Received: by rv-out-0506.google.com with SMTP id k40so6001111rvb.1
        for <git@vger.kernel.org>; Mon, 26 Jan 2009 11:49:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=y0E0dqxSCRARorV6WhCcORuNEHMYgcS1RVasq/HI1ic=;
        b=tj3OasDMhKsEyqK9lLoLxUHXxDpgL0/x2AjNGKzOdzYIRwxh1aHCxEWvFm9SSucLas
         NLm6AjV9jutMkELfW5FGWg/D/2muMLyZsF4Hm9fUBrf70thU7cytiyfaVR7EPOQcFpZ6
         kDdBZ0OxXeuLHfOdIcnl33PRCMH+VJODt3MWo=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=lbVbQQwQGtAHxfkLICwRiAjJO5UY6ZaAdOVvP95+XVeqnVrjFF0EjAQySx9ZJg4zyK
         C2nmNU4YR3wkptlEeJYjxMZ0VngqwjTsT2zjU01M/ET3rJ/JWvPtUbM94l6RtMAJheve
         d7jZtbaCD+5nWDObCYKf+71WQhCxTFUUwlSIg=
Received: by 10.141.36.10 with SMTP id o10mr2485803rvj.254.1232999356021; Mon, 
	26 Jan 2009 11:49:16 -0800 (PST)
In-Reply-To: <20090126184829.GA27543@coredump.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/107258>

On Mon, Jan 26, 2009 at 1:48 PM, Jeff King <peff@peff.net> wrote:
> But then you have that problem that the _user_ is stuck specifying "OK,
> turn on fancy features." And I don't relish the thought of typing "git
> diff -J" every time. :)

Well, this issue seems to come up every so often, so the idea would be:

- We're adding a mechanism for scripts to communicate that they need
plumbing context
- Start using it in your scripts when calling git if you rely on a
stable interface
- In the next major release, git may introduce changes to commands
which are not clearly plumbing if you haven't adopted the mechanism

Where mechanism could be a switch, environment variable, etc.
Typically in a network API, the client and server have a way to
negotiate the highest level each supports; that's missing from git,
but seems like it would be useful.

j.

p.s. perhaps you'd prefer -P? :)
