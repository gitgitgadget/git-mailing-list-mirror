From: Richard Hansen <rhansen@bbn.com>
Subject: Re: [PATCH v2] remote-bzr: reuse bzrlib transports when possible
Date: Thu, 12 Sep 2013 17:05:16 -0400
Message-ID: <52322C8C.4000501@bbn.com>
References: <522C0B66.1080707@bbn.com> <1378619269-21991-1-git-send-email-rhansen@bbn.com> <xmqqa9jl1u7j.fsf@gitster.dls.corp.google.com> <xmqqbo40wd3d.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, felipe.contreras@gmail.com
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Sep 12 23:05:27 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VKE4q-0005gX-Mk
	for gcvg-git-2@plane.gmane.org; Thu, 12 Sep 2013 23:05:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755956Ab3ILVFU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 12 Sep 2013 17:05:20 -0400
Received: from smtp.bbn.com ([128.33.0.80]:34596 "EHLO smtp.bbn.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754243Ab3ILVFU (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 12 Sep 2013 17:05:20 -0400
Received: from socket.bbn.com ([192.1.120.102]:55535)
	by smtp.bbn.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.77 (FreeBSD))
	(envelope-from <rhansen@bbn.com>)
	id 1VKE4j-0000o0-3O; Thu, 12 Sep 2013 17:05:17 -0400
X-Submitted: to socket.bbn.com (Postfix) with ESMTPSA id D78D340093
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:17.0) Gecko/20130803 Thunderbird/17.0.8
In-Reply-To: <xmqqbo40wd3d.fsf@gitster.dls.corp.google.com>
X-Enigmail-Version: 1.5.2
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/234696>

On 2013-09-10 18:01, Junio C Hamano wrote:
> Junio C Hamano <gitster@pobox.com> writes:
> 
>> Richard Hansen <rhansen@bbn.com> writes:
>>
>>>  def do_export(parser):
>>> -    global parsed_refs, dirname
>>> +    global parsed_refs, dirname, transports
>>
>> As this has been acked by Felipe who knows the script the best, I'll
>> apply this directly to 'master'.
>>
>> These additions of "global transports" however have trivial
>> interactions with fc/contrib-bzr-hg-fixes topic Felipe posted
>> earlier, which I was planning to start merging down to 'next' and
>> then to 'master'.  Most funcions merely use the variable without
>> assigning, so "global transports" can be removed, in line with the
>> spirit of 641a2b5b (remote-helpers: cleanup more global variables,
>> 2013-08-28), except for the obvious initialisation in main(), I
>> think.  Please double check the conflict resolution result in a
>> commit on 'pu' with
>>
>>     git show 'origin/pu^{/Merge fc/contrib-bzr}'
>>
>> when I push the result out.
>>
>> Thanks.
> 
> Ping?  I'd like to merge fc/contrib-bzr.hg-fixes topic to 'next'
> (and fast track it to 'master' after that), and it would be helpful
> to get an Ack on the conflict resolution I have.

Sorry for the delay.

Looks good to me, and the tests still pass.

-Richard
