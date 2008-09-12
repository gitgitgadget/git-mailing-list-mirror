From: Clark Williams <clark.williams@gmail.com>
Subject: Re: StGit question
Date: Fri, 12 Sep 2008 07:41:11 -0500
Message-ID: <48CA6367.9020300@gmail.com>
References: <48C94F86.6080707@gmail.com> <20080912075116.GA26685@diana.vm.bytemark.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Catalin Marinas <catalin.marinas@gmail.com>
To: =?UTF-8?B?S2FybCBIYXNzZWxzdHLDtm0=?= <kha@treskal.com>
X-From: git-owner@vger.kernel.org Fri Sep 12 14:42:28 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Ke7yi-0005Fi-7t
	for gcvg-git-2@gmane.org; Fri, 12 Sep 2008 14:42:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752780AbYILMlR convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 12 Sep 2008 08:41:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752728AbYILMlR
	(ORCPT <rfc822;git-outgoing>); Fri, 12 Sep 2008 08:41:17 -0400
Received: from mail-gx0-f16.google.com ([209.85.217.16]:39096 "EHLO
	mail-gx0-f16.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752477AbYILMlQ (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 12 Sep 2008 08:41:16 -0400
Received: by gxk9 with SMTP id 9so18894194gxk.13
        for <git@vger.kernel.org>; Fri, 12 Sep 2008 05:41:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from
         :user-agent:mime-version:to:cc:subject:references:in-reply-to
         :x-enigmail-version:content-type:content-transfer-encoding;
        bh=5EPSFqvVNYBxp7BhpSUuFyxnIr0sjX1qRx+LMMO+xkk=;
        b=NdJukcmyJ5gRYvWN/BNobbNACqZ43U96CtH7ufmckiw4Pq1TeVh7qd+y7uXuIRt66T
         23y52wunSY4VOvJED0K0O6zDnu4Z0fdOUHbOAOgjOQ6xwnxzkys1iGDYARguKGZaUQbN
         /i/EoFtyRKxRreA28ntgHpEMEDkxKYV0wfWBQ=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:x-enigmail-version:content-type
         :content-transfer-encoding;
        b=kmj9TN/+1GU7oMePvq5R1ObxzWqv8ZK8IX5GDUHULlNEbfxuxLJXWO3D8wUqW8TgUC
         DDhN10rj0W6gk/MzSJ0cTMW01zwT38uZo6wFU/wQYxdflUNKDMtZVZR7ObzrMcMf92Wz
         8z7/jOIt/ySGRf6R4rUwkqL4tZeoe9eg/i75I=
Received: by 10.150.58.5 with SMTP id g5mr5986561yba.134.1221223274332;
        Fri, 12 Sep 2008 05:41:14 -0700 (PDT)
Received: from ?192.168.2.35? ( [74.239.78.188])
        by mx.google.com with ESMTPS id 9sm13668878yws.5.2008.09.12.05.41.12
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Fri, 12 Sep 2008 05:41:13 -0700 (PDT)
User-Agent: Thunderbird 2.0.0.14 (X11/20080501)
In-Reply-To: <20080912075116.GA26685@diana.vm.bytemark.co.uk>
X-Enigmail-Version: 0.95.7
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/95718>

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Karl Hasselstr=C3=B6m wrote:
> On 2008-09-11 12:04:06 -0500, Clark Williams wrote:
>=20
>> Are there any guidelines or best-practices for sharing StGit trees?
>=20
> See below. ;-)
>=20
>> I'm working with the Linux -rt patchset and I need to be able to
>> share my tree with other people. What I'd *like* to do is push git
>> tree's up to a git server, let other people fetch them and have them
>> be able to 'stg uncommit' to get back to my stack state. The problem
>> is that when someone uncommits, you lose the patch names. If you're
>> trying to create an RPM out of a stack, this causes problems :).
>>
>> Is there something I can do or something that we can do to StGit to
>> make it possible for an 'uncommit' to restore the original patch
>> name? It looks like I could modify the commit message, so that the
>> first line is the patch name, but that's not very nice for people
>> scanning commits.
>>
>> Or am I missing something completely trivial that will make my life
>> easier?
>=20
> You've probably already found this and dismissed it, but
>=20
>   $ stg uncommit foo bar baz woo wee aaahh
>=20
> will uncommit six patches and give them those names. So if you just
> share the output of
>=20
>   $ stg series --applied --noprefix
>=20
> along with your branch, the other end will be able to recreate a
> series with the same names. (In not-quite-bleeding-edge stg's, "serie=
s
> --applied" is spelled "applied".)


Ahhhh, no I hadn't found this. Cool! I wonder if I could save the serie=
s in the
branch, so that someone could just checkout the branch and do:

$ stg uncommit $(cat stg-series)

Or, maybe I'll look at adding a --series or --file option to uncommit?

I suspect some chicken-and-egg problems here, but this is workable. And=
 when you're
talking >500 patches, anything you can do to automate is a wonderful th=
ing :).

>=20
> As for merging your work once both of you have made changes to the
> series, the current solution is "stg sync", which you'll have to ask
> Catalin about. The patch stack log in my experimental branch is
> designed to allow for true 3-way merging of patch series, so that
> you'd be able to get your colleague's latest modifications with a
> simple "stg merge" command, but that merge currently exists only in a
> couple of mails to this list -- there isn't even a prototype
> implementation -- so I expect you'll have more luck with "stg sync"
> right now ...
>=20

Most of the time it's not more than one or two patches difference, so I=
 think that it
can be handled manually for now. I'll definitely keep an eye on sync an=
d merge though...

Thanks,
Clark
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)
Comment: Using GnuPG with Fedora - http://enigmail.mozdev.org

iEYEARECAAYFAkjKY2cACgkQqA4JVb61b9cVYgCfZE8//UgP11+D3AKMCsDGN8Qs
KpsAni8gLlZn088lQr/1nbzQf4uKHxn/
=3DA6MK
-----END PGP SIGNATURE-----
