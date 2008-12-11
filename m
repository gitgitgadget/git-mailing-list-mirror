From: "Lars Hjemli" <hjemli@gmail.com>
Subject: Re: [RFC] cgit in git?
Date: Fri, 12 Dec 2008 00:37:07 +0100
Message-ID: <8c5c35580812111537v1144c9fdy19f2a3cc56e2a04f@mail.gmail.com>
References: <8c5c35580812111348iceaf30dyb55183017cff5b1d@mail.gmail.com>
	 <7vwse6bart.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: "Git Mailing List" <git@vger.kernel.org>
To: "Junio C Hamano" <gitster@pobox.com>,
	"Seth Vidal" <skvidal@fedoraproject.org>
X-From: git-owner@vger.kernel.org Fri Dec 12 00:38:37 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LAv6y-00049L-Ik
	for gcvg-git-2@gmane.org; Fri, 12 Dec 2008 00:38:29 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754339AbYLKXhK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 11 Dec 2008 18:37:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752309AbYLKXhK
	(ORCPT <rfc822;git-outgoing>); Thu, 11 Dec 2008 18:37:10 -0500
Received: from rv-out-0506.google.com ([209.85.198.228]:1140 "EHLO
	rv-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752139AbYLKXhI (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 11 Dec 2008 18:37:08 -0500
Received: by rv-out-0506.google.com with SMTP id k40so1108416rvb.1
        for <git@vger.kernel.org>; Thu, 11 Dec 2008 15:37:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to
         :subject:cc:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:references;
        bh=uATGm3x/8KCJIXj89XU0+/zdQgBPhkhwEKznrV5sd5c=;
        b=asdz9yDYr2HXbaeKfuUIZ0cVljvJemtJBjioN+rbOVWHud/nPF3pwLl/Q3Clzotk9i
         ByGbx6pQ1nCIr2E0ZPlvW84tAJBWXixJN6t7v1E2gF1hieBCsvXUjZ+d61UKaz28HQ5M
         0NMeia4RBTkJxiZ6sVeQrSHQnGyMYIpRbnYe4=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version
         :content-type:content-transfer-encoding:content-disposition
         :references;
        b=E547uAAe2RYM+UlHK3lAKWEPGHKcL+PuyOWfVayn7vPiOfSoIrHJOcNqLQNU+tJj53
         IF8bC+UoR5OYvuw0QdEXjmJPFIC9wjJLfd6l+eyu1fk8nY7AOED/Kvs64a4tcshIIIU5
         15w/FZ7dlijOHAurZQOGt6Q50r+Kej/tYOPSw=
Received: by 10.114.77.1 with SMTP id z1mr2237950waa.194.1229038627620;
        Thu, 11 Dec 2008 15:37:07 -0800 (PST)
Received: by 10.114.170.20 with HTTP; Thu, 11 Dec 2008 15:37:07 -0800 (PST)
In-Reply-To: <7vwse6bart.fsf@gitster.siamese.dyndns.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/102843>

On Thu, Dec 11, 2008 at 23:35, Junio C Hamano <gitster@pobox.com> wrote:
> "Lars Hjemli" <hjemli@gmail.com> writes:
>
>> 2) the cgit release tarballs includes the needed git sources
>>
>> Option 2 is doable but still requires the fedora project to support
>> two git packages (but now the 'git-for-cgit' package is hidden inside
>> the cgit source tree). The good thing about this option is that it
>> only requires some minor modifications to the cgit releases.
>
> I do not understand why this is any extra work for fedora.

I imagined that it could have a ripple-effect on package dependencies,
i.e. the git release used by cgit could have subtle
'incompatibilities' with the real git package, but I really don't know
the first thing about packaging so this is just a guess.


> Instead of
> running "make get-git" and then running your build procedure, they need to
> just run your build procedure because you now ship your source with the
> matching version of the git source, which sounds like the right thing to
> me.  You do not install anything from the contained git.git area (we do
> not do shared objects, nor public header files) to the end product, right?

Right.


> Doesn't cgit bind git.git as a subproject at the source level?  I would
> expect that the most natural release tarball for such a project would be a
> single tarball that has both the superproject itself _and_ the submodules
> it contains already extracted, iow, the state of your tree after you run
> "make get-git".

Your expectation makes sense to me, thanks for elaborating.

Seth: would such a self-contained tarball solve the problems on your end?

--
larsh
