From: Steffen Prohaska <prohaska@zib.de>
Subject: Re: [PATCH 5/8] push, send-pack: support pushing HEAD to real ref name
Date: Sun, 28 Oct 2007 16:59:37 +0100
Message-ID: <EE8B843C-5276-4FEC-ABDD-FC456EFD3D75@zib.de>
References: <119350380778-git-send-email-prohaska@zib.de> <11935038081211-git-send-email-prohaska@zib.de> <11935038081650-git-send-email-prohaska@zib.de> <1193503808519-git-send-email-prohaska@zib.de> <11935038083369-git-send-email-prohaska@zib.de> <11935038084055-git-send-email-prohaska@zib.de> <7vwst7wvdr.fsf@gitster.siamese.dyndns.org> <722152C5-299C-435E-B720-D2D331D16249@zib.de> <7vd4uzuu1g.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0 (Apple Message framework v752.3)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Oct 28 16:59:00 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1ImAXT-0005HQ-AB
	for gcvg-git-2@gmane.org; Sun, 28 Oct 2007 16:58:59 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751290AbXJ1P6q (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 28 Oct 2007 11:58:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751097AbXJ1P6q
	(ORCPT <rfc822;git-outgoing>); Sun, 28 Oct 2007 11:58:46 -0400
Received: from mailer.zib.de ([130.73.108.11]:56953 "EHLO mailer.zib.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750749AbXJ1P6q (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 28 Oct 2007 11:58:46 -0400
Received: from mailsrv2.zib.de (sc2.zib.de [130.73.108.31])
	by mailer.zib.de (8.13.7+Sun/8.13.7) with ESMTP id l9SFwBOA009287;
	Sun, 28 Oct 2007 16:58:12 +0100 (CET)
Received: from [192.168.178.21] (brln-4db1072b.pool.einsundeins.de [77.177.7.43])
	(authenticated bits=0)
	by mailsrv2.zib.de (8.13.4/8.13.4) with ESMTP id l9SFwAqx027333
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=NO);
	Sun, 28 Oct 2007 16:58:11 +0100 (MET)
In-Reply-To: <7vd4uzuu1g.fsf@gitster.siamese.dyndns.org>
X-Mailer: Apple Mail (2.752.3)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/62567>


On Oct 28, 2007, at 4:40 PM, Junio C Hamano wrote:

> Steffen Prohaska <prohaska@zib.de> writes:
>
>> On Oct 28, 2007, at 8:28 AM, Junio C Hamano wrote:
>>
>>> Steffen Prohaska <prohaska@zib.de> writes:
>>>
>>>> This teaches "push <remote> HEAD" to resolve HEAD on the local
>>>> side to its real ref name, e.g. refs/heads/master, and then
>>>> use the real ref name on the remote side to search a matching
>>>> remote ref.
>>>
>>> This probably is a good idea.
>>
>> I'll add an even shorter shorthand: "git push HEAD" will push
>> the current branch to its default remote.
>
> Ugh, that looks way too magicky.  The first parameter to push if
> one ever exists has _always_ been the remote, and the above
> breaks it.

Yes. It breaks setups that have a remote named HEAD.


> Please don't.

I already did it -- it was too easy. But it's a separate patch.
So it can easily be skipped.

What would you propose for pushing only the current branch to
its default remote repository? All information is there. Only
a way to tell push to restrict push to the current branch
is missing. Would you prefer something like
"git push --only-current-branch"?

	Steffen
