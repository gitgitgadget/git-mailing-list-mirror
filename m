From: Michael J Gruber <git@drmicha.warpmail.net>
Subject: Re: [PATCH] -C/--chdir command line option
Date: Mon, 20 Oct 2008 14:57:45 +0200
Message-ID: <48FC8049.2080107@drmicha.warpmail.net>
References: <20081019000227.GA9423@charybdis.dreamhost.com> <20081019131745.GA8643@coredump.intra.peff.net> <86685067-021C-4DC5-A462-AA6834208BDE@pasternacki.net> <20081019141634.GA8997@coredump.intra.peff.net> <7vr66b50gy.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Jeff King <peff@peff.net>,
	Maciej Pasternacki <maciej@pasternacki.net>,
	git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Oct 20 22:20:10 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KruLh-0006un-Dh
	for gcvg-git-2@gmane.org; Mon, 20 Oct 2008 14:59:05 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752120AbYJTM5w (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 20 Oct 2008 08:57:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751719AbYJTM5w
	(ORCPT <rfc822;git-outgoing>); Mon, 20 Oct 2008 08:57:52 -0400
Received: from out3.smtp.messagingengine.com ([66.111.4.27]:46832 "EHLO
	out3.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751246AbYJTM5v (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 20 Oct 2008 08:57:51 -0400
Received: from compute2.internal (compute2.internal [10.202.2.42])
	by out1.messagingengine.com (Postfix) with ESMTP id 633DD1810CC;
	Mon, 20 Oct 2008 08:57:48 -0400 (EDT)
Received: from heartbeat2.messagingengine.com ([10.202.2.161])
  by compute2.internal (MEProxy); Mon, 20 Oct 2008 08:57:48 -0400
X-Sasl-enc: SNVr+gcGRwJCbMG93PkTjKnEWh2WUvf0fxDsnfLDfhLc 1224507467
Received: from [139.174.44.12] (whitehead.math.tu-clausthal.de [139.174.44.12])
	by mail.messagingengine.com (Postfix) with ESMTPSA id 7C1351F4E4;
	Mon, 20 Oct 2008 08:57:47 -0400 (EDT)
User-Agent: Thunderbird 2.0.0.17 (X11/20080914)
In-Reply-To: <7vr66b50gy.fsf@gitster.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/98698>

Junio C Hamano venit, vidit, dixit 20.10.2008 06:55:
> Jeff King <peff@peff.net> writes:
> 
>> On Sun, Oct 19, 2008 at 03:47:04PM +0200, Maciej Pasternacki wrote:
>>
>>> As for -C being superfluous: --git-dir and --work-tree seem to support  
>>> weird usage patterns (like work tree separate from git-dir), but it seems 
>> Hmm. Yeah, thinking about it more, -C is not really superfluous with
>> respect to those options. You don't want to say "here is the work-tree,
>> and here is the git-dir". You want to say "find the work-tree and
>> git-dir for me using the usual rules, as if I were in this directory."
> 
> I think that interpretation of -C, if the option existed, makes sense, but
> I do not understand why the tool that drives git refuses to chdir to the
> repository for itself in the first place.
> 
> The only excuse I remember seeing in the thread was that "make has '-C'
> option, so let's have it, because it is similar", which does not justfiy
> addition of that option to git at all to me.

I want to have '-j2' ;)

Seriously:

git -C elsewhere command opts

is shorther and more direct than

(cd elsewhere && git command opts)

which is the true equivalent, or

pushd elsewhere; git command opts; popd

And much shorter than using --git-dir and --work-tree, which are
semi-broken right now.

I just think it's very useful to be able to peek into a repo somewhere
else quickly; or for transferral of objects between unrelated objects
(run rev-parse elsewhere etc.).

Michael
