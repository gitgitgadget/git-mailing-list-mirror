From: Phil Hord <phil.hord@gmail.com>
Subject: Re: [PATCHv5 1/3] wt-status.*: better advices for git status added
Date: Fri, 1 Jun 2012 08:40:39 -0400
Message-ID: <CABURp0rm2JKBmrm62uAVj1WSc3BE_LoKoHbjmxvkQhPNgnozpA@mail.gmail.com>
References: <1338384216-18782-1-git-send-email-Lucien.Kong@ensimag.imag.fr>
 <1338477344-15940-1-git-send-email-Lucien.Kong@ensimag.imag.fr>
 <vpq8vg7jue4.fsf@bauges.imag.fr> <20120601132710.Horde.j1U5UHwdC4BPyKcOgc8zbbA@webmail.minatec.grenoble-inp.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
	Kong Lucien <Lucien.Kong@ensimag.imag.fr>, git@vger.kernel.org,
	Duperray Valentin <Valentin.Duperray@ensimag.imag.fr>,
	Jonas Franck <Franck.Jonas@ensimag.imag.fr>,
	Nguy Thomas <Thomas.Nguy@ensimag.imag.fr>,
	Nguyen Huynh Khoi Nguyen 
	<Huynh-Khoi-Nguyen.Nguyen@ensimag.imag.fr>
To: konglu@minatec.inpg.fr
X-From: git-owner@vger.kernel.org Fri Jun 01 14:41:12 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SaRAC-0004Sn-0n
	for gcvg-git-2@plane.gmane.org; Fri, 01 Jun 2012 14:41:08 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759575Ab2FAMlB convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 1 Jun 2012 08:41:01 -0400
Received: from mail-gg0-f174.google.com ([209.85.161.174]:59894 "EHLO
	mail-gg0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759545Ab2FAMlA convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 1 Jun 2012 08:41:00 -0400
Received: by gglu4 with SMTP id u4so1670622ggl.19
        for <git@vger.kernel.org>; Fri, 01 Jun 2012 05:40:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        bh=q2LsJV9zic//pDdr72O0bQgaGwy1+qckF7niDN8nhsk=;
        b=aM9VKMRGXc636yf1/fU9uE/Vdd59j22vbnTO3U70ZesXZusl8p8Xr8clAIKTwtyhEk
         bbkt/xj8MDEibTmEekS7Cw4+B4dIp/7MRgVGB+EdH8FL3mwF9eycqcfLrf3YHHF8qu+U
         pDGEkcXw3VTdlKlLTlj9rW9OEK9N3RX57j+Rn7ebs4TIc6Fx3hRlm0bNTIvvuLmRqdtj
         F0srXooXkl58HTKmjYhjalaPmwbZWOSgiquOedJI12Q5HVruCH26TKQnkGUPTDbMVSX0
         ugeKaNoNZdbqe2ZyS1keWJf5lHF5ymFA/bJBriP39lNe/ioZdp+/vSDf/AfXFYxtBdGc
         bdHw==
Received: by 10.236.193.99 with SMTP id j63mr2499789yhn.45.1338554459704; Fri,
 01 Jun 2012 05:40:59 -0700 (PDT)
Received: by 10.146.150.18 with HTTP; Fri, 1 Jun 2012 05:40:39 -0700 (PDT)
In-Reply-To: <20120601132710.Horde.j1U5UHwdC4BPyKcOgc8zbbA@webmail.minatec.grenoble-inp.fr>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/198985>

On Fri, Jun 1, 2012 at 7:27 AM,  <konglu@minatec.inpg.fr> wrote:
>
> Matthieu Moy <Matthieu.Moy@grenoble-inp.fr> a =E9crit=A0:
>
>>> + =A0 =A0if (state->merge_in_progress)
>>> + =A0 =A0 =A0 =A0 =A0 =A0merge_in_progress_show(s, state, state_col=
or);
>>> + =A0 =A0else if (state->am_in_progress)
>>> + =A0 =A0 =A0 =A0 =A0 =A0am_in_progress_show(s, state, state_color)=
;
>>> + =A0 =A0else if (state->rebase_in_progress ||
>>> state->rebase_interactive_in_progress)
>>> + =A0 =A0 =A0 =A0 =A0 =A0rebase_in_progress_show(s, state, state_co=
lor);
>>> + =A0 =A0else if (state->cherry_pick_in_progress)
>>> + =A0 =A0 =A0 =A0 =A0 =A0cherry_pick_in_progress_show(s, state, sta=
te_color);
>>> + =A0 =A0if (state->bisect_in_progress)
>>> + =A0 =A0 =A0 =A0 =A0 =A0bisect_in_progress_show(s, state, state_co=
lor);
>>
>> I still disagree with the "else if" logic here. If the user started =
two
>> operations, I think we should show both messages.
>
> We show both messages in the case of bisect. However, we decided to
> implement a priority for the other cases because of how the code figu=
res
> out the current state.
> The cases in which you're in 'am' AND 'rebase' or only in 'am' is har=
d to
> handle. Thus The priority is given to the 'am' because running 'am' d=
uring
> a 'rebase' is possible (and the other way is not).
> On top of that, I think that the user only needs to know his "most re=
cent"
> current state. Given that he's running 'am' during a 'rebase', knowin=
g that
> he's in am progress is enough. If he finishes the 'am', then he will =
still
> know that he's in a 'rebase' with 'git status'.


Related to this, I think this is all useful information which is being
gathered and analyzed here.  It would be useful if all of the git code
could use these status functions in common instead of implementing
similar functionality individually.  But that is a topic for another
commit.

More appropriate for now is that I think there should be a
porcelain(?) version of this information.  First, imagine we can get
just this new session status information with a switch named
'--sequencer'[*]::

  $ git status --sequencer
  You have unmerged paths.
  You are in an am session.
  You are in the middle of an interactive rebase.

  $ git status --porcelain --sequencer
  airu

The "--porcelain --sequencer" combination I am imagining here would
show the status as a script-parseable sequence of single-letter
indicators telling the status of these same various conditions:
  u - unmerged paths
  a - git-am session
  i - interactive rebase
  r - rebase
  c - cherry-pick
  m - merge
etc.

By giving a value to --porcelain, we could limit the test to certain
conditions and return a meaningful result code if any are true.

  $ if git status --porcelain --sequencer=3Du ; then echo "Unmerged
paths exist" ; fi

I don't know if it makes sense to spell the --porcelain version with
or without spaces/newlines.  Any opinions?

What about the idea overall?

Phil

[*] Though I hate the choice of 'sequencer' as an option name for the
user, it makes sense to me in this context. Please suggest any
alternatives that spring to mind.
