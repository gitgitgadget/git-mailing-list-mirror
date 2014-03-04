From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: Re: [PATCH] implemented strbuf_write_or_die()
Date: Tue, 04 Mar 2014 10:18:57 +0100
Message-ID: <53159A81.4050905@alum.mit.edu>
References: <1393672871-28281-1-git-send-email-faiz.off93@gmail.com> <CAJr59C0e22OuDWU5Xc0A=cc+zY32nfum6SXTDU3wLCPyFPF70A@mail.gmail.com> <CAPig+cRgc4UtmJMieS9Mdrz7vjUNiu7QFu1PSBppKo22Ln5G-A@mail.gmail.com> <xmqqvbvvqglc.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Eric Sunshine <sunshine@sunshineco.com>,
	He Sun <sunheehnus@gmail.com>,
	Faiz Kothari <faiz.off93@gmail.com>, git <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Mar 04 10:19:11 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WKlVG-0006WE-3k
	for gcvg-git-2@plane.gmane.org; Tue, 04 Mar 2014 10:19:10 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756669AbaCDJTF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 4 Mar 2014 04:19:05 -0500
Received: from alum-mailsec-scanner-8.mit.edu ([18.7.68.20]:50172 "EHLO
	alum-mailsec-scanner-8.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752195AbaCDJTD (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 4 Mar 2014 04:19:03 -0500
X-AuditID: 12074414-f79d96d000002d2b-f3-53159a85fb52
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by alum-mailsec-scanner-8.mit.edu (Symantec Messaging Gateway) with SMTP id CC.5E.11563.58A95135; Tue,  4 Mar 2014 04:19:01 -0500 (EST)
Received: from [192.168.69.148] (p57A2482C.dip0.t-ipconnect.de [87.162.72.44])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id s249Ivv1001563
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES128-SHA bits=128 verify=NOT);
	Tue, 4 Mar 2014 04:18:59 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:17.0) Gecko/20131103 Icedove/17.0.10
In-Reply-To: <xmqqvbvvqglc.fsf@gitster.dls.corp.google.com>
X-Enigmail-Version: 1.6
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrBKsWRmVeSWpSXmKPExsUixO6iqNs6SzTYYOcaSYv7G1+xWHRd6Way
	aOi9wmzRdns7o8WZN42MDqweO2fdZfe4eEnZY/EDL4/Pm+QCWKK4bZISS8qCM9Pz9O0SuDMu
	z7zNWHBboGLqzwXsDYydvF2MnBwSAiYSzX07WSBsMYkL99azdTFycQgJXGaUOPdoIyuEc5ZJ
	4t3LH6wgVbwC2hJfTt9nA7FZBFQljm48DdbNJqArsainmQnEFhUIllh9+QELRL2gxMmZT8Bs
	EQE1iYlth1hAhjILTGaU2DOhBywhLGAmsfzLSnaIbX8ZJT60/QXbwClgLTFr1UXmLkYOoPvE
	JXoag0DCzAI6Eu/6HjBD2PIS29/OYZ7AKDgLyb5ZSMpmISlbwMi8ilEuMac0Vzc3MTOnODVZ
	tzg5MS8vtUjXQi83s0QvNaV0EyMk5EV2MB45KXeIUYCDUYmHd6GxaLAQa2JZcWXuIUZJDiYl
	Ud7LU4FCfEn5KZUZicUZ8UWlOanFhxglOJiVRHhfTQbK8aYkVlalFuXDpKQ5WJTEeb8tVvcT
	EkhPLEnNTk0tSC2CycpwcChJ8DbOBGoULEpNT61Iy8wpQUgzcXCCDOeSEilOzUtJLUosLcmI
	B0VxfDEwjkFSPEB7F4K08xYXJOYCRSFaTzHqctxu+/WJUYglLz8vVUqc1wakSACkKKM0D24F
	LMG9YhQH+liYVxWkigeYHOEmvQJawgS0hBvsueKSRISUVAOjc2WEjfzzB3VfFzM9PlB/Isnb
	613BH+fLt8/9nH3k149FST/frFiv5ntSK2JbT3ZelHb0TTupX2l5Pwqrk0NrlR+y 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/243333>

On 03/03/2014 07:31 PM, Junio C Hamano wrote:
> Eric Sunshine <sunshine@sunshineco.com> writes:
> 
>> On Sat, Mar 1, 2014 at 7:51 AM, He Sun <sunheehnus@gmail.com> wrote:
>>> 2014-03-01 19:21 GMT+08:00 Faiz Kothari <faiz.off93@gmail.com>:
>>>> diff --git a/remote-curl.c b/remote-curl.c
>>>> index 10cb011..dee8716 100644
>>>> --- a/remote-curl.c
>>>> +++ b/remote-curl.c
>>>> @@ -634,7 +634,7 @@ static int rpc_service(struct rpc_state *rpc, struct discovery *heads)
>>>>         if (start_command(&client))
>>>>                 exit(1);
>>>>         if (preamble)
>>>> -               write_or_die(client.in, preamble->buf, preamble->len);
>>>> +               strbuf_write_or_die(client.in, preamble);
>>>>         if (heads)
>>>>                 write_or_die(client.in, heads->buf, heads->len);
>>>
>>> This should be changed. May be you can use Ctrl-F to search write_or_die().
>>> Or if you are using vim, use "/ and n" to find all.
>>
>> It's not obvious from the patch fragment, but 'heads' is not a strbuf,
>> so Faiz correctly left this invocation alone.
> 
> That is a very good sign why this change is merely a code-churn and
> not an improvement, isn't it?  We know (and any strbuf user should
> know) that ->buf and ->len are the ways to learn the pointer and the
> length the strbuf holds.  Why anybody thinks it is benefitial to
> introduce another function that is _only_ for writing out strbuf and
> cannot be used to write out a plain buffer is simply beyond me.

I'm the guilty one.  I like the change (obviously, since I suggested
it).  Writing strbufs comes up frequently and will hopefully increase in
usage and I think it is a positive thing to encourage the use of strbufs
by making them increasingly first-class citizens.

But I can see your points too, and I humbly defer to the wisdom of the
list.  I will remove this suggestion from the list of microprojects.

Faiz, this is the way things go on the Git mailing list.  It would be
boring if everybody agreed all the time :-)

Michael

-- 
Michael Haggerty
mhagger@alum.mit.edu
http://softwareswirl.blogspot.com/
