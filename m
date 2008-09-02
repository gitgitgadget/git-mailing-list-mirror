From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Add --filedirstat diff option
Date: Tue, 02 Sep 2008 16:40:54 -0700
Message-ID: <7vwshuglq1.fsf@gitster.siamese.dyndns.org>
References: <20080901011259.GA31696@zakalwe.fi>
 <7vd4jnnifp.fsf@gitster.siamese.dyndns.org>
 <20080902115848.GA1252@jolt.modeemi.cs.tut.fi>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Heikki Orsila <shd@modeemi.fi>
X-From: git-owner@vger.kernel.org Wed Sep 03 01:42:46 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KafWD-0001zK-IY
	for gcvg-git-2@gmane.org; Wed, 03 Sep 2008 01:42:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754923AbYIBXlE (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 2 Sep 2008 19:41:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754138AbYIBXlD
	(ORCPT <rfc822;git-outgoing>); Tue, 2 Sep 2008 19:41:03 -0400
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:39636 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754923AbYIBXlA (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 2 Sep 2008 19:41:00 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTP id 2134770B2B;
	Tue,  2 Sep 2008 19:40:59 -0400 (EDT)
Received: from pobox.com (ip68-225-240-211.oc.oc.cox.net [68.225.240.211])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with
 ESMTPSA id 53CBE70B29; Tue,  2 Sep 2008 19:40:56 -0400 (EDT)
In-Reply-To: <20080902115848.GA1252@jolt.modeemi.cs.tut.fi> (Heikki Orsila's
 message of "Tue, 2 Sep 2008 14:58:49 +0300")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 984FFD2E-7948-11DD-8AEB-3113EBD4C077-77302942!a-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/94739>

Heikki Orsila <shd@modeemi.fi> writes:

> On Mon, Sep 01, 2008 at 11:57:46PM -0700, Junio C Hamano wrote:
>> Heikki Orsila <heikki.orsila@iki.fi> writes:
>> 
>> > @@ -2474,7 +2478,10 @@ int diff_opt_parse(struct diff_options *options, const char **av, int ac)
>> >  		options->output_format |= DIFF_FORMAT_DIRSTAT;
>> >  	else if (!strcmp(arg, "--cumulative"))
>> >  		options->output_format |= DIFF_FORMAT_CUMULATIVE;
>> > -	else if (!strcmp(arg, "--check"))
>> > +	else if (opt_arg(arg, 'X', "filedirstat", &options->dirstat_percent)) {
>> > +		options->output_format |= DIFF_FORMAT_DIRSTAT;
>> > +		options->filedirstat = 1;
>> 
>> Why 'X'?  It would never match, confusing to the reader, and risks a
>> sudden change in behaviour when these statements are reordered or somebody
>> mechanically attempts to convert this to parse_options().
>
> This is embarrassing.. I just copied the previous "dirstat" line.. 
> *grin*
>
> Anyway, what about the concept of filedirstat? Is it agreeable?

I am neutral.

I do not think the additional code hurts anybody, so I wouldn't say I do
not want to have the patch anywhere near my tree, but on the other hand,
personally I do not find the feature as interesting or useful as dirstat.

Maybe there are many others who do find this option useful.  I dunno.
