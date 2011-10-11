From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCHv5/RFC 1/6] Documentation: Preparation for gitweb manpages
Date: Tue, 11 Oct 2011 10:49:15 -0700
Message-ID: <7vvcrvfmg4.fsf@alter.siamese.dyndns.org>
References: <1318098723-12813-1-git-send-email-jnareb@gmail.com>
 <201110102352.25456.jnareb@gmail.com>
 <7v62jwjvdk.fsf@alter.siamese.dyndns.org>
 <201110111739.49967.jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	Drew Northup <drew.northup@maine.edu>,
	Jonathan Nieder <jrnieder@gmail.com>
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Tue Oct 11 19:49:23 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RDgSB-0006Yx-2o
	for gcvg-git-2@lo.gmane.org; Tue, 11 Oct 2011 19:49:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755091Ab1JKRtS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 11 Oct 2011 13:49:18 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:46356 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754830Ab1JKRtR (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 11 Oct 2011 13:49:17 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 51A70556A;
	Tue, 11 Oct 2011 13:49:17 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=EFsMFHnvGNVroHpqjCCLarn/xFI=; b=Yb4Pqd
	1g1eGOzhPhmML+D8tMsWEgHCLHtUVC+tf7+djy9dpTrvtPStgqZncCtavl0s5/NT
	FnpZB1Ub+VerWSULlSnonN6QvllXGALbUbK+maPsVqnKZVjlZfN0l1bS/7FfLLqm
	60iHRKbyPbQrGDATfC73VV3WpRkAzmmEKafhs=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=STTAR2O1nX37IpmW9jWMxfmeKt7WPhfv
	pFUkNiTz8OTwrtKnOpdpYw7GZBIsSGq2H592niqWKhqaENqyLGQ+IN721/3K4M2+
	XWAamknExdmeV/MuoRiq1UaHnggUULmLKXBE7FR8hMt71KxhkFt9PPJ74boTUZ2r
	ZGHGiYyco6k=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 486335569;
	Tue, 11 Oct 2011 13:49:17 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id CE8CA5568; Tue, 11 Oct 2011
 13:49:16 -0400 (EDT)
In-Reply-To: <201110111739.49967.jnareb@gmail.com> (Jakub Narebski's message
 of "Tue, 11 Oct 2011 17:39:49 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 56D64878-F431-11E0-A98E-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/183312>

Jakub Narebski <jnareb@gmail.com> writes:

> On Tue, 11 Oct 2011, Junio C Hamano wrote:
>
>> I probably do not have time to look into this, but just FYI my trial merge
>> to 'pu' of this topic is failing like this:
>> 
>> asciidoc: ERROR: gitweb.conf.txt: line 484: illegal style name: Default: ()
>> asciidoc: ERROR: gitweb.conf.txt: line 494: illegal style name: Default: 300
>
> Damn, I thought I have fixed that.  This probably depends on AsciiDoc
> version ("make doc" on 'master' generates a few _warnings_ for me related
> to similar situation), but the problem is with
>
>   [Default: <value>]
>
> that was copied from gitweb/README.  But [<sth>] is an attribute list
> (style name in simplest form), used more often in newer AsciiDoc.
>
> So either we have to escape '[' and ']', i.e. use {startsb} and {endsb},
> which would reduce human-friendliness, or move to different way of marking
> default values, e.g. _italic_.
>
> What do you think?

What do the other documents in the directory this file lives say?  I think
we explain what the variables does, and add "defaults to false" or
somesuch in the text, without any funny mark-up.
