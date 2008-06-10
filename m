From: Clark Williams <clark.williams@gmail.com>
Subject: Re: [PATCH - stgit] Patch to allow import of compressed files
Date: Tue, 10 Jun 2008 09:06:39 -0500
Message-ID: <484E8A6F.1060602@gmail.com>
References: <484D78BF.6030504@gmail.com>	 <20080610063328.GB26965@diana.vm.bytemark.co.uk>	 <alpine.DEB.1.10.0806092335420.17180@swallowtail>	 <bd6139dc0806100107y415a292eqe22af7a7b2215e65@mail.gmail.com>	 <20080610095349.GA30119@diana.vm.bytemark.co.uk>	 <bd6139dc0806100257k4700d364occ08457279e8a735@mail.gmail.com>	 <20080610102800.GB30119@diana.vm.bytemark.co.uk> <bd6139dc0806100333s4395cca4g52b58679d7fc5c25@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?B?S2FybCBIYXNzZWxzdHLDtm0=?= <kha@treskal.com>,
	Asheesh Laroia <asheesh@asheesh.org>,
	Catalin Marinas <catalin.marinas@gmail.com>,
	git@vger.kernel.org
To: sverre@rabbelier.nl
X-From: git-owner@vger.kernel.org Tue Jun 10 16:07:55 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K64Vi-0002SU-58
	for gcvg-git-2@gmane.org; Tue, 10 Jun 2008 16:07:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754694AbYFJOGq convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 10 Jun 2008 10:06:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754657AbYFJOGp
	(ORCPT <rfc822;git-outgoing>); Tue, 10 Jun 2008 10:06:45 -0400
Received: from rv-out-0506.google.com ([209.85.198.229]:50199 "EHLO
	rv-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754545AbYFJOGo (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 10 Jun 2008 10:06:44 -0400
Received: by rv-out-0506.google.com with SMTP id k40so909630rvb.1
        for <git@vger.kernel.org>; Tue, 10 Jun 2008 07:06:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from
         :user-agent:mime-version:to:cc:subject:references:in-reply-to
         :x-enigmail-version:content-type:content-transfer-encoding;
        bh=EP7ru+NZVAq1eRmtij4IX5pJ+JcLOFPQfV9B7HTEcGk=;
        b=Mm+injVXZz8h4XcMsnyv1SuJs9Iuo07QtFEARADGkLxfAh5KQyrMdK+W/dL5AsPK2G
         c3GCU2RC/cmWxiSJF3yJYEsoI3MR4zRDdUAhFSHJ4wXUGGS2HM+5olXtfMhLg7RDSonu
         adiOwXttOzPToDGC8yZLk+p5axu6uAxvNuJx4=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:x-enigmail-version:content-type
         :content-transfer-encoding;
        b=bRO/GFQUPbFgFsrvX+vbIkEa+7L//d4LGQ3TojjivP5u7TULbPa4YIA+g9FIok3xM6
         5luIViKvgbMfvXLdO6NppFdsktoBBaqCK52idQbpJxH9IhE5UX46KKk/W+PYttK2kKyF
         errkgUW3jMiKeLBVC+x6ghzvtd0h7Y018NI5Y=
Received: by 10.141.75.6 with SMTP id c6mr2998186rvl.286.1213106804060;
        Tue, 10 Jun 2008 07:06:44 -0700 (PDT)
Received: from ?192.168.2.37? ( [74.239.78.188])
        by mx.google.com with ESMTPS id 8sm11619651ywg.6.2008.06.10.07.06.40
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Tue, 10 Jun 2008 07:06:40 -0700 (PDT)
User-Agent: Thunderbird 2.0.0.6 (X11/20070911)
In-Reply-To: <bd6139dc0806100333s4395cca4g52b58679d7fc5c25@mail.gmail.com>
X-Enigmail-Version: 0.95.3
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/84505>

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Sverre Rabbelier wrote:
> On Tue, Jun 10, 2008 at 12:28 PM, Karl Hasselstr=C3=B6m <kha@treskal.=
com> wrote:
>> If there's just one patch in the tar file, why did you use a tar fil=
e
>> in the first place instead of just gzipping?
>=20
> I guess mostly habbit :P. Whenever I zip something I create a gzipped
> tarball because that's how I usually do it.
>=20
>> I'm pretty sure that anyone who really has use for the tar-file
>> capability would be using tar files with multiple patches in them.
>=20
> Yeah, I guess that's true for most people indeed.
>=20
>> I was refering to the fact that due to tar-files in the general case
>> containing more than one patch, you'd have to modify the parts of
>> imprt.py that deal with importing multiple patches at once, in
>> addition to the parts the current patch touches.
>=20
> Mhhh, yeah, but should be something like
> for patch in patches
>   applyPatch(patch)
>=20

But, since patches in general are ordered beasts, you can get into trou=
ble if you
didn't name your patches such that they lexically sort in the proper or=
der *and* the
tar library gives them to you in the right order.

I think if I were going to add this, I'd probably look for a series fil=
e and use that
 to apply in the proper order. Same for if we support .zip files. Seems=
 like the only
other thing you could do is read in the list of files and sort them, th=
en apply them.

>> But you're probably right that the amount of additional work would n=
ot
>> be much more than what went into the current patch.
>=20
> To just support .tar, yeah, but let's see what the author has to say
> about this ;).
>=20

Author. Mmmmmmm, much nicer than "Mad Python patch hacker". I like it!

Clark

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)
Comment: Using GnuPG with Fedora - http://enigmail.mozdev.org

iEUEARECAAYFAkhOim8ACgkQqA4JVb61b9eMBACWIoP2sEcIdH8+2R60NN26UB/b
PQCgozvd0Kkonjz7xJlMN5cJqpVzhkY=3D
=3DUOWy
-----END PGP SIGNATURE-----
