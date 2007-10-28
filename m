From: Steffen Prohaska <prohaska@zib.de>
Subject: Re: [PATCH 4/8] rev-parse: teach "git rev-parse --symbolic" to print the full ref name
Date: Sun, 28 Oct 2007 09:56:20 +0100
Message-ID: <30641295-495B-4E5E-9D44-5CAF7C480DF2@zib.de>
References: <119350380778-git-send-email-prohaska@zib.de> <11935038081211-git-send-email-prohaska@zib.de> <11935038081650-git-send-email-prohaska@zib.de> <1193503808519-git-send-email-prohaska@zib.de> <11935038083369-git-send-email-prohaska@zib.de> <7v3avvy9yc.fsf@gitster.siamese.dyndns.org> <79CE31EE-0975-48EB-8B3E-FC9D6A8EB3E4@zib.de> <20071028080654.GS14735@spearce.org>
Mime-Version: 1.0 (Apple Message framework v752.3)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Sun Oct 28 09:55:17 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Im3vQ-0006T4-0N
	for gcvg-git-2@gmane.org; Sun, 28 Oct 2007 09:55:16 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750950AbXJ1Iy7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 28 Oct 2007 04:54:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751127AbXJ1Iy7
	(ORCPT <rfc822;git-outgoing>); Sun, 28 Oct 2007 04:54:59 -0400
Received: from mailer.zib.de ([130.73.108.11]:33437 "EHLO mailer.zib.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750860AbXJ1Iy6 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 28 Oct 2007 04:54:58 -0400
Received: from mailsrv2.zib.de (sc2.zib.de [130.73.108.31])
	by mailer.zib.de (8.13.7+Sun/8.13.7) with ESMTP id l9S8ssd1015669;
	Sun, 28 Oct 2007 09:54:54 +0100 (CET)
Received: from [192.168.178.21] (brln-4db1072b.pool.einsundeins.de [77.177.7.43])
	(authenticated bits=0)
	by mailsrv2.zib.de (8.13.4/8.13.4) with ESMTP id l9S8srSu002644
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=NO);
	Sun, 28 Oct 2007 09:54:53 +0100 (MET)
In-Reply-To: <20071028080654.GS14735@spearce.org>
X-Mailer: Apple Mail (2.752.3)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/62542>


On Oct 28, 2007, at 9:06 AM, Shawn O. Pearce wrote:

> Steffen Prohaska <prohaska@zib.de> wrote:
>> On Oct 28, 2007, at 8:28 AM, Junio C Hamano wrote:
>>> Steffen Prohaska <prohaska@zib.de> writes:
>>>> @@ -213,6 +215,7 @@ int cmd_rev_parse(int argc, const char **argv,
>>>> const char *prefix)
>>>> {
>>>> 	int i, as_is = 0, verify = 0;
>>>> 	unsigned char sha1[20];
>>>> +	char* real_name = 0;
>>>
>>> Pointer sign '*' in git sources go next to the name not the
>>> type, as:
>>>
>>> 	char *real_name = NULL;
>>
>> I know and I tried hard to follow this convention, although
>> I think its the wrong choice ;)
>
> Oh, hmm...
>
>   char* a, b;
>
> What's the type of b?  If you said "char*" you're wrong.

I know. Obviously, you need a combination of conventions.

- '*' is part of the type; put it there.
- Only define a single variable per statement.

My combined rule avoids your question. I typically use C++,
which make the second rule easier to follow, because you
defer defining variables until you really need them. There's
no need to save space at the start of the function block by
defining several variables in a single line.


> Git's style of putting the * next to the name makes it far easier to
> spot these sort of typing problems.  At least that's my take on it.

Let's stop this discussion here. I'm not proposing to change the
rules. I'll follow the git coding conventions when submitting
patches to git, even if it's sometimes hard for me. I already packed
as much as possible in my editor configuration. Unfortunately,
I can't teach vim to always place the '*' correctly. At least I
don't know how to do this.

	Steffen
