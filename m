From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH] contrib: Replaced /bin/sh with /bin/bash to make
 scripts with Bash syntax work on Solaris.
Date: Mon, 9 Aug 2010 15:16:29 -0500
Message-ID: <20100809201629.GB2888@burratino>
References: <1281099365-11978-1-git-send-email-asgeir@twingine.no>
 <20100808031142.GA20077@burratino>
 <7vvd7j67wo.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: "Asgeir S. Nilsen" <asgeir@twingine.no>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Aug 09 22:18:12 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OiYnS-0003EZ-Kl
	for gcvg-git-2@lo.gmane.org; Mon, 09 Aug 2010 22:18:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755348Ab0HIUSE convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 9 Aug 2010 16:18:04 -0400
Received: from mail-wy0-f174.google.com ([74.125.82.174]:63846 "EHLO
	mail-wy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754214Ab0HIUSC (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 9 Aug 2010 16:18:02 -0400
Received: by wyi11 with SMTP id 11so64453wyi.19
        for <git@vger.kernel.org>; Mon, 09 Aug 2010 13:18:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :content-transfer-encoding:in-reply-to:user-agent;
        bh=ikRwEev42NlSEgi3PUyWbqnmDVjzS37qmg3qHv/AzeY=;
        b=EacDtavV0uHl2uFGDfTI7VKERidagMYyEiNNUAZiOqQU0xvj9Mk0BrEtC5xupDeDfz
         egHS9d7yRG/dOJpNbmPC4DNo2PyfjE31mHE9VZz1jqW7f6gGWzhyaYJuhnkfMM1Izgl/
         wtRqKQ1wyBGMCX7p4qXoZkS/1iUGYVYwqHZvI=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        b=XAj46onptNQIn1MOVKvSuaEUxJsrSOB9UNBq5dJEZnZ3cI+WTkzBk8glOiubONeDdi
         naXN98ltqDbxfsUeoGqDjUnAdMA7KswMbKCjZEUDhgaC+YX4SMQ7dan3p3Eyek2s9VGq
         lI6WkRzU4DV712juaJag3qsphMbXTUczZewg4=
Received: by 10.216.234.132 with SMTP id s4mr3091917weq.0.1281385081603;
        Mon, 09 Aug 2010 13:18:01 -0700 (PDT)
Received: from burratino (ip-64-32-208-34.chi.megapath.net [64.32.208.34])
        by mx.google.com with ESMTPS id l6sm2860346wed.1.2010.08.09.13.17.58
        (version=SSLv3 cipher=RC4-MD5);
        Mon, 09 Aug 2010 13:18:00 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <7vvd7j67wo.fsf@alter.siamese.dyndns.org>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/153015>

Junio C Hamano wrote:
> Jonathan Nieder <jrnieder@gmail.com> writes:

>> Maybe, relying on a sane $PATH:
>>
>> 	#!/usr/bin/env sh
>
> That's even worse.  Please don't go there.

Okay.  I was trying to be exhaustive, even if most of the strategies I
mentioned are insane (=E2=80=9Cmaybe=E2=80=9D was probably too strong o=
f a word :)).
(For example, I remember some version of Cygwin requiring the #! line,
so I fear it is dangerous to leave that off.)

After-the-fact s,/bin/sh,$SHELL_THE_USER_WANTS, substitution is the
only sane strategy I have seen used in practice.  POSIX has even
blessed something like it, at last.

http://www.opengroup.org/onlinepubs/9699919799/utilities/sh.html#tag_20=
_117_16
