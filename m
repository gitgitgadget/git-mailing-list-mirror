From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Documentation: add a planning document for the next CLI 
 revamp
Date: Mon, 03 Nov 2008 15:33:10 -0800
Message-ID: <7v4p2ov0zt.fsf@gitster.siamese.dyndns.org>
References: <20081030002239.D453B21D14E@mail.utsl.gen.nz>
 <20081031003154.GA5745@sigill.intra.peff.net>
 <7v3ai9226q.fsf@gitster.siamese.dyndns.org>
 <20081103092507.GD13930@artemis.corp>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jeff King <peff@peff.net>, Sam Vilain <samv@vilain.net>,
	git@vger.kernel.org,
	Johannes Schindelin <johannes.schindelin@gmx.de>,
	Scott Chacon <schacon@gmail.com>,
	Tom Preston-Werner <tom@github.com>,
	"J.H." <warthog19@eaglescrag.net>,
	Christian Couder <chriscool@tuxfamily.org>,
	Kai Blin <kai@samba.org>
To: Pierre Habouzit <madcoder@debian.org>
X-From: git-owner@vger.kernel.org Tue Nov 04 00:35:25 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Kx8x9-0008Ss-3R
	for gcvg-git-2@gmane.org; Tue, 04 Nov 2008 00:35:23 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754377AbYKCXeG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 3 Nov 2008 18:34:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753729AbYKCXeF
	(ORCPT <rfc822;git-outgoing>); Mon, 3 Nov 2008 18:34:05 -0500
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:60120 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752263AbYKCXeE (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 3 Nov 2008 18:34:04 -0500
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id E9FFE7544A;
	Mon,  3 Nov 2008 18:34:01 -0500 (EST)
Received: from pobox.com (ip68-225-240-211.oc.oc.cox.net [68.225.240.211])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with
 ESMTPSA id E97387543A; Mon,  3 Nov 2008 18:33:17 -0500 (EST)
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: E54848BA-A9FF-11DD-AE8B-9CEDC82D7133-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/100009>

Pierre Habouzit <madcoder@debian.org> writes:

> On Sun, Nov 02, 2008 at 10:27:57PM +0000, Junio C Hamano wrote:
>> Jeff King <peff@peff.net> writes:
>> 
>> >> +  * 'git push --matching' does what 'git push' does today (without
>> >> +    explicit configuration)
>> >
>> > I think this is reasonable even without other changes, just to override
>> > any configuration.
>> 
>> I don't.  Can't you say "git push $there HEAD" these days?  I vaguely
>> recall that there is a way to configure push that way for people too lazy
>> to type "origin HEAD" after "git push".
>
> Yes, but it's broken in the sense that if you're in a non matching
> branch it creates it remotely.

Ok, I agree that may be a problem.

But that would not change if you only changed the default behaviour from
matching to _this branch_.  You need to also teach a new mode of operation
to send-pack/receive-pack pair, which is to "update the same branch as the
one I am on locally, but do not do anything if there is no such branch
over there".  I do not think we have such a mode of operation currently.

By the way, didn't we add a feature to let you say "git push $there :"
which is to do what "git push --matching $there" would do?
