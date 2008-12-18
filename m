From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCHv5 2/3] gitweb: add patches view
Date: Thu, 18 Dec 2008 11:15:37 -0800
Message-ID: <7viqphguqu.fsf@gitster.siamese.dyndns.org>
References: <1229422290-6213-1-git-send-email-giuseppe.bilotta@gmail.com>
 <1229422290-6213-3-git-send-email-giuseppe.bilotta@gmail.com>
 <7v4p12hv5q.fsf@gitster.siamese.dyndns.org>
 <200812181033.57360.jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Giuseppe Bilotta <giuseppe.bilotta@gmail.com>, git@vger.kernel.org,
	Petr Baudis <pasky@suse.cz>
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Thu Dec 18 20:17:10 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LDOMv-0002bw-Rr
	for gcvg-git-2@gmane.org; Thu, 18 Dec 2008 20:17:10 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751185AbYLRTPw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 18 Dec 2008 14:15:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751379AbYLRTPw
	(ORCPT <rfc822;git-outgoing>); Thu, 18 Dec 2008 14:15:52 -0500
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:56348 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750973AbYLRTPv (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 18 Dec 2008 14:15:51 -0500
Received: from localhost.localdomain (unknown [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id 3C16688EEE;
	Thu, 18 Dec 2008 14:15:50 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES256-SHA (256/256 bits)) (No client certificate requested) by
 a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTPSA id 0C29088EED; Thu,
 18 Dec 2008 14:15:44 -0500 (EST)
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 4817596C-CD38-11DD-92E5-5720C92D7133-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/103480>

Jakub Narebski <jnareb@gmail.com> writes:

> On Thu, 18 Dec 2008, Junio C Hamano wrote:
>> Giuseppe Bilotta <giuseppe.bilotta@gmail.com> writes:
>> 
>> >  sub git_commitdiff {
>> >  	my $format = shift || 'html';
>> > +	my %params = @_;
>> > ...  
>> > +			if ($params{-single}) {
>> > +				push @commit_spec, '-1';
>> > +			} else {
>> > +				if ($patch_max > 0) {
>> > ...
>> > +			}
>> > @@ -5625,6 +5635,10 @@ sub git_commitdiff_plain {
>> >  
>> >  # format-patch-style patches
>> >  sub git_patch {
>> > +	git_commitdiff('patch', -single=> 1);
>> > +}
>> 
>> Hmm, if you are changing the interface this way, wouldn't it make more
>> sense to also do this?
>> 
>> 	git_commitdiff(--format => 'patch', --single => 1);
>> 	git_commitdiff(--format => 'html');
>
> The first argument (format) is _required_, second is _optional_;

My reading of the first line of the sub seems to contradict with your
statement.  "If the first argument is empty, we use 'html' instead" sounds
pretty optional to me.
