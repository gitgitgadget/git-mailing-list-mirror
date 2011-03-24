From: Nicolas Morey-Chaisemartin <devel-git@morey-chaisemartin.com>
Subject: Re: [PATCH 1/2] git-submodule.sh: Handle submodules with merge conflicts
Date: Thu, 24 Mar 2011 07:58:57 +0100
Message-ID: <4D8AEBB1.5010501@morey-chaisemartin.com>
References: <4D886430.3080300@kalray.eu> <4D88F6EF.3020804@web.de> <7voc52kf3t.fsf@alter.siamese.dyndns.org>
Reply-To: devel-git@morey-chaisemartin.com
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Mar 24 07:59:12 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Q2eVi-0004eD-KK
	for gcvg-git-2@lo.gmane.org; Thu, 24 Mar 2011 07:59:10 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932956Ab1CXG7D (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 24 Mar 2011 02:59:03 -0400
Received: from 30.mail-out.ovh.net ([213.186.62.213]:56932 "HELO
	30.mail-out.ovh.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S932845Ab1CXG7B (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 24 Mar 2011 02:59:01 -0400
Received: (qmail 13376 invoked by uid 503); 24 Mar 2011 06:49:19 -0000
Received: from b9.ovh.net (HELO mail419.ha.ovh.net) (213.186.33.59)
  by 30.mail-out.ovh.net with SMTP; 24 Mar 2011 06:49:19 -0000
Received: from b0.ovh.net (HELO queueout) (213.186.33.50)
	by b0.ovh.net with SMTP; 24 Mar 2011 08:58:59 +0200
Received: from mailhost.kalray.eu (HELO sat.lin.mbt.kalray.eu) (devel-git@morey-chaisemartin.com@217.108.237.233)
  by ns0.ovh.net with SMTP; 24 Mar 2011 08:58:57 +0200
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.9.2.13) Gecko/20101209 Fedora/3.1.7-0.35.b3pre.fc14 Lightning/1.0b2 Thunderbird/3.1.7
In-Reply-To: <7voc52kf3t.fsf@alter.siamese.dyndns.org>
X-Ovh-Tracer-Id: 16983355669964120024
X-Ovh-Remote: 217.108.237.233 (mailhost.kalray.eu)
X-Ovh-Local: 213.186.33.20 (ns0.ovh.net)
X-Spam-Check: DONE|U 0.5/N
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/169894>

On 03/22/2011 10:41 PM, Junio C Hamano wrote:
> Jens Lehmann <Jens.Lehmann@web.de> writes:
>
>> Thanks, that fixes it nicely!
>>
>> Am 22.03.2011 09:56, schrieb Nicolas Morey-Chaisemartin:
>>> During a merge with conflict on a submodule, the submodule appears 3 times in git ls-files (stage 1,2,3) which caused the submodule to be used 3 times in git submodule init, sync, update and status command.
>>> This patch filters the results of git ls-files to generate a single entry for conflicting submodules with a 0 SHA1 and 'U' as stage.
>> Nit: Usually we wrap commit messages at about 72 characters.
> Also it is very dissapointing to see that none of the careful thinking
> that was needed while deciding what each subcommand should do was copied
> from <7vhbb1320t.fsf@alter.siamese.dyndns.org> -- did I just waste my
> time trying to guide this topic forward?
>
Sorry about that. I wasn't sure how much details you put in commit logs. I guess it wasn't enough.
I'll fix this as soon as I have added a test case for the 'U' status
