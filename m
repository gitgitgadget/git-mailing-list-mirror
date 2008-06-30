From: Junio C Hamano <gitster@pobox.com>
Subject: Re: What's cooking in git.git (topics)
Date: Mon, 30 Jun 2008 15:15:52 -0700
Message-ID: <7vabh2vaav.fsf@gitster.siamese.dyndns.org>
References: <7vlk4snpj3.fsf@gitster.siamese.dyndns.org>
 <7vhcehzdeg.fsf@gitster.siamese.dyndns.org>
 <7vbq4j748l.fsf@gitster.siamese.dyndns.org>
 <7vr6d8apjx.fsf@gitster.siamese.dyndns.org>
 <7vhcdyfe9u.fsf@gitster.siamese.dyndns.org>
 <7vabjm1a0q.fsf@gitster.siamese.dyndns.org>
 <7vr6crj0jk.fsf@gitster.siamese.dyndns.org>
 <7vmyn4hr8f.fsf@gitster.siamese.dyndns.org>
 <7vmymsjz6x.fsf@gitster.siamese.dyndns.org>
 <7vabijxhk4.fsf@gitster.siamese.dyndns.org>
 <7vwslhg8qe.fsf@gitster.siamese.dyndns.org>
 <7vhccfiksy.fsf@gitster.siamese.dyndns.org>
 <7vod6k6zg4.fsf@gitster.siamese.dyndns.org>
 <7v4p7xwsfp.fsf@gitster.siamese.dyndns.org>
 <7v3anb19n7.fsf@gitster.siamese.dyndns.org>
 <7vwskjazql.fsf@gitster.siamese.dyndns.org>
 <7vk5ggipuw.fsf@gitster.siamese.dyndns.org>
 <7vej6l3lp7.fsf@gitster.siamese.dyndns.org>
 <7vod5kd3im.fsf@gitster.siamese.dyndns.org>
 <7v3amv1e8n.fsf@gitster.siamese.dyndns.org>
 <1214834970.3382.4.camel@gaara.bos.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, akpm@linux-foundation.org,
	Stephen Rothwell <sfr@canb.auug.org.au>, pasky@suse.cz
To: Kristian =?utf-8?Q?H=C3=B8gsberg?= <krh@redhat.com>
X-From: git-owner@vger.kernel.org Tue Jul 01 00:17:18 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KDRgS-0006uk-DT
	for gcvg-git-2@gmane.org; Tue, 01 Jul 2008 00:17:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932587AbYF3WQJ convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 30 Jun 2008 18:16:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1762094AbYF3WQH
	(ORCPT <rfc822;git-outgoing>); Mon, 30 Jun 2008 18:16:07 -0400
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:61181 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752856AbYF3WQG convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 30 Jun 2008 18:16:06 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id 3064B18923;
	Mon, 30 Jun 2008 18:16:05 -0400 (EDT)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with
 ESMTPSA id F358818922; Mon, 30 Jun 2008 18:15:56 -0400 (EDT)
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 21AAC8F8-46F2-11DD-A605-CE28B26B55AE-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/86946>

Kristian H=C3=B8gsberg <krh@redhat.com> writes:

> On Mon, 2008-06-30 at 02:08 -0700, Junio C Hamano wrote:
> ...
>> It already is beginning to become clear what 1.6.0 will look like.  =
What's
>> already in 'next' all are well intentioned (I do not guarantee they =
are
>> already bug-free --- that is what cooking them in 'next' is for) and=
 are
>> good set of feature enhancements.  Bigger changes will be:
> ...
> A small detail I've suggested scheduling for 1.6 before is removing (=
or
> rather, stop creating) the empty .git/branches directory.  How does t=
hat
> sound?

What's the benefit of the removal that outweighs the downside?  I can
imagine two contradicting voices from new end users.

 (1) With current git, I ran "git init" and I have an empty
     .git/branches/, but my remote information created with "git clone"
     and "git remote add" all go to .git/config these days.  Why do I h=
ave
     to have this empty directory that I do not use?

 (2) It is documented that "git fetch" can use files in .git/branches/ =
as
     the source specification, but when I ran "git init", it does not
     create the directory with Kristian's git. I need to do an extra
     "mkdir .git/branches/" myself.  Why?

You are obviously coming from the former camp, but do you have a good
answer to people from the other camp?

I do not recall if Cogito required to have .git/branches created by us =
or
it can create it on demand if we don't.  If the latter, that would be
great, otherwise remaining users would be in the latter camp as well, a=
nd
we may have to make sure Cogito is really dead already (or wait for it =
to
die), or Cogito gets updated for its remaining users to tolerate the
initial lack of the directory (and wait for that version percolates dow=
n
to the users).

Some people rely on (or at least "like") the convenience of being able =
to
create a single-liner file in .git/branches/ to easily add, and remove
such a file to easily remove where they integrate from.  This is
especially so when they have dozens of source repositories to fetch fro=
m.
I do not think we want to remove support for .git/branches as a way to
specify fetch sources (this is why I am CC'ing Andrew who I know uses
branches, and Stephen who is also a heavy integrator even though I do n=
ot
know if he is in branches camp or uses more modern style), but they now
have to do an extra "mkdir .git/branches" after "git init" to continue
their workflow if we adopt the change you are proposing here.  It is no=
t a
big deal, but it still is a backward incompatible change.
