From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH/RFC 3/2] Refactor Git::config_*
Date: Mon, 17 Oct 2011 13:50:52 -0700
Message-ID: <7vsjmrl4ur.fsf@alter.siamese.dyndns.org>
References: <vpqty7wk9km.fsf@bauges.imag.fr>
 <201110010000.13328.jnareb@gmail.com>
 <7voby1oesm.fsf@alter.siamese.dyndns.org>
 <201110072317.17436.jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Eric Wong <normalperson@yhbt.net>,
	Cord Seele <cowose@googlemail.com>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
	git@vger.kernel.org, Cord Seele <cowose@gmail.com>
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Mon Oct 17 22:51:01 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RFu9F-0004l6-DF
	for gcvg-git-2@lo.gmane.org; Mon, 17 Oct 2011 22:51:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754890Ab1JQUu4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 17 Oct 2011 16:50:56 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:46640 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754115Ab1JQUuz (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 17 Oct 2011 16:50:55 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 2BABB4917;
	Mon, 17 Oct 2011 16:50:54 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=sVCINkjD+GGJpl0nB8GJ822cjHg=; b=Ri4lRG
	JR3yN+T43IOgxorJIKLZBap+UwwWqJWGgtKGwl9XYItIRUe+1O7B5rNKUTf3kY2F
	UKHhwgJBvvXKLL4pzINppvLh4PCusCYgojcB4rUoCfuqholEFacQIP2s4F8HTx3J
	uuM+h8yNWD7CNOjbyzCXrk+zSs2g9BcRzNlTk=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=pC6s8Rehwn1xIV043IM1kGVjFSndgKWU
	pSXVz8PLCHPW8G3e+MCT1J7IU1YyM+Op83J4LWihvU/U2izJFhWmNkp4IZ4eQbFB
	yBXt32uieQ+NwDiKBl5x8BrLtmeYie2ILg/jTT0fLLqFGxq+EuCrVHA7iBCa5aeL
	4uuSE0jzWSA=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 201514916;
	Mon, 17 Oct 2011 16:50:54 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id A04C24910; Mon, 17 Oct 2011
 16:50:53 -0400 (EDT)
In-Reply-To: <201110072317.17436.jnareb@gmail.com> (Jakub Narebski's message
 of "Fri, 7 Oct 2011 23:17:16 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: B456E9CE-F901-11E0-BE0E-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/183820>

Jakub Narebski <jnareb@gmail.com> writes:

> This is version which has fixed style to be more Perl-ish, and which
> actually works (i.e. t9700 passes).
>
> I have also moved _config_common() after commands that use it, just like
> it is done with other "private" methods (methods with names starting with
> '_'), and excluded this private detail of implementation from docs.

It seems that this breaks many tests in t9xxx series for me, especially
the 9100 series that cover git-svn.
