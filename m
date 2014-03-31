From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: Re: [PATCH v2 18/27] update-ref --stdin: Harmonize error messages
Date: Tue, 01 Apr 2014 00:37:39 +0200
Message-ID: <5339EE33.7050708@alum.mit.edu>
References: <1395683820-17304-1-git-send-email-mhagger@alum.mit.edu>	<1395683820-17304-19-git-send-email-mhagger@alum.mit.edu> <xmqqy4zq2g0b.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Brad King <brad.king@kitware.com>,
	Johan Herland <johan@herland.net>, Jeff King <peff@peff.net>,
	Vicent Marti <tanoku@gmail.com>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Apr 01 00:37:58 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WUkq3-0005kj-AH
	for gcvg-git-2@plane.gmane.org; Tue, 01 Apr 2014 00:37:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751724AbaCaWhp (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 31 Mar 2014 18:37:45 -0400
Received: from alum-mailsec-scanner-5.mit.edu ([18.7.68.17]:65533 "EHLO
	alum-mailsec-scanner-5.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751380AbaCaWhn (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 31 Mar 2014 18:37:43 -0400
X-AuditID: 12074411-f79ab6d000002f0e-5b-5339ee36d562
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by alum-mailsec-scanner-5.mit.edu (Symantec Messaging Gateway) with SMTP id 6F.A3.12046.63EE9335; Mon, 31 Mar 2014 18:37:42 -0400 (EDT)
Received: from [192.168.69.148] (p5B156503.dip0.t-ipconnect.de [91.21.101.3])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id s2VMbecp017262
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES128-SHA bits=128 verify=NOT);
	Mon, 31 Mar 2014 18:37:41 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:24.0) Gecko/20100101 Icedove/24.3.0
In-Reply-To: <xmqqy4zq2g0b.fsf@gitster.dls.corp.google.com>
X-Enigmail-Version: 1.6
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrLKsWRmVeSWpSXmKPExsUixO6iqGv2zjLY4GGTusXOdRIWXVe6mSwa
	eq8wW8y7u4vJ4kdLD7PFx84FzA5sHjtn3WX3uPTyO5vHx2fL2T2e9e5h9Lh4Sdnj8ya5ALYo
	bpukxJKy4Mz0PH27BO6MFTcWMxa0clScO3iUuYFxLVsXIyeHhICJxMqDC1ghbDGJC/fWA8W5
	OIQELjNKfDkxnRHCOcsk0XyjG6yKV0BbYu/qrywgNouAqsTbG9PZQWw2AV2JRT3NTCC2qECQ
	xOENp6DqBSVOznwCVi8ioCYxse0QC8hQZoHVjBJLp8wAO0NYwEvi2/8ZrBDb1jJKrD40mREk
	wSlgLbGs9QOQzQF0n7hET2MQSJhZQEfiXd8DZghbXmL72znMExgFZyHZNwtJ2SwkZQsYmVcx
	yiXmlObq5iZm5hSnJusWJyfm5aUW6Zrq5WaW6KWmlG5ihESE4A7GGSflDjEKcDAq8fBallsG
	C7EmlhVX5h5ilORgUhLlffgYKMSXlJ9SmZFYnBFfVJqTWnyIUYKDWUmEN/YlUI43JbGyKrUo
	HyYlzcGiJM7Lt0TdT0ggPbEkNTs1tSC1CCYrw8GhJMGr8RaoUbAoNT21Ii0zpwQhzcTBCTKc
	S0qkODUvJbUosbQkIx4UxfHFwDgGSfEA7Y14A7K3uCAxFygK0XqK0Zhjw7Y1jUwct5ZvbGQS
	YsnLz0uVEuc99RqoVACkNKM0D24RLBW+YhQH+luYVxfkHh5gGoWb9wpoFRPQKrciM5BVJYkI
	KakGxil3fTgXTQs4Zbz0Se7jzyVTfjJs+t8d/Dh1YcSJE7qrNGYv6xeWvmBps3yW 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/245562>

On 03/31/2014 11:51 PM, Junio C Hamano wrote:
> Michael Haggerty <mhagger@alum.mit.edu> writes:
> 
>> Make (most of) the error messages for invalid input have the same
>> format [1]:
>>
>>     $COMMAND [SP $REFNAME]: $MESSAGE
>>
>> Update the tests accordingly.
>>
>> [1] A few error messages are left with their old form, because
>>     $COMMAND and $REFNAME aren't passed all the way down the call
>>     stack.  Maybe those sites should be changed some day, too.
>>
>> Signed-off-by: Michael Haggerty <mhagger@alum.mit.edu>
>> ---
> 
> Up to this point, modulo nits that have been pointed out separately,
> the series looked reasonably well done.

Thanks for the feedback!  Would you like me to expand the commit
messages to answer the questions that you asked about the previous
patches?  And if so, do you want a v3 sent to the list already or should
I wait for you to review patches 19-27 first?

Cheers,
Michael

-- 
Michael Haggerty
mhagger@alum.mit.edu
http://softwareswirl.blogspot.com/
