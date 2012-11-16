From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: [PATCH v4] tcsh-completion re-using git-completion.bash
Date: Fri, 16 Nov 2012 21:01:40 +0100
Message-ID: <CAMP44s0-OezE9W5-fCM-LS7vPs0S9q0MwsUyFgu7HBdDq3Xzsg@mail.gmail.com>
References: <CAFj1UpHgPvdDeKZ-Ap7-aVx6p_pxT4a2F01ajmNa00txPyS=Qw@mail.gmail.com>
	<1352980269-15569-1-git-send-email-marc.khouzam@gmail.com>
	<CAMP44s0Guq0nYJEfbvNDyt8Oqaux-cXbTsyro6pxUnEpA4+XOw@mail.gmail.com>
	<CAFj1UpEdft+L5KW+tMy6Lqm1eUkHQgwWuXaC0UTUdqwW=ohk-Q@mail.gmail.com>
	<CAMP44s1RtOj6LKCNJ8SX8KSA8eNCMZ+4D-VfQ+WtXju-KhG8ng@mail.gmail.com>
	<CAFj1UpHLf2je_+b1e5B_5thZ03UYVmW=CWhAh63kNRCbke0kQw@mail.gmail.com>
	<CAFj1UpGmoEiLeHPh8LaUGLktV55YbTthi1wMNjLDn6vFMSdMwQ@mail.gmail.com>
	<CAMP44s3rwUw1QaADgm0xVOK3ebPNVSa06QdN5voNniD2acsz0g@mail.gmail.com>
	<CAFj1UpEMugSrGv53ajvCm=F_wOFm4qr1bnsR5NRPsvgC_fRs5Q@mail.gmail.com>
	<7v4nkpmi96.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Marc Khouzam <marc.khouzam@gmail.com>,
	=?UTF-8?Q?SZEDER_G=C3=A1bor?= <szeder@ira.uka.de>,
	git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Nov 16 21:01:57 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TZS6t-0003zc-Tq
	for gcvg-git-2@plane.gmane.org; Fri, 16 Nov 2012 21:01:56 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753329Ab2KPUBl (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 16 Nov 2012 15:01:41 -0500
Received: from mail-ob0-f174.google.com ([209.85.214.174]:58087 "EHLO
	mail-ob0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751749Ab2KPUBl (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 16 Nov 2012 15:01:41 -0500
Received: by mail-ob0-f174.google.com with SMTP id wc20so3160658obb.19
        for <git@vger.kernel.org>; Fri, 16 Nov 2012 12:01:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=jRAqYtUm+wDPBDG+azth8aMOrIFNk3GMALWmbKCliSU=;
        b=0eAViYYnAKaw7gTwt6XKn7Vp0xomEdTDJY0XSElMDMCC2bQP4+Ad1IAtprFVY8ekHU
         dK5BFrQQOYmMkEc6XcoisixtmvZaOYHU9hyPF3t+nfOChG41Vuu4bbkhFnN3xMnKKqMB
         nycCi8ga0qeTFyPJMTo/Nz9FbsWWAfsIEXP2y5ZAPc2mksZgfCt+1GdV7W7AcsLsAVAF
         5o6RIhUegj04anGg2VxUciZPMn3Wwj4W1A/8tqd8baKo/SPVoPOk54f9ZS1Bs8nzlTsg
         KXOFPKP45RmbKU5FP4bzppOvCUX5tcUGFpJvzxgu57V7kwGF5if/dkFxvzSreT/07B7w
         eaRw==
Received: by 10.182.10.6 with SMTP id e6mr4820518obb.16.1353096100480; Fri, 16
 Nov 2012 12:01:40 -0800 (PST)
Received: by 10.60.4.74 with HTTP; Fri, 16 Nov 2012 12:01:40 -0800 (PST)
In-Reply-To: <7v4nkpmi96.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/209901>

On Fri, Nov 16, 2012 at 8:59 PM, Junio C Hamano <gitster@pobox.com> wrote:
> Marc Khouzam <marc.khouzam@gmail.com> writes:
>
>> The current tcsh-completion support for Git, as can be found on the
>> Internet, takes the approach of defining the possible completions
>> explicitly.  This has the obvious draw-back to require constant
>> updating as the Git code base evolves.
>> ...
>>   C) Modifications:
>>           New git-completion.tcsh
>>
>>      Provide a short tcsh script that generates another script
>>      which extends git-completion.bash.  This new script can be
>>      used by tcsh to perform completion.
>>
>>      Pros:
>>        1- tcsh support is entirely isolated in git-completion.tcsh
>>        2- new tcsh script can be as complex as needed
>>      Cons (for tcsh users only):
>>        1- requires the user to copy both git-completion.tcsh and
>>           git-completion.bash to ${HOME}
>>        2- requires bash script to have a fixed name and location:
>>           ${HOME}/.git-completion.bash
>>        3- sourcing the new script will generate a third script
>>
>> Approach (C) was selected avoid any modification to git-completion.bash.
>>
>> Signed-off-by: Marc Khouzam <marc.khouzam@gmail.com>
>> ---
>>
>> As suggested, I put the 'sort | uniq' inside the script.
>> In that case, I don't need to worry about aliases since 'sort |uniq' will
>> be executed in bash, for which the tcsh user surely doesn't have aliases setup.
>
> OK, so does this look OK to everybody (it does, looking at the
> difference between v3 and this one, to me)?
>
> The patch may deserve a Reviewed-by: by Felipe, by the way.  I can
> add one while applying.

That's fine by me.

Cheers.

-- 
Felipe Contreras
