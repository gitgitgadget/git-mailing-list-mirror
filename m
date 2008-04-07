From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 1/4] Add history graph API
Date: Sun, 06 Apr 2008 20:12:50 -0700
Message-ID: <7v4paes6h9.fsf@gitster.siamese.dyndns.org>
References: <1207507332-1866-1-git-send-email-adam@adamsimpkins.net>
 <alpine.DEB.1.00.0804062204580.12583@eeepc-johanness>
 <20080406220447.GB5822@adamsimpkins.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	git@vger.kernel.org
To: Adam Simpkins <adam@adamsimpkins.net>
X-From: git-owner@vger.kernel.org Mon Apr 07 05:14:09 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Jiho6-0006Hi-9P
	for gcvg-git-2@gmane.org; Mon, 07 Apr 2008 05:14:06 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753836AbYDGDNI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 6 Apr 2008 23:13:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753800AbYDGDNH
	(ORCPT <rfc822;git-outgoing>); Sun, 6 Apr 2008 23:13:07 -0400
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:48291 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753748AbYDGDNG (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 6 Apr 2008 23:13:06 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id 98C0C7D49;
	Sun,  6 Apr 2008 23:13:03 -0400 (EDT)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with
 ESMTP id DC0D67D47; Sun,  6 Apr 2008 23:12:57 -0400 (EDT)
In-Reply-To: <20080406220447.GB5822@adamsimpkins.net> (Adam Simpkins's
 message of "Sun, 6 Apr 2008 15:04:48 -0700")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/78946>

Adam Simpkins <adam@adamsimpkins.net> writes:

> On Sun, Apr 06, 2008 at 10:06:24PM +0100, Johannes Schindelin wrote:
>> 
>> On Sun, 6 Apr 2008, Adam Simpkins wrote:
>> 
>> > +/* Defined in commit.h */
>> > +struct commit;
>> > +/* Defined in strbuf.h */
>> > +struct strbuf;
>> 
>> You do not need those.
>
> I added them so that graph.h can be included without including any
> other header files first.  They can be taken out if we assume that all
> users of graph.h will include commit.h and strbuf.h first.

The current practice is we expect .c files to include necessary .h files
themselves and avoid including .h files from others (I do not personally
necessarily agree with this practice, by the way, but that is the way it
is).  So please drop them.

> Sorry, force of habit.  I tried to remember to use postfix in most
> places, but I guess I forgot in that place.

We seem to consistently use postfix when increment is done only for its
side effect.
