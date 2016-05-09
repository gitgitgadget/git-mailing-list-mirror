From: "Philip Oakley" <philipoakley@iee.org>
Subject: Re: /* compiler workaround */ - what was the issue?
Date: Mon, 9 May 2016 20:40:22 +0100
Organization: OPDS
Message-ID: <9836AC86AA754C27AFD5D87519DF1402@PhilipOakley>
References: <AA5B2B1715BAF7438221293187A417A7BDE9D11D@desmdswms002.des.grplnk.net><17E04501C9474282B87758C7998A1F5B@PhilipOakley><xmqqtwic9o88.fsf@gitster.mtv.corp.google.com><CACsJy8CBuU8H8r_f4KsnLkhLtfRv0nDo4hGS31LVn0e1Y_3OAQ@mail.gmail.com><51C902B1F7464CF2B58EB0E495F86BB5@PhilipOakley><572CDCFF.9050607@ramsayjones.plus.com><xmqq60ur3tlu.fsf@gitster.mtv.corp.google.com><572CF0D5.6010305@xiplink.com><xmqqinyr2c3d.fsf@gitster.mtv.corp.google.com> <CAGZ79kby0Z1FMUT-w8h=YfRxsmyXaiE2pA_VoJ0g9wn0Mzk2Wg@mail.gmail.com>
Reply-To: "Philip Oakley" <philipoakley@iee.org>
Mime-Version: 1.0
Content-Type: text/plain;
	format=flowed;
	charset="UTF-8";
	reply-type=original
Content-Transfer-Encoding: 7bit
Cc: "Marc Branchaud" <marcnarc@xiplink.com>,
	"Ramsay Jones" <ramsay@ramsayjones.plus.com>,
	"Duy Nguyen" <pclouds@gmail.com>, "Git List" <git@vger.kernel.org>
To: "Stefan Beller" <sbeller@google.com>,
	"Junio C Hamano" <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon May 09 21:40:34 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1azr2b-0001Db-1R
	for gcvg-git-2@plane.gmane.org; Mon, 09 May 2016 21:40:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751228AbcEITkZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 9 May 2016 15:40:25 -0400
Received: from smtp-out-6.talktalk.net ([62.24.135.70]:30727 "EHLO
	smtp-out-6.talktalk.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751033AbcEITkY (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 9 May 2016 15:40:24 -0400
Received: from PhilipOakley ([92.22.21.237])
	by smtp.talktalk.net with SMTP
	id zr2Ra4CRgAgnLzr2RahGQg; Mon, 09 May 2016 20:40:22 +0100
X-Originating-IP: [92.22.21.237]
X-Spam: 0
X-OAuthority: v=2.2 cv=Trikv3fh c=1 sm=1 tr=0 a=YxMFZmwUIZCSM0iMmexPsw==:117
 a=YxMFZmwUIZCSM0iMmexPsw==:17 a=IkcTkHD0fZMA:10 a=1XWaLZrsAAAA:8
 a=ybZZDoGAAAAA:8 a=8q6LdnVOAAAA:8 a=Yj7LhcEDJJB-6oIRbm0A:9
 a=nJcEw6yWrPvoIXZ49MH8:22 a=0RhZnL1DYvcuLYC8JZ5M:22 a=jNYSTCpFY2gkngftge3H:22
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2900.5931
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2900.6157
X-CMAE-Envelope: MS4wfDkjUSfk8X/Zy5lCwIZ2BoBBQEGB/Ig/vgaB4sXMGvJ50VX+dVClEC+YbWx0kO4Inir71w6lW2/JcoLqW4IEnxlL2DACe01gABTSTS6eK33opmtWzxYC
 ujQ2BG2bA/a4oEIDXwzEdIjTRNyS04RKQ6kQdS1kTyr88qpykuEg8RIhnNMevs+9N/uqu3mJbzyNotFuCIUft0B+Q0T2/jw1xNRXg2ZTx06X9dd5RUsS4I/E
 /3PrdvGYPPY+4F8LXctM3qBjUQfxYUZsd2KxXIDUva7wwRlqEJjEww0gI62YzzGTyMN/lXbnVaBEzVft5NaQGLsB1bPcq34bH8SrHHZ6Kv0=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/294042>

From: "Stefan Beller" <sbeller@google.com>
> On Fri, May 6, 2016 at 12:57 PM, Junio C Hamano <gitster@pobox.com> wrote:
>> Marc Branchaud <marcnarc@xiplink.com> writes:
>>
>>> On 2016-05-06 02:54 PM, Junio C Hamano wrote:
>>>>
>>>> I wonder if can we come up with a short and sweet notation to remind
>>>> futhre readers that this "initialization" is not initializing but
>>>> merely squelching warnings from stupid compilers, and agree to use
>>>> it consistently?
>>>
>>> Perhaps
>>>
>>>       #define COMPILER_UNINITIALIZED_WARNING_INITIALIZER 0
>>>
>>> or, for short-and-sweet
>>>
>
>           /* Here could go a longer explanation than the 4 character
> define :) */
>>>       #define CUWI 0
>>>
>>> ?
>>>
>>> :)
>>
>> I get that smiley.
>>
>> I was hinting to keep the /* compiler workaround */ comment, but
>> in a bit shorter form.
>> --

For some background, I found $gmane/169098/focus=169104 which covers some of 
the issues (the focused msg is one from Junio). Hannes then notes 
($gmane/169121) that the current xx = xx; could be seen as possible 
undefined behaviour - perhaps one of those 'no good solution' problems.

Perhaps a suitable name...

#define SUPPRESS_COMPILER_UNINITIALIZED_WARNING 0
/* Use when some in-use compiler is unable to determine if the variable is 
used uninitialized, and no good default value is available */

Though, where best to put it?

--
Philip 
