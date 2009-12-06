From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Continued work on sr/vcs-helper and sr/gfi-options
Date: Sat, 05 Dec 2009 17:47:14 -0800
Message-ID: <7vr5r8oov1.fsf@alter.siamese.dyndns.org>
References: <fabb9a1e0912051653s77ba25e1g9ff1e21219cd06c9@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git List <git@vger.kernel.org>
To: Sverre Rabbelier <srabbelier@gmail.com>
X-From: git-owner@vger.kernel.org Sun Dec 06 02:47:30 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NH6Dh-00042t-4k
	for gcvg-git-2@lo.gmane.org; Sun, 06 Dec 2009 02:47:29 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755737AbZLFBrR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 5 Dec 2009 20:47:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755571AbZLFBrQ
	(ORCPT <rfc822;git-outgoing>); Sat, 5 Dec 2009 20:47:16 -0500
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:45158 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755381AbZLFBrP (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 5 Dec 2009 20:47:15 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 810FCA4110;
	Sat,  5 Dec 2009 20:47:21 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=AZ4oGPZeBYbT9GmIFiRMg5WrFlE=; b=hmIINS
	Acg1N/20ySI/Kr4yOpJ6HvVfe8aGAVz5tvrx4meUjPiMPWKlFG6YwRvf+hFGYqHY
	Bs2jfz6ymouvh/W9EqBP+o/ERWGmaAQ0ZjCYBiqpSWr6Au3Ga+SUn8PfWF0+TTQB
	tL0l/nZC6meeaUxjDImn4828Uv3++U3xbl6i8=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=sq6Rhchf62kWF9DYYP4fw0Jt86bOXT4x
	pcOWz0inEnhRfUyhfS4NU9P+kRA4yy62HFxJdGavy6wZX9LkjgE01p0QpUGwkBmr
	H99IvZuM5wyTet9LeFhmOPMkqO5CusUJ9JU93jyyhE518jrtSb5SKoGFhD5xishF
	e9tn6ESLZ1E=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 5FCD1A410F;
	Sat,  5 Dec 2009 20:47:19 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id 5E58DA410E; Sat,  5 Dec 2009
 20:47:16 -0500 (EST)
In-Reply-To: <fabb9a1e0912051653s77ba25e1g9ff1e21219cd06c9@mail.gmail.com>
 (Sverre Rabbelier's message of "Sun\, 6 Dec 2009 01\:53\:03 +0100")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 4A1A0E8A-E209-11DE-8CDD-EF34BBB5EC2E-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/134641>

Sverre Rabbelier <srabbelier@gmail.com> writes:

> I'm planning to start finishing up git-remote-hg this week, and for
> that I need both sr/vcs-helper (in next) and sr/gfi-options (in pu).
> How can I best go about working on these? I _think_ what I want is to
> merge sr/vcs-helper and sr/gfi-options, into either master or next
> (with a three-way merge), but I'm not sure? Also, when I try to rebase
> sr/vcs-helper onto master I get conflicts yet again, since these were
> already resolved in next, what is the best way for me to proceed in
> such a way that it is convenient for you (Junio) and the list, if
> possible, without having to untangle those merge conflicts.

Some observations.

 - sr/vcs-helper seems to be near completion; I'd expect it to be among
   the first batch of topics to go to 'master' after 1.6.6 final (some
   fixes may happen between now and 1.6.6 final to make the series a bit
   longer, though).

 - sr/gfi-options started moving again and there could be a couple more
   iterations before it would hit 'next'.

Until sr/gfi-options becomes more solid, one way we can manage
sr/remote-hg is (thinking aloud):

 - Fork sr/remote-hg from today's sr/vcs-helper; 

 - Merge today's 'master' to sr/remote-hg (optional);

 - Whenever any updates to vcs-helper topic appears, apply them to
   sr/vcs-helper, and merge the result to sr/remote-hg;

 - Create an unstable sr/pu-remote-hg branch that:

   - is reset to the tip of sr/remote-hg at the beginning of the day;
   - merges the day's sr/gfi-options on top;
   - re-applies patches to implement Hg interoperation on top of the
     result.

When sr/gfi-options becomes solid, we can merge it to sr/remote-hg itself,
get rid of sr/pu-remote-hg "patch queue", and move the Hg interoperation
patches we helpd in sr/pu-remote-hg to sr/remote-hg branch.  We will merge
early parts of sr/remote-hg (at least up to the merge with sr/gfi-options,
and perhaps early parts of individual Hg interoperation patches as well)
to 'next', and remaining parts on the branch to 'pu' (and they can be
replaced).
