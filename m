From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Fix problem with authentification on http repository.
Date: Tue, 08 Jul 2008 23:28:15 -0700
Message-ID: <7vlk0blgg0.fsf@gitster.siamese.dyndns.org>
References: <11911047823308-git-send-email-jean.guyader@linkea.org>
 <7v8x6pjb4c.fsf@gitster.siamese.dyndns.org>
 <Pine.LNX.4.64.0709300039430.28395@racer.site>
 <7v4phdja01.fsf@gitster.siamese.dyndns.org>
 <7v4p6zmx0l.fsf@gitster.siamese.dyndns.org>
 <20080709055150.GA28482@glandium.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	jean.guyader@linkea.org, git@vger.kernel.org,
	Jean Guyader <jean.guyader@gmail.com>
To: Mike Hommey <mh@glandium.org>
X-From: git-owner@vger.kernel.org Wed Jul 09 08:29:27 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KGTB6-0006kT-Vm
	for gcvg-git-2@gmane.org; Wed, 09 Jul 2008 08:29:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751803AbYGIG21 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 9 Jul 2008 02:28:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751887AbYGIG21
	(ORCPT <rfc822;git-outgoing>); Wed, 9 Jul 2008 02:28:27 -0400
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:54712 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751526AbYGIG20 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 9 Jul 2008 02:28:26 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id 55D5418DD2;
	Wed,  9 Jul 2008 02:28:24 -0400 (EDT)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with
 ESMTPSA id 7FBC318DCD; Wed,  9 Jul 2008 02:28:17 -0400 (EDT)
In-Reply-To: <20080709055150.GA28482@glandium.org> (Mike Hommey's message of
 "Wed, 9 Jul 2008 07:51:50 +0200")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 3BADCDCE-4D80-11DD-915E-CE28B26B55AE-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/87853>

Mike Hommey <mh@glandium.org> writes:

> On Tue, Jul 08, 2008 at 10:44:58PM -0700, Junio C Hamano wrote:
>> Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:
>> 
>> > On Sat, 29 Sep 2007, Junio C Hamano wrote:
>> >
>> >> We never supported URLs with embedded credentials (see
>> >> Documentation/urls.txt), partly because nobody asked for it, but
>> >> more importantly because giving -n to curl to have it read from
>> >> user's .netrc is generally much more preferred approach.
>> >
>> > To elaborate on that: if you fetch from somewhere, your url, username and 
>> > password can be read from the output of "ps ax | grep http" very easily.
>> 
>> Actually Documentation/howto/setup-git-server-over-http.txt
>> talks about http://user@server/path/ format.  How well does this
>> work in practice?  If it does, we should update Documentation/urls.txt
>> to allow optional user@ there like...
>
> AFAIK, there is nothing to deal with asking a password to the user in git
> in this case, so that doesn't work.

Then perhaps the howto needs updating?
