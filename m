From: =?UTF-8?B?SmFrdWIgTmFyxJlic2tp?= <jnareb@gmail.com>
Subject: Re: [PATCH] t3700 (add): add failing test for add with submodules
Date: Tue, 09 Apr 2013 15:49:39 +0200
Message-ID: <51641C73.9080006@gmail.com>
References: <CACsJy8BAQUms9sgNh5_VFOx0_9LkobytjDk33VB+U_J-S44o_A@mail.gmail.com> <1365416809-4396-1-git-send-email-artagnon@gmail.com> <20130408213006.GD9649@sigill.intra.peff.net> <5163FED4.8070403@gmail.com> <CALkWK0nMQbk3JQ1yX+uv3Eot3qbEvsWGSqVpg8UnoVXP=g_M7A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Jeff King <peff@peff.net>, Duy Nguyen <pclouds@gmail.com>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Git List <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>,
	Linus Torvalds <torvalds@linux-foundation.org>
To: Ramkumar Ramachandra <artagnon@gmail.com>
X-From: git-owner@vger.kernel.org Tue Apr 09 15:51:33 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UPYxP-0006cz-3m
	for gcvg-git-2@plane.gmane.org; Tue, 09 Apr 2013 15:51:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1761924Ab3DINuO convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 9 Apr 2013 09:50:14 -0400
Received: from mail-ea0-f178.google.com ([209.85.215.178]:43687 "EHLO
	mail-ea0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1760703Ab3DINtp (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 9 Apr 2013 09:49:45 -0400
Received: by mail-ea0-f178.google.com with SMTP id o10so2929267eaj.9
        for <git@vger.kernel.org>; Tue, 09 Apr 2013 06:49:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:message-id:date:from:user-agent:mime-version:to:cc
         :subject:references:in-reply-to:x-enigmail-version:content-type
         :content-transfer-encoding;
        bh=A+tRXXjroxwsMmfK2E6cNE8HZxc0PAjoTyDpg5hOMY4=;
        b=I8q7jAul3M9XptB3tTkWMrZVSiDr3mhLzBPUy0dcYwcnYWs/rzQzJevIts8Qu9hr/l
         7E118m76j+UxrsGHINZgekGjnOxBTSVVXJy3PWDd1BCAalod6fqm7m5pgw6Xcgztao6a
         PafLwBAGbxuVx+go8sJMgDFrHAzqEX+0C8/3kpH+A2FaNF9pOTJR7anoARpcn6mGT9ox
         yRItqJYkI2EDmojyX3VHg6mpPTPkPBSD2ysneAcZkp/CN0Rw3ZlGWWbymYVAhPOxbvYC
         pu8rRvFl6zSJ5xSIpr18nvz62ypNggPKc3c4pqF1NPBPXanEsVcUYwnGntd6SJ3lntzP
         narw==
X-Received: by 10.15.31.197 with SMTP id y45mr14980328eeu.18.1365515383817;
        Tue, 09 Apr 2013 06:49:43 -0700 (PDT)
Received: from [192.168.1.14] (eio154.neoplus.adsl.tpnet.pl. [83.21.130.154])
        by mx.google.com with ESMTPS id n2sm38107633eeo.10.2013.04.09.06.49.41
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Tue, 09 Apr 2013 06:49:43 -0700 (PDT)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:17.0) Gecko/20130308 Thunderbird/17.0.4
In-Reply-To: <CALkWK0nMQbk3JQ1yX+uv3Eot3qbEvsWGSqVpg8UnoVXP=g_M7A@mail.gmail.com>
X-Enigmail-Version: 1.5.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/220569>

On 09.04.2013, Ramkumar Ramachandra wrote:
> Jakub Nar=C4=99bski wrote:

>> Hmmm... I used to do (and still do) such not-recommended thing,
>> i.e. keeping git/gitweb/TODO etc. in git/gitweb/.git repository,
>> while having git/gitweb/gitweb.perl in git/.git repository.
>=20
> Why don't you put the gitweb/TODO in a different branch in the git.gi=
t
> repository?  Why do you feel the need to have two different
> repositories tracking different files in the same path?

It is not only gitweb/TODO.  If it was only that file, I could have
used 'gitweb/todo' branch for it, or something.  Though I would be
missing having it beside gitweb.perl, and having easy access to it
during work on gitweb.perl

I want to have various files that I use when working on gitweb.perl
(but should not and would not be in gitweb subsystem in git.git
repository) to be under version control, and be side-by-side near
gitweb.perl.

These are:
* gitweb/TODO - TODO file for gitweb (personal, not often updated),
  and similar gitweb/gitwebs-whats-cooking.txt

  Might be put into 'gitweb/todo/TODO' file and 'gitweb/todo/.git'
  private repository (and perhaps 'gitweb/todo' branch of my clone
  of git.git repository).

* various *_test.perl files, where I test features to be possibly
  put into gitweb, like e.g. chop_str_test.perl or test_find_forks.perl
  (or similar benchmark_find_forks.perl)

* private personal configuration files for testing its output, like
  gitweb/gitweb_config.perl and gitweb/magic.txt !!!

  Those are very much required to reside beside gitweb/gitweb.perl
  because of default GITWEB_CONFIG value.  With those I can simply
  run current gitweb/gitweb.perl (sic!) from its directory while
  I am working on it.

> Just out of curiosity, how does stuff work with your setup?  Does the
> worktree gitweb/ belong to your gitweb.git repository or git.git
> repository?

The 'git/gitweb/' worktree belong to both repositories (it is 'gitweb/'
in git.git clone i.e. git/.git, and it is top dir of git/gitweb/.git
repository).

> How do half the git commands work?  For example, won't
> git clean -dfx remove the files tracked by your other repository?

They work, somewhat and with some care.  I don't use "git clean"
for example.

> Will a conflicting checkout not stomp files tracked by the other
> repository?  How are worktree-rules like .gitignore applied?

'git/gitweb/.gitignore' belong to 'git/gitweb/.git' repository
and is used to ignore 'git/.git' files (with the intent of marking
them untracked *precious*).  I could have used 'info/exclude'
here because this repository is for the time being private.

As gitweb subsystem in git.git is quite stable, untracked but
existing 'gitweb/.gitignore' doesn't usually matter, as all files
in 'gitweb/' are already tracked.  Besides I can always use
"git add -f" for adding to git.git if necessary (e.g. when splitting
gitweb.js etc.).

>> So my (admittedly strange) setup will stop working?
>=20
> Yes.  I would persuade you not to use such a gross setup; this is not
> what git was intended for at all.

Why not?

--=20
Jakub Nar=C4=99bski
