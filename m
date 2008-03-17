From: "Martin Langhoff" <martin.langhoff@gmail.com>
Subject: Re: [PATCH] git-cvsserver: handle change type T
Date: Tue, 18 Mar 2008 08:34:39 +1300
Message-ID: <46a038f90803171234m7e3f1cbfgb65311bfb64e6e0d@mail.gmail.com>
References: <E1Jay7s-0000dO-IX@fencepost.gnu.org>
	 <7v63vmicvf.fsf@gitster.siamese.dyndns.org> <47DD9890.3060005@gnu.org>
	 <7vve3lbwz9.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: "Paolo Bonzini" <bonzini@gnu.org>, git@vger.kernel.org,
	beuc@gnu.org, "Martin Langhoff" <martin@catalyst.net.nz>
To: "Junio C Hamano" <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Mar 17 20:35:39 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JbL7G-00041c-Dc
	for gcvg-git-2@gmane.org; Mon, 17 Mar 2008 20:35:26 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753540AbYCQTen (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 17 Mar 2008 15:34:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753313AbYCQTen
	(ORCPT <rfc822;git-outgoing>); Mon, 17 Mar 2008 15:34:43 -0400
Received: from ik-out-1112.google.com ([66.249.90.182]:56497 "EHLO
	ik-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752596AbYCQTem (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 17 Mar 2008 15:34:42 -0400
Received: by ik-out-1112.google.com with SMTP id c28so2466133ika.5
        for <git@vger.kernel.org>; Mon, 17 Mar 2008 12:34:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        bh=0DAWxpx7LMcs6miMBtqlRXBZpr5XcyDTPYQX0qLYGMo=;
        b=terS9aDqmaTOhKgLxA8XMBqMYSfJJHZZEvPj+Cfri1SsuFWEKbucKJkserkgedgr6IHSatU8/BPDW04YIZqrt+boZLcUPg8Nt3zWMPEVm1Wx6+ZtB4m0afKObWYLpVKCPjwgKkqGgbSFHijqMIEp1ad/YzjDJ0J+TLvsF2apdVs=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=XASJEoOqymA1iWNpBZ+OztjE7iLdLZxzwF+JSsLpanFHXfEWtqQ4Qp8PKDEbYrq7X8Fi7WM3F4sDadCU968fg4j+YzNPF0fyZgaV0YB+r5lqmGnAddlzK4gs/oAsAvwD61yhRsZ/aXNrNDbl47kyBLDcdZUaC+LnvFbQtZdf6vg=
Received: by 10.142.180.17 with SMTP id c17mr607223wff.76.1205782479334;
        Mon, 17 Mar 2008 12:34:39 -0700 (PDT)
Received: by 10.66.252.6 with HTTP; Mon, 17 Mar 2008 12:34:39 -0700 (PDT)
In-Reply-To: <7vve3lbwz9.fsf@gitster.siamese.dyndns.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/77458>

On Mon, Mar 17, 2008 at 9:01 PM, Junio C Hamano <gitster@pobox.com> wrote:
>  Martin, likes, dislikes?

Hmmm. Trying to make up my mind on this. It looks like symlink support
is broken in cvsserver, it is something we did not even consider, so I
am trying to visualise _how_ broken it is, and what it would take to

 - refuse to handle symlinks (temporarily, until we can guarantee our
handling is sane)
 - translate symlinks that are internal - hard, and probably not even
a good idea
 - handle symlinks directly - is the client safe from malicious symlinks?

I have never used symlinks with either git or cvs, so I am unsure as
to whether their handling is compatible. Do either of them perform any
sanity checks on the targetof the symlink?

cheers,



m
