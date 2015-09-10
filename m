From: "Philip Oakley" <philipoakley@iee.org>
Subject: Re: storing cover letter of a patch series?
Date: Thu, 10 Sep 2015 21:09:25 +0100
Organization: OPDS
Message-ID: <A20C476954134C53B0D256D644B1CCC2@PhilipOakley>
References: <CA+P7+xpHDGY5RTR8ntrABdxqM6b4V9dndS68=kV1+1Ym1N6YKw@mail.gmail.com> <xmqqh9n241el.fsf@gitster.mtv.corp.google.com> <CA+P7+xq9P2NHqQe-y+2n38ZvbR74UxR0Rik=btgy=JtEoZbX2A@mail.gmail.com> <xmqqvbbi2jy5.fsf@gitster.mtv.corp.google.com> <CA+P7+xodgeu6Vo+Rt57_iFycxkEnNjxP-TTOfY8DdXwzeVKbZg@mail.gmail.com>
Reply-To: "Philip Oakley" <philipoakley@iee.org>
Mime-Version: 1.0
Content-Type: text/plain;
	format=flowed;
	charset="UTF-8";
	reply-type=original
Content-Transfer-Encoding: 7bit
Cc: "Git List" <git@vger.kernel.org>
To: "Jacob Keller" <jacob.keller@gmail.com>,
	"Junio C Hamano" <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Sep 10 22:09:25 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Za89m-0000EG-N3
	for gcvg-git-2@plane.gmane.org; Thu, 10 Sep 2015 22:09:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752439AbbIJUJP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 10 Sep 2015 16:09:15 -0400
Received: from out1.ip04ir2.opaltelecom.net ([62.24.128.240]:60535 "EHLO
	out1.ip04ir2.opaltelecom.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752083AbbIJUJO (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 10 Sep 2015 16:09:14 -0400
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-Anti-Spam-Result: A2CDMgBD4vFVPDkqFlxdGQEBgwiBPYMmgy9tvV0EBAKBU00BAQEBAQEHAQEBAUE/QQECAoNYBQEBAQEDCAEBGRUeAQEhCwIDBQIBAxUDAgIFIQICFAEECBIGBwMUBgESCAIBAgMBCIgAAxa4FoZYiD8NhQ+BIoVRhHuCT4FaEQFRgnAvgRQFlVYBgRWJd5UphzyCcxyBVT0zgnSDCoEMgT8BAQE
X-IPAS-Result: A2CDMgBD4vFVPDkqFlxdGQEBgwiBPYMmgy9tvV0EBAKBU00BAQEBAQEHAQEBAUE/QQECAoNYBQEBAQEDCAEBGRUeAQEhCwIDBQIBAxUDAgIFIQICFAEECBIGBwMUBgESCAIBAgMBCIgAAxa4FoZYiD8NhQ+BIoVRhHuCT4FaEQFRgnAvgRQFlVYBgRWJd5UphzyCcxyBVT0zgnSDCoEMgT8BAQE
X-IronPort-AV: E=Sophos;i="5.17,506,1437433200"; 
   d="scan'208";a="609490107"
Received: from host-92-22-42-57.as13285.net (HELO PhilipOakley) ([92.22.42.57])
  by out1.ip04ir2.opaltelecom.net with SMTP; 10 Sep 2015 21:09:11 +0100
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2900.5931
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2900.6157
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/277632>

From: "Jacob Keller" <jacob.keller@gmail.com>
> On Thu, Sep 10, 2015 at 11:44 AM, Junio C Hamano <gitster@pobox.com> 
> wrote:
>> Jacob Keller <jacob.keller@gmail.com> writes:
>>
>>> I hadn't thought of separating the cover letter from git-send-email.
>>> That would be suitable for me.
>>
>> Yeah, I said this number of times over time, and I said it once
>> recently in another thread, but I think it was a mistake to allow
>> git-send-email to drive format-patch.  It may appear that it will
>> make things convenient in the perfect world where no user makes
>> mistakes, but people are not perfect in real life.  Expecting them
>> to be is being naive.
>>
>
> Yep. I didn't even know cover-letter was an option of format-patch
> only thought it was in send-email.
>
Actually, the one feature I'd like (I think) is to be able to join 
together the empty commit mechanism and the cover letter mechanism 
within format patch so that:

* the empty commit message would detected and automatically become the 
[0/N] in the patch series (without need to say --cover-letter)

* the cover letter would still have some 'template' markings to say "*** 
insert what's changed here***" or smilar (with option to exclude them).

That way, when starting a series / branch, the first item would be to 
add the explanatory 'empty commit' that states the requirements of what 
one hopes to achieve (a key cover letter content), which is then 
followed by commits that move toward that goal.

The series can then be rebased as the user develops the code, and that 
cover note can be edited as required during the rebase.

When it comes time to show it to the list, the format patch will *know* 
from the empty commit that it is the [0/N] cover letter and 
(perhaps -option) add the appropriate markers ready for editing.

The user edits the cover letter with the extra 'what's changed' / 
interdiff / whatever, and sends. sendmail barfs if the user hasn't 
edited the markers.

This could also work with the sendmail patch formating (though I've 
never used that workflow) as now the cover letter becomes automatic for 
the upstream.

Philip 
