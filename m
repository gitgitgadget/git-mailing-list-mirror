From: Pranit Bauva <pranit.bauva@gmail.com>
Subject: Re: [RFC] Code reorgnization
Date: Fri, 18 Mar 2016 02:33:27 +0530
Message-ID: <CAFZEwPMBr4oK9tM7rMsBUDhON-0+jymGT=t1sdkztbh3eNyt5g@mail.gmail.com>
References: <20160317111136.GA21745@lanh>
	<CAGZ79kbcwFcPSJ9xwE6xi4gQ871m3brtfAut2TChGNzL-foxdQ@mail.gmail.com>
	<xmqqy49gzzrf.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Stefan Beller <sbeller@google.com>, Duy Nguyen <pclouds@gmail.com>,
	"git@vger.kernel.org" <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Mar 17 22:03:34 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1agf4w-0004u3-92
	for gcvg-git-2@plane.gmane.org; Thu, 17 Mar 2016 22:03:34 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030873AbcCQVD3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 17 Mar 2016 17:03:29 -0400
Received: from mail-yw0-f178.google.com ([209.85.161.178]:33023 "EHLO
	mail-yw0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1030620AbcCQVD2 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 17 Mar 2016 17:03:28 -0400
Received: by mail-yw0-f178.google.com with SMTP id m126so91991690ywd.0
        for <git@vger.kernel.org>; Thu, 17 Mar 2016 14:03:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc;
        bh=inrNo3J3PC5zLO1wEcBrYgh7Ok+K2vPEyC5G1pUKwj0=;
        b=lqShSGcvKNgVE/XY1cejNtnApFUonsTI+pFBldopH7wNmuohgXdoyr0JOAFuLRMl6t
         vWpkS7lKCOR1A9yf0CC7h3dXo7zuH0sJX8dHN16fvVdtXAs+8U3Wq/l/unmm0xMHX2UH
         sCHpTxIcG8UDw54UzHmDkTkkcEYz+dF97jCBPfpJP7iOzkQhH540IJ2Lyi0oCXiaEq10
         Zijz4IYXeKVuSj+GNx/1K7G151buB5jcp/DXPIQzAKbF0mAbK6vmABAf4kI19qK7Ls6P
         aJzTTbBPk3hbAQjBRAVXpQouUvhKHLGVlwpXZUikTwicMj1jm4YcLcSXOQ6L5ZZHcBJD
         7jdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc;
        bh=inrNo3J3PC5zLO1wEcBrYgh7Ok+K2vPEyC5G1pUKwj0=;
        b=WV38+e+apzxAm1cV/FtHJvnZ/o7/E5Lc2o/QJtfVaE88AvEClvAoqPGblhMQxOiHpl
         7cA9/9RrZ1rIYTcxufOTJiqJx7MAYTEeA50pK+9s8shAY4p9dC2GQem/QfDhDCbzGZWq
         K+SOt+oYokrIhvxsy30wz9ua63IN/OhBoylcKpms3bPyju35Qfq+btHNyAGK+rzb0Nw0
         i+CgiIV77DA8Ly1cdpRlIQeKMcYcLUznsPVeEFP35EjrW0FBZe8otVNDYLPeo8Cgi526
         peBMC4PTffT5sea0e3yR0u2LW8GU0U9/Q9CFf5wqYCE/gBSZMqwUjGWKWfv24SDpJMw2
         3duw==
X-Gm-Message-State: AD7BkJJPG03J1KU+3dLzwL3CvGRFdzx5EtDkASGn36AqUWlo4uKIr0Oop81PKN4zEDh1NYsmpGGy2HAtlaLJiA==
X-Received: by 10.129.37.3 with SMTP id l3mr5042451ywl.128.1458248607242; Thu,
 17 Mar 2016 14:03:27 -0700 (PDT)
Received: by 10.13.203.137 with HTTP; Thu, 17 Mar 2016 14:03:27 -0700 (PDT)
In-Reply-To: <xmqqy49gzzrf.fsf@gitster.mtv.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/289155>

On Fri, Mar 18, 2016 at 12:40 AM, Junio C Hamano <gitster@pobox.com> wrote:
> Stefan Beller <sbeller@google.com> writes:
>
>> For now I would just go with 3 directories:
>>
>> non-git/ (or util, helpers, or anything that could be ripped out and be useful
>>     e.g. strbufs, argv-array run-command, lockfile
>> git/ (maybe called lib? All stuff that is pure Git and is used for libgit
>>
>> builtin/ (as we have it today + all that stuff that doesn't go into
>> git/ very well?)
>
> It is unclear where you want to have standalone programs in the
> above.  I'd say lib/ and src/ for the first two, where lib/ is for
> things that could be lifted without any Git dependencies and src/
> for everything else.
>
> Aren't there some folks who link directly with our codebase (I am
> thinking about cgit, but hjemli.net/git/cgit does not seem to be
> responding anymore)?

They now have a new mailing list.[1] I guess they forward all the
mails to the new one[2]. The new one seems active. [3]

[1] : cgit@lists.zx2c4.com
[2] : https://lists.zx2c4.com/pipermail/cgit/2013-May/001380.html
[3] : http://news.gmane.org/gmane.comp.version-control.cgit
