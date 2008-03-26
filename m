From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Auto detaching head options (Re: Working copy revision and push
 pain)
Date: Wed, 26 Mar 2008 11:49:44 -0700
Message-ID: <7v3aqde2wn.fsf@gitster.siamese.dyndns.org>
References: <47E658D3.1060104@jwatt.org>
 <51419b2c0803230645l5b07bbf5h9cbf9b6f47373efa@mail.gmail.com>
 <47E6612A.5020408@jwatt.org>
 <51419b2c0803230706w5ff88fc7oc7e8e34ab8afa1fd@mail.gmail.com>
 <alpine.LSU.1.00.0803231519380.4353@racer.site> <47E66DAA.4080807@jwatt.org>
 <alpine.LSU.1.00.0803231555380.4353@racer.site> <47E6765D.2020103@jwatt.org>
 <alpine.LSU.1.00.0803231658460.4353@racer.site>
 <20080325192552.GC4857@efreet.light.src>
 <20080325232424.GB5273@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jan Hudec <bulb@ucw.cz>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Jonathan Watt <jwatt@jwatt.org>,
	Elijah Newren <newren@gmail.com>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Wed Mar 26 19:51:00 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Jeai0-0001AP-VN
	for gcvg-git-2@gmane.org; Wed, 26 Mar 2008 19:50:49 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758148AbYCZSuF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 26 Mar 2008 14:50:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756352AbYCZSuF
	(ORCPT <rfc822;git-outgoing>); Wed, 26 Mar 2008 14:50:05 -0400
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:40990 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753505AbYCZSuE (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 26 Mar 2008 14:50:04 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id 29F6B54BE;
	Wed, 26 Mar 2008 14:50:02 -0400 (EDT)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with
 ESMTP id B8D2954BB; Wed, 26 Mar 2008 14:49:53 -0400 (EDT)
In-Reply-To: <20080325232424.GB5273@coredump.intra.peff.net> (Jeff King's
 message of "Tue, 25 Mar 2008 19:24:24 -0400")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/78299>

Jeff King <peff@peff.net> writes:

> FWIW, I also initially thought this was only a "HEAD" problem, but I
> think Junio's recent argument makes a lot of sense: the problem is not
> one of working tree and HEAD sync, nor even of detached versus ref HEAD.
> The problem is that somebody is using the non-bare repository to do
> stuff (why else would it be non-bare), and you are changing the state
> behind their back.

For people who are overwhelmed by the volume of the list traffic, the
relevant thread is:

  http://thread.gmane.org/gmane.comp.version-control.git/77955/focus=78062

> Isn't this essentially the 'base' index extension that Junio did a
> while back? It was eventually reverted (or perhaps never merged, I don't
> recall).

It was in 'next' for a while but was reverted before it hit 'master':

  http://thread.gmane.org/gmane.comp.version-control.git/44360/focus=44508

> But maybe you are referencing it here:
>
>>    It would really be similar to the revision number in index proposal,
>>    except less invasive and I actually believe there is a case (some form of
>>    checkout or reset), where we want to read-tree, but not change this ref.
>
> I don't recall the reasons the base extension was not accepted, but I
> think it would make sense to frame your argument as "this is like X;
> people didn't like X for reason Y, but my proposal fixes this by..."

But if you take the position "work tree belongs to the repository owner
and nobody has any business pushing into it sideways; push into acceptance
branch and let the work tree owner merge it when able", the history of the
failed index base experiment becomes irrelevant.
