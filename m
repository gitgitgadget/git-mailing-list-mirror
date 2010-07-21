From: Jonathan Nieder <jrnieder@gmail.com>
Subject: git name-rev for fun and profit (Re: [PATCH] t/: work around
 one-shot variable assignment with test_must_fail)
Date: Tue, 20 Jul 2010 20:05:39 -0500
Message-ID: <20100721010539.GF4282@burratino>
References: <8HvhdiflWJtex2eC6n_6Q38YcvRRYhnh0scnq4s56M4wdwT_YlAiOw@cipher.nrlssc.navy.mil>
 <iU5XdZGtMeaspoCqSJIp6Y--60TPVkZUrm3SdW86dsTZkNYZWqbSppLBrMXyL1rVqqYtHm94ACo@cipher.nrlssc.navy.mil>
 <AANLkTilzC8iMikfBieS_pcChP7_F4hA6bT1ydWHD4etP@mail.gmail.com>
 <20100721000101.GB4282@burratino>
 <AANLkTik0gKFfDCmcLZnn4WFCFY3Lb5zRgrzKLAgD5qH6@mail.gmail.com>
 <20100721001402.GE4282@burratino>
 <AANLkTil8gyaOcjHGm0tLTdYDdTT4VckUr9nELNiBlKNa@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Brandon Casey <casey@nrlssc.navy.mil>, git@vger.kernel.org,
	erick.mattos@gmail.com, jaredhance@gmail.com, drafnel@gmail.com
To: =?iso-8859-1?Q?=C6var_Arnfj=F6r=F0?= Bjarmason <avarab@gmail.com>
X-From: git-owner@vger.kernel.org Wed Jul 21 03:06:45 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ObNll-0002ub-Kn
	for gcvg-git-2@lo.gmane.org; Wed, 21 Jul 2010 03:06:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932569Ab0GUBGk convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 20 Jul 2010 21:06:40 -0400
Received: from mail-iw0-f174.google.com ([209.85.214.174]:53085 "EHLO
	mail-iw0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1761763Ab0GUBGj convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 20 Jul 2010 21:06:39 -0400
Received: by iwn7 with SMTP id 7so6258441iwn.19
        for <git@vger.kernel.org>; Tue, 20 Jul 2010 18:06:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :content-transfer-encoding:in-reply-to:user-agent;
        bh=6bbhbUFBNHWTVlDdBORYzsa8z6rLGU9C0FpwuMLnG4A=;
        b=moxd9Dg7MMrqAR7s2JdLoKfYxFBLBR9kHYiJkb/dcj/DJLRSvjaqp5d93q1hMngGxi
         4oKqLvnz6MzYVeXPyuonzrGvs1IbPKkzTgsQMhKBZZ8cwmsHiFskxIzoY4lnIyoakw6g
         IucAuOVLb8eYJyuu305+LQFfyYzpa0LpDF5T4=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        b=NJmVCA2+J1kW+BdKs26SuE9FfNH0ndm/oU6KGSIkchNDjsGqu5iWYCduNKgtfJx3nd
         Mt0xYiEuNHny4GSBJUr0uXtRUUkitCJ1POU9RyHal7ymjOLGybphj9XFh9sR7Ron/Ujj
         nPAk6XEWmZrFKRuUr1e5Ao+8DrdbQNIrIQU1o=
Received: by 10.231.184.1 with SMTP id ci1mr8598024ibb.39.1279674395838;
        Tue, 20 Jul 2010 18:06:35 -0700 (PDT)
Received: from burratino (c-98-212-3-231.hsd1.il.comcast.net [98.212.3.231])
        by mx.google.com with ESMTPS id h8sm28099805ibk.15.2010.07.20.18.06.34
        (version=SSLv3 cipher=RC4-MD5);
        Tue, 20 Jul 2010 18:06:35 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <AANLkTil8gyaOcjHGm0tLTdYDdTT4VckUr9nELNiBlKNa@mail.gmail.com>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/151383>

=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason wrote:

> As an aside, how do you make these 61-commits-after-rc0 commit ids. I=
s
> there a sha1->that tool that I haven't spotted?

 GIT_PAGER_IN_USE=3D1 git log --all-match --grep=3Dshell --grep=3Dexpor=
t |
 git -p name-rev --tags --stdin

v1.5.6-rc0~61 is 61 commits before rc0 (well, the 61st-generation
grandparent using the first parent where there is a choice).  The
distinction matters because =E2=80=9C61 commits _after_ 1.5.6-rc0=E2=80=
=9D is not
well-defined.

If you want the latter sort of description anyway, =E2=80=98git describ=
e=E2=80=99
might help.
