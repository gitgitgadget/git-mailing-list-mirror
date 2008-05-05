From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 0/2] Show committer ident in some cases
Date: Sun, 04 May 2008 22:23:14 -0700
Message-ID: <7vhcddnx31.fsf@gitster.siamese.dyndns.org>
References: <1209752541-19111-1-git-send-email-sbejar@gmail.com>
 <20080505033044.GB15498@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Santi =?utf-8?Q?B=C3=A9jar?= <sbejar@gmail.com>,
	git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Mon May 05 07:24:29 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JstBd-00022T-1o
	for gcvg-git-2@gmane.org; Mon, 05 May 2008 07:24:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752858AbYEEFXl convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 5 May 2008 01:23:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752986AbYEEFXl
	(ORCPT <rfc822;git-outgoing>); Mon, 5 May 2008 01:23:41 -0400
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:39691 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752371AbYEEFXk convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 5 May 2008 01:23:40 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id D40443D23;
	Mon,  5 May 2008 01:23:36 -0400 (EDT)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with
 ESMTP id 913313D21; Mon,  5 May 2008 01:23:29 -0400 (EDT)
In-Reply-To: <20080505033044.GB15498@sigill.intra.peff.net> (Jeff King's
 message of "Sun, 4 May 2008 23:30:44 -0400")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 69B5436E-1A63-11DD-9C98-80001473D85F-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/81232>

Jeff King <peff@peff.net> writes:

> On Fri, May 02, 2008 at 08:22:19PM +0200, Santi B=C3=A9jar wrote:
>
>> The different strategies are.. Show the committer:
>>=20
>> 1) always
>> 2) when user.warn =3D yes (defaulting to yes)
>> 3) when it is automatic
>>    a) always
>>    b) and different from parent
>>    c) and different from a list of valid committer idents
>>    d) and when user.WarnAutomatic =3D yes (defaulting to yes)
>>=20
>> The first patch implements 3a
>> The second patch implements 3d
>>=20
>> I prefer 3a.
>
> I haven't kept up to date very well with this patch, but let me add a
> (possibly belated) addendum to my earlier comments: I like 3a, and I
> think it addresses the issues I brought up in earlier revisions.

I tend to agree.

I usually _really_ hate any patch that adds noise that punishes people
whose system is configured and maintained well.

The 3a approach punishes people on a well maintained system where you
would get a good value out of GECOS and gethostname(2) by forcing them =
to
duplicate the information in their .git/config (or $HOME/.gitconfig).  =
So
I should be hating the idea, but I think alternatives are much worse th=
an
that, and it is the least problematic.
