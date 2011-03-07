From: Colin Guthrie <gmane@colin.guthr.ie>
Subject: Re: [BUG] git-am silently applying patches incorrectly
Date: Mon, 07 Mar 2011 09:37:23 +0000
Message-ID: <4D74A753.2020200@colin.guthr.ie>
References: <4D70EBC3.3010400@colin.guthr.ie> <7vr5am7p30.fsf@alter.siamese.dyndns.org> <7vei6m7muw.fsf@alter.siamese.dyndns.org> <7v39n27llq.fsf@alter.siamese.dyndns.org> <AANLkTim=jpJmBZmtAVX2V8Ui44AwpTbevJtSR2Xk=wLX@mail.gmail.com> <7vy64u65ta.fsf@alter.siamese.dyndns.org> <loom.20110304T210337-216@post.gmane.org> <7vtyfi606a.fsf@alter.siamese.dyndns.org> <4D7165A3.5080308@colin.guthr.ie> <7vlj0u5wyw.fsf@alter.siamese.dyndns.org> <4D7223A9.6080105@colin.guthr.ie> <7vlj0r520k.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: Alexander Miseler <alexander@miseler.de>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Mar 07 10:37:34 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PwWsf-0001eW-BX
	for gcvg-git-2@lo.gmane.org; Mon, 07 Mar 2011 10:37:33 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755268Ab1CGJh2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 7 Mar 2011 04:37:28 -0500
Received: from brent.tribalogic.net ([78.86.109.144]:48525 "EHLO
	summit.brent.tribalogic.net" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1752719Ab1CGJh1 (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 7 Mar 2011 04:37:27 -0500
Received: from localhost (summit.brent.tribalogic.net [127.0.0.1])
	by summit.brent.tribalogic.net (Postfix) with ESMTP id 7943CD8720;
	Mon,  7 Mar 2011 09:37:25 +0000 (GMT)
X-Virus-Scanned: amavisd-new at brent.tribalogic.net
Received: from summit.brent.tribalogic.net ([127.0.0.1])
	by localhost (summit.brent.tribalogic.net [127.0.0.1]) (amavisd-new, port 10025)
	with LMTP id ghppx4c3XOT4; Mon,  7 Mar 2011 09:37:23 +0000 (GMT)
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.9.2.15) Gecko/20110305 Mageia/3.1.9-1.mga1 (1) Thunderbird/3.1.9
In-Reply-To: <7vlj0r520k.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/168571>

'Twas brillig, and Junio C Hamano at 06/03/11 22:15 did gyre and gimble:
>> > Personally I wouldn't bother making offset absolute... (equiv of
>> > abs(offset)) as knowing it applied earlier or later could be useful...
>> > the direction is lost here and I don't really see why that's nicer for
>> > the user. But maybe that's just my opinion?
> I don't have a strong opinion on this either way; I would just imitate
> what GNU patch would do, which would probably be to show the offset as-is,
> except that it flips the sign if it is being run in reverse with -R
> option.

Yeah I think that's quite sensible. I think converging with the way GNU
patch does it except when there is really good reason not to makes a lot
of sense, if nothing more than general familiarity and expectations.

> A bigger question I would actually care _more_ about is if this should be
> on by default without -v.  We usually do not allow fuzz by default for
> safety, and we do warn loudly when -C reduces the context and we actually
> need to use it to match the preimage.

Users used to using patch may simply think there are no offset
adjustments when using git am and live in blissful ignorance. For that
reason I'd say it should be on by default. But then again, I've been
recently jaded by a mis-applied patch... if I'm honest, I would probably
say that 99 times in a 100, I couldn't really care less (or really read)
the offset adjustments.... so I can't really comment very subjectively
here :s

> In any case, here is an update to match what GNU patch seems to do more
> closely.

Looks good to me!

Thanks again for looking into this issue :) Hopefully the primary fix
can be pushed soon and the nice usability improvements that have spawned
from it can head the same direction too :)

Col

-- 

Colin Guthrie
gmane(at)colin.guthr.ie
http://colin.guthr.ie/

Day Job:
  Tribalogic Limited [http://www.tribalogic.net/]
Open Source:
  Mageia Contributor [http://www.mageia.org/]
  PulseAudio Hacker [http://www.pulseaudio.org/]
  Trac Hacker [http://trac.edgewall.org/]
