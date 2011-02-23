From: Jonathan Nieder <jrnieder@gmail.com>
Subject: ab/i18n (What's cooking in git.git (Feb 2011, #05; Wed, 23))
Date: Wed, 23 Feb 2011 17:48:28 -0600
Message-ID: <20110223234828.GA7286@elie>
References: <7v1v2y5o3p.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org,
	=?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Feb 24 00:48:45 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PsORo-0007UD-DD
	for gcvg-git-2@lo.gmane.org; Thu, 24 Feb 2011 00:48:44 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753542Ab1BWXsj convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 23 Feb 2011 18:48:39 -0500
Received: from mail-vx0-f174.google.com ([209.85.220.174]:40611 "EHLO
	mail-vx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753516Ab1BWXsj convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 23 Feb 2011 18:48:39 -0500
Received: by vxi39 with SMTP id 39so3442715vxi.19
        for <git@vger.kernel.org>; Wed, 23 Feb 2011 15:48:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:date:from:to:cc:subject:message-id:references
         :mime-version:content-type:content-disposition
         :content-transfer-encoding:in-reply-to:user-agent;
        bh=rNondpep7ViHDGZMlOmxr019VlXPUJG9buskHRJH3ms=;
        b=PErU7YF5Z/PuGXhH1D4PKr5G+1vdyT6w7paJucPzigYAV2Za4cNqv9Gj+lp8Z8m7ZE
         6xeILOy+/ROZn1C/ZchNaovpp+h1ijN1pwGs0KXQIjzEm7JXswGrgf30tFe0ZHVgWJty
         gEJqAUPlgPHuKsWuzYzyDgX6UwekD5qpWiVns=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        b=m8W5UflDPr2HIh72Yb5FICBEc2+bw5kmj7+Ow37kZTvbelc7Y7OzVBsyu7NPy4hK3o
         2jVwlZJOw2ZDvYoSu8dUzFGu31zLoAm++pfN5+ifW8NpGdaAkUU4KmCgrt9HGb1bFHdw
         s+69cRHzhPGqJmw1++2gTwnidMmRUAHF6uE38=
Received: by 10.52.90.13 with SMTP id bs13mr134692vdb.309.1298504918211;
        Wed, 23 Feb 2011 15:48:38 -0800 (PST)
Received: from elie (adsl-69-209-53-52.dsl.chcgil.sbcglobal.net [69.209.53.52])
        by mx.google.com with ESMTPS id p8sm3880300vcr.42.2011.02.23.15.48.36
        (version=SSLv3 cipher=OTHER);
        Wed, 23 Feb 2011 15:48:37 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <7v1v2y5o3p.fsf@alter.siamese.dyndns.org>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/167745>

Junio C Hamano wrote:

> * ab/i18n (2011-02-22) 73 commits
[...]
>  - i18n: do not poison translations unless GIT_GETTEXT_POISON envvar =
is set
>  - i18n: add GETTEXT_POISON to simulate translated messages unfriendl=
y translator
>  - i18n: add no-op _() and N_() wrappers
>
> Re^4-roll, coordinated between =C3=86var and Jonathan.
>
> I'd like to fast-track the basics (especially the bottom 3 patches), =
and
> am even tempted to rebase other patches on 'pu' that are not yet in '=
next'
> on top of them, to make the transition easier, so please lend extra s=
ets
> of eyeballs on an earlier ones to make sure they are sane (I thought =
they
> were, but I am far from perfect).

The commit message for the second one seems to have been mangled:

	i18n: add GETTEXT_POISON to simulate translated messages unfriendly tr=
anslator

Before, it said "simulate unfriendly translator", as in "turn on this
option to see what the translator from hell could do to your program".
(Well, it's not _that_ bad because it takes out format strings.)

I still don't like the #-sign business in this commit.  Couldn't it
be split into a separate patch, not to be applied until just before
the strings in commit/tag/wt-status are marked for translation?

There is also a patch out there to make this use rot13, which I am
somewhat fond of.  Unfortunately, it leaks (because it is not clear
how long translated strings are supposed to last).

I'd be happy with renaming use_poison() to gettext_poison() or
similar.  I suppose that is not urgent.

Regards,
Jonathan
