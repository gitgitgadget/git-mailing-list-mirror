From: "Catalin Marinas" <catalin.marinas@gmail.com>
Subject: Re: stg clean removes conflicting patch
Date: Fri, 25 Jan 2008 09:53:46 +0000
Message-ID: <b0943d9e0801250153t30c5b9b8w4c08af107cfdf202@mail.gmail.com>
References: <1201233317.2811.17.camel@dv>
	 <20080125080434.GA5599@diana.vm.bytemark.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: "Pavel Roskin" <proski@gnu.org>, git@vger.kernel.org
To: "=?ISO-8859-1?Q?Karl_Hasselstr=F6m?=" <kha@treskal.com>
X-From: git-owner@vger.kernel.org Fri Jan 25 10:54:37 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JILGT-0000ka-A3
	for gcvg-git-2@gmane.org; Fri, 25 Jan 2008 10:54:25 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754873AbYAYJxv convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 25 Jan 2008 04:53:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754491AbYAYJxv
	(ORCPT <rfc822;git-outgoing>); Fri, 25 Jan 2008 04:53:51 -0500
Received: from rv-out-0910.google.com ([209.85.198.186]:17542 "EHLO
	rv-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752456AbYAYJxt convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 25 Jan 2008 04:53:49 -0500
Received: by rv-out-0910.google.com with SMTP id k20so660013rvb.1
        for <git@vger.kernel.org>; Fri, 25 Jan 2008 01:53:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        bh=7q7SB61UZ2at/p7+PDm/6cue6mQOmjG6ed/MasJnVCA=;
        b=T1qAKV/TcU4RMcInswtqAqn2SiWYQybTGGIy0m/8av9JKzaYgAQ9dsdz02qOTrCj4tDqSZnSPef6D1+xgIdOezWKX4yY2gjFOgEltqwjPdOLYTyWojvlrkbzvnA/EYin2L8pqQW8VuCTuOn7JigvQeysyAoklcOf+P7Pj4ZmFWc=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=uaa5361CHuAhGOjnAvSZiMwuh0UKH7eaWMj65gfB+S3QFZEi9dv/zxTDZnV3mHtmvOUOxrDFH6+aJvEcVRn+qW+wOsSNqSYIiKVEXGIe6hfqWnbo5zPa1IeNqQfUa8MS+k6OPqol3cGK5gjxqWnCAMBGnX5DaH+lu9JiX4cu9MU=
Received: by 10.140.193.16 with SMTP id q16mr1282036rvf.109.1201254826895;
        Fri, 25 Jan 2008 01:53:46 -0800 (PST)
Received: by 10.140.193.5 with HTTP; Fri, 25 Jan 2008 01:53:46 -0800 (PST)
In-Reply-To: <20080125080434.GA5599@diana.vm.bytemark.co.uk>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/71693>

On 25/01/2008, Karl Hasselstr=F6m <kha@treskal.com> wrote:
> On 2008-01-24 22:55:17 -0500, Pavel Roskin wrote:
>
> > If "stg push" fails, the subsequent "stg clean" will remove the
> > patch that could not been applied. I think it's wrong.
>
> I agree. It's consistent -- a conflicting patch is empty -- but
> clearly the wrong thing to do from a usability perspective.

Got broken by commit fe1cee2e49d9995852ba92d8fba1d064acf2fca9 which
removes the check_conflicts() call. As I said in a different post, we
should add these back (and to the 'goto' command as well) to make
StGIT safer.

> > I've made a patch for the testsuite that should pass once the bug i=
s
> > fixed. Try removing "stg clean" from the test. and it will pass. Bu=
t
> > "stg clean" should make no difference here.
>
> Good!
>
> For known-to-be-failing tests, you can use test_expect_failure. I'll
> amend your patch to do that when I pick it up (if Catalin doesn't bea=
t
> me to it).

Probably not, I'm really busy for one more week with a Linux kernel rel=
ease.

--=20
Catalin
