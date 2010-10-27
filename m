From: Eugene Sajine <euguess@gmail.com>
Subject: Re: Why the default action for pull is merge, but not rebase?
Date: Wed, 27 Oct 2010 13:21:18 -0400
Message-ID: <AANLkTimoSH2C4dBDDN1KMaFAp_nwAtLy5_uNFfiuz5GR@mail.gmail.com>
References: <AANLkTinLbaE6He-bxA_+CT6J5uWmZSgodGs6SXO7eqnr@mail.gmail.com>
	<20101027165723.GC11069@burratino>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Wed Oct 27 19:21:30 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PB9gk-00084e-4T
	for gcvg-git-2@lo.gmane.org; Wed, 27 Oct 2010 19:21:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752741Ab0J0RVV convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 27 Oct 2010 13:21:21 -0400
Received: from mail-bw0-f46.google.com ([209.85.214.46]:42287 "EHLO
	mail-bw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752675Ab0J0RVT convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 27 Oct 2010 13:21:19 -0400
Received: by bwz11 with SMTP id 11so798844bwz.19
        for <git@vger.kernel.org>; Wed, 27 Oct 2010 10:21:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:in-reply-to
         :references:date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=J0EBf9lMT/jjELYC5buMEVsxM/oiweHASxmWVhxMkNw=;
        b=nNUF53LZ+/oPGwrC/PIRlGFOEMOcKBrWhPgejCBBwLCS4saX9668eOCoXB0FmtmZ83
         iIzk9OtJiqHykAVyPNQ662fPcbXTUvmBpYoFUc3Sd6mlI3YOhLn9lHnwh5VbjOOeFUmQ
         g5BWWyA04YlXVeKlu7eKpTm/vATm8Dqq6Wj3c=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=C814527XD4ilAMKuI2XXDPJhYP5GEy1UT7dGk6OLSCvipf4AaZtadmtrGAQBYjFrWG
         npHpANHFZ/FaGm84UdoSSqZVmsJz85gGj3BHs8Y2QoSzcPbzz6M1uKB+Ie7K6Fm3eP6F
         oZHveJGsRirVIeVH+GEDfaTs4xBpNyIaHO3zI=
Received: by 10.204.69.200 with SMTP id a8mr7703212bkj.36.1288200078478; Wed,
 27 Oct 2010 10:21:18 -0700 (PDT)
Received: by 10.204.46.207 with HTTP; Wed, 27 Oct 2010 10:21:18 -0700 (PDT)
In-Reply-To: <20101027165723.GC11069@burratino>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/160104>

On Wed, Oct 27, 2010 at 12:57 PM, Jonathan Nieder <jrnieder@gmail.com> =
wrote:
> Eugene Sajine wrote:
>
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 So, why not to reba=
se?
>
> An interesting question.
>
> Rebasing results in untested commits. =C2=A0If this is a patch series
> for submission, that's fine, because you will be extensively
> testing each patch anyway or indicating to reviewers that that
> needs to be done (right?). =C2=A0But if it's a long-lived branch then
> such repeated testing work can be a serious hassle.
> https://git.wiki.kernel.org/index.php/GitFaq#What_is_the_difference_b=
etween_a_merge_and_a_rebase.3F
>
> A public branch that is regularly rebased is hard to follow
> ("git log foo@{1}..foo") and build on.
> http://www.kernel.org/pub/software/scm/git/docs/git-rebase.html#_reco=
vering_from_upstream_rebase
>
> Code consumers often want clean history, but that really means
> (a) clean and (b) history.
> http://thread.gmane.org/gmane.comp.video.dri.devel/34739/focus=3D3474=
4
>
> Hope that helps.
>

Thanks for prompt answer. But let me clarify:

When you do pull git performs:

fetch of the remote branch to the FETCH_HEAD
and then merge of FETCH_HEAD into the local branch

What I'm saying is that your local branch should be rebased on top of
=46ETCH_HEAD instead

In this case there is no such thing as "often rebased public branch".

if the history got diverged then pull will result in new state that
should be tested anyway, so why not to rebase local branch on top of
the upstream instead of merging upstream into local branch?

i'm not saying to rebase the upstream published branch on top of the
local changes - that's NO-NO I'm aware of

thanks,
Eugene
