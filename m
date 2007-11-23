From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: Wishlist for a bundle-only transport mode
Date: Fri, 23 Nov 2007 11:04:32 +0100
Message-ID: <200711231104.32605.jnareb@gmail.com>
References: <8aa486160711210654p357ccd87i4809e0cda9471303@mail.gmail.com> <200711231018.49322.jnareb@gmail.com> <7vejehux3y.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Santi =?utf-8?q?B=C3=A9jar?= <sbejar@gmail.com>,
	"Johannes Schindelin" <Johannes.Schindelin@gmx.de>,
	git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Nov 23 11:04:57 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IvVP7-0007mu-9V
	for gcvg-git-2@gmane.org; Fri, 23 Nov 2007 11:04:57 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754069AbXKWKEk convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 23 Nov 2007 05:04:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753899AbXKWKEk
	(ORCPT <rfc822;git-outgoing>); Fri, 23 Nov 2007 05:04:40 -0500
Received: from nf-out-0910.google.com ([64.233.182.185]:29563 "EHLO
	nf-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753485AbXKWKEj (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 23 Nov 2007 05:04:39 -0500
Received: by nf-out-0910.google.com with SMTP id g13so2721518nfb
        for <git@vger.kernel.org>; Fri, 23 Nov 2007 02:04:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:from:to:subject:date:user-agent:cc:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        bh=GKwmzI0WaKOGfSftHv9mLET9a+Ui3K50dnaVyywsQvY=;
        b=WHqMj48ohAClFqEOCEselTJ4mjEZMNSHUmj+KBTN5p5e7ic73KA9Fyox9GD4XDdkuMNQ3eLnFZjfDTFQ370oLaMEvK2DhWkgW4h0dqDpTygie9tWjwcswNoK3nKKCKqbHpW7u/89K19rbzs7ubCVBMsz3QpDDbkTSCX7UErYKGc=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:from:to:subject:date:user-agent:cc:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=ez/hRRrCNsqB0DGnEVObf7ygj1L3cYrYiL8yDf6KUfgz+gexy7zr2i1ZMklUjw9EztYvzNHsKAo/aT3PQs6BFkhg39hXxPawpisrYlVGtBO+n96eG0TRKSFPpeEczV7Vo+fVbXIKsEXDJP/hqOQxvI/RZuzZqznCCoiEUnNSbjY=
Received: by 10.86.4.2 with SMTP id 2mr9377667fgd.1195812277253;
        Fri, 23 Nov 2007 02:04:37 -0800 (PST)
Received: from ?192.168.1.11? ( [83.8.249.172])
        by mx.google.com with ESMTPS id l12sm1082205fgb.2007.11.23.02.04.34
        (version=SSLv3 cipher=OTHER);
        Fri, 23 Nov 2007 02:04:35 -0800 (PST)
User-Agent: KMail/1.9.3
In-Reply-To: <7vejehux3y.fsf@gitster.siamese.dyndns.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/65886>

On Fri, 23 Nov 2007, Junio C Hamano wrote:
> Jakub Narebski <jnareb@gmail.com> writes:
>> On Thu, 22 Nov 2007, Junio C Hamano :
>>> "Santi B=C3=A9jar" <sbejar@gmail.com> writes:
>>>=20
>>>> Sorry but I do not understand this. I think this two lines could b=
e equivalent:
>>>>
>>>> git push --bundle bundle.bdl "refs/heads/master:refs/remotes/bundl=
e/master"
>>>> git bundle create bundle.bdl refs/heads/master ^refs/remotes/bundl=
e/master
>>>=20
>>> Interesting.
>>>=20
>>> 	$ git push $something ours:theirs
>>>=20
>>> has defined semantics for any value of $something.
>>> ...
>>> If bundle.bdl does not exist yet, it is like pushing into a
>>> freshly initialized empty repository.
>>
>> But for that I think "git bundle" should learn new subcommand:
>> "git bundle update", which would use refs existing in given
>> bundle as prerequisites, and either update bundle (create anew
>> or just concatenate next pack) or create incremental bundle.
>>
>> Something similar to incremental mode or update command of
>> archivers...
>=20
> I was disagreeing with Santi's "'push --bundle' and 'bundle
> create' can be equivalent".  They can't be, as "push" is always
> "update" and never "create".  So I do not quite get your "But for
> that I think"; I think you are just agreeing with me.

Bad choice of words on my part... and I didn't parse that you were
disagreeing as well as commenting. :-/

> Even if we taught "push" to create (which I doubt would happen
> due to its security and administrative implications), it would
> not make the two any closer to being equivalent.  For them to
> become equivalent, we would need to have "push" unlearn how to
> update, which would never happen ;-).

I also think that pushing to bundle might be not a good idea;
but I think that "git clone <bundle>" should just work.

Nevertheless I think that having "git bundle update" or=20
"git bundle create --reference=3D<old bundle>" (or both) would be
a good thing, as it would free us from remembering or tagging when
last bundle was created.


Could anyone who uses "git bundle" actively raise a voice?

--=20
Jakub Narebski
Poland
