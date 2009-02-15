From: Junio C Hamano <gitster@pobox.com>
Subject: Re: filter-branch: Remove original/*
Date: Sun, 15 Feb 2009 13:58:07 -0800
Message-ID: <7v7i3ricr4.fsf@gitster.siamese.dyndns.org>
References: <431341160902131845g58d99635ie0735b433802d6be@mail.gmail.com>
 <alpine.DEB.1.00.0902142219010.10279@pacific.mpi-cbg.de>
 <7vvdrblcl0.fsf@gitster.siamese.dyndns.org>
 <alpine.DEB.1.00.0902152046090.10279@pacific.mpi-cbg.de>
 <7vvdrbie7k.fsf@gitster.siamese.dyndns.org>
 <alpine.DEB.1.00.0902152230330.10279@pacific.mpi-cbg.de>
 <7vbpt3id1w.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Eric Kidd <git@randomhacks.net>, git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Sun Feb 15 22:59:57 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LYp1n-0002J4-8i
	for gcvg-git-2@gmane.org; Sun, 15 Feb 2009 22:59:55 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755241AbZBOV6P (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 15 Feb 2009 16:58:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753118AbZBOV6O
	(ORCPT <rfc822;git-outgoing>); Sun, 15 Feb 2009 16:58:14 -0500
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:52720 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752925AbZBOV6O (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 15 Feb 2009 16:58:14 -0500
Received: from localhost.localdomain (unknown [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id 688469ACAD;
	Sun, 15 Feb 2009 16:58:13 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES256-SHA (256/256 bits)) (No client certificate requested) by
 a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTPSA id D3D4A9ACA6; Sun,
 15 Feb 2009 16:58:08 -0500 (EST)
In-Reply-To: <7vbpt3id1w.fsf@gitster.siamese.dyndns.org> (Junio C. Hamano's
 message of "Sun, 15 Feb 2009 13:51:39 -0800")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: BDD81E4C-FBAB-11DD-A365-0433C92D7133-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/110065>

Junio C Hamano <gitster@pobox.com> writes:

> Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:
>
>>> That merely means whoever changes the tag and wants the record of such an
>>> update, which is uncommon, need to make sure reflog is created for that
>>> tag (and that tag only).
>>
>> The thing is: we cannot.  At least not at the moment.
>
> $ mkdir -p .git/logs/refs/tags
> $ >.git/logs/refs/tags/junker
> $ git tag junker
> $ wc .git/logs/refs/tags/junker
>   1   8 134 .git/logs/refs/tags/junker
>
> Ok, it's not 180 byte as I said, but only 134 bytes.

Having proven my superiour intelligence ;-) I think I can agree if your
next proposal is to toggle reflog on for the tag when "git tag -f" is used
to update an existing tag and core.logAllRefUpdates does not say "never"
(this new value needs to be treated the same as "false" for most other
purposes), and the tag does not already have a reflog.
