From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [RFC/PATCHv8 00/10] git notes
Date: Tue, 19 Jan 2010 10:10:02 -0800
Message-ID: <7vk4ve9dad.fsf@alter.siamese.dyndns.org>
References: <1258681154-2167-1-git-send-email-johan@herland.net>
 <7vk4xl5y3z.fsf@alter.siamese.dyndns.org>
 <20091120192800.6117@nanako3.lavabit.com>
 <7vk4xl1nkl.fsf@alter.siamese.dyndns.org>
 <81b0412b1001190754m37ed01b0nd93b318d77d88a75@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Nanako Shiraishi <nanako3@lavabit.com>,
	Johan Herland <johan@herland.net>, git@vger.kernel.org,
	spearce@spearce.org
To: Alex Riesen <raa.lkml@gmail.com>
X-From: git-owner@vger.kernel.org Tue Jan 19 19:10:38 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NXIXC-0003GZ-14
	for gcvg-git-2@lo.gmane.org; Tue, 19 Jan 2010 19:10:34 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755072Ab0ASSKV convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 19 Jan 2010 13:10:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753988Ab0ASSKS
	(ORCPT <rfc822;git-outgoing>); Tue, 19 Jan 2010 13:10:18 -0500
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:49004 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752143Ab0ASSKP convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 19 Jan 2010 13:10:15 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 3B77A92DB4;
	Tue, 19 Jan 2010 13:10:15 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:message-id:mime-version:content-type
	:content-transfer-encoding; s=sasl; bh=o5cHhzzZlZrLhO+BifCEOI0wl
	8I=; b=BXIHJIKIzYkh02vKT+SDoNAQIYtJWi3N7kY1z0NaaZYPwHXqLn/gk/jyQ
	VDlvB+Yr0Nuz6e1AcY+SlzZJDsHOYiQGuFL2g70ysH8gPoIqkavmBUVa95wSIrm4
	T0zhpv3Zy6Aac/WwHXiJxAJ69sJnL6Ljht0m4ZHZsUwIJ5+810=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:message-id:mime-version:content-type
	:content-transfer-encoding; q=dns; s=sasl; b=mCscHEXNJY8H6RsDw9g
	Dw50/2FtHHhNNtzLvGs7qJ3i38piDhAGgyf+74VR2eusR83dnDSYeAM1Fpgy+BF4
	Y/UwelSExdpbrrDWCgGPBVJ9DBFesrhbxrc6AAI4MkOMgB8SgKrWRhudswPyFmRS
	jidf5RvQMobZeKMR66pgHuUM=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id D730C92DB2;
	Tue, 19 Jan 2010 13:10:09 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id C463A92DAB; Tue, 19 Jan
 2010 13:10:03 -0500 (EST)
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: E16F2E8E-0525-11DF-B0D8-6AF7ED7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/137480>

Alex Riesen <raa.lkml@gmail.com> writes:

> On Fri, Nov 20, 2009 at 11:46, Junio C Hamano <gitster@pobox.com> wro=
te:
>> @@ -716,7 +719,7 @@ int cmd_checkout(int argc, const char **argv, co=
nst char *prefix)
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if (!strcmp(a=
rg, "-"))
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0arg =3D "@{-1}";
>>
>> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if (get_sha1(arg,=
 rev)) {
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if (get_sha1_mb(a=
rg, rev)) {
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0if (has_dash_dash) =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0/* c=
ase (1) */
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0die("invalid reference: %s", =
arg);
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0if (!patch_mode &&
>
> This is a bit of a problem on Windows, as the arg (eventually contain=
ing
> something like "master..."), will be passed to resolve_ref below.

I don't see "resolve_ref below"; do you mean this part?

		/* we can't end up being in (2) anymore, eat the argument */
		argv++;
		argc--;

		new.name =3D arg;
		if ((new.commit =3D lookup_commit_reference_gently(rev, 1))) {
			setup_branch_path(&new);
			if (resolve_ref(new.path, rev, 1, NULL))
				new.commit =3D lookup_commit_reference(rev);
			else
				new.path =3D NULL;
			parse_commit(new.commit);
			source_tree =3D new.commit->tree;
		} else
			source_tree =3D parse_tree_indirect(rev);

It is primarily to tell "git checkout master" and "git checkout master^=
0"
apart (the latter must detach HEAD).  IOW, it is testing if you gave th=
e
"name" of the branch, or something that yields the commit object name t=
hat
happens to be at the tip of the branch.  So the call to resolve_ref() i=
s
very relevant.

> Now, Windows,
> being the piece of shit it is, will lie and tell that a file
> "refs/heads/master..."
> exists and be same as "refs/heads/master".

Meh; then windows users cannot use "git checkout A..." syntax (they can
still use "git checkout A...HEAD", I presume).

This is not a problem specific to three-dots, but if you give the funct=
ion
"refs/heads/master.."  it would also get "exists" back, no?  You could
teach resolve_ref() about windows (namely, the filesystem may lie about
anything that ends with a series of dots).

> This breaks "checkout to merge base" on Windows and t2012 in particul=
ar.

> BTW, why should the arg be run through resolve_ref at all if
> get_sha1(_mb) has succeeded?
> Isn't the commit already resolved by lookup_commit_reference_gently?

l-c-r-g makes sure rev (that is raw object name SHA-1) points at a comm=
it
and doesn't have anything to do with the name.
