From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: Re: [PATCH 4/5] ref_transaction_commit(): remove the local flags
 variables
Date: Sat, 25 Apr 2015 00:22:36 +0200
Message-ID: <553AC22C.2030700@alum.mit.edu>
References: <1429875349-29736-1-git-send-email-mhagger@alum.mit.edu>	<1429875349-29736-5-git-send-email-mhagger@alum.mit.edu> <CAPig+cS7+NW1L5D1gAwz3xp9jv13u4L9i-u1oFDLvRbr-u_X7w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Cc: Junio C Hamano <gitster@pobox.com>,
	Stefan Beller <sbeller@google.com>, Jeff King <peff@peff.net>,
	Git List <git@vger.kernel.org>
To: Eric Sunshine <sunshine@sunshineco.com>
X-From: git-owner@vger.kernel.org Sat Apr 25 00:22:56 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Yllzq-0007XZ-CX
	for gcvg-git-2@plane.gmane.org; Sat, 25 Apr 2015 00:22:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S967054AbbDXWWu (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 24 Apr 2015 18:22:50 -0400
Received: from alum-mailsec-scanner-6.mit.edu ([18.7.68.18]:59810 "EHLO
	alum-mailsec-scanner-6.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S967010AbbDXWWt (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 24 Apr 2015 18:22:49 -0400
X-AuditID: 12074412-f79e46d0000036b4-ba-553ac22f228d
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by alum-mailsec-scanner-6.mit.edu (Symantec Messaging Gateway) with SMTP id 8E.F6.14004.F22CA355; Fri, 24 Apr 2015 18:22:39 -0400 (EDT)
Received: from [192.168.69.130] (p4FC973EF.dip0.t-ipconnect.de [79.201.115.239])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id t3OMMa1j009669
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES128-SHA bits=128 verify=NOT);
	Fri, 24 Apr 2015 18:22:38 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:31.0) Gecko/20100101 Icedove/31.6.0
In-Reply-To: <CAPig+cS7+NW1L5D1gAwz3xp9jv13u4L9i-u1oFDLvRbr-u_X7w@mail.gmail.com>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrMKsWRmVeSWpSXmKPExsUixO6iqKt/yCrUYM8yEYuuK91MFg29V5gt
	frT0MFts3tzOYnHmTSOjA6vHgk2lHs969zB6XLyk7LH4gZfH501yAaxR3DZJiSVlwZnpefp2
	CdwZJz+/Yim4xFmxavtC9gbG1+xdjJwcEgImErufLGODsMUkLtxbD2RzcQgJXGaUeHd1P1hC
	SOACk8SUTgcQm1dAW6J3bz9TFyMHB4uAqsSvxgiQMJuArsSinmYmEFtUIEii9dpURohyQYmT
	M5+wgNgiQK0fNmxiBJnPLNDHKHG56S5Yg7BAqMStPxcYIRYfYpR41DSRFSTBKRAo8f/8ObBL
	mQXUJf7Mu8QMYctLNG+dzTyBUWAWkiWzkJTNQlK2gJF5FaNcYk5prm5uYmZOcWqybnFyYl5e
	apGumV5uZoleakrpJkZIgAvtYFx/Uu4QowAHoxIP74w5lqFCrIllxZW5hxglOZiURHm9+61C
	hfiS8lMqMxKLM+KLSnNSi4FO5mBWEuHl7wXK8aYkVlalFuXDpKQ5WJTEeX8uVvcTEkhPLEnN
	Tk0tSC2CycpwcChJ8GodBGoULEpNT61Iy8wpQUgzcXCCDOeSEilOzUtJLUosLcmIB8VqfDEw
	WkFSPEB7GUHaeYsLEnOBohCtpxgVpcR5nxwASgiAJDJK8+DGwtLWK0ZxoC+FeQNB2nmAKQ+u
	+xXQYCagwTOXWoAMLklESEk1MHY4lJ3LZG4XqNvm7Plz7aYzGcVFzZevqp4Lda6eNcNJ1t2h
	4f2/4LNnnA5xpi8I4Nao3CBpeGuvHUdu0f/sTiWH7VzT3r69/e36frMv016VRjD/ 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/267759>

On 04/24/2015 11:51 PM, Eric Sunshine wrote:
> On Fri, Apr 24, 2015 at 7:35 AM, Michael Haggerty <mhagger@alum.mit.edu> wrote:
>> Instead, work directly with update->flags. This has the advantage that
>> the REF_DELETING bit, set in the first loop, can be read in the third
>> loop instead of having to compute the same expression again. Plus, it
>> was kindof confusing having both update->flags and flags, which
> 
> s/kindof/kind of/
> 
>> sometimes had different values.
>>
>> Signed-off-by: Michael Haggerty <mhagger@alum.mit.edu>

Hehe thanks for looking over my scribblings. In this case, neither
"kindof" nor "kind of" is in fact correct English. I used the slang word
"kindof" (sometimes spelled "kinda") to mean "somewhat", I guess because
"somewhat" sounded too formal for my slapdash opinion.

But I suppose it's kindof thoughtless to use slang in commit messages
:-), especially given that they are also meant for people for whom
English is a second language (let alone sloppy American English).

I suggest s/kindof/potentially/, at least until I have time to submit a
patch to the English language to make "kindof" a reputable word :-)

Michael

-- 
Michael Haggerty
mhagger@alum.mit.edu
