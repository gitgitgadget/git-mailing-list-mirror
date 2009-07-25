From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 02/10] gitweb: Mark boundary commits in 'blame' view
Date: Fri, 24 Jul 2009 17:39:27 -0700
Message-ID: <7vskgl38ao.fsf@alter.siamese.dyndns.org>
References: <1248475450-5668-1-git-send-email-jnareb@gmail.com>
 <1248475450-5668-3-git-send-email-jnareb@gmail.com>
 <7vocr94o2t.fsf@alter.siamese.dyndns.org>
 <200907250232.28561.jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	Petr Baudis <pasky@suse.cz>,
	Fredrik Kuivinen <frekui@gmail.com>,
	Giuseppe Bilotta <giuseppe.bilotta@gmail.com>,
	Luben Tuikov <ltuikov@yahoo.com>,
	Martin Koegler <mkoegler@auto.tuwien.ac.at>
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Sat Jul 25 02:39:52 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MUVIl-0007jC-9F
	for gcvg-git-2@gmane.org; Sat, 25 Jul 2009 02:39:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754875AbZGYAjn (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 24 Jul 2009 20:39:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754838AbZGYAjn
	(ORCPT <rfc822;git-outgoing>); Fri, 24 Jul 2009 20:39:43 -0400
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:41051 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754397AbZGYAjm (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 24 Jul 2009 20:39:42 -0400
Received: from localhost.localdomain (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id F404310BB6;
	Fri, 24 Jul 2009 20:39:40 -0400 (EDT)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id 1153C10BB1; Fri, 24 Jul 2009
 20:39:29 -0400 (EDT)
In-Reply-To: <200907250232.28561.jnareb@gmail.com> (Jakub Narebski's message
 of "Sat\, 25 Jul 2009 02\:32\:27 +0200")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: A3C3497A-78B3-11DE-97B6-AEF1826986A2-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/123986>

Jakub Narebski <jnareb@gmail.com> writes:

> On Sat, 25 July 2009, Junio C Hamano wrote:
>> Jakub Narebski <jnareb@gmail.com> writes:
>> 
>> > Use "boundary" class to mark boundary commits, which currently results
>> > in using bold weight font for SHA-1 of a commit (to be more exact for
>> > all text in the first cell in row, that contains SHA-1 of a commit).
>> > ...
>> > diff --git a/gitweb/gitweb.css b/gitweb/gitweb.css
>> > index 70b7c2f..f47709b 100644
>> > --- a/gitweb/gitweb.css
>> > +++ b/gitweb/gitweb.css
>> > @@ -242,6 +242,10 @@ tr.dark:hover {
>> >  	background-color: #edece6;
>> >  }
>> >  
>> > +tr.boundary td.sha1 {
>> > +	font-weight: bold;
>> > +}
>> > +
>> 
>> "boundary" means that "blame low..hight file" attributed the line to the
>> "low" commit, not because the commit introduced the line, but because the
>> user said not to bother digging further.
>
> Well, currently 'blame' view in gitweb doesn't allow to limit revision
> range from below, i.e. to state "low" commit; it doesn't use 'hpb' 
> (hash_parent_base) parameter.  So boundary commit means root commit.

Yes, but I think it is the same thing.  The initial import of a tarball,
that is "a distant stable past as opposed to more recent breakages".
