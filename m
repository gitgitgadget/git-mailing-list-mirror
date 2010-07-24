From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: rfc - Changing the way gitk and git-gui are managed
Date: Sat, 24 Jul 2010 07:54:08 -0500
Message-ID: <20100724125408.GA17481@burratino>
References: <7vocdygbw0.fsf@alter.siamese.dyndns.org>
 <20100724110239.GA13067@vidovic>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Nicolas Sebrecht <nicolas.s.dev@gmx.fr>
X-From: git-owner@vger.kernel.org Sat Jul 24 14:55:38 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OceGM-0003pu-Sv
	for gcvg-git-2@lo.gmane.org; Sat, 24 Jul 2010 14:55:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753672Ab0GXMzN convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 24 Jul 2010 08:55:13 -0400
Received: from mail-iw0-f174.google.com ([209.85.214.174]:49922 "EHLO
	mail-iw0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752213Ab0GXMzM (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 24 Jul 2010 08:55:12 -0400
Received: by iwn7 with SMTP id 7so1151302iwn.19
        for <git@vger.kernel.org>; Sat, 24 Jul 2010 05:55:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :content-transfer-encoding:in-reply-to:user-agent;
        bh=4hZIGXEPG25pl0AOfQ0KWepEJrGXrQYYr2fHoVwgb+o=;
        b=YwPtt8fOYG7RxLdKTMu4UaE+Su7RjgKku2L7PwQJhG5WsWR/2dUwOgtNmz/DwJTA49
         Qzw/X9j4jrT9SNyuOE/9fTsB9JXxsFT+dEgeiHJGR3ELA7McBC44l7g5LbNiprkUlUcx
         LN8ouKCQDn+5TTKtAx441TVCm7iU6GXlSCMV4=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        b=IJA/waIyTjWQW3LYv+TCDRtu1ZTjI7Bu4O7CVNvFTDQi4qHUNnLE6SoBoBiRKZok8z
         WD6dfpxyN4tK4oQYhsDuHnh/k0ZxlHHZORh2BNrPfeU4LaNx+iC89Bgwgpk2/bFXHau1
         zaoPyLv/g+VIsjnkY3vYeTmWOwETIZ/ZtCEH0=
Received: by 10.231.183.10 with SMTP id ce10mr5329138ibb.96.1279976111628;
        Sat, 24 Jul 2010 05:55:11 -0700 (PDT)
Received: from burratino (c-98-212-3-231.hsd1.il.comcast.net [98.212.3.231])
        by mx.google.com with ESMTPS id r3sm1326098ibk.19.2010.07.24.05.55.10
        (version=SSLv3 cipher=RC4-MD5);
        Sat, 24 Jul 2010 05:55:11 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20100724110239.GA13067@vidovic>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/151627>

Nicolas Sebrecht wrote:

> What is the issue with the current status?

Here is one:

 $ git log --oneline -SListbox.font -- gitk-git/gitk
 $ git log --oneline --follow -SListbox.font -- gitk-git/gitk
 62ba514 Move gitk to its own subdirectory
 $ git log --oneline -SListbox.font -- gitk-git/gitk gitk
 207ad7b gitk: Set the font for all listbox widgets
 $

> Going this way, why would we want gitk and git-gui as submodules at a=
ll?

If we want to stop distributing them completely (though I am not
convinced that would be a good idea), then submodules would be a
good stopping point along the way to avoid changing the world too
much at a time.

git archive hasn=E2=80=99t learned to do recursive archive yet; I think
the last murmurs of that topic were [1] and [2], though it would
be simple enough to use "git archive" more than once together
with "tar rf" to take care of it by hand in this case.

[1] http://thread.gmane.org/gmane.comp.version-control.git/107030
which is a reroll of
http://thread.gmane.org/gmane.comp.version-control.git/106788/focus=3D1=
06787

[2] http://thread.gmane.org/gmane.comp.version-control.git/106788/focus=
=3D106787
