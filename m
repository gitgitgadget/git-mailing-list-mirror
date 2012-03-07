From: Thomas Rast <trast@inf.ethz.ch>
Subject: Re: [PATCH 1/2] perf: compare diff algorithms
Date: Wed, 7 Mar 2012 13:44:26 +0100
Message-ID: <877gywy40l.fsf@thomas.inf.ethz.ch>
References: <87pqcp6fyh.fsf@thomas.inf.ethz.ch>
	<f113867bcf2fec3210cd1a997e1398903b3bdd76.1331039505.git.trast@student.ethz.ch>
	<7vhay1se0g.fsf@alter.siamese.dyndns.org>
	<87y5rdzbpb.fsf@thomas.inf.ethz.ch>
	<7vr4x5qvgd.fsf@alter.siamese.dyndns.org>
	<m31up5tnjw.fsf@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Cc: Junio C Hamano <gitster@pobox.com>,
	Thomas Rast <trast@student.ethz.ch>, <git@vger.kernel.org>,
	Michal Privoznik <mprivozn@redhat.com>,
	Jeff King <peff@peff.net>
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Wed Mar 07 13:44:37 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1S5GEN-0005T7-1F
	for gcvg-git-2@plane.gmane.org; Wed, 07 Mar 2012 13:44:35 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755361Ab2CGMoa (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 7 Mar 2012 07:44:30 -0500
Received: from edge20.ethz.ch ([82.130.99.26]:59658 "EHLO edge20.ethz.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751034Ab2CGMo3 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 7 Mar 2012 07:44:29 -0500
Received: from CAS10.d.ethz.ch (172.31.38.210) by edge20.ethz.ch
 (82.130.99.26) with Microsoft SMTP Server (TLS) id 14.1.355.2; Wed, 7 Mar
 2012 13:44:26 +0100
Received: from thomas.inf.ethz.ch.ethz.ch (129.132.153.233) by cas10.d.ethz.ch
 (172.31.38.210) with Microsoft SMTP Server (TLS) id 14.1.355.2; Wed, 7 Mar
 2012 13:44:26 +0100
In-Reply-To: <m31up5tnjw.fsf@localhost.localdomain> (Jakub Narebski's message
	of "Tue, 6 Mar 2012 13:41:30 -0800")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Originating-IP: [129.132.153.233]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/192446>

Jakub Narebski <jnareb@gmail.com> writes:

> Junio C Hamano <gitster@pobox.com> writes:
>> 
>> But of course, this from a command line would not work:
>> 
>> 	$ perl -MGit
>> 
>> I do not expect it to, and for the ease of testing new versions, I
>> prefer it not to work.
>> 
>> In any case, you should be able to do anything under t/ _before_
>> installing, so relying on having Git.pm in normal @INC is a double
>> no-no.
>
> Thomas, take a look at how it is solved in 't/t9700/test.pl', used by
> 't/t9700-perl-git.sh':
>
>   use lib (split(/:/, $ENV{GITPERLLIB}));

Hum.  The problem is that the user may invoke aggregate.perl manually,
and GITPERLLIB won't be set in that case.

Is there a better solution than duplicating the logic that sets
GITPERLLIB in test-lib.sh within aggregate.perl?

-- 
Thomas Rast
trast@{inf,student}.ethz.ch
