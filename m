From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [git-users] Highlevel (but simple to implement) commands
 provided by default for git
Date: Wed, 29 May 2013 22:23:18 -0700
Message-ID: <20130530052318.GA2923@elie.Belkin>
References: <f611150e-a12a-47f6-97f0-8aaff3045338@googlegroups.com>
 <CAJri6_tm=tk6L1DT=A_BB25jm7b+2Uniw1uSCGtrY5_8X=t_hw@mail.gmail.com>
 <CAMP44s0Cx-FCZLOFZxcpC86sY+H03HKBi0nKFMgit=B5XCy71g@mail.gmail.com>
 <CALkWK0mBOB1RM+MXH+Nvos29M5vqc2yAtC__zPyowf7imfnz9Q@mail.gmail.com>
 <CAJri6_uScqjovt5eK9f9+Z4ehtsdYQNuiEX1MERiDBEJWueAXg@mail.gmail.com>
 <CALkWK0=5BwterP7ATM1GgFvLUs391w_MW4YrwbnvsbM6Q4_Opg@mail.gmail.com>
 <20130529234335.GE28153@google.com>
 <CAMP44s3807Dk0SOZcBbaOKTLj5k36bW0SA9F5ZBY2MwS1Nnxiw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Ramkumar Ramachandra <artagnon@gmail.com>,
	=?utf-8?Q?Br=C3=A1ulio?= Bhavamitra <brauliobo@gmail.com>,
	git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
To: Felipe Contreras <felipe.contreras@gmail.com>
X-From: git-owner@vger.kernel.org Thu May 30 07:23:32 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UhvKl-0004Fz-D4
	for gcvg-git-2@plane.gmane.org; Thu, 30 May 2013 07:23:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S967382Ab3E3FX2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 30 May 2013 01:23:28 -0400
Received: from mail-pb0-f42.google.com ([209.85.160.42]:39184 "EHLO
	mail-pb0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S966838Ab3E3FX0 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 30 May 2013 01:23:26 -0400
Received: by mail-pb0-f42.google.com with SMTP id uo1so10415020pbc.15
        for <git@vger.kernel.org>; Wed, 29 May 2013 22:23:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=YRbslb0DYA9QT87Shh/GmpVRDQcKDfYcBeFQGLZ+1j8=;
        b=Ws2MrdXZNnyYMq1t8CxVyBBFXPALZCuvOe2LUr3HRSw8RXtXvdaJy+h/Z+Bi4ffxXW
         /k3YLf9HXZ4xd0Mmfr3MehbgDbfMbSR3KWQ3GCsCKqnhYUXxyEW5cO6YaB2VVSW6bnH4
         IfJeAdW450ZNhGSMjJWW/asIksxwejyyT3+yTBJjm7ApbLItCIZPGmQynRUWLfsIx8k2
         +ZbweV3LC4qJ/jt9Sr7KN97KLxPfEvB4OKTxqxvgQX93qGRl5SFFMLXCzdGOJ2Q860rQ
         JHXLLRXoTZSXq7pdJJhI9l5nrUexYIYwZY6L2834YPENIhwGJ14oWbdscHcfX+y9xC8q
         RsVg==
X-Received: by 10.68.232.194 with SMTP id tq2mr6224902pbc.133.1369891406109;
        Wed, 29 May 2013 22:23:26 -0700 (PDT)
Received: from elie.Belkin (c-107-3-135-164.hsd1.ca.comcast.net. [107.3.135.164])
        by mx.google.com with ESMTPSA id rn7sm40289136pbc.12.2013.05.29.22.23.23
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Wed, 29 May 2013 22:23:25 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <CAMP44s3807Dk0SOZcBbaOKTLj5k36bW0SA9F5ZBY2MwS1Nnxiw@mail.gmail.com>
User-Agent: Mutt/1.5.21+51 (9e756d1adb76) (2011-07-01)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/225923>

Felipe Contreras wrote:
> On Wed, May 29, 2013 at 6:43 PM, Jonathan Nieder <jrnieder@gmail.com> wrote:
>> Ramkumar Ramachandra wrote:

>>> Making builtins override'able is also a terrible idea.  It opens doors
>>> to potential bugs we don't want to deal with.  Simple example:
>>>
>>>    am = log -1
>>>    log = am -3
>>
>> That's detectable and could be made to error out, so it's not too bad.
>>
>> A bigger problem (in my opinion) with allowing arbitrary changes to
>> the meaning of existing commands is that scripts, whether placed in
>> .sh files or given as commands to run over IRC, stop working
>> altogether.  It's nice to have commands like "git log" and "git am"
>> mean the same thing no matter what machine I am on.
>
> Except that's not true:

It's not true that my opinion is that a bigger problem than the
non-problem Ram mentioned with allowing arbitrary changes to the
meaning of existing commands is that scripts stop working reliably?

This combative style of communication is toxic.  It kills the chance
of a calm, pleasant discussion, even with patient people who don't
even fundamentally disagree.  Please stop it.

Perhaps you meant "Commands like 'git log' and 'git am' actually don't
mean the same thing on all machines.  The default format of 'git log'
is configurable.  But that is neither here nor there", which would
have been a pleasant (if irrelevant) response instead of an obnoxious
one.

Regards,
Jonathan
