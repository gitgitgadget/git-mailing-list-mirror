From: "Avery Pennarun" <apenwarr@gmail.com>
Subject: Re: git annoyances
Date: Thu, 10 Apr 2008 11:05:07 -0400
Message-ID: <32541b130804100805o4ad1e9a6x38e9b1fcf17c5d1d@mail.gmail.com>
References: <20080409101428.GA2637@elte.hu>
	 <20080409145758.GB20874@sigill.intra.peff.net>
	 <32541b130804091008h1a757552o14dd8e937ed19058@mail.gmail.com>
	 <20080410084119.GA8979@diana.vm.bytemark.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: "Jeff King" <peff@peff.net>, "Ingo Molnar" <mingo@elte.hu>,
	git@vger.kernel.org
To: "=?ISO-8859-1?Q?Karl_Hasselstr=F6m?=" <kha@treskal.com>
X-From: git-owner@vger.kernel.org Thu Apr 10 17:14:36 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JjyLw-00071Y-9z
	for gcvg-git-2@gmane.org; Thu, 10 Apr 2008 17:06:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756721AbYDJPFP convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 10 Apr 2008 11:05:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756083AbYDJPFP
	(ORCPT <rfc822;git-outgoing>); Thu, 10 Apr 2008 11:05:15 -0400
Received: from nf-out-0910.google.com ([64.233.182.184]:12811 "EHLO
	nf-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756224AbYDJPFO convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 10 Apr 2008 11:05:14 -0400
Received: by nf-out-0910.google.com with SMTP id g13so21600nfb.21
        for <git@vger.kernel.org>; Thu, 10 Apr 2008 08:05:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        bh=uY1fvD7IsEMDCxFPHbwJACA0MzKmRPJxWOqC4fvt/DU=;
        b=oMGATwYurEsSsenjYzFVNGD4TJxLTLkrkjQP6LTfq+b4rW5k3LASinuIr+bUSHL7STb22PlxlTtaj3oTAot0YB8OGuJUcvy8ErpeLM5MEHU4C03nmzOuv5F0YaPLTvZoS/VEkp/FCwcCOe6awy0qwJJ72kpzj3LQslYH/cJ7TGM=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=doVUYL5KtpB/M/cI6Wk1ZCKC7qA7jSEZa8TbHgAiSSLjweavj6VzHimjozGMwS5Y/93FWbu9CIigRqhftM7EwCrI7OZQkB8+wfXEDKtZbLRppdE5jxB5c/mqC7o1hXub4evhltTyP2vbBDMqe0fEUcq+grCTwcvMcwN7QHLgU8w=
Received: by 10.82.166.9 with SMTP id o9mr2412422bue.32.1207839907674;
        Thu, 10 Apr 2008 08:05:07 -0700 (PDT)
Received: by 10.82.100.5 with HTTP; Thu, 10 Apr 2008 08:05:07 -0700 (PDT)
In-Reply-To: <20080410084119.GA8979@diana.vm.bytemark.co.uk>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/79216>

On Thu, Apr 10, 2008 at 4:41 AM, Karl Hasselstr=F6m <kha@treskal.com> w=
rote:
> On 2008-04-09 13:08:39 -0400, Avery Pennarun wrote:
>
>  > For example, in svn you can talk about
>  > svn+ssh://reposerver/path/to/repo/branches/foo@1234; it's a single
>  > "word" that refers to a particular revision on a particular branch
>  > of a particular server.
>
>  Heh, not really. Subversion actually makes this even more confusing
>  than git does.
>
>  The @rev is called a "peg revision", and is different from the
>  "operative revision" specified with the -r flag. The peg revision is
>  used in conjunction with a path to specify the file (or directory) y=
ou
>  want, and the operative revision is used to specify which revision o=
f
>  that file you mean.

Yes, but I believe you get the one from @rev if you don't specify -r.

=46or example, I can ask for an "svn diff svn://blahblah@56
svn://blahblah@59" and it'll feed it to me as expected.

This is nearly the same as "svn diff -r56:59 svn://blahblah", except
that it might look for blahblah in different places, as you say.  I
tend to prefer the @notation for exactly at that reason.

> (This complexity is needed because subversion has
>  a concept of file identity.)

=46ile renames make diffing and merging complicated no matter whether
you track them or not.

svn's tracking of file identity is additional, but doesn't increase
the (UI) complexity in the common case.  At least with svn, a newbie
can even get real work done without even knowing about -r *or*
@notation.

Compare that to arbitrary differences in behaviour between "git-fetch"
vs "git-fetch a" vs "git-fetch a b", or the difference between HEAD^
and HEAD~1 and HEAD@1.  git is very powerful, but also definitely more
complex for beginners.

Have fun,

Avery
