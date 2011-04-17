From: Pau Garcia i Quiles <pgquiles@elpauer.org>
Subject: Re: The future of gitweb - part 2: JavaScript
Date: Sun, 17 Apr 2011 17:14:43 +0200
Message-ID: <BANLkTin80KQzp9=2Bu4rxJSwcnUj-aXaHw@mail.gmail.com>
References: <201102142039.59416.jnareb@gmail.com> <201104141154.55078.jnareb@gmail.com>
 <BANLkTikNfTWuSM1yscUZVqgQk-EyPZL58A@mail.gmail.com> <201104171659.02950.jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, John Hawley <warthog9@kernel.org>,
	Kevin Cernekee <cernekee@gmail.com>,
	Petr Baudis <pasky@suse.cz>, Petr Baudis <pasky@ucw.cz>
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Sun Apr 17 17:15:12 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QBTgt-0004Yn-KW
	for gcvg-git-2@lo.gmane.org; Sun, 17 Apr 2011 17:15:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754119Ab1DQPPH convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 17 Apr 2011 11:15:07 -0400
Received: from mail-px0-f179.google.com ([209.85.212.179]:33256 "EHLO
	mail-px0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752439Ab1DQPPF convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 17 Apr 2011 11:15:05 -0400
Received: by pxi2 with SMTP id 2so2705365pxi.10
        for <git@vger.kernel.org>; Sun, 17 Apr 2011 08:15:04 -0700 (PDT)
Received: by 10.68.48.38 with SMTP id i6mr5255700pbn.514.1303053303100; Sun,
 17 Apr 2011 08:15:03 -0700 (PDT)
Received: by 10.68.55.163 with HTTP; Sun, 17 Apr 2011 08:14:43 -0700 (PDT)
In-Reply-To: <201104171659.02950.jnareb@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/171724>

On Sun, Apr 17, 2011 at 4:59 PM, Jakub Narebski <jnareb@gmail.com> wrot=
e:

>> My suggestion is going to be tremendously unpopular, but still: if I
>> were to develop my own gitweb, I'd use Wt ( http://webtoolkit.eu ) +
>> libgit2. In fact, there is a very basic gitweb-like example bundled
>> with Wt sources, it's available online at
>> http://www.webtoolkit.eu/wt/examples/git
>
> Well, nothing prevents you or anybody else from writing (yet another)
> web interface in C++ + Wt + libgit2.

I do not have the slightest intention of doing that, at least not in
my spare time. The existing interfaces (gitweb, cgit, etc) are good
enough for me. I made the suggestion of going with Wt just in case a
rewrite of gitweb was in mind.

> Gitweb has the advantage that if you can install git, and you have we=
b
> server with CGI support, you can install and run gitweb. =A0First par=
t
> of series was about relaxing this "no non-core dependencies required"
> requirement. =A0Requiring to install C++ / libstdc++, Boost and Wt...

Sure, that's why I mentioned the dependencies. No dependencies is a
major feature in itself in some environments.

> BTW. do I understand correctly that Wt generates JavaScript code, in
> similar vein to GWT for Java, or Pyjamas for Python?

Wt generates Javascript only if the visitor has Javascript enabled. If
Javascript is not available, it will generate plain HTML pages, with
"update" buttons, etc and it will do that automatically: there is no
need for you to write code "if Javascript is available { ... } else {
=2E.. }".

The advantage of Wt is you can compile a hypothetical gitwebwt as a
static executable and the result will be a single executable file that
depends only on libc (or libc + git, if you call git instead of
linking to libgit.a or libgit2). Also, performance and memory
requirements are very good, which is important for not-that-powerful
devices such as routers, etc.

--=20
Pau Garcia i Quiles
http://www.elpauer.org
(Due to my workload, I may need 10 days to answer)
