From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [RFC] git rm -u
Date: Sun, 24 Feb 2013 22:54:15 -0800
Message-ID: <7vzjys28a0.fsf@alter.siamese.dyndns.org>
References: <50FB1196.2090309@gmail.com> <1358632037-ner-2564@calvin>
 <CALWbr2zhxkZEGWc5iN-8MivzV7viEdfwV_Q-iH0xSUWkwnSmyQ@mail.gmail.com>
 <50FB1673.8020808@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Antoine Pelisse <apelisse@gmail.com>,
	Tomas Carnecky <tomas.carnecky@gmail.com>,
	git <git@vger.kernel.org>
To: Eric James Michael Ritz <lobbyjones@gmail.com>
X-From: git-owner@vger.kernel.org Mon Feb 25 07:54:52 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1U9rxc-0003L2-Cu
	for gcvg-git-2@plane.gmane.org; Mon, 25 Feb 2013 07:54:52 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756972Ab3BYGyT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 25 Feb 2013 01:54:19 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:36993 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751621Ab3BYGyS (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 25 Feb 2013 01:54:18 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 94BC896F6;
	Mon, 25 Feb 2013 01:54:17 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:message-id:mime-version:content-type;
	 s=sasl; bh=sZQId1VTIdC/f1YW6IFjKvR28cw=; b=sWpTreTbCf7EO8GREl+b
	yT6gG94J0TK25JyjTy6bmRB41nOJWZKvNLykBYYe+MUwiY2/8EK8xJHxawZzgU3O
	vOF29J1DNQv6+/+JlGX/dThZbD7ffzOLD+73wgYidz8MT72ok9+As6D8niH4HGbK
	LJ6H9+b6vAOI3aP2CJu2Iwc=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:message-id:mime-version:content-type;
	 q=dns; s=sasl; b=K1o5NpxwBHNXBlvE2yjRCse7GtPZrYCKCSXW8C450JmkS7
	EL4SXMVgv+hePaoxvo35wM2xmMVcLhcGa4mEt0PENLSdRkbKB092j+id7V1HsSrB
	0Sbbe56t0qUR2hcJLObBhLjWynGjSDDb60pceN99OET41+DZi6a4C0lg1H95A=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 8977596F5;
	Mon, 25 Feb 2013 01:54:17 -0500 (EST)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 0509E96F3; Mon, 25 Feb 2013
 01:54:16 -0500 (EST)
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 2C18C854-7F18-11E2-BA4B-27D12E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/217039>

Eric James Michael Ritz <lobbyjones@gmail.com> writes:

> On 01/19/2013 04:49 PM, Antoine Pelisse wrote:
>> I think `git add -u` would be closer. It would stage removal of
>> files, but would not stage untracked files.  It would stage other
>> type of changes though.
>
> On Sat, Jan 19, 2013 at 10:47 PM, Tomas Carnecky
>> Does `git add -A` do what you want?
>
> Thank you Tomas and Antoine.  Both of these commands do what I want:
> stage deleted files on the index.  But does the idea of a `git rm -u`
> still sound useful since these commands also stage changes besides
> deleted files?

Even though I am not sure how often I would use it myself, "reflect
only the removals in the working tree to the index, but exclude any
other kind of changes" might turn out to be a useful addition to the
toolchest in certain cases.

I however am not yet convinced that "git rm -u" is a good way to
express the feature at the UI.  "git add -u" is "update the index
with modification and removal but ignore new files because we won't
know if they are garbage or assets".  What the same "-u" option
means in the context of "git rm" is not very clear, at least to me.
