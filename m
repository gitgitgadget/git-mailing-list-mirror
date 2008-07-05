From: Junio C Hamano <gitster@pobox.com>
Subject: Re: About -X<option>
Date: Sat, 05 Jul 2008 10:40:16 -0700
Message-ID: <7v63rktekf.fsf@gitster.siamese.dyndns.org>
References: <alpine.DEB.1.00.0807051454060.3334@eeepc-johanness>
 <20080705133245.GH4729@genesis.frugalware.org>
 <AB745D70-D23A-4742-A5B3-DC1B6CAD9C30@ai.rug.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Miklos Vajna <vmiklos@frugalware.org>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	gitster@pobox.com, git@vger.kernel.org
To: Pieter de Bie <frimmirf@gmail.com>
X-From: git-owner@vger.kernel.org Sat Jul 05 19:42:23 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KFBm1-0004jJ-J0
	for gcvg-git-2@gmane.org; Sat, 05 Jul 2008 19:42:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755274AbYGERka (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 5 Jul 2008 13:40:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756814AbYGERk2
	(ORCPT <rfc822;git-outgoing>); Sat, 5 Jul 2008 13:40:28 -0400
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:52448 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756823AbYGERk0 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 5 Jul 2008 13:40:26 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id 1F72A22078;
	Sat,  5 Jul 2008 13:40:25 -0400 (EDT)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with
 ESMTPSA id 5A6D022077; Sat,  5 Jul 2008 13:40:19 -0400 (EDT)
In-Reply-To: <AB745D70-D23A-4742-A5B3-DC1B6CAD9C30@ai.rug.nl> (Pieter de
 Bie's message of "Sat, 5 Jul 2008 15:48:07 +0200")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 731524FC-4AB9-11DD-8AA0-CE28B26B55AE-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/87455>

Pieter de Bie <frimmirf@gmail.com> writes:

> On 5 jul 2008, at 15:32, Miklos Vajna wrote:
>
>> As a user I would think that it tells git-merge to first try
>> 'recursive'
>> then 'theirs'.
>>
>
> I agree with this. Perhaps there's an easy fix: how about a colon?
>
> 	git pull -s recursive:theirs
>
> might be more intuitive?

How would you do the equivalent of

	git pull -s recursive -Xsubtree="My Playpen/" -Xours

with the syntax?

Note that the current scripted "pull" and "merge" has a limitation that it
does not allow $IFS in -X<option> but that is not a designed-in limitation
but purely comes from a lazy implementation .

Also I do not see why -X<option> is not easy with parseopt() as Dscho
claimed in the original message in this thread...
