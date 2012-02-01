From: "Bernhard R. Link" <brl+git@mail.brlink.eu>
Subject: Re: [PATCH v5 2/5] gitweb: add project_filter to limit project list
 to a subdirectory
Date: Wed, 1 Feb 2012 17:59:02 +0100
Message-ID: <20120201165902.GA14706@server.brlink.eu>
References: <20120128165606.GA6770@server.brlink.eu>
 <20120130095252.GA6183@server.brlink.eu>
 <20120130114557.GB9267@server.brlink.eu>
 <201201301657.12944.jnareb@gmail.com>
 <20120130200355.GA2584@server.brlink.eu>
 <7v39axaq0v.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jakub Narebski <jnareb@gmail.com>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Feb 01 17:58:51 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RsdWE-0005pD-7F
	for gcvg-git-2@plane.gmane.org; Wed, 01 Feb 2012 17:58:50 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753952Ab2BAQ6p (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 1 Feb 2012 11:58:45 -0500
Received: from server.brlink.eu ([78.46.187.186]:54135 "EHLO server.brlink.eu"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751986Ab2BAQ6o (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 1 Feb 2012 11:58:44 -0500
Received: from mfs.mathematik.uni-freiburg.de ([132.230.30.170] helo=client.brlink.eu)
	by server.brlink.eu with esmtpsa (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.72)
	(envelope-from <brl@mail.brlink.eu>)
	id 1RsdW7-0007bP-9o; Wed, 01 Feb 2012 17:58:43 +0100
Received: from brl by client.brlink.eu with local (Exim 4.77)
	(envelope-from <brl@mail.brlink.eu>)
	id 1RsdWQ-0003ps-UJ; Wed, 01 Feb 2012 17:59:03 +0100
Content-Disposition: inline
In-Reply-To: <7v39axaq0v.fsf@alter.siamese.dyndns.org>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/189522>

* Junio C Hamano <gitster@pobox.com> [120130 21:34]:
> Thanks; I'll queue them in 'pu' for now (if Jakub wants to Ack the pieces,
> I'll amend them).
>
> Regarding the first patch in the series, while it may be a valid perl to
> introduce a new variable, assign to it and then munge its contents with
> s///, all inside a parameter list of a function call, it is doing a bit
> too much and makes it hard to see if the variable may or may not later be
> used in the same scope (in this case, it is not).
>
> I am tempted to squash the following in.

Look liks a change like that is actually needed. I made the mistake of
assuming
  (my $filter = $project) =~ s/\.git$//;
was the same like
  $project =~ s/\.git$//r;
but the latter returns the changed string, the former returns the number
of arguments. (So it looks for forks in a directory named '1').

(Should have tested it again after this last change)...

Can you squash it in (with the correction of Jakub Narebski), or do you
prefer a new patch?

        Bernhard R. Link
