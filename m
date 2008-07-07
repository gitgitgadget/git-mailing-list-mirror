From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] better git-submodule status output
Date: Mon, 07 Jul 2008 12:51:39 -0700
Message-ID: <7viqvh322c.fsf@gitster.siamese.dyndns.org>
References: <20080701150119.GE5852@joyeux>
 <alpine.LSU.1.00.0807061456100.3486@wbgn129.biozentrum.uni-wuerzburg.de>
 <20080706160758.GA23385@jhaampe.org>
 <alpine.DEB.1.00.0807061821340.7342@eeepc-johanness>
 <20080707062142.GA5506@jhaampe.org>
 <32541b130807070725p6fa4d0dfne9f04bc857920dc7@mail.gmail.com>
 <alpine.DEB.1.00.0807071533240.18205@racer>
 <alpine.DEB.1.00.0807071537070.18205@racer> <20080707145726.GI3696@joyeux>
 <7v8wwd4kvb.fsf@gitster.siamese.dyndns.org>
 <32541b130807071129m218059eaw8837681c0d705cd@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: "Sylvain Joyeux" <sylvain.joyeux@dfki.de>,
	"Johannes Schindelin" <Johannes.Schindelin@gmx.de>,
	"Lars Hjemli" <hjemli@gmail.com>, "Ping Yin" <pkufranky@gmail.com>,
	"Mark Levedahl" <mlevedahl@gmail.com>, git@vger.kernel.org
To: "Avery Pennarun" <apenwarr@gmail.com>
X-From: git-owner@vger.kernel.org Mon Jul 07 21:52:55 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KFwla-00077u-6B
	for gcvg-git-2@gmane.org; Mon, 07 Jul 2008 21:52:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755478AbYGGTvz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 7 Jul 2008 15:51:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755418AbYGGTvz
	(ORCPT <rfc822;git-outgoing>); Mon, 7 Jul 2008 15:51:55 -0400
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:33805 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755194AbYGGTvy (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 7 Jul 2008 15:51:54 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id AB4A513401;
	Mon,  7 Jul 2008 15:51:52 -0400 (EDT)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with
 ESMTPSA id DEE7A133BF; Mon,  7 Jul 2008 15:51:44 -0400 (EDT)
In-Reply-To: <32541b130807071129m218059eaw8837681c0d705cd@mail.gmail.com>
 (Avery Pennarun's message of "Mon, 7 Jul 2008 14:29:30 -0400")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 2544BA84-4C5E-11DD-84A5-CE28B26B55AE-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/87645>

"Avery Pennarun" <apenwarr@gmail.com> writes:

> Is this really desirable?

Yes.

After "git fetch $random_place master && git log ..FETCH_HEAD" to inspect
what the other guy is up to, if you do not like what you see, you do want
the objects that are only reachable from FETCH_HEAD to go away (note that
it is not counted as the root of fsck traversal for this exact reason).
