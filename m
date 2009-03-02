From: Jay Soffian <jaysoffian@gmail.com>
Subject: Re: merge, keeping the remote as a new file?
Date: Mon, 2 Mar 2009 08:05:42 -0500
Message-ID: <76718490903020505j4c4f2df2i379632158f1c80bf@mail.gmail.com>
References: <81bfc67a0903011616w32ebdad9ofc096f5d1fd3174a@mail.gmail.com>
	 <20090302041113.GA3094@coredump.intra.peff.net>
	 <20090302063604.GA17245@hashpling.org>
	 <20090302064519.GA5635@coredump.intra.peff.net>
	 <20090302065949.GD6289@atjola.homenet>
	 <20090302070406.GA12937@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?Q?Bj=C3=B6rn_Steinbrink?= <B.Steinbrink@gmx.de>,
	Charles Bailey <charles@hashpling.org>,
	Caleb Cushing <xenoterracide@gmail.com>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Mon Mar 02 14:07:47 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Le7rV-0006s4-Kt
	for gcvg-git-2@gmane.org; Mon, 02 Mar 2009 14:07:14 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751085AbZCBNFp convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 2 Mar 2009 08:05:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751084AbZCBNFp
	(ORCPT <rfc822;git-outgoing>); Mon, 2 Mar 2009 08:05:45 -0500
Received: from rv-out-0506.google.com ([209.85.198.227]:53191 "EHLO
	rv-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750958AbZCBNFo convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 2 Mar 2009 08:05:44 -0500
Received: by rv-out-0506.google.com with SMTP id g37so2260209rvb.1
        for <git@vger.kernel.org>; Mon, 02 Mar 2009 05:05:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=6RZS6mZbe4g1t+qb32ekJ2XsJsx084lSSmYvBg070nw=;
        b=WSLT1DuvwN2YDGrbCJyrU/PouBgV9M1uS3T6G/KeZ2jiHiUnf0KFTs66Ky8Mui5k50
         Gan0pAW9YiaVIIso7leY7xJBhLrv6kfEwThPw/jmDmlldVNbSOkCNm5Kgd3RKrLDXChd
         vLAEeB3XeO81QNZdBekeFxJOLS18BkTBPQ8tc=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=mzMsyNdDeyXQ92cOdh/xYrCeVHop4g8F0/E0iQndZZVwFsSdzVCzpDaBxXPY37T/xy
         E5ttZsQYt8jB+9ZCYoF1H/AU1GTzAgWHvj9mQ1jDNwVU/zYASqk71B4FI9PJJ16sghWx
         sq8mC3K8/GJK4aAcdBz7Cxxcp63sgTSCK/QXc=
Received: by 10.141.76.1 with SMTP id d1mr2921999rvl.110.1235999142573; Mon, 
	02 Mar 2009 05:05:42 -0800 (PST)
In-Reply-To: <20090302070406.GA12937@coredump.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/111936>

On Mon, Mar 2, 2009 at 2:04 AM, Jeff King <peff@peff.net> wrote:
> On Mon, Mar 02, 2009 at 07:59:49AM +0100, Bj=C3=B6rn Steinbrink wrote=
:
>
>> Hm, how about this?
>> git checkout --theirs file
>> git mv file newname
>> git checkout HEAD file # Can't use --ours here due to the mv
>
> Actually, you can use --ours if you don't "git mv":
>
> =C2=A0git checkout --theirs file
> =C2=A0mv file newfile
> =C2=A0git checkout --ours file
> =C2=A0git add file newfile
>
> One more command, but I think more obvious about what is going on (an=
d I
> think both are better than the other suggestions).

This is a superior answer as well because it avoids plumbing in a
situation where plumbing ought not be needed.

j.
