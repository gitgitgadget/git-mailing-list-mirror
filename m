From: Johan Herland <johan@herland.net>
Subject: Re: [RFD] Rewriting safety - warn before/when rewriting published history
Date: Sat, 11 Feb 2012 14:10:48 +0100
Message-ID: <CALKQrgdWOgG3y2HzM694zDykGJWa4QDetsEVXf0AGpf=FNFaVg@mail.gmail.com>
References: <201202042045.54114.jnareb@gmail.com>
	<201202071531.08385.jnareb@gmail.com>
	<CALKQrge821x7OoSekkWw7vUjP642jhbE0D9oWPcCxuuTXOqQHA@mail.gmail.com>
	<201202102038.55710.jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Philip Oakley <philipoakley@iee.org>, git@vger.kernel.org
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Sat Feb 11 14:11:02 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RwCjD-0007Rr-3g
	for gcvg-git-2@plane.gmane.org; Sat, 11 Feb 2012 14:10:59 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755207Ab2BKNKy convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 11 Feb 2012 08:10:54 -0500
Received: from locusts.copyleft.no ([178.255.144.241]:51247 "EHLO
	mail.mailgateway.no" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755088Ab2BKNKy convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 11 Feb 2012 08:10:54 -0500
Received: from mail-iy0-f174.google.com ([209.85.210.174])
	by mail.mailgateway.no with esmtpsa (TLSv1:RC4-SHA:128)
	(Exim 4.72 (FreeBSD))
	(envelope-from <johan@herland.net>)
	id 1RwCj6-000ERx-F1
	for git@vger.kernel.org; Sat, 11 Feb 2012 14:10:52 +0100
Received: by iacb35 with SMTP id b35so1612038iac.19
        for <git@vger.kernel.org>; Sat, 11 Feb 2012 05:10:48 -0800 (PST)
Received: by 10.50.85.227 with SMTP id k3mr17110726igz.17.1328965848899; Sat,
 11 Feb 2012 05:10:48 -0800 (PST)
Received: by 10.42.226.9 with HTTP; Sat, 11 Feb 2012 05:10:48 -0800 (PST)
In-Reply-To: <201202102038.55710.jnareb@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/190512>

On Fri, Feb 10, 2012 at 20:38, Jakub Narebski <jnareb@gmail.com> wrote:
> On Tue, 7 Feb 2012, Johan Herland wrote:
>> On Tue, Feb 7, 2012 at 15:31, Jakub Narebski <jnareb@gmail.com> wrot=
e:
>> I am unsure whether the 'secret'-ness of a commit should follow acro=
ss
>> the push, but if you do (assuming we store the 'secret' flag using
>> git-notes) this is simply a matter of synchronizing the
>> refs/notes/secret to the same remote.
>
> I think it should, so that 'secret' commit would not escape by accide=
nt
> via a group secret repository.
>
> What makes it hard (I think) is that we would prefer to transfer
> 'secret'-ness only for pushed commits. =C2=A0That might be problem fo=
r notes
> based implementation of 'secret' annotation and 'secret'-ness transfe=
r...
> though I guess knowing that there exist 'secret' commit with given SH=
A1
> which we do not have and should not have is not much breach of
> confidentiality. =C2=A0Still...

If you don't want to transfer all of refs/notes/secret, you would
probably have to extend the git protocol with a per-commit 'secret'
flag (which would then be applied to the receiving repo's
refs/notes/secret).

Still, this is all specific to the 'secret' feature, which IMHO is
much less important then the 'public' feature. Implementing the
barebones 'public' feature (i.e. refuse rewrite of commits reachable
from upstream) is much less work, and would be enough for 90% of git
users, I believe.


=2E..Johan

--=20
Johan Herland, <johan@herland.net>
www.herland.net
