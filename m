From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: Finding a branch point in git
Date: Thu, 31 May 2012 18:10:16 +0200
Message-ID: <CAMP44s2eqLQvfaMhQJV-JmmQf3hXMK2_85OVGrd4bLqC5xzMVA@mail.gmail.com>
References: <CAMP44s0f7AJPQSTDgvy0U7vx8nxzq2a3vMhSr2Tcc61fetFkJA@mail.gmail.com>
	<20120528062026.GB11174@sigill.intra.peff.net>
	<CAMP44s04msWMOaaH8U30XXg5yXJnEd=bULJ7VPxWSD0Wfh2=EA@mail.gmail.com>
	<20120528190639.GA2478@sigill.intra.peff.net>
	<CAMP44s0UBsVicuEcwACsm1zTT_jGau_Q20hJv4J_6uvancYJRQ@mail.gmail.com>
	<20120530215415.GB3237@sigill.intra.peff.net>
	<CAMP44s1Q26B9hCdubfDiP2_YUUWGOtyyA=gSwqpGOE4FfZrN8A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Thu May 31 18:10:33 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Sa7xC-0007Jc-9B
	for gcvg-git-2@plane.gmane.org; Thu, 31 May 2012 18:10:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932703Ab2EaQKV convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 31 May 2012 12:10:21 -0400
Received: from mail-lpp01m010-f46.google.com ([209.85.215.46]:43981 "EHLO
	mail-lpp01m010-f46.google.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S932692Ab2EaQKU convert rfc822-to-8bit
	(ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 31 May 2012 12:10:20 -0400
Received: by lahd3 with SMTP id d3so840069lah.19
        for <git@vger.kernel.org>; Thu, 31 May 2012 09:10:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        bh=XEC5v26O16VK2pNQqVI1oWT9VrWjYC7r0t1CSvFcRLI=;
        b=qL0thkHspo+EsV8ES8z7OuAt2bDv6i7KB/0tnI2yzvy6BOVxsy3HAwOzOAV1b+Vgzm
         ifwwYrQf2hz+DPfg/FHEh+HPMtK8XW0nguj+O0pFzJJkvOaURxzHTU0nVyu5iXRH+DKS
         wyTWbD8A5ohtcrL8eTv4pYMe+lBzLTQni4WOxRbKuXbnQzs5AEV5d3g9m3Azmdh3uKE3
         F871m5BC9Rk9kLSREtjwJldSQXGfzZ60Se5SKe92LO7o8a+Dl+mChJGZwAkHJMCU5rs0
         0O4pAmu1WK1ZY7QP2qzvCJdSgA/eZBIY4e8GXyTRLz1u83ElAGHU3IPH4dOc89PqwtPo
         vprw==
Received: by 10.152.109.166 with SMTP id ht6mr20711153lab.46.1338480616899;
 Thu, 31 May 2012 09:10:16 -0700 (PDT)
Received: by 10.112.107.65 with HTTP; Thu, 31 May 2012 09:10:16 -0700 (PDT)
In-Reply-To: <CAMP44s1Q26B9hCdubfDiP2_YUUWGOtyyA=gSwqpGOE4FfZrN8A@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/198925>

On Thu, May 31, 2012 at 5:27 PM, Felipe Contreras
<felipe.contreras@gmail.com> wrote:
> On Wed, May 30, 2012 at 11:54 PM, Jeff King <peff@peff.net> wrote:
>> On Wed, May 30, 2012 at 07:07:39PM +0200, Felipe Contreras wrote:
>>
>>> On Mon, May 28, 2012 at 9:06 PM, Jeff King <peff@peff.net> wrote:
>>> > On Mon, May 28, 2012 at 02:36:04PM +0200, Felipe Contreras wrote:
>>> >
>>> >> > What about a history with multiple branches?
>>> >> >
>>> >> > --X--A--B--C--D----E =C2=A0(master)
>>> >> > =C2=A0 =C2=A0 =C2=A0\ =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 /
>>> >> > =C2=A0 =C2=A0 =C2=A0 G--H--I---J =C2=A0 (branch X)
>>> >> > =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 \ =C2=A0 =C2=A0/
>>> >> > =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0K--L =C2=A0 =C2=A0(br=
anch Y)
>>> >> [...]
>>> >>
>>> >> Yes, but then you would need to specify a second branch. I would=
 avoid
>>> >> that if possible.
>>> >
>>> > I agree that is less nice. But I don't think the operation is
>>> > well-defined with a single branch. If you ask for "when did branc=
h X
>>> > split", then in the above graph it is unclear if you meant "split=
 from
>>> > master", or "split from Y".
>>>
>>> If you look from the context that I explained in the first mail; it
>>> would be from *any* branch; IOW; find the first commit from branch =
X
>>> (G), and then find the parent. That would be the first commit where
>>> branch X started.
>>
>> I'm not sure that's possible, though, in the face of criss-cross mer=
ges.
>> How do we distinguish the history above from one in which branch Y w=
as
>> forked from master at G, and then branch X was forked from branch Y =
at
>> H?
>
> That is true, but we could use the algorithm used by name-rev: G woul=
d
> have a distance 3 from branch X, and distance 2 from Y, so it would b=
e
> considered part of branch Y.

Er, actually that would list X as branch Y. Now I believe there is a
real problem.

However, I don't believe mercurial branch labels are the solution;
probably a pointer to the tail of the branch would provide with all
the information needed.

Cheers.

--=20
=46elipe Contreras
