From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v4] Documentation/remote-helpers: Add invocation section
Date: Mon, 05 Apr 2010 23:48:13 -0700
Message-ID: <7vhbnpjcuq.fsf@alter.siamese.dyndns.org>
References: <x2zf3271551003311240i53ecb2fck173c8f34bdb3257@mail.gmail.com>
 <7v1vetmrl1.fsf@alter.siamese.dyndns.org>
 <r2gf3271551004051943u6111c956p24f4fd2897c08d0c@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Daniel Barkalow <barkalow@iabervon.org>,
	Git Mailing List <git@vger.kernel.org>,
	Ilari Liusvaara <ilari.liusvaara@elisanet.fi>,
	Gabriel Filion <lelutin@gmail.com>,
	Sverre Rabbelier <srabbelier@gmail.com>,
	Michael J Gruber <git@drmicha.warpmail.net>,
	Jonathan Nieder <jrnieder@gmail.com>
To: Ramkumar Ramachandra <artagnon@gmail.com>
X-From: git-owner@vger.kernel.org Tue Apr 06 08:48:52 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Nz2ah-0004RA-48
	for gcvg-git-2@lo.gmane.org; Tue, 06 Apr 2010 08:48:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756959Ab0DFGsq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 6 Apr 2010 02:48:46 -0400
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:63400 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755661Ab0DFGso (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 6 Apr 2010 02:48:44 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id AEB21A82FC;
	Tue,  6 Apr 2010 02:48:32 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:message-id:mime-version:content-type; s=
	sasl; bh=9uv+eHypo04LSrhD5vWo3SIYYsA=; b=wKY12EbPP6pgNF9MLmTrJVE
	TLpYSbXEPmfp4Po1sEwx3wYhQMT8xmYiX3LM37UgYY9xU4aaHMKECs+3yHz9c5Dn
	6xlTrJZmdt6Tz9peZxsnRNzV4YtFQ+SJcLJJB01a7yFG9+d3Nw68nzIsBwdCmZrB
	JoSvlZyFk+8tCdSnWETU=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:message-id:mime-version:content-type; q=
	dns; s=sasl; b=QMGCU5at+V+Z68PYWCu7SYbYKU8QvxIHywmPkEb3n1KRTz/KK
	H4YQwD0uepDiPlpxS38BEJglJUBCfZPP+JnmZ46bl5mM81yxhK0Di4vvgbZwTLqT
	RGncUTwo64dmOYmGG1bRr/gssLjhpOgviIuC1Ttjakth0UpVUdUO3CdJYE=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 31BD3A82F3;
	Tue,  6 Apr 2010 02:48:24 -0400 (EDT)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id C78A1A82DC; Tue,  6 Apr
 2010 02:48:14 -0400 (EDT)
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 658F4F1A-4148-11DF-AC79-D033EE7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/144106>

Ramkumar Ramachandra <artagnon@gmail.com> writes:

> I prepared this revision after Daniel Barkalow's comments [2]
> and [3].
> Daniel: Could you please comment on this?

Sorry for putting you in an awkward place.  I think Daniel and I have
different target audience in mind for various pieces of documentation.

Here is what I think.

 - An end user who has heard of a "svn" foreign interface may want to look
   at something like urls.txt (which is included by the manual page for
   clone and perhaps fetch) to learn how to use a repository his friends
   who are still using Subversion use with his git installation.

   When "svn" foreign interface is polished enough to be a first class
   citizen, I would imagine that we would have a simple "to access
   Subversion repository using their native protocol, use the same URL as
   your Subversion friends use, e.g. svn://svn.rockbox.org/rockbox", and
   that description would appear at the same level as our native URLs like
   "git://k.org/pub/scm/git/git.git" (that is what I mean by "first class
   citizen").

 - On the other hand, I think git-remote-helpers.txt would be more for
   helper writers than the end users.  We could move detailed discussion
   that are needed by helper writers to Documentation/technical/, but then
   I do not see much else to discuss in git-remote-helpers left.  I do not
   see how the end user needs anything deeper than the simple "here is how
   you would give the protocol and location to your 'git clone' and
   everything else will be set up for you" that would be in urls.txt.

> [2] http://thread.gmane.org/gmane.comp.version-control.git/143438

  [regarding Ilari's description on how helper is chosen]

  That information ought to be in the documentation, but possibly not on 
  this man page in particular. I think it would be better to document that 
  part in the documentation of the code and programs that call the helper, 
  not in the helper documentation. In general, I'd like the helpers to make 
  as few assumptions about their caller as possible, and similarly keep the 
  information about the caller out of their documentation.

  Also, I think it would be more helpful in general to get that information 
  into documentation of the transport and remote code and configuration of 
  these things, because users are going to come at this from that side ("I 
  want to access an SVN repository, how does that work?") rather than from 
  the helper documentation side ("I want to exercise git-remote-svn's export 
  support, just to run that code").

While in principle I can understand Daniel's aversion of spelling things
out in too much detail to paint himself in a corner he cannot get out of,
I think it is necessary to give the overall picture to the readers (my
intended target audience is "helper writers").  In other words, I think
the documentation needs to say something like:

    "clone" gets transport and transport specific data to identify the
    data source in _this_ way from the user, stores it in .git/config for
    future interaction with the same foreign repository by _this_ and
    _that_ command, and all these will cause your helper program to be
    called _this_ way, hence your program must be prepared to do _this_
    and _that_.

and it wouldn't be as helpful to the helper writers if we only said the
last "your program must do this and that" part.

> [3] http://thread.gmane.org/gmane.comp.version-control.git/143483

  I think getting information on what the helper is supposed to do with its 
  command-line arguments into this man page would be good, and the 
  appropriate focus for the man page.

  The current answer is this:
   argv[1] is the name of a remote, which may be a nickname or some more 
    direct name; in any case, remote_get() will produce the available data 
    for it.
   argv[2] is the URL, if there is one. Since a remote could have more than 
    one URL, the helper gets the URL it should be handling. Some systems 
    don't use URLs, and these will just look at the remote or something like 
    that.

  The rest of what you wrote is true, but it's really more information on 
  how the attributes of remotes are determined than what the helper should 
  be worrying about.

Here mostly Daniel agrees with me that having techinical details that is
needed for helper writers in git-remote-helpers.txt is a good idea, but
I am not sure if I agree with the last paragraph.
