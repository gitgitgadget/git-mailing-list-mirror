From: Gulshan Singh <gsingh2011@gmail.com>
Subject: Re: Why can't I push from a shallow clone?
Date: Fri, 26 Jul 2013 12:12:04 -0700
Message-ID: <CANEZYrdR3xLRSQAo6rroN3TLv48HEKp4_t95WEf6rm8-+r+2tw@mail.gmail.com>
References: <CANEZYrdsCgH+3NnZnnmsn_znt=+01aNn02u4mWyb3td9XypUog@mail.gmail.com>
	<20130726065528.GA4940@paksenarrion.iveqy.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Fredrik Gustafsson <iveqy@iveqy.com>
X-From: git-owner@vger.kernel.org Fri Jul 26 21:12:12 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1V2nQx-0008UD-Vb
	for gcvg-git-2@plane.gmane.org; Fri, 26 Jul 2013 21:12:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756008Ab3GZTMI convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 26 Jul 2013 15:12:08 -0400
Received: from mail-ve0-f181.google.com ([209.85.128.181]:61184 "EHLO
	mail-ve0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752649Ab3GZTMG convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 26 Jul 2013 15:12:06 -0400
Received: by mail-ve0-f181.google.com with SMTP id jz10so1519284veb.40
        for <git@vger.kernel.org>; Fri, 26 Jul 2013 12:12:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        bh=n6pC9AGfVv0YVOoAOavtMz3/EVipdrg2p5r1W8AllVA=;
        b=LUw6+W1IoXE2B//bfocUACNPrcJCABIx6y3nHshLudXdfIIkLrGzisLHFem2sgSMxr
         QHywDqFxddUMHySj9tYafxPIk+L9OTdEztbk3LOaXv1/OhoCrEsATR0rBAToTZGuHTR4
         BOiz6GQ4qITSTVqZ4wnEdV5ViAqVuG4ooti3TbWLEakzDgBovTcn4HwO2Rwq2ERNHHsv
         HJi3M+CO6jIuUp9dMUt/YzS3ayix3iIsV9oulj2GRW5qJdHyOQhwkME8uvfih+ilQRnj
         DQj0blABkFQ7neQiaf+rlHpu2DUxSBzdQQ+803ZjGsXY0MpBLrHv1p85q1mLtaSR09KS
         RbCQ==
X-Received: by 10.220.114.135 with SMTP id e7mr4126371vcq.17.1374865924415;
 Fri, 26 Jul 2013 12:12:04 -0700 (PDT)
Received: by 10.220.191.202 with HTTP; Fri, 26 Jul 2013 12:12:04 -0700 (PDT)
In-Reply-To: <20130726065528.GA4940@paksenarrion.iveqy.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/231197>

Hey Fredrick,

It's good to know that work is being done on this. I still want to
understand it though, so I guess I'll ask specific questions about
Junio's response. He states,

"If you cloned shallowly some time ago, worked without communicating
with the other side while the other side progressed, AND if the other
side's progress included a rewind & rebuild of the history, you would
see a similar topology.
The leftmost 'S' in the above picture might have been the tip of the
branch when you shallowly cloned with depth 1, and since then the
remote end may have discarded topmost three commits and have rebuilt
its history that leads to the rightmost 'R'. In such a case pushing to
the remote's HEAD will fail."

So as an example, if you shallow clone a branch, then someone squashes
the head commit and makes a new commit, you won't be able to push to
HEAD because the parent has changed. But if someone does that, I don't
think you would be able to push even if it was a full clone. That's
why it's usually not a good idea to rebase shared branches. So did I
misunderstand the scenario?


On Thu, Jul 25, 2013 at 11:55 PM, Fredrik Gustafsson <iveqy@iveqy.com> =
wrote:
> On Thu, Jul 25, 2013 at 07:33:16PM -0700, Gulshan Singh wrote:
>> I've been trying to figure out why I can't push from a shallow clone
>> (using --depth) to a repository. I've made simple examples where it
>> works, but I've read that in doesn't work in every case. However, I
>> can't come up with a case where it doesn't work. Googling gives this
>> answer: http://stackoverflow.com/questions/6900103/why-cant-i-push-f=
rom-a-shallow-clone,
>> but I don't completely understand the explanation, so I was hoping
>> someone could explain it.
>
> I can't explain it better than what Junio did in the link you just
> provide. However there's ongoing work to allow shallow clones to be a=
ble
> to push. You can read about it here:
> http://thread.gmane.org/gmane.comp.version-control.git/230612/focus=3D=
230878
>
> --
> Med v=E4nliga h=E4lsningar
> Fredrik Gustafsson
>
> tel: 0733-608274
> e-post: iveqy@iveqy.com



--=20
Gulshan Singh
University of Michigan, Class of 2015
College of Engineering, Computer Science Major
gulshan@umich.edu | 248.961.6317
Alternate E-mail: gsingh2011@gmail.com
