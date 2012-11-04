From: Tay Ray Chuan <rctay89@gmail.com>
Subject: Re: Wrap commit messages on `git commit -m`
Date: Sun, 4 Nov 2012 01:27:05 -0600
Message-ID: <CALUzUxrdCw6nPLzeLHij+CjHsPO3w=e0nUdjBL=P7rqJtZ+t3A@mail.gmail.com>
References: <CALkWK0kQ+qCsOa87yY4wma279mp+9h+LFv3qCP_qrNdDyGNcsQ@mail.gmail.com>
 <m3a9v170ca.fsf@black.gullik.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Ramkumar Ramachandra <artagnon@gmail.com>, git@vger.kernel.org
To: =?ISO-8859-1?Q?Lars_Gullik_Bj=F8nnes?= <larsbj@gullik.org>
X-From: git-owner@vger.kernel.org Sun Nov 04 08:28:35 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TUudG-0004ms-6i
	for gcvg-git-2@plane.gmane.org; Sun, 04 Nov 2012 08:28:34 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752138Ab2KDH1c convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 4 Nov 2012 02:27:32 -0500
Received: from mail-ob0-f174.google.com ([209.85.214.174]:52890 "EHLO
	mail-ob0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752128Ab2KDH1c convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 4 Nov 2012 02:27:32 -0500
Received: by mail-ob0-f174.google.com with SMTP id uo13so4809443obb.19
        for <git@vger.kernel.org>; Sun, 04 Nov 2012 00:27:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        bh=fRYH/LAsoJXUrytCd6xNafFZQAZKj613U45khLTkly8=;
        b=ltxDtTMgoRmCr0oZ+v+/JlN451KU2sjF04OjLc4mGNEs5uK9/UvsOSaR0JN2wXUns0
         36VsLCTehxhOtI01ouq6SV+gk5GGElE+Clf9YQ9eQuwAYj5/4lYu2BbLNIFvQYyUxoc6
         BGI0uTB9WsakNW8kn6j0c7OgywIHwYr/CWjXeOtIP1tDg0BxqetRAIA8qm9D43lSrXEe
         /f84uINYcYJslUIoRHOdm3jLkhJaNuxArartGPdytn0A4y1gWYuJH0vuUaAMBy0eHhJw
         wsb18Nge6dAezYtkBGSBrKyJt2wzmGXA5ZdHr8W0Bcxzfr/ZmUruQyhENezdxWeT+LEu
         fEsA==
Received: by 10.182.64.34 with SMTP id l2mr5208475obs.28.1352014046412; Sun,
 04 Nov 2012 00:27:26 -0700 (PDT)
Received: by 10.76.151.166 with HTTP; Sun, 4 Nov 2012 00:27:05 -0700 (PDT)
In-Reply-To: <m3a9v170ca.fsf@black.gullik.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/209021>

On Thu, Nov 1, 2012 at 11:29 AM, Lars Gullik Bj=F8nnes <larsbj@gullik.o=
rg> wrote:
> Ramkumar Ramachandra <artagnon@gmail.com> writes:
>
> | Hi,
>>
> | Some of my colleagues are lazy to fire up an editor and write prope=
r
> | commit messages- they often write one-liners using `git commit -m`.
> | However, that line turns out to be longer than 72 characters, and t=
he
> | resulting `git log` output is ugly.  So, I was wondering if it woul=
d
> | be a good idea to wrap these one-liners to 72 characters
> | automatically.
>
> git commit -m 'foo: fix this problem
>
> This problem is fixed by doing foo,
> bar and baz.
>
> Signed-off-by: me
> '
>
> works.

Perhaps a deeper issue is that the implicit email format
(subject-body) for commit messages, is, well, implicit. New users of
git who type git-commit -m '...' isn't going to know that those few
characters will all be lumped on a "subject" line, forever screwing
themselves when they review the output of git-log, git-rebase
--interactive, etc. (can't remember off the top of my head if
git-format-patch would chop off long subjects and move it to the
body), which may be a significant period of time (and thus commits)
later.

While I don't have any ideas on how to improve on this, hopefully this
gets recognized as an issue in the first place.

--=20
Cheers,
Ray Chuan
