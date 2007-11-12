From: Benoit Sigoure <tsuna@lrde.epita.fr>
Subject: Re: [PATCH] git-svn: prevent dcommitting if the index is dirty.
Date: Mon, 12 Nov 2007 10:11:03 +0100
Message-ID: <F711CC72-4A91-4B69-B26A-31B0FB6621B0@lrde.epita.fr>
References: <1194806501-4796-1-git-send-email-tsuna@lrde.epita.fr> <20071112022851.GA25675@mayonaise>
Mime-Version: 1.0 (Apple Message framework v752.3)
Content-Type: multipart/signed; protocol="application/pgp-signature"; micalg=pgp-sha1; boundary="Apple-Mail-39--344384958"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Eric Wong <normalperson@yhbt.net>
X-From: git-owner@vger.kernel.org Mon Nov 12 10:11:41 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IrVKO-0000FN-Er
	for gcvg-git-2@gmane.org; Mon, 12 Nov 2007 10:11:32 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752813AbXKLJLR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 12 Nov 2007 04:11:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752784AbXKLJLQ
	(ORCPT <rfc822;git-outgoing>); Mon, 12 Nov 2007 04:11:16 -0500
Received: from 2.139.39-62.rev.gaoland.net ([62.39.139.2]:57309 "EHLO
	kualalumpur.lrde.epita.fr" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752625AbXKLJLQ (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 12 Nov 2007 04:11:16 -0500
Received: from quanta.tsunanet.net ([82.229.223.213])
	by kualalumpur.lrde.epita.fr with esmtpsa (TLS-1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.63)
	(envelope-from <tsuna@lrde.epita.fr>)
	id 1IrVK5-0001QR-T0; Mon, 12 Nov 2007 10:11:14 +0100
In-Reply-To: <20071112022851.GA25675@mayonaise>
X-Pgp-Agent: GPGMail 1.1.2 (Tiger)
X-Mailer: Apple Mail (2.752.3)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/64579>

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--Apple-Mail-39--344384958
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed

On Nov 12, 2007, at 3:28 AM, Eric Wong wrote:

> Benoit Sigoure <tsuna@lrde.epita.fr> wrote:
>> dcommit uses rebase `sync' the history with what has just been  
>> pushed to
>> SVN.  Trying to dcommit with a dirty index is troublesome for  
>> rebase, so now
>> the user will get an error message if he attempts to dcommit with  
>> a dirty
>> index.
>>
>> Signed-off-by: Benoit Sigoure <tsuna@lrde.epita.fr>
>
> Thanks,
>
> Minor nit below about indentation (which Junio can fix when applying),
> but nevertheless:
>
> Acked-by: Eric Wong <normalperson@yhbt.net>
>
>> ---
>>  git-svn.perl                              |    3 +++
>>  t/t9106-git-svn-dcommit-clobber-series.sh |    6 ++++++
>>  2 files changed, 9 insertions(+), 0 deletions(-)
>>
>> diff --git a/git-svn.perl b/git-svn.perl
>> index dd93e32..a15df4f 100755
>> --- a/git-svn.perl
>> +++ b/git-svn.perl
>> @@ -390,6 +390,9 @@ sub cmd_set_tree {
>>
>>  sub cmd_dcommit {
>>  	my $head = shift;
>> +        git_cmd_try { command_oneline(qw/diff-index --quiet HEAD/) }
>> +          'Cannot dcommit with a dirty index.  Commit your  
>> changes first'
>> +          . "or stash them with `git stash'.\n";
>
> We use tabs for indentation, and spaces for alignment.

Yes, sorry again, would you consider to add `# vi: set noexpandtab:'  
at the end of the file so that ViM users (like me) don't have to  
think about it?  (it tells ViM to NOT expand tabs to series of spaces)

-- 
Benoit Sigoure aka Tsuna
EPITA Research and Development Laboratory



--Apple-Mail-39--344384958
content-type: application/pgp-signature; x-mac-type=70674453;
	name=PGP.sig
content-description: This is a digitally signed message part
content-disposition: inline; filename=PGP.sig
content-transfer-encoding: 7bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.7 (Darwin)

iD8DBQFHOBinwwE67wC8PUkRAv92AKCr+lbQvKtToICklm87OzXjMYVW9gCgmkEV
10uAeJldWUtzSZkSbZeqzGc=
=Uyf0
-----END PGP SIGNATURE-----

--Apple-Mail-39--344384958--
