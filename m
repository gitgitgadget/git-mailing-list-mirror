From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: [Bash-completion-devel] [PATCH v2] completion: add new
 git_complete helper
Date: Sat, 21 Apr 2012 18:41:32 +0300
Message-ID: <CAMP44s1dNqokGuLg3ReLAreNBM++0NxOMUUk-=AgFBUy3n=E9w@mail.gmail.com>
References: <CAMP44s0PWAV=nD1xnAFMx8OPby88W2jKwDGtiUFY4LA93D-gAw@mail.gmail.com>
	<7vaa2by8nj.fsf@alter.siamese.dyndns.org>
	<20120416160729.GM5813@burratino>
	<CAMP44s2_VYNFeBi9GPa9CeqT=oRmSq1J1XaSP+aKgC6bJ55Lfg@mail.gmail.com>
	<20120416200941.GD12613@burratino>
	<CAMP44s0CVsmHw4jQqHvZMi342V8-Yh2zYYcAE_5EHu5OAiktcw@mail.gmail.com>
	<20120416203320.GF12613@burratino>
	<CAMP44s0Q2A_oKJx27ct9W__KVQkQxzst3H7gq6sZDhrCLDQaag@mail.gmail.com>
	<20120416204641.GH12613@burratino>
	<CAMP44s23_Qx3R9TX4frM-JYNv7XT3eVbcZ_D45nEdh0rq-O8kA@mail.gmail.com>
	<20120416205952.GJ12613@burratino>
	<4F925FBC.2030406@iki.fi>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Jonathan Nieder <jrnieder@gmail.com>,
	bash-completion-devel@lists.alioth.debian.org, git@vger.kernel.org
To: =?UTF-8?Q?Ville_Skytt=C3=A4?= <ville.skytta@iki.fi>
X-From: git-owner@vger.kernel.org Sat Apr 21 17:41:40 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SLcRP-0002kO-GY
	for gcvg-git-2@plane.gmane.org; Sat, 21 Apr 2012 17:41:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751188Ab2DUPle convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 21 Apr 2012 11:41:34 -0400
Received: from mail-ey0-f174.google.com ([209.85.215.174]:50662 "EHLO
	mail-ey0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750967Ab2DUPle convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 21 Apr 2012 11:41:34 -0400
Received: by eaaq12 with SMTP id q12so2717917eaa.19
        for <git@vger.kernel.org>; Sat, 21 Apr 2012 08:41:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        bh=/B5jkIvsCvlZ5DXK8V6bKhgDApRbmbW6l8yG+3QI080=;
        b=b1++Ob4OSguFkEMyy3coICubum8Mxji3BDr8knpHeHv6mI0TOHeowWB8tXs9pxQPxg
         v6P6ILY9v4bChf+r1RRiCFCmzHIzEYQQtAG/LXfM40mtMIjnSSE53JyIYWCJ/r2z2Dqp
         CwPT8SVSJT/jtO1hPQ9m2pwA1cKPFDrXn+9JVP1YC8K96dnuDr3VAwwSsTVoj+MkGwOs
         u/SP701rdBf84iRQE7+njaaPiFOhKArZDCd6ttLJlke7SZOiacIYdcmGFYpiZ6YNn6QY
         gb6InjSeslgiLYufpWb8rhn9YSpRPg1bEJhnoXsG6CVb1seL/8RBfJyQTyi+dgO+L850
         n11Q==
Received: by 10.14.50.74 with SMTP id y50mr1610589eeb.107.1335022892569; Sat,
 21 Apr 2012 08:41:32 -0700 (PDT)
Received: by 10.213.103.18 with HTTP; Sat, 21 Apr 2012 08:41:32 -0700 (PDT)
In-Reply-To: <4F925FBC.2030406@iki.fi>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/196052>

On Sat, Apr 21, 2012 at 10:20 AM, Ville Skytt=C3=A4 <ville.skytta@iki.f=
i> wrote:
> On 2012-04-16 23:59, Jonathan Nieder wrote:
>
>> Hopefully this information helps clarify to what extent the leading
>> underscores in functions exposed by completion scripts are meant or
>> are not meant as a convention.
>
> We've discussed what a real "API" or "namespace" of bash-completion
> would look like, but so far nothing concrete has come out of it.
>
> http://thread.gmane.org/gmane.comp.shells.bash.completion.scm/2013/fo=
cus=3D3135

Thank you for pointing this out. This means I was correct; there
was/is no convention for public APIs.

According to that thread, the closest there is to a convention would
be to name it _GIT_complete. That would certainly avoid conflicts with
any current namespace, so I feel it's much better than __git_complete.

Still, I don't see the point in avoiding 'git_complete' and making our
lifes more difficult. Bash public functions, like *complete*, don't
have any special namespace, they just snatch them, and that's the end
of it. In the particular case of git, where would have only a couple
(currently 2) public functions, I don't see what's the big deal.

Cheers.

--=20
=46elipe Contreras
