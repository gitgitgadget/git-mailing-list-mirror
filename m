From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 3/4 v2] Add tests for .git file
Date: Wed, 06 Feb 2008 02:13:14 -0800
Message-ID: <7vr6fqz939.fsf@gitster.siamese.dyndns.org>
References: <7vfxw66a0s.fsf@gitster.siamese.dyndns.org>
	<1202284583-24478-1-git-send-email-hjemli@gmail.com>
	<7v7ihi32bv.fsf@gitster.siamese.dyndns.org>
	<8c5c35580802060130i12fc261aqbe9c136f26218188@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: "Junio C Hamano" <gitster@pobox.com>,
	"Johannes Schindelin" <Johannes.Schindelin@gmx.de>,
	"Shawn O. Pearce" <spearce@spearce.org>, git@vger.kernel.org
To: "Lars Hjemli" <hjemli@gmail.com>
X-From: git-owner@vger.kernel.org Wed Feb 06 11:14:02 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JMhI2-000083-6x
	for gcvg-git-2@gmane.org; Wed, 06 Feb 2008 11:14:02 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1761211AbYBFKNb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 6 Feb 2008 05:13:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1761216AbYBFKNa
	(ORCPT <rfc822;git-outgoing>); Wed, 6 Feb 2008 05:13:30 -0500
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:35567 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1761174AbYBFKNa (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 6 Feb 2008 05:13:30 -0500
Received: from a-sasl-quonix (localhost [127.0.0.1])
	by a-sasl-quonix.pobox.com (Postfix) with ESMTP id AC2111954;
	Wed,  6 Feb 2008 05:13:27 -0500 (EST)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by a-sasl-quonix.pobox.com (Postfix) with ESMTP id CFC2E1953;
	Wed,  6 Feb 2008 05:13:21 -0500 (EST)
In-Reply-To: <8c5c35580802060130i12fc261aqbe9c136f26218188@mail.gmail.com>
	(Lars Hjemli's message of "Wed, 6 Feb 2008 10:30:16 +0100")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/72791>

"Lars Hjemli" <hjemli@gmail.com> writes:

> On Feb 6, 2008 9:40 AM, Junio C Hamano <gitster@pobox.com> wrote:
>> Lars Hjemli <hjemli@gmail.com> writes:
>> > +objpath() {
>> > +    echo $1 | sed -re 's|(..)(.+)|\1/\2|'
>> > +}
>>
>> "sed -r"???  Please limit ourselves to the basics.
>
> Sorry, I didn't realize 'sed -r' wasn't kosher. Should I resend or is
> this something you'd --amend?

If we live in POSIX only world it is fine, but I try to be
conservative when I am able.

No need to resend; I've done something like this (there are
other minor amends).

    diff --git a/t/t0002-gitfile.sh b/t/t0002-gitfile.sh
    new file mode 100755
    index 0000000..d280663
    --- /dev/null
    +++ b/t/t0002-gitfile.sh
    @@ -0,0 +1,74 @@
    +#!/bin/sh
    +
    +test_description='.git file
    +
    +Verify that plumbing commands work when .git is a file
    +'
    +. ./test-lib.sh
    +
    +objpath() {
    +    echo "$1" | sed -e 's|\(..\)|\1/|'
    +}
    + ...

But the result won't be pushed out til tomorrow morning.
