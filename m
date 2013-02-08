From: Junio C Hamano <gitster@pobox.com>
Subject: Re: `git checkout --orpan` leaves a dirty worktree
Date: Fri, 08 Feb 2013 12:12:56 -0800
Message-ID: <7vzjzezhrr.fsf@alter.siamese.dyndns.org>
References: <CALkWK0mjf5vsiHvMW-QyzMHdmZQvdzjw_ORJnMd=mT6RCqB1xg@mail.gmail.com>
 <20130208200402.GB8461@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Ramkumar Ramachandra <artagnon@gmail.com>,
	Git List <git@vger.kernel.org>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Fri Feb 08 21:13:26 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1U3uK2-0003Ai-H9
	for gcvg-git-2@plane.gmane.org; Fri, 08 Feb 2013 21:13:22 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932129Ab3BHUM7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 8 Feb 2013 15:12:59 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:35575 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932068Ab3BHUM6 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 8 Feb 2013 15:12:58 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 4C20CB323;
	Fri,  8 Feb 2013 15:12:58 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=xZNJcQstwxoYVu1rphGZ+pNFN3Y=; b=mnGJL3
	2/PlvC3PUxQqV70NJpk6EdPKpWeZ9Q/KfmPDjuFKPXgYL/JSvI9Zl+rTmdYaxdOS
	0tP3AgPg204XbpcLeJYR6MHcrln4u/WT+6KZFNt7/kqzSNsyfPkO2FhXgGvPR+IE
	pgsYOh5lKffxZTcRTa5RVIczqfY+aj6Ct+tDM=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=RYFt7j5HD9lFNtoEN7cr5GZZkMI/cLzL
	T4AvUyjaKpLIQlg0Plepow9GmBDTzKgGK/5eDNP8voDN6zbV4u46qMd0ExKp7DYM
	uGTP2dppKDmbrnoV/cBsvDRXN+/pl/xHGtFQCM+9JEbt1Ffoa2iSHCqqDNWBxCMN
	zRiOYu67BlA=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 3FAA5B322;
	Fri,  8 Feb 2013 15:12:58 -0500 (EST)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id B0F51B321; Fri,  8 Feb 2013
 15:12:57 -0500 (EST)
In-Reply-To: <20130208200402.GB8461@google.com> (Jonathan Nieder's message of
 "Fri, 8 Feb 2013 12:04:02 -0800")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: EE09DDB2-722B-11E2-B07F-BCD12E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/215812>

Jonathan Nieder <jrnieder@gmail.com> writes:

> Ramkumar Ramachandra wrote:
>
>> Why should I have to `git rm -rf .` after a `git checkout --orphan`?
>> What sort of misfeature/ incomplete feature is this?
>
> One designed for the "going open source" use case, where you have
> existing code that you want to put into a new branch without history.
> When there is no existing code, it seems simpler to do
>
> 	cd ..
> 	git init code-that-has-nothing-to-do-previous-cwd
> 	cd code-that-*
> 	... hack hack hack ...
> 	git commit
> 	git remote add origin <url>
> 	git push -u origin master
>
> BTW, I suspect a clearer way to say what you meant is "Sounds like a
> misfeature" which is gentler and more focused than an implied "What
> kind of idiot designed this?"  Even if you are thinking the latter. :)

So true ;-).  

Especially when you may an answer that may make _you_ look like an
idiot ;-)
