From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: [PATCH v2 1/6] completion: add comment for test_completion()
Date: Fri, 16 Nov 2012 22:09:05 +0100
Message-ID: <CAMP44s0m2iATv7Bt0Dy4hTcJvBNvzvN+Vcc+=NVLCMrVP_YJDw@mail.gmail.com>
References: <1352644558-9410-1-git-send-email-felipe.contreras@gmail.com>
	<1352644558-9410-2-git-send-email-felipe.contreras@gmail.com>
	<20121116205457.GY12052@goldbirke>
	<CAMP44s333124DkyG5VX+n=p_eHRmPYCu27rsLgLQG8mOVcRBPg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	Jeff King <peff@peff.net>, Jonathan Nieder <jrnieder@gmail.com>
To: =?UTF-8?Q?SZEDER_G=C3=A1bor?= <szeder@ira.uka.de>
X-From: git-owner@vger.kernel.org Fri Nov 16 22:09:23 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TZTA9-0004gM-QS
	for gcvg-git-2@plane.gmane.org; Fri, 16 Nov 2012 22:09:22 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753482Ab2KPVJH convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 16 Nov 2012 16:09:07 -0500
Received: from mail-ob0-f174.google.com ([209.85.214.174]:47618 "EHLO
	mail-ob0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753420Ab2KPVJG convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 16 Nov 2012 16:09:06 -0500
Received: by mail-ob0-f174.google.com with SMTP id wc20so3225173obb.19
        for <git@vger.kernel.org>; Fri, 16 Nov 2012 13:09:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        bh=H9+WlykaoevDnIRVlRvjAdDk9PlwQxdEzMf0iTGV+J8=;
        b=vcBG7eEsenmtS+dx0NWbdMlgicVMQYEXGNMltliPIrWjNarZx61EmuDZOBIVj2APD5
         +YG5HrlqqIKJ8Xuiyd03DkLBXF1LzzBYiSinQZEzaudqXYNizS+QZ/GjExssFtmiYO4x
         se2toR987qBB2mFg1SRzgt0NcHc78r3NCHSuExF4dP/nKUSvl7V8IAiOT0CpDXHZF/ND
         htrKBJEolvqhdvgshbincD9HM4A0fXMPu6KmsQPJooAjmgxyZ7H6spfvbrpBpSEKlKFW
         t2j8l+HvhIj2BqizGBMjw79b0aG3uKQ+YFmzJbZAPyA+2dnBxm6RILI3V+W5hhP208yL
         ljFA==
Received: by 10.60.20.1 with SMTP id j1mr4972013oee.46.1353100145269; Fri, 16
 Nov 2012 13:09:05 -0800 (PST)
Received: by 10.60.4.74 with HTTP; Fri, 16 Nov 2012 13:09:05 -0800 (PST)
In-Reply-To: <CAMP44s333124DkyG5VX+n=p_eHRmPYCu27rsLgLQG8mOVcRBPg@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/209912>

On Fri, Nov 16, 2012 at 10:06 PM, Felipe Contreras
<felipe.contreras@gmail.com> wrote:
> On Fri, Nov 16, 2012 at 9:54 PM, SZEDER G=C3=A1bor <szeder@ira.uka.de=
> wrote:
>> On Sun, Nov 11, 2012 at 03:35:53PM +0100, Felipe Contreras wrote:
>>> So that it's easier to understand what it does.
>>>
>>> Also, make sure we pass only the first argument for completion.
>>> Shouldn't cause any functional changes because run_completion only
>>> checks $1.
>>>
>>> Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
>>> ---
>>>  t/t9902-completion.sh | 6 +++++-
>>>  1 file changed, 5 insertions(+), 1 deletion(-)
>>>
>>> diff --git a/t/t9902-completion.sh b/t/t9902-completion.sh
>>> index cbd0fb6..5c06709 100755
>>> --- a/t/t9902-completion.sh
>>> +++ b/t/t9902-completion.sh
>>> @@ -54,10 +54,14 @@ run_completion ()
>>>       __git_wrap__git_main && print_comp
>>>  }
>>>
>>> +# Test high-level completion
>>> +# Arguments are:
>>> +# 1: typed text so far (cur)
>>
>> Bash manuals calls this the current command line or words in the
>> current command line.  I'm not sure what you mean with '(cur)' here.
>
> The current _word_ text typed so far.
>
>> The variable $cur in the completion script (or in bash-completion in
>> general) is something completely different.
>
> I believe bash's completion, this test, and the whole git completion
> stuff uses the same definition of 'cur'.

Oops, actually in this particular helper this is not actually 'cur'. I
think 'command line' might be more appropriate.

--=20
=46elipe Contreras
