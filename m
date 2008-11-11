From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] git-diff: Add --staged as a synonym for --cached.
Date: Mon, 10 Nov 2008 17:11:08 -0800
Message-ID: <7vljvr2hjn.fsf@gitster.siamese.dyndns.org>
References: <1225296936-1357-1-git-send-email-dsymonds@gmail.com>
 <20081029164253.GA3172@sigill.intra.peff.net>
 <ee77f5c20810290950k6d7acfcbt90b6280c290bd532@mail.gmail.com>
 <alpine.DEB.1.00.0810291804400.22125@pacific.mpi-cbg.de.mpi-cbg.de>
 <20081029171122.GA12167@sigill.intra.peff.net>
 <20081102123519.GA21251@atjola.homenet>
 <7vljw2yo93.fsf@gitster.siamese.dyndns.org>
 <20081103071420.GD10772@coredump.intra.peff.net>
 <ee77f5c20811101537u6061e5b4w420e9692e0cefad3@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: "Jeff King" <peff@peff.net>, "Junio C Hamano" <gitster@pobox.com>,
	=?utf-8?Q?Bj=C3=B6rn_Steinbrink?= <B.Steinbrink@gmx.de>,
	"Johannes Schindelin" <Johannes.Schindelin@gmx.de>,
	git@vger.kernel.org, "Stephan Beyer" <s-beyer@gmx.net>
To: "David Symonds" <dsymonds@gmail.com>
X-From: git-owner@vger.kernel.org Tue Nov 11 02:12:59 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KzhoP-0006cg-BD
	for gcvg-git-2@gmane.org; Tue, 11 Nov 2008 02:12:57 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752836AbYKKBLm (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 10 Nov 2008 20:11:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751488AbYKKBLm
	(ORCPT <rfc822;git-outgoing>); Mon, 10 Nov 2008 20:11:42 -0500
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:61081 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751340AbYKKBLl (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 10 Nov 2008 20:11:41 -0500
Received: from localhost.localdomain (unknown [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id 761487B820;
	Mon, 10 Nov 2008 20:11:38 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES256-SHA (256/256 bits)) (No client certificate requested) by
 a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTPSA id AD17F7B818; Mon,
 10 Nov 2008 20:11:16 -0500 (EST)
In-Reply-To: <ee77f5c20811101537u6061e5b4w420e9692e0cefad3@mail.gmail.com>
 (David Symonds's message of "Tue, 11 Nov 2008 10:37:37 +1100")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: B0EF6B1E-AF8D-11DD-B5F4-9CEDC82D7133-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/100608>

"David Symonds" <dsymonds@gmail.com> writes:

> On Mon, Nov 3, 2008 at 6:14 PM, Jeff King <peff@peff.net> wrote:
>
>> And I am not proposing a change here (except to perhaps "git diff
>> --staged" instead of "--cached"). Just pointing out that it does not
>> follow the "--staged operates on both, --staged-only operates on just
>> the index" rule.
>
> So apart from the wider discussion, I think this patch by itself is a
> nice step forward towards improving the UI of this part of git. Is
> there any further discussion on this one alone?

I do not think anybody is fundamentally opposed to introduce a consistent
set of new synonyms.  I do not think anybody disagrees that the word
"stage" will be involved in that set, either.

I however have a suspicion that people would regret having applied this
"diff --staged" patch, after they realize that other commands need two
options "--staged-only" and "--staged-too", and would wish this patch were
to introduce a synonym "diff --staged-only", not "diff --staged", for
uniformity's sake.

I doubt "Is there any further discussion on THIS ONE ALONE?" is a valid
question to ask.  What are the other command options we are introducing
synonyms for?  There is no need for two variants of staged for "diff" (you
don't have --staged-too option but instead you give a committish argument,
e.g. HEAD), so --staged-only can be abbreviated to --staged without
risking any ambiguity.  But at least a fully-spelled-out --staged-only
should also be accepted, shouldn't it?
