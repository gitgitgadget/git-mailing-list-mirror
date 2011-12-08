From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: Re: [PATCH 2/2] bundle: rewrite builtin to use parse-options
Date: Fri, 9 Dec 2011 01:09:21 +0530
Message-ID: <CALkWK0nCuFgS8PKkQLMzqpBsOWouSs5y=CEKS1r0x0=LkhqC9A@mail.gmail.com>
References: <1323349817-15737-1-git-send-email-artagnon@gmail.com>
 <1323349817-15737-4-git-send-email-artagnon@gmail.com> <20111208163946.GB2394@elie.hsd1.il.comcast.net>
 <CALkWK0mmjKSzSbxq2i7=JvcB4LTro-MYDCwQLUUwqcf8qS0zPA@mail.gmail.com>
 <20111208170319.GD2394@elie.hsd1.il.comcast.net> <CALkWK0m89D02aku8J0OXbpyrovHCOpsYS4Qpx2jH-pFG4rOG2A@mail.gmail.com>
 <20111208175913.GK2394@elie.hsd1.il.comcast.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
	Git List <git@vger.kernel.org>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Thu Dec 08 20:39:48 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RYjoq-00046v-A4
	for gcvg-git-2@lo.gmane.org; Thu, 08 Dec 2011 20:39:48 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752871Ab1LHTjo convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 8 Dec 2011 14:39:44 -0500
Received: from mail-ww0-f44.google.com ([74.125.82.44]:35118 "EHLO
	mail-ww0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752839Ab1LHTjn convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 8 Dec 2011 14:39:43 -0500
Received: by wgbdr13 with SMTP id dr13so3956952wgb.1
        for <git@vger.kernel.org>; Thu, 08 Dec 2011 11:39:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        bh=KUgeJ0zVaUyQgF6GG58mAdlulEN+nV38C1RaLkuplag=;
        b=gqbC8KjeqY6fgxfTtBOHENeCZDsuG9Oo4Tp7NYvVy1BI9fTXZG1919LBIJBzH+Aw6w
         EDp/neOIhtzzK82NjOMIwwbcV06+M5CSjYg3Qu9k2MywGfdZgHw104C6dCV588O4vWjR
         K71iibIlu7eLWluolvYP2f+s2CHEJLdFYZhvc=
Received: by 10.227.209.9 with SMTP id ge9mr4882067wbb.1.1323373182311; Thu,
 08 Dec 2011 11:39:42 -0800 (PST)
Received: by 10.216.51.141 with HTTP; Thu, 8 Dec 2011 11:39:21 -0800 (PST)
In-Reply-To: <20111208175913.GK2394@elie.hsd1.il.comcast.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/186587>

Hi,

Jonathan Nieder wrote:
> What's the desired behavior? =C2=A0Then we can talk about how to impl=
ement it.
>
> If the goal is "use parse-options for a command that has subcommands"=
,
> see builtin/notes.c.

Uses strcmp() to match argv[0].  And you can't specify the options for
a certain subcommand before the subcommand itself on the command-line,
although I don't consider this a serious limitation.  I was going for
something prettier with subcommand-specific help text, albeit a
serious limitation.  I'll try working towards this for a few more
hours to see if anything useful comes out of it -- otherwise, I'll
just drop this patch and focus on eliminating the ugliness in
builtin/revert.c around '--continue', '--quit' parsing.

That being said, do you see value in lifting the restriction on
opts->long_name and PARSE_OPTS_NODASH not allowed together?  The
restriction seems quite arbitrary, but I can't justify lifting it
unless I can show some valid usecase.

Thanks.

-- Ram
