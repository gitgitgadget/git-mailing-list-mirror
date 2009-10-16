From: =?UTF-8?Q?Bj=C3=B6rn_Gustavsson?= <bgustavsson@gmail.com>
Subject: Re: [PATCH] rebase -i: fix reword when using a terminal editor
Date: Fri, 16 Oct 2009 10:05:39 +0200
Message-ID: <6672d0160910160105t33ea0585r5c791d47d03f40a9@mail.gmail.com>
References: <1255674753-13949-1-git-send-email-bebarino@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
To: Stephen Boyd <bebarino@gmail.com>
X-From: git-owner@vger.kernel.org Fri Oct 16 10:09:25 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Myhrd-0006T1-VB
	for gcvg-git-2@lo.gmane.org; Fri, 16 Oct 2009 10:08:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754353AbZJPIGW convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 16 Oct 2009 04:06:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751308AbZJPIGV
	(ORCPT <rfc822;git-outgoing>); Fri, 16 Oct 2009 04:06:21 -0400
Received: from mail-fx0-f218.google.com ([209.85.220.218]:36796 "EHLO
	mail-fx0-f218.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752175AbZJPIGQ convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 16 Oct 2009 04:06:16 -0400
Received: by fxm18 with SMTP id 18so2088978fxm.37
        for <git@vger.kernel.org>; Fri, 16 Oct 2009 01:05:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=LHKmicKzwLYTbaE9vl1yh3IKUOo5W3hJZezfECJctQc=;
        b=np2Z7/OLRFO3typUzMiwGqoz+Y2byBu6nqKPcDbD/8E+Y2W8FW2Zj0nhC22HxquoQ8
         DcPGLghNyoMFoGV92bzxAKM+7vRjyx1uZs/iRJsT4ILE7SmOSwOr4/fJrdC6TCWLZt+u
         012Syh/MCzFfLSdhhI41U1IJOrkT/Qm3KWyRE=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=vr3u4+zBpUUrv4j/c9A5Ar5udmwS1pIYcESyQe1l+6uRtoGTToA2WIu9MiisdGLuNA
         psrEnSZrlGHgtDZGycXOLiKf52+uSsif4FeN5aenjSUA5VlSK5RZjoWDzUD9FyAIH2SG
         4dK0szvcCH1eNWa0jI9wljrd9JDIeCBEGE1uc=
Received: by 10.204.2.73 with SMTP id 9mr931464bki.159.1255680339384; Fri, 16 
	Oct 2009 01:05:39 -0700 (PDT)
In-Reply-To: <1255674753-13949-1-git-send-email-bebarino@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/130462>

2009/10/16 Stephen Boyd <bebarino@gmail.com>:
> We don't want to use output() on git-commit --amend when rewording th=
e
> commit message. This leads to confusion as the editor is run in a
> subshell with it's output saved away, leaving the user with a seeming=
ly
> frozen terminal.
>
> Fix by removing the output part.
>
> Signed-off-by: Stephen Boyd <bebarino@gmail.com>
> ---
>
> On top of next.
>
> I think this is right, although I'm not really experienced in the reb=
ase -i
> code

Thanks!

Yes, it seems right to me too after a more thorough reading of the
existing rebase -i code. It seems that 'output' is only used for
non-interactive commands.

I never noticed the problem because I use 'emacsclient' as my
commit editor. I didn't think of testing with an editor that run in
the terminal window.

/Bj=C3=B6rn
--=20
Bj=C3=B6rn Gustavsson, Erlang/OTP, Ericsson AB
