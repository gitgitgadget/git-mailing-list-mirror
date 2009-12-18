From: Junio C Hamano <gitster@pobox.com>
Subject: Re: git remote set-head not working?
Date: Fri, 18 Dec 2009 13:42:17 -0800
Message-ID: <7veimst0w6.fsf@alter.siamese.dyndns.org>
References: <76c5b8580912180825t17bfc90eq20dfc05cafa8c02e@mail.gmail.com>
 <20091218165302.GA1746@sigill.intra.peff.net>
 <76c5b8580912180938s2b885efax33be860f963ba92f@mail.gmail.com>
 <76718490912181328k5f87d82u499b7a1eba471126@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Eugene Sajine <euguess@gmail.com>, Jeff King <peff@peff.net>,
	git@vger.kernel.org
To: Jay Soffian <jaysoffian@gmail.com>
X-From: git-owner@vger.kernel.org Fri Dec 18 22:42:38 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NLkaq-0006aD-CA
	for gcvg-git-2@lo.gmane.org; Fri, 18 Dec 2009 22:42:36 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755674AbZLRVmb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 18 Dec 2009 16:42:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932703AbZLRVmb
	(ORCPT <rfc822;git-outgoing>); Fri, 18 Dec 2009 16:42:31 -0500
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:35216 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755612AbZLRVma (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 18 Dec 2009 16:42:30 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 2EC38A8FB4;
	Fri, 18 Dec 2009 16:42:29 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=C8GoGpNYgnDqLv7UeLfug5m0fQE=; b=snJe8L
	HNgwigOoOmdsLupxsNEXFzKkz7fh9KTN/6ZSeXhRhyjxj3HqTAwOgTCC9CgyUfhC
	IhNSHW8hCN2pZlEoagibqLPxUrPdnFZgxQJuSg+3sqs0DM1P979GuOuiJ1JFGas6
	LdrLmuvx2JVVHv2CH6oadxdSAOTcRMpMRb5LI=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=rour7CRg7nvhixC5qCNJjtOAkiLRMabi
	uFrZThSCAMRiysSENLKMboSKiMGvZ+nFBpno3MBqxc6HUHriLwVXSEnD+eeiC60z
	hf4Xz5vw446HO8yANCOEYTlcVQ8tMKPcjkz0zPFSQvoLK2nBO511aJiv1MUmtJ/9
	k5ey6V24juI=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id E4AB4A8FB2;
	Fri, 18 Dec 2009 16:42:24 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id 91CCFA8FB1; Fri, 18 Dec 2009
 16:42:19 -0500 (EST)
In-Reply-To: <76718490912181328k5f87d82u499b7a1eba471126@mail.gmail.com> (Jay
 Soffian's message of "Fri\, 18 Dec 2009 16\:28\:35 -0500")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 3AE533DA-EC1E-11DE-89C2-B34DBBB5EC2E-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/135440>

Jay Soffian <jaysoffian@gmail.com> writes:

> On Fri, Dec 18, 2009 at 12:38 PM, Eugene Sajine <euguess@gmail.com> wrote:
>> Yes. I was trying to change the HEAD on the bare remote (origin) repo
>> and the concept here is really confusing.
>
> The remote command is about updating things under .git/refs/remotes,
> not about updating a remote server. For updating a remote server,
> there is really only push. Clear as mud?

We still support (and unfortunately we would probably end up supporting
for a long time) "remote update" so it is not strictly true, but that is
the original motivation behind "git remote" subcommand.

> Understood. I'm not sure whether the send-pack/receive-pack protocol
> supports the notion of "I want to change what HEAD points to."

It does not support it, but that is not because there is a strong reason
it shouldn't.
