From: Marc Branchaud <marcnarc@xiplink.com>
Subject: Re: RFC: Supporting .git/hooks/$NAME.d/* && /etc/git/hooks/$NAME.d/*
Date: Tue, 26 Apr 2016 09:40:05 -0400
Message-ID: <571F6FB5.2000305@xiplink.com>
References: <CACBZZX6j6q2DUN_Z-Pnent1u714dVNPFBrL_PiEQyLmCzLUVxg@mail.gmail.com>
 <xmqq4mapmvjq.fsf@gitster.mtv.corp.google.com>
 <CACBZZX6AYBYeb5S4nEBhYbx1r=icJ81JGYBx5=H4wacPhHjFbQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git <git@vger.kernel.org>
To: =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
	Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Apr 26 15:46:59 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1av3KK-0005D2-9w
	for gcvg-git-2@plane.gmane.org; Tue, 26 Apr 2016 15:46:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751966AbcDZNqk convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 26 Apr 2016 09:46:40 -0400
Received: from smtp98.iad3a.emailsrvr.com ([173.203.187.98]:57115 "EHLO
	smtp98.iad3a.emailsrvr.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751815AbcDZNqk (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 26 Apr 2016 09:46:40 -0400
X-Greylist: delayed 392 seconds by postgrey-1.27 at vger.kernel.org; Tue, 26 Apr 2016 09:46:39 EDT
Received: from smtp29.relay.iad3a.emailsrvr.com (localhost.localdomain [127.0.0.1])
	by smtp29.relay.iad3a.emailsrvr.com (SMTP Server) with ESMTP id DF50D380554;
	Tue, 26 Apr 2016 09:40:06 -0400 (EDT)
X-Auth-ID: mbranchaud@xiplink.com
Received: by smtp29.relay.iad3a.emailsrvr.com (Authenticated sender: mbranchaud-AT-xiplink.com) with ESMTPSA id 592A0380119;
	Tue, 26 Apr 2016 09:40:06 -0400 (EDT)
X-Sender-Id: mbranchaud@xiplink.com
Received: from [10.10.1.32] ([UNAVAILABLE]. [192.252.130.194])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA)
	by 0.0.0.0:465 (trex/5.5.4);
	Tue, 26 Apr 2016 09:40:06 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:38.0) Gecko/20100101
 Thunderbird/38.6.0
In-Reply-To: <CACBZZX6AYBYeb5S4nEBhYbx1r=icJ81JGYBx5=H4wacPhHjFbQ@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/292600>

On 2016-04-26 06:58 AM, =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason wrote:
>=20
> Makes sense to have an experimental.* config tree for git for stuff l=
ike this.

I disagree.

* If the point is to express some kind of warning to users, I think the
community has been much better served by leaving experimental settings
undocumented (or documented only in unmerged topic branches).  It feels=
 like
an experimental.* tree is a doorway to putting experimental features in
official releases, which seems odd considering that (IMHO) git has so f=
ar
done very well with the carefully-planned-out integration of all sorts =
of
features.

* Part of the experiment is coming up with appropriate configuration kn=
obs,
including where those knobs should live.  Often such considerations lea=
d to a
better implementation for the feature.  Dumping things into an experime=
ntal.*
tree would merely postpone that part of the feature's design.

* Such a tree creates a flag day when the experimental feature eventual=
ly
becomes a "real" feature. That'll annoy any early adopters. Sure, they
*should* be prepared to deal with config tree bike-shedding, but still =
that
extra churn seems unnecessary.

		M.
