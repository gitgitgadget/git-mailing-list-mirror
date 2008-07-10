From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Fix problem with authentification on http repository.
Date: Thu, 10 Jul 2008 00:32:27 -0700
Message-ID: <7vk5fuqjn8.fsf@gitster.siamese.dyndns.org>
References: <7v8x6pjb4c.fsf@gitster.siamese.dyndns.org>
 <Pine.LNX.4.64.0709300039430.28395@racer.site>
 <7v4phdja01.fsf@gitster.siamese.dyndns.org>
 <7v4p6zmx0l.fsf@gitster.siamese.dyndns.org>
 <20080709055150.GA28482@glandium.org>
 <7vlk0blgg0.fsf@gitster.siamese.dyndns.org>
 <20080709075345.GA22022@glandium.org>
 <7vhcazlbch.fsf@gitster.siamese.dyndns.org>
 <20080709085651.GA23453@glandium.org>
 <alpine.DEB.1.00.0807091341230.5277@eeepc-johanness>
 <20080710072420.GA5167@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Mike Hommey <mh@glandium.org>, jean.guyader@linkea.org,
	git@vger.kernel.org, Jean Guyader <jean.guyader@gmail.com>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Thu Jul 10 09:34:08 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KGqf1-0001eb-Bc
	for gcvg-git-2@gmane.org; Thu, 10 Jul 2008 09:33:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756554AbYGJHcp (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 10 Jul 2008 03:32:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756527AbYGJHcp
	(ORCPT <rfc822;git-outgoing>); Thu, 10 Jul 2008 03:32:45 -0400
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:65347 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756475AbYGJHcn (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 10 Jul 2008 03:32:43 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id E48A31FA64;
	Thu, 10 Jul 2008 03:32:41 -0400 (EDT)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with
 ESMTPSA id 0ECDF1FA63; Thu, 10 Jul 2008 03:32:34 -0400 (EDT)
In-Reply-To: <20080710072420.GA5167@sigill.intra.peff.net> (Jeff King's
 message of "Thu, 10 Jul 2008 03:24:20 -0400")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 61643A12-4E52-11DD-AFDA-CE28B26B55AE-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/87951>

Jeff King <peff@peff.net> writes:

> On Wed, Jul 09, 2008 at 01:43:07PM +0200, Johannes Schindelin wrote:
>
>> > Note that http://user:pass@server/path/ /should/ work (but that would 
>> > need validation), though not a good idea on command line.
>> 
>> Well, now that the programs using URLs are all builtins, we can actually 
>> do something about it.  We can edit out the "user[:pass]@" part out of 
>> argv, which usually means that "ps" will not see it anymore.
>
> Wouldn't there still be a race condition for publicly broadcasting your
> password via ps?

In addition, I think on some Unices overwriting argv[0] does not have the
effect Dscho is aiming for.

I thought we do discourage [:pass] part in our documentation.
