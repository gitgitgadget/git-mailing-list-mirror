From: Marc Khouzam <marc.khouzam@gmail.com>
Subject: Re: [PATCH] tcsh-completion re-using git-completion.bash
Date: Fri, 16 Nov 2012 13:20:31 -0500
Message-ID: <CAFj1UpHMc-bHJgSZKY13YH_69TXkz-50g5xpLA6C+Eh0aqcN9A@mail.gmail.com>
References: <CAFj1UpHgPvdDeKZ-Ap7-aVx6p_pxT4a2F01ajmNa00txPyS=Qw@mail.gmail.com>
	<1352980269-15569-1-git-send-email-marc.khouzam@gmail.com>
	<CAMP44s0Guq0nYJEfbvNDyt8Oqaux-cXbTsyro6pxUnEpA4+XOw@mail.gmail.com>
	<CAFj1UpEdft+L5KW+tMy6Lqm1eUkHQgwWuXaC0UTUdqwW=ohk-Q@mail.gmail.com>
	<CAMP44s1RtOj6LKCNJ8SX8KSA8eNCMZ+4D-VfQ+WtXju-KhG8ng@mail.gmail.com>
	<CAFj1UpHLf2je_+b1e5B_5thZ03UYVmW=CWhAh63kNRCbke0kQw@mail.gmail.com>
	<CAMP44s1RvMSBu2RJqKw9ne4cJyMO4dbFc-gW2HgsN2-uviv=fA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: szeder@ira.uka.de, git@vger.kernel.org
To: Felipe Contreras <felipe.contreras@gmail.com>
X-From: git-owner@vger.kernel.org Fri Nov 16 19:20:52 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TZQX4-0006BB-Sp
	for gcvg-git-2@plane.gmane.org; Fri, 16 Nov 2012 19:20:51 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753149Ab2KPSUd (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 16 Nov 2012 13:20:33 -0500
Received: from mail-ia0-f174.google.com ([209.85.210.174]:48655 "EHLO
	mail-ia0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753130Ab2KPSUc (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 16 Nov 2012 13:20:32 -0500
Received: by mail-ia0-f174.google.com with SMTP id y25so1867515iay.19
        for <git@vger.kernel.org>; Fri, 16 Nov 2012 10:20:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=2OyBsHSjilHXArnCDKTtUQAh68STi8RKcatOfvScnT0=;
        b=tfFSBccIieQddVPczW7128n81HJhPHPF70h74hlkXK9WTT3KEPdEGoLTbxySKglTFJ
         xE6UbrwPlCVpyrQdD5f2uGP3wQnQKWVsUuFo6yaWSMe6G9FCPkRVxYxuYTythyzznBk+
         JeyJbtq+XPF4a8wd4PmqIbC+MqOuuXK08IUFdMPh87zMgue6iKoUHfarmYDy5m8KFnSi
         HDkuXYSrRnMsL0D6UYLbc4++CXr//ylZ7UWEqYnGjutZwPw4gAqCPh81eYzQ0BqOnCRI
         e0Qwsn4kyrmiLm+bmq9880Ys86eN2C0fYx1k3sa2Ot43oxCN5hdDbjfPEXsaJccLlyaa
         5iPA==
Received: by 10.50.16.144 with SMTP id g16mr4328595igd.23.1353090031913; Fri,
 16 Nov 2012 10:20:31 -0800 (PST)
Received: by 10.64.132.39 with HTTP; Fri, 16 Nov 2012 10:20:31 -0800 (PST)
In-Reply-To: <CAMP44s1RvMSBu2RJqKw9ne4cJyMO4dbFc-gW2HgsN2-uviv=fA@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/209891>

On Fri, Nov 16, 2012 at 12:18 PM, Felipe Contreras
<felipe.contreras@gmail.com> wrote:
> On Fri, Nov 16, 2012 at 4:48 PM, Marc Khouzam <marc.khouzam@gmail.com> wrote:
>> On Fri, Nov 16, 2012 at 10:33 AM, Felipe Contreras
>> <felipe.contreras@gmail.com> wrote:
>
>>> Is it possible to just check if this is a login shell?
>>
>> I think it would be nice to allow the user to manually
>> source git-completion.tcsh, in case they want to make
>> manual modifications to it.
>
> Yeah, they could still do that... because they would be running in a
> login shell.
>
> What I meant is that if the user does: tcsh
> my_script_that_has_nothing_to_do_with_completion.sh, they would not be
> executing this whole script.

Oh, I see now.

I can put a check in the script for the existence of the $prompt variable.
This will indicate if it is a login shell or not.
However, a good .cshrc file should already have such a check to avoid
sourcing a bunch of useless things.  So, I personally think that we
should not add it to the git-completion.tcsh script but let the tcsh
user decide to do it herself.  But I don't mind being overruled :)

>> I think the most user-friendly option is to actually re-generate the
>> script each time.  It feels wrong, but it works well :)
>
> I'm not too strongly opposed to add that function to the bash
> completion, but to do it only for tcsh doesn't sound right, specially
> when there are other alternatives.

I agree, and this is why I made the proposed
__git_complete_with_output () generic.  That way it could be
used by other shells or programs.  But at this time, only tcsh
would make use of it.

If you think having __git_complete_with_output () could
be useful for others, I think we should go with solution (A).
If you don't think so, or if it is better to wait until a need
arises first, then solution (C) will work fine.

> Correct me if I'm wrong, but very few people use tcsh.

Less than I originally thought, when I started working
on this patch :-\  But I'm still hoping that the those people
will be a little happier with their git completion.

Marc

>
> --
> Felipe Contreras
