From: Paul Mackerras <paulus@samba.org>
Subject: Re: [PATCH] gitk: read and write a repository specific configuration
 file
Date: Sun, 9 Dec 2012 21:44:26 +1100
Message-ID: <20121209104426.GA20818@bloggs.ozlabs.ibm.com>
References: <50BF6629.8050806@xiplink.com>
 <1354966067-2865-1-git-send-email-stlman@poczta.fm>
 <7vd2yjeg8f.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?utf-8?Q?=C5=81ukasz?= Stelmach <stlman@poczta.fm>,
	git@vger.kernel.org, mbranchaud@xiplink.com
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Dec 09 11:45:01 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TheNX-0003Td-BR
	for gcvg-git-2@plane.gmane.org; Sun, 09 Dec 2012 11:44:59 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933811Ab2LIKon convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 9 Dec 2012 05:44:43 -0500
Received: from ozlabs.org ([203.10.76.45]:49774 "EHLO ozlabs.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1758326Ab2LIKom (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 9 Dec 2012 05:44:42 -0500
Received: by ozlabs.org (Postfix, from userid 1003)
	id 9C56D2C0199; Sun,  9 Dec 2012 21:44:41 +1100 (EST)
Content-Disposition: inline
In-Reply-To: <7vd2yjeg8f.fsf@alter.siamese.dyndns.org>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/211234>

On Sun, Dec 09, 2012 at 01:18:08AM -0800, Junio C Hamano wrote:
> =C5=81ukasz Stelmach <stlman@poczta.fm> writes:
>=20
> > Enable gitk read and write repository specific configuration
> > file: ".git/k" if the file exists. To make gitk use the local
> > file simply create one, e.g. with the touch(1) command.
> >
> > This is very useful if one uses different views for different
> > repositories. Now there is no need to store all of them in
> > ~/.gitk and make the views list needlessly long.
>=20
> I do not use gitk heavily myself, but I have a mixed feeling about
> this patch.

I agree, I think this would be surprising to people who are used to
the way gitk works now.

I could imagine having a checkbox in the Edit->Preferences dialog to
say "Save configuration settings locally", and if you check that box,
then it writes the configuration to .git/gitkconfig or whatever
(having first saved that setting in the global ~/.gitk).  But I think
it should be an opt-in thing.

> In any case, the filename .git/k may be _cute_, but I do not think
> we would want to see:
>=20
>     $ ls .git
>     branches        config       HEAD   index  k     objects
>     COMMIT_EDITMSG  description  hooks  info   logs  refs
>=20
> It is too cryptic, unless the user _knows_ 'k' is for gitk.  I'd
> call it $GIT_DIR/gitkconfig or something, if I were supportive for
> this feature (which I am not enthusiastic, yet).

I agree with this too.

Paul.
