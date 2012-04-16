From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: [PATCH v2] completion: add new git_complete helper
Date: Mon, 16 Apr 2012 23:04:52 +0300
Message-ID: <CAMP44s2_VYNFeBi9GPa9CeqT=oRmSq1J1XaSP+aKgC6bJ55Lfg@mail.gmail.com>
References: <1334524814-13581-1-git-send-email-felipe.contreras@gmail.com>
	<20120415213718.GB5813@burratino>
	<CAMP44s0PWAV=nD1xnAFMx8OPby88W2jKwDGtiUFY4LA93D-gAw@mail.gmail.com>
	<7vaa2by8nj.fsf@alter.siamese.dyndns.org>
	<20120416160729.GM5813@burratino>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	=?UTF-8?Q?SZEDER_G=C3=A1bor?= <szeder@ira.uka.de>,
	Thomas Rast <trast@student.ethz.ch>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Mon Apr 16 22:05:03 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SJsAW-0007fj-Nv
	for gcvg-git-2@plane.gmane.org; Mon, 16 Apr 2012 22:05:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754137Ab2DPUEy convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 16 Apr 2012 16:04:54 -0400
Received: from mail-ey0-f174.google.com ([209.85.215.174]:41124 "EHLO
	mail-ey0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753229Ab2DPUEx convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 16 Apr 2012 16:04:53 -0400
Received: by eaaq12 with SMTP id q12so1392968eaa.19
        for <git@vger.kernel.org>; Mon, 16 Apr 2012 13:04:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        bh=6wC0cSIVbpVL6Te6RLsYZoUnHyzbs2JhVuUi787qR4o=;
        b=U/VpjqWctkYZyNSrjHhwfgpiRkhBkZbbO79W0srNHW8tcMnWRpqD73R4aYZSSkqssi
         OMK0sNkyHKf1EM6XCdfagMPLTUq/8sHg4oN2cSCkdxvGKTrl5cx4VRfWFyk8MpmkVM4u
         DGTw1lZ6yHZUiF0aMM5IwrZ6/ZF19A8ka+bBPOhXIcSx1mOjeQEWuB3koLgUZe+hf74A
         2WQ4JqalTJMrlIAIpFAiesf7aKrhUJBCkqRL56Zc4ZTPDC2LOf33T42cr/8W13uLPYUq
         g2h+LZiMmMkBuMSc2qHMAPVdPYkwl9QTX6IpxKoS3i4vaarAaN82a/zrtfiC7UES5UGy
         4zzg==
Received: by 10.14.96.6 with SMTP id q6mr1838873eef.6.1334606692175; Mon, 16
 Apr 2012 13:04:52 -0700 (PDT)
Received: by 10.213.19.67 with HTTP; Mon, 16 Apr 2012 13:04:52 -0700 (PDT)
In-Reply-To: <20120416160729.GM5813@burratino>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/195681>

On Mon, Apr 16, 2012 at 7:07 PM, Jonathan Nieder <jrnieder@gmail.com> w=
rote:
> Junio C Hamano wrote:
>
>> I am OK with introducing git_ps1 while keeping __git_ps1 as an equiv=
alent
>> and declare that git_$anything will be the surface interface for end=
 users
>> to *use* the machinery we provide, though.
>
> The problem is that completion scripts are often included implicitly
> in .profile through the bash completion machinery. =C2=A0Users do not=
 have
> to explicitly ask for them, so there is no reason for users to expect
> that the function name "more_cowbell" is dangerous to use in .profile
> because some day the completion script for the "more" command will
> start using it.

Sure, that's why we would have _git_cowbell instead, so for *most* of
functions the user would have no trouble, it would *only* be
git_completion the one without prefix, and I think the name is quite
safe. There's quite likely few, probably nobody, actually using that
function name in their profiles.

Also, the script would now be loaded only *after*, the user types 'git
<TAB>'. And there's already a bunch of functions that are already
exported by just having bash completion: have(), quote(), dequote(),
quote_readline(). And there's at least one script that uses a function
without a prefix: ri_get_methods()

I would like to see a completion script that actually has a function
supposed to be exported and that still uses the _ prefix anyway.

Cheers.

--=20
=46elipe Contreras
