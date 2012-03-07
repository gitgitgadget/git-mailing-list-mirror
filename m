From: =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Subject: Re: Replacing large blobs in git history
Date: Wed, 7 Mar 2012 22:27:11 +0100
Message-ID: <CACBZZX4hinV8vkebyNCLp_Ac6L80aNbdGOFqg1nSsCuRktFFrg@mail.gmail.com>
References: <CAD-6W7byTiuE9MFZY1yG_ann-Ox7+wGjYduZ=Wwmw0ToF5Pynw@mail.gmail.com>
 <4F56786D.60801@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Barry Roberts <blr@robertsr.us>, git <git@vger.kernel.org>
To: Neal Kreitzinger <nkreitzinger@gmail.com>
X-From: git-owner@vger.kernel.org Wed Mar 07 22:27:43 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1S5OOc-0002DP-HV
	for gcvg-git-2@plane.gmane.org; Wed, 07 Mar 2012 22:27:42 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932418Ab2CGV1e convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 7 Mar 2012 16:27:34 -0500
Received: from mail-ee0-f46.google.com ([74.125.83.46]:65141 "EHLO
	mail-ee0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756083Ab2CGV1c convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 7 Mar 2012 16:27:32 -0500
Received: by eekc41 with SMTP id c41so2492533eek.19
        for <git@vger.kernel.org>; Wed, 07 Mar 2012 13:27:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        bh=IwNuds/8A+vPsw+IGyTuEUt1sRKJnjCjO4wtFKx4q9U=;
        b=oGmghY4QPWM6TdPMiSStiKgHAlVbdLaHT0SQoMHU06YbKWxNFpp3TsJQq0QXfTtgY2
         Hv44VvabWok7sV41QA89h5oJ0gya9dPhisxdPYmwo3CRbDDrTYV2MKljSwcCI1Ei5plb
         VOE0w9NHRwZB1iYGxDt1cbkS6HMHhcEIstvF7iR+cGAzpxpsl0wssCWdMVyGql4R6CXV
         KSaZS97ZG0lu/kuCqL7fCMwgQtw3X/bVWmO+Y0+tFnUyi2uIMwL1QLmvI6e6t+b7T7wp
         n8y9dceUCxzBsRYFgCA5YSj8gxOv5abPCLbsGbBp0Pdkry9ogdrvhDPqTVHNPDYC/+oE
         LA8g==
Received: by 10.213.27.22 with SMTP id g22mr882351ebc.83.1331155651230; Wed,
 07 Mar 2012 13:27:31 -0800 (PST)
Received: by 10.213.2.147 with HTTP; Wed, 7 Mar 2012 13:27:11 -0800 (PST)
In-Reply-To: <4F56786D.60801@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/192485>

On Tue, Mar 6, 2012 at 21:49, Neal Kreitzinger <nkreitzinger@gmail.com>=
 wrote:
> On 3/6/2012 10:09 AM, Barry Roberts wrote:
> Be aware that you are rewriting history. =C2=A0I assume this is publi=
shed
> history that you are going to run filter-branch on. =C2=A0That means =
everyone who
> cloned from the old history (pre-filter-branch), not to mention those=
 who
> also have WIP based on the old history, will need to somehow adjust t=
o the
> new history.

Does something other than git-fsck actually check whether the
collection of blobs you're getting from the remote when you clone have
sensible sha1's?

What'll happen if he replaces that 550MB blob with a 0 byte blob but
hacks the object store so that it pretends to have the same sha1?

Of course the real solution to this issue is to either rewrite
history, or to change Git to support partially fetching the old blobs
in your project.
