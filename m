From: Paolo Giarrusso <p.giarrusso@gmail.com>
Subject: Re: Fwd: [PATCH] git-subtree: Avoid using echo -n even indirectly
Date: Mon, 28 Oct 2013 15:04:13 +0100
Message-ID: <CAAcnjCRcU8L+F3BuGtm2c+XJxyVsROyY1pwVynK9qdvS8zfFZw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Tay Ray Chuan <rctay89@gmail.com>,
	Git Mailing List <git@vger.kernel.org>,
	"David A. Greene" <greened@obbligato.org>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Mon Oct 28 15:04:40 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VanQt-0002E2-RR
	for gcvg-git-2@plane.gmane.org; Mon, 28 Oct 2013 15:04:40 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756380Ab3J1OEf convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 28 Oct 2013 10:04:35 -0400
Received: from mail-lb0-f176.google.com ([209.85.217.176]:51854 "EHLO
	mail-lb0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756032Ab3J1OEf convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 28 Oct 2013 10:04:35 -0400
Received: by mail-lb0-f176.google.com with SMTP id z5so2817632lbh.7
        for <git@vger.kernel.org>; Mon, 28 Oct 2013 07:04:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:from:date:message-id:subject:to:cc:content-type
         :content-transfer-encoding;
        bh=0UjAjnVkrMOZTXRvME+ffuld2sb5Jq0wEbgQehg1veA=;
        b=OJkElgIHbD0UYlemBwhAeIY7iUTDQXNrnE8KMKeIFinYe7CQEV5u4/Tr+acr+M/mav
         Ix+sc2iMyfpLr09VX6EB9RT+D3caPUlEmczQJL0UA0Ulq3iS/cRIG9VLTiDMnP3sdy94
         OEvL3r+6czonzO4wEAOs5iaJQ3B9Cq8HdfvEF/kexAV8pkTDCWMvH5sdNSSq1ZexMHaN
         0mI3qh1j4830Sqt8g6J2XIYuRJ8vbuqUXyncsntUXyCFtuYQQcdpEYNpm5oCtf5SShuN
         2/3OXhEo5eHLfcrthcUZdZDkWMm+qWmpSMNYJN0hPDnETThcZd0u0fGZp9SQ+xkTtSuw
         XhFg==
X-Received: by 10.152.202.167 with SMTP id kj7mr1316668lac.43.1382969073495;
 Mon, 28 Oct 2013 07:04:33 -0700 (PDT)
Received: by 10.112.190.102 with HTTP; Mon, 28 Oct 2013 07:04:13 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/236830>

(Resending without HTML, so that it reaches the ML).

On Fri, Oct 11, 2013 at 11:32 AM, Paolo Giarrusso <p.giarrusso@gmail.co=
m> wrote:
>
> On Wed, Oct 9, 2013 at 11:11 PM, Jonathan Nieder <jrnieder@gmail.com>=
 wrote:
> > Paolo Giarrusso wrote:
> >
> >> Seeing the email, I wonder whether there's hope something like tha=
t
> >> can be preserved in an email, and whether the code should use some
> >> escape sequence instead.
> >
> > Yes, please.  Mind if I amend it to
> >
> >         printf "%s\r" "$revcount/$revmax ($createcount)" >&2
> >
> > ?
>
> Please do go ahead, by all means (arguably as a different commit, but
> those are minor details).

What happened? Did you go ahead, as you wrote? Is the patch somewhere?
Arguably it should go into the maint branch, but I think it didn't =E2=80=
=94
otherwise https://github.com/git/git/pull/61 should have stopped being
mergeable.

This also makes me wonder whether you use any tracker at all =E2=80=94 =
but
unless there is one that I missed, that's a separate discussion.

> > [...]
> >>>         say()
> >>>         {
> >>>                 if [ -z "$quiet" ]; then
> >>>                         echo "$@" >&2
> >>>                fi
> >>>         }
> >
> > I agree with the other reviewers that this should be fixed to use
> > printf, too, but that's another topic.
> Seconded.

--=20
Paolo G. Giarrusso - Ph.D. Student, Philipps-University Marburg
http://www.informatik.uni-marburg.de/~pgiarrusso/
