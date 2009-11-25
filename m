From: James Pickens <jepicken@gmail.com>
Subject: Re: [PATCH] grep: --full-tree
Date: Wed, 25 Nov 2009 15:12:26 -0700
Message-ID: <885649360911251412n3e566c8fu536b361b993f2ac6@mail.gmail.com>
References: <7vk4xggv27.fsf@alter.siamese.dyndns.org>
	 <20091125203922.GA18487@coredump.intra.peff.net>
	 <7viqcytjic.fsf@alter.siamese.dyndns.org>
	 <20091125210034.GC18487@coredump.intra.peff.net>
	 <7vmy2as319.fsf@alter.siamese.dyndns.org>
	 <20091125214949.GA31473@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Wed Nov 25 23:12:40 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NDQ6I-0000jE-KK
	for gcvg-git-2@lo.gmane.org; Wed, 25 Nov 2009 23:12:39 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933772AbZKYWMX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 25 Nov 2009 17:12:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754714AbZKYWMW
	(ORCPT <rfc822;git-outgoing>); Wed, 25 Nov 2009 17:12:22 -0500
Received: from mail-iw0-f171.google.com ([209.85.223.171]:45237 "EHLO
	mail-iw0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759383AbZKYWMV (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 25 Nov 2009 17:12:21 -0500
Received: by iwn1 with SMTP id 1so109723iwn.33
        for <git@vger.kernel.org>; Wed, 25 Nov 2009 14:12:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type;
        bh=dx4JjCTAYeCIuI1Ear7+4u81iNuPDjsA0MG4u9MJTw4=;
        b=s0ncLrxTlzdrQ5gmU4ROoCcNUi8nA07mrQhlL6WM788074thlNshX1Id75vN8OMEZx
         1AJBhW6nLPzsWpgTk8VGA6zZuA8vgtFPwBSWSkB3445cYoVG5K/u3c/vXHOWZBTUk1F3
         jClKJ++ZC7/0NrE+CYzB8hIOO8kT/cMcwca+w=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        b=pWuIPNbJuLwjxPHhH1YqIprJvYDtLzo9JeRn3Cl4FNbuxa1sNJx3UlzOlSr2TCPDxA
         fXUZ8oU0VjSFaFDBq+gHT3gYCu0wv01uApH6UWQbjG4YCKN/4iR4bIACRtUsJbrjAK65
         wcyQAxlLTC4xjBn8FBErqeuAhHxxzxcSGz92A=
Received: by 10.231.1.22 with SMTP id 22mr2501681ibd.56.1259187146897; Wed, 25 
	Nov 2009 14:12:26 -0800 (PST)
In-Reply-To: <20091125214949.GA31473@coredump.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/133681>

On Wed, Nov 25, 2009 at 2:49 PM, Jeff King <peff@peff.net> wrote:
> I'm not sure I really understand. "git grep" is routinely producing
> wrong results for me _now_. I'd like to configure it so that it produces
> results more sensible to me. If I am the one who sets the configuration
> variable to something more sensible for my workflow, who am I hurting?

Config options are not free - they add code bloat, increase the maintenance
and testing burden, make it harder to explain how Git works if you have to
say things like "if config X is true, then Git does ..., otherwise Git does
..., unless config Y is false, in which case Git does ...", make it harder
to debug when Git doesn't do what you expected if you have to check a bunch
of configs to figure out what the behavior should be, and make it harder to
develop new features since you have to consider how they might interact with
lots of config options.  So I think the bar for adding config options,
especially ones that fundamentally change user visible behavior, should be
set pretty high, and this one doesn't even come close to getting over the
bar.

I like Junio's suggestion to make paths starting with / anchored to the
top.  If that were added then it would be easy for users to tell Git what
they want; they just have to use the right pathspec, which I think is a
very reasonable requirement.

That's my 2 cents....

James
