From: Marc Branchaud <mbranchaud@xiplink.com>
Subject: Re: [RFC] Add a new email notification script to "contrib"
Date: Thu, 08 Nov 2012 11:24:35 -0500
Message-ID: <509BDCC3.1050107@xiplink.com>
References: <1342249182-5937-1-git-send-email-mhagger@alum.mit.edu> <50092C8C.3000305@alum.mit.edu> <CACBZZX6=e6_qO=wMcxLdUAc6XxYpdiP-9RPRsCXrVC_iuJ11Jg@mail.gmail.com> <509B7E6B.1030407@alum.mit.edu> <CACBZZX5FihEMSyrws-D7GyWvxtpMCPwvaiM18ZqOBaoBcvEjDA@mail.gmail.com> <509BA2E7.4080102@alum.mit.edu>
Reply-To: marcnarc@xiplink.com
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
	git@vger.kernel.org, Andy Parkins <andyparkins@gmail.com>,
	Sitaram Chamarty <sitaramc@gmail.com>,
	=?UTF-8?B?U3RlZmFuIE7DpHdl?= <stefan.naewe@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
To: Michael Haggerty <mhagger@alum.mit.edu>
X-From: git-owner@vger.kernel.org Thu Nov 08 17:24:46 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TWUuL-0000Mv-Aj
	for gcvg-git-2@plane.gmane.org; Thu, 08 Nov 2012 17:24:45 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756290Ab2KHQYc convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 8 Nov 2012 11:24:32 -0500
Received: from smtp154.ord.emailsrvr.com ([173.203.6.154]:36319 "EHLO
	smtp154.ord.emailsrvr.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755672Ab2KHQYb (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 8 Nov 2012 11:24:31 -0500
X-Greylist: delayed 1243 seconds by postgrey-1.27 at vger.kernel.org; Thu, 08 Nov 2012 11:24:31 EST
Received: from localhost (localhost.localdomain [127.0.0.1])
	by smtp24.relay.ord1a.emailsrvr.com (SMTP Server) with ESMTP id E2D3919824C;
	Thu,  8 Nov 2012 11:24:30 -0500 (EST)
X-Virus-Scanned: OK
Received: by smtp24.relay.ord1a.emailsrvr.com (Authenticated sender: mbranchaud-AT-xiplink.com) with ESMTPSA id 3716D19823B;
	Thu,  8 Nov 2012 11:24:30 -0500 (EST)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:16.0) Gecko/20121028 Thunderbird/16.0.2
In-Reply-To: <509BA2E7.4080102@alum.mit.edu>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/209169>

On 12-11-08 07:17 AM, Michael Haggerty wrote:
> On 11/08/2012 12:39 PM, =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason wrote:
>> [...]
>=20
> I'm glad it's getting some use.  Thanks for the feedback.
>=20
>> I'll test it out some more, the issues I've had with it so far in
>> migrating from the existing script + some custom hacks we have to it
>> have been:
>>
>>  * Overly verbose default templates, easy to overwrite now. Might se=
nd
>>    patches for some of them.
>=20
> The templating is currently not super flexible nor very well document=
ed,
> but simple changes should be easy enough.  I mostly carried over the
> text explanations from the old post-receive-email script; it is true
> that they are quite verbose.
>=20
>>  * No ability to link to a custom gitweb, probably easy now.
>=20
> What do you mean by "a custom gitweb"?  What are the commitmail issue=
s
> involved?

We would also like to have a gitweb link in the summary email, like =C3=
=86var
describes.

>>  * If someone only pushes one commit I'd like to only have one e-mai=
l
>>    with the diff, but if they push multiple commits I'd like to have=
 a
>>    summary e-mail and replies to that which have the patches.
>>
>>    It only seemed to support the latter mode, so you send out two
>>    e-mails for pushing one commit.
>=20
> That's correct, and I've also thought about the feature that you
> described.  I think it would be pretty easy to implement; it is only =
not
> quite obvious to which mailing list(s?) such emails should be sent.

Overall, what should be the approach to the separate mailing lists?

Maybe I don't understand how the script is meant to work.  We configure=
d
things here with 'mailinglist' and 'commitlist' set to different lists.=
  Now
if someone wants to get both the summary and per-commit emails, they ne=
ed to
be on both lists.  If I understand correctly, if all 4 mailing lists ar=
e
distinct, someone who wants all the emails needs to be on all of them. =
 This
seems a little awkward.

I'd like there to be one list that always gets everything, and the othe=
r
lists should get subsets of the everything list.

		M.
