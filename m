From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: git status during interactive rebase
Date: Thu, 21 Jan 2016 10:28:29 +0100 (CET)
Message-ID: <alpine.DEB.2.20.1601211016140.2964@virtualbox>
References: <CAGZ79kbUwJ+CN=YoQUP=rm=EhU=fU2ynt_7Q-cd7Dic-bsx+TA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: "git@vger.kernel.org" <git@vger.kernel.org>,
	Guillaume Pages <guillaume.pages@ensimag.grenoble-inp.fr>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
To: Stefan Beller <sbeller@google.com>
X-From: git-owner@vger.kernel.org Thu Jan 21 10:28:42 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aMBXk-0002B0-Jb
	for gcvg-git-2@plane.gmane.org; Thu, 21 Jan 2016 10:28:40 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758995AbcAUJ2g (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 21 Jan 2016 04:28:36 -0500
Received: from mout.gmx.net ([212.227.17.22]:50590 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757467AbcAUJ2e (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 21 Jan 2016 04:28:34 -0500
Received: from virtualbox ([37.24.143.74]) by mail.gmx.com (mrgmx102) with
 ESMTPSA (Nemesis) id 0MRB8F-1aZ9RQ0azP-00UcwU; Thu, 21 Jan 2016 10:28:31
 +0100
X-X-Sender: virtualbox@virtualbox
In-Reply-To: <CAGZ79kbUwJ+CN=YoQUP=rm=EhU=fU2ynt_7Q-cd7Dic-bsx+TA@mail.gmail.com>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
X-Provags-ID: V03:K0:hVtPzY9DssInzfZtptxjyWzB+atprouIuXtkjYGsfrx+HkcNEdp
 cqeRphS+Elc3yZqmvbJQrALdNZu5yWF3ReN01ZFsU320o6xVmjkKGeHFDdB5f+PGkTCmyn0
 /Hfzlo4+vD5m041+rUlgU40MLjbud1c4K2qLORsC8Hav+MdNtzU6SwmmY/ww1P6rQx8mthD
 wHi6gYT/+roQTzynClXwA==
X-UI-Out-Filterresults: notjunk:1;V01:K0:DpUb2CSrPUM=:lHI0vALl2Bfracjlx/sFiE
 b0RE6lh15KJW4Gwo1w6AiT408T5SvLxgkIg/UaUpkxY7uVQ6jVFN+koOEIgJzjze2oElzbK3t
 minS+XtdKM6ORLNG/qdhqHOWCBtNf/MwA0J7rlvlI3MyahDIAUrT1tEK+fAp3LHeSaz/N8YhF
 PT9tq3x1jjDyxKlHvBDcrVlk2CESigyLF0HMvPXuYa74od5F8+PvIsfNB/VRPNzUqIrqZPuIz
 cKBqXH3QagWotG0Yz6xm43UMi/gmSZ8orWEDDybEnZAEVcXKGcyXhk9FVRNmsCdudmWtSUfsU
 LDnTOoQELcOIxfnmTImGLgDzzikBMgdC2DOQqM8BnqNKNnPAvo8aDlijCVYE5Rs7mJixLk0gt
 mLPPikyp7qXA+aqRwc9De0LlQcnOjGHZnmYiVbOfC3NSiWJeJKHR0XfMT3Lf1PYnxX8iVATmQ
 WRewapm0qvAoecQNxeXD6RvhPwf9DuR7jST6f20G+9BJ8CHg9KntxixfJIut2divMZkIBvyC4
 5cF68j9kU5iq1EOEV6cNkLAknE+xx5rfsiZJFttQa6Mj+gOSVfZtGLvV3Xbo4WBBkgsfhCcdA
 cBIsS0JYpY0mcb5ytCgvtqA7oTFKChkXPGlKFrKSCD3S2sShxuOmvZPtXOeAPeLztEB1IMpTq
 +GSYBlvkMI7yEO/sdqqZcUgur932TFUfgY7geVpVeUXwyfHymsHY6iThI22nnbMRg2YQw7MTs
 IiQqoS0P2Ibn4VCD2ZUiJxyAQIOVpWpFRi3SG/396P7257txsat6uXmO+p/oqZTGVbP2ZTFH 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/284508>

Hi Stefan,

On Wed, 20 Jan 2016, Stefan Beller wrote:

> So I ran an interactive rebase, and while editing
> .git/rebase-merge/git-rebase-todo I tried to run
> `git status` in another terminal to inquire about a
> filename of an untracked file.

Heh, I don't think that anybody did that before, because the rebase has
not even quite started yet...

The cop-out would be to write an empty 'done' file before editing the
todo, but it would give the wrong impression that it is safe to run `git
rebase --continue` now... Interactive rebase is *definitely* not
thread-safe ;-)

So the proper fix might be to test for the presence of the "done" file and
otherwise tell the user that this rebase has not even started yet.

Ciao,
Dscho
