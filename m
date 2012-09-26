From: Cosmin Stejerean <cosmin@offbytwo.com>
Subject: Re: Can git pull from a mercurial repository?
Date: Wed, 26 Sep 2012 15:21:57 -0500
Message-ID: <CAF+fDw6eUdW_pmLsMzXgfhm46S8ey07kdo=vxJ=jP=SWjzR5RQ@mail.gmail.com>
References: <k39lir$gpm$1@ger.gmane.org> <50585F10.3080307@op5.se>
 <000a01cd959a$d8cd0730$8a671590$@schmitz-digital.de> <37D17798-4BDC-433D-A9B4-49F4352754D9@quendi.de>
 <5062B0F6.1040906@unixsol.org> <7F5A6E53-4F7C-462F-8B04-09934BAB88DB@quendi.de>
 <5062CF09.2090703@unixsol.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: Max Horn <postbox@quendi.de>,
	Joachim Schmitz <jojo@schmitz-digital.de>,
	Andreas Ericsson <ae@op5.se>, git@vger.kernel.org
To: Georgi Chorbadzhiyski <gf@unixsol.org>
X-From: git-owner@vger.kernel.org Wed Sep 26 22:22:32 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TGy7p-0004j9-GM
	for gcvg-git-2@plane.gmane.org; Wed, 26 Sep 2012 22:22:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754445Ab2IZUWU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 26 Sep 2012 16:22:20 -0400
Received: from mail-wi0-f172.google.com ([209.85.212.172]:63636 "EHLO
	mail-wi0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750945Ab2IZUWT convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 26 Sep 2012 16:22:19 -0400
Received: by wibhq12 with SMTP id hq12so5409660wib.1
        for <git@vger.kernel.org>; Wed, 26 Sep 2012 13:22:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=offbytwo.com; s=google;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        bh=onBzXEtadTo3LLOQGGvDRza4I8V/NBfvJJJpydCPdfg=;
        b=inA364gOjaZJjBNSfycn1ylFEx/nwJdbmOdB32ZcHLUwf8rBVNYCpdiva3XSp/mw93
         937xusJst8GQUE6Nh70b0QIMzCzWz+NwifvlKqfmWIiyeYFqI9KDcG6M51wfAHGI3KlJ
         X/q30UxaLow0R+NcF8qsZ+WLygu76GDCAJ1RU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding:x-gm-message-state;
        bh=onBzXEtadTo3LLOQGGvDRza4I8V/NBfvJJJpydCPdfg=;
        b=bRXAUiQJEzQWi/hZVfo0se0/MeTy1t/zR+2f01hxSXTCLAlNh2r+eUm+WNNKAV9H/e
         J+gwG7ODPTy/WqUfrZyo821heGE/8aUHCXTuQWl+big1GkpD7bkln4ERiwTnMiDd3u0p
         Q9ufctwg10Fa+Dyw9+yX01iaclhsxFJhh3dkg3kPFdCIkthjdepEAKZ2jVy3ndlHW2sX
         z1/ZMukWbgVwMhxf5EsqGsYOaT4MZDloJEP3uiE16s9fd3Vq2If+/xELzyF8XPmVl4qi
         Og9F5dNGqMslZrolVlKaqdNpzVyaXoMNyGs+DRwZwB8jOPm64GeCr7bjeg/vDpJLh0GA
         U6TA==
Received: by 10.180.104.200 with SMTP id gg8mr3575763wib.14.1348690937638;
 Wed, 26 Sep 2012 13:22:17 -0700 (PDT)
Received: by 10.194.16.106 with HTTP; Wed, 26 Sep 2012 13:21:57 -0700 (PDT)
In-Reply-To: <5062CF09.2090703@unixsol.org>
X-Gm-Message-State: ALoCoQmv4euDGanjutyTYo5NQZGAp/AD8NX9r04xwNSbPTYAJbuYbq+0pEk1O/1QyvQHdgFiqq5j
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/206443>

I definitely wrote git-hg for the purpose of checking out a mercurial
repo so I can develop locally against it with git and then submit
patches. Getting push support was never really a priority for me.
Someone did eventually contribute some mechanism for pushing things
back in a pull request, so I merged it in. I occasionally get pull
requests for minor things around push, so it seems like at least a few
people are using it.

The way to get proper push support would be to use the hg-git
extension. The git-hg-again project uses that, and if I had some time
I'd love to move git-hg over to that approach as well. Patches
welcome. Alternatively, you can always https://www.gittip.com/cosmin/
:)


- Cosmin

On Wed, Sep 26, 2012 at 4:46 AM, Georgi Chorbadzhiyski <gf@unixsol.org> wrote:
> Around 09/26/2012 11:46 AM, Max Horn scribbled:
>> On 26.09.2012, at 09:38, Georgi Chorbadzhiyski wrote:
>>> Around 09/25/2012 05:15 PM, Max Horn scribbled:
>>>> I think there is a lot of demand for a "git-hg" bridge, a way to seemlessly access a Mercurial repository as if it was a git repository. A converse to hg-git <http://hg-git.github.com/>
>>>
>>> I've already mentioned this, but such a tool already exists and it
>>> is working very well (IMHO): http://offbytwo.com/git-hg/
>>
>> I guess this is a matter of perspective. It doesn't work at all for me because it does not really support pushing. (It does have a "push" command, but at least last time I looked, it was utterly broken; see also <https://github.com/dubiousjim/yagh/blob/master/Backends.md> for a discussion (not written by me!). I'd be happy to learn that has changed, though I just looked, and it still uses "hg convert", so I don't see how it possibly could work...
>
> I have not tested push (I'm using git-hg to sync hg repo and develop
> using git, no pushing back to hg, just sending patches).
>
> According to git-hg README "Push supported added as well although it
> is still experimental". You should report the "push" bugs to the
> author(s) they may be able to fix them.
>
> --
> Georgi Chorbadzhiyski
> http://georgi.unixsol.org/
