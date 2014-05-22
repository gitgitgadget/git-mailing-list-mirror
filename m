From: Johannes Sixt <j.sixt@viscovery.net>
Subject: Re: [PATCHv2 10/19] git-submodule.sh: convert test -a/-o to && and
 ||
Date: Thu, 22 May 2014 11:10:02 +0200
Message-ID: <537DBEEA.8010403@viscovery.net>
References: <1400682255-17616-1-git-send-email-gitter.spiros@gmail.com>	<vpqha4is3yd.fsf@anie.imag.fr> <CA+EOSB=wqBUb_QB6XtK0v4Lsux1mG7wCvXP3XVeDe7o=ofsYFA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: "git@vger.kernel.org" <git@vger.kernel.org>
To: Elia Pinto <gitter.spiros@gmail.com>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
X-From: git-owner@vger.kernel.org Thu May 22 11:10:15 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WnP0w-0008HX-G3
	for gcvg-git-2@plane.gmane.org; Thu, 22 May 2014 11:10:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753994AbaEVJKI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 22 May 2014 05:10:08 -0400
Received: from so.liwest.at ([212.33.55.23]:53235 "EHLO so.liwest.at"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752114AbaEVJKH (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 22 May 2014 05:10:07 -0400
Received: from [81.10.228.254] (helo=theia.linz.viscovery)
	by so.liwest.at with esmtpa (Exim 4.80.1)
	(envelope-from <j.sixt@viscovery.net>)
	id 1WnP0k-0003uX-9E; Thu, 22 May 2014 11:10:02 +0200
Received: from [192.168.1.95] (J6T.linz.viscovery [192.168.1.95])
	by theia.linz.viscovery (Postfix) with ESMTP id 0A7A616613;
	Thu, 22 May 2014 11:10:01 +0200 (CEST)
User-Agent: Mozilla/5.0 (Windows NT 5.1; rv:24.0) Gecko/20100101 Thunderbird/24.1.0
In-Reply-To: <CA+EOSB=wqBUb_QB6XtK0v4Lsux1mG7wCvXP3XVeDe7o=ofsYFA@mail.gmail.com>
X-Enigmail-Version: 1.6
X-Spam-Score: -1.0 (-)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/249884>

Am 5/22/2014 10:38, schrieb Elia Pinto:
> 2014-05-22 8:49 GMT+02:00 Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>:
>> Elia Pinto <gitter.spiros@gmail.com> writes:
>>> @@ -1059,13 +1059,17 @@ cmd_summary() {
>>>               while read mod_src mod_dst sha1_src sha1_dst status sm_path
>>>               do
>>>                       # Always show modules deleted or type-changed (blob<->module)
>>> -                     test $status = D -o $status = T && echo "$sm_path" && continue
>>> +                     case "$status" in
>>> +                     [DT])
>>> +                             printf '%s\n' "$sm_path" &&
>>> +                             continue
>>> +                     esac
>>
>> turning a echo into a printf is good, but would be better done
>> separately.
> 
> I had thought, but the change was in the fix of Johannes, and it did
> not think was right to change this, especially that it was right
> anyway. But I understand very well the observation.

My intent was to show the final state of this piece of code. I do agree
with Matthieu that the change from 'echo' to 'printf' is a different topic
(in particular, since this is not the only point in the script that would
need that change). Sorry for having sent you in circles.

-- Hannes
