From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [ANNOUNCE] Git v2.0.0-rc0
Date: Tue, 22 Apr 2014 13:12:56 -0700
Message-ID: <xmqq4n1l3yyf.fsf@gitster.dls.corp.google.com>
References: <xmqqk3ambf9k.fsf@gitster.dls.corp.google.com>
	<475e137b5095e45c92a87a9969f58f0@74d39fa044aa309eaea14b9f57fe79c>
	<20140422185829.GB15516@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: "Kyle J. McKay" <mackyle@gmail.com>,
	Johan Herland <johan@herland.net>, git@vger.kernel.org
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Tue Apr 22 22:13:11 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Wch42-00035P-D0
	for gcvg-git-2@plane.gmane.org; Tue, 22 Apr 2014 22:13:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751745AbaDVUND (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 22 Apr 2014 16:13:03 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:56274 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751256AbaDVUNB (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 22 Apr 2014 16:13:01 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 84B1E7FDCC;
	Tue, 22 Apr 2014 16:13:00 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:message-id:in-reply-to:mime-version
	:content-type; s=sasl; bh=yHe0xAotAdzdhuw8GGjehV1NEmA=; b=Lj1pXM
	YDX/Qn2FdummXZ/GGaiUxd1tAOig84ofIV+nQtApwofJ4hvZKnJPawKHgfn0A+wK
	NRXuDnUP4XW0AdnISWx/KBSYpIZ0P65d/w9NGUuvPeLcypI8Jmg9cL9bwo+lk70V
	6Ay40RDwkvYLlvh4i7RqUAxmgGQ89Fc6SuwNg=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:message-id:in-reply-to:mime-version
	:content-type; q=dns; s=sasl; b=oWxEeA1+lTAk7eGMWApNCsfAF6OrinGQ
	3q8VrsEXbdzQmhFRWBfjMEfX4DLpztB0xIPvRyWsk/hWWrCYFqRAB7hOleNS1SMN
	oMRGLu89B/LKrOldma5Scn9xmgORqqd6fBr5XtLD0JvVA6OXhs32kFGcwbJ08ZEf
	wdCBtl+UgvA=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 690647FDCA;
	Tue, 22 Apr 2014 16:13:00 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id C18C77FDC5;
	Tue, 22 Apr 2014 16:12:58 -0400 (EDT)
Newsgroups: gmane.comp.version-control.git
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
Cancel-Lock: sha1:q7jwmXxPRQZjhMAk8SUpBUR006A=
In-Reply-To: <20140422185829.GB15516@google.com> (Jonathan Nieder's message of
	"Tue, 22 Apr 2014 11:58:29 -0700")
Posted-To: gmane.comp.version-control.git
X-Pobox-Relay-ID: 7F9ECDFA-CA5A-11E3-B1C2-0731802839F8-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/246781>

The following message is a courtesy copy of an article
that has been posted to gmane.comp.version-control.git as well.

Jonathan Nieder <jrnieder@gmail.com> writes:

> Hm, perhaps we should introduce a 'no-prefix' option to work around
> this.
> ...
>> |diff --git a/git-svn.perl b/git-svn.perl
>> |index 7349ffea..284f458a 100755
>> |--- a/git-svn.perl
>> |+++ b/git-svn.perl
>> |@@ -149,7 +149,7 @@ my ($_trunk, @_tags, @_branches, $_stdlayout);
>>   my %icv;
>>   my %init_opts = ( 'template=s' => \$_template, 'shared:s' => \$_shared,
>>                     'trunk|T=s' => \$_trunk, 'tags|t=s@' => \@_tags,
>>                     'branches|b=s@' => \@_branches, 'prefix=s' => \$_prefix,
>   +		      'no-prefix' => sub { $_prefix = "" },
>
>>                     'stdlayout|s' => \$_stdlayout,
>>                     'minimize-url|m!' => \$Git::SVN::_minimize_url,
>>                    'no-metadata' => sub { $icv{noMetadata} = 1 },
>
> That way, normal usage of --prefix would still be consistent with
> other git commands that prefer the form with argument attached
> (--prefix=foo, not --prefix foo; see gitcli(7)).
>
> Thoughts?

I do not think that it is a good idea to use "--no-anything" for
something that is not a boolean.

I can buy "--old-default-prefix", or "--empty-prefix", but running
"git svn --prefix ''" (or "--prefix=''") would be OK and logically
consistent anyway (i.e. the option tells us what string to add after
"refs/remotes/", and the old default that everybody hated were to
use an empty string), so...
