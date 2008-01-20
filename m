From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Let "git svn" run "git gc --auto" occasionally
Date: Sun, 20 Jan 2008 11:17:02 -0800
Message-ID: <7vlk6k8fyp.fsf@gitster.siamese.dyndns.org>
References: <20080119123557.GA30778@diana.vm.bytemark.co.uk>
	<20080119223249.8227.31460.stgit@yoghurt>
	<1200783050.5724.196.camel@brick> <20080120033737.GA7767@soma>
	<20080120093436.GA10924@diana.vm.bytemark.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Eric Wong <normalperson@yhbt.net>,
	Harvey Harrison <harvey.harrison@gmail.com>,
	git@vger.kernel.org, Kevin Ballard <kevin@sb.org>
To: Karl =?utf-8?Q?Hasselstr=C3=B6m?= <kha@treskal.com>
X-From: git-owner@vger.kernel.org Sun Jan 20 20:17:49 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JGffv-0008UL-0z
	for gcvg-git-2@gmane.org; Sun, 20 Jan 2008 20:17:47 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753056AbYATTRS convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 20 Jan 2008 14:17:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754875AbYATTRS
	(ORCPT <rfc822;git-outgoing>); Sun, 20 Jan 2008 14:17:18 -0500
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:36552 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751711AbYATTRR convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 20 Jan 2008 14:17:17 -0500
Received: from a-sasl-quonix (localhost [127.0.0.1])
	by a-sasl-quonix.pobox.com (Postfix) with ESMTP id C7DBD2D43;
	Sun, 20 Jan 2008 14:17:15 -0500 (EST)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by a-sasl-quonix.pobox.com (Postfix) with ESMTP id 314962D42;
	Sun, 20 Jan 2008 14:17:10 -0500 (EST)
In-Reply-To: <20080120093436.GA10924@diana.vm.bytemark.co.uk> (Karl
	=?utf-8?Q?Hasselstr=C3=B6m's?= message of "Sun, 20 Jan 2008 10:34:36
 +0100")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/71184>

Karl Hasselstr=C3=B6m <kha@treskal.com> writes:

> On 2008-01-19 19:37:37 -0800, Eric Wong wrote:
>
>> Harvey Harrison <harvey.harrison@gmail.com> wrote:
>>
>> > I found 100 was a bit too low when doing some large repos, I've
>> > been using 1000. I'd argue that --repack=3D1000 should be done by
>> > default.
>>
>> I've found 100 for repack too low in the past, too, which is why
>> repack defaults to 1000 if no number is specified. I think it should
>> hold for gc --auto, too.
>
> OK, I'll change it. But remember, gc --auto doesn't do _anything_
> unless it's deemed necessary, so it should behave much better than
> just plain repack. In theory at least.

Careful. I made the same mistake and it had to be corrected with
e0cd252eb0ba6453acd64762625b004aa4cc162b.

I think defaulting to --repack=3D1000 is a sane first step and you
guys already have most code for it so that is a very safe thing.

Switching to "gc --auto" can be done early post 1.5.4, right?
