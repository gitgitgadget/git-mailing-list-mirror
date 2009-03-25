From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 3/5] Add option for using a foreign VCS
Date: Wed, 25 Mar 2009 11:58:45 -0700
Message-ID: <7vprg51lay.fsf@gitster.siamese.dyndns.org>
References: <alpine.LNX.1.00.0903242303330.19665@iabervon.org>
 <7v1vsm9jwd.fsf@gitster.siamese.dyndns.org>
 <alpine.LNX.1.00.0903251042280.19665@iabervon.org>
 <7vhc1h5vkt.fsf@gitster.siamese.dyndns.org>
 <alpine.LNX.1.00.0903251442200.19665@iabervon.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Daniel Barkalow <barkalow@iabervon.org>
X-From: git-owner@vger.kernel.org Wed Mar 25 20:00:38 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LmYL6-0002db-Vc
	for gcvg-git-2@gmane.org; Wed, 25 Mar 2009 20:00:37 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752323AbZCYS6x (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 25 Mar 2009 14:58:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750846AbZCYS6x
	(ORCPT <rfc822;git-outgoing>); Wed, 25 Mar 2009 14:58:53 -0400
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:48811 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750830AbZCYS6w (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 25 Mar 2009 14:58:52 -0400
Received: from localhost.localdomain (unknown [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id 1A129A40CC;
	Wed, 25 Mar 2009 14:58:50 -0400 (EDT)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTPSA id D9F0FA40C9; Wed,
 25 Mar 2009 14:58:46 -0400 (EDT)
In-Reply-To: <alpine.LNX.1.00.0903251442200.19665@iabervon.org> (Daniel
 Barkalow's message of "Wed, 25 Mar 2009 14:46:14 -0400 (EDT)")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: FA1A831E-196E-11DE-83E3-32B0EBB1AA3C-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/114647>

Daniel Barkalow <barkalow@iabervon.org> writes:

> On Wed, 25 Mar 2009, Junio C Hamano wrote:
>
>> Daniel Barkalow <barkalow@iabervon.org> writes:
>> 
>> >> > -	if (!prefixcmp(url, "rsync:")) {
>> >> > +	if (remote && remote->foreign_vcs) {
>> >> > +	} else if (!prefixcmp(url, "rsync:")) {
>> >> 
>> >> 	if (...) {
>> >>         	; /* empty */
>> >> 	} else ...
>> >
>> > I don't think I've ever tried writing an empty block for git before. It's 
>> > braces containing a semicolon and comment? (Of course, the reason I wrote 
>> > this one this way is so that the next patch could put two "+" lines in 
>> > there and have no "-" lines)
>> 
>> Wasn't a serious "this has to be the final style" suggestion, but more
>> about "what do you mean by this?  are you going to add more code here in
>> the later round?" question.
>
> Ah, yes, I do intend to add code there subsequently, and this is just a 
> placeholder so that it returns a correctly-constructed struct which 
> doesn't support any operations until those operations are added.

Ah, OK, thanks.

In that case, I would say:

	if (...) {
        	; /* empty for now */
	} else ... {

or even more explicit:

	if (...) {
		/*
                 * NEEDSWORK: later when we activate nitfol,
                 * add code to let gostak distim the doshes here.
                 */
        	;
	} else ... {

to allow people to grep for NEEDSWORK would be more appropriate.
