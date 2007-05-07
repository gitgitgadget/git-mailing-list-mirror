From: "Dana How" <danahow@gmail.com>
Subject: Re: [PATCH] Use GIT_OBJECT_DIR for temporary files of pack-objects
Date: Mon, 7 May 2007 10:51:24 -0700
Message-ID: <56b7f5510705071051l75d701d7r94b7c4629cc425f@mail.gmail.com>
References: <81b0412b0705040225p26679dbib6a1261a1a43ee67@mail.gmail.com>
	 <7vy7k4ud3d.fsf@assigned-by-dhcp.cox.net>
	 <81b0412b0705040342p4fed3a4bnee92cce6b5fb6b9@mail.gmail.com>
	 <7vslacttij.fsf@assigned-by-dhcp.cox.net>
	 <81b0412b0705041024i43d7fc5ah1967d6a6192dc6ee@mail.gmail.com>
	 <7v6478tmyy.fsf@assigned-by-dhcp.cox.net>
	 <20070507173324.GA3436@steel.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, "Junio C Hamano" <junkio@cox.net>,
	danahow@gmail.com
To: "Alex Riesen" <raa.lkml@gmail.com>
X-From: git-owner@vger.kernel.org Mon May 07 19:51:39 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Hl7Mx-0001Ep-Ai
	for gcvg-git@gmane.org; Mon, 07 May 2007 19:51:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754559AbXEGRv0 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 7 May 2007 13:51:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754561AbXEGRv0
	(ORCPT <rfc822;git-outgoing>); Mon, 7 May 2007 13:51:26 -0400
Received: from nz-out-0506.google.com ([64.233.162.226]:49567 "EHLO
	nz-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754559AbXEGRvZ (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 7 May 2007 13:51:25 -0400
Received: by nz-out-0506.google.com with SMTP id o1so1647744nzf
        for <git@vger.kernel.org>; Mon, 07 May 2007 10:51:24 -0700 (PDT)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=g5DGouku87dTHDW4Pfl3G7eR+CrwebiiC2Y1k3sUVDUtXpkkbaY0DyMpZ7XxtKiDktm+3M5R4H213uF+l2FRb0yZD14ytNkSDyGAQ270Y19eQC2ZS3n3eDIjUnzFrIZN1s2KyQbHmguVkudFOhKIl98NUHNX/ZDnupqqNfVD5Es=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=V6/L9HSugiRlCAstxKEGiz/vfCSJWUoI6LfY6q92xT0GrmD3e9uLZkfnG0A8NYUCaFgoMh0+fg/goT6tkImjSTNA4tunixosGU5dI3iiJYUkIUiBjC8xfHD3aAWrTi6nwi5kmoLBV6Rr+DeJolSBK6Bn1FeO8u0iXz5VYTS7kKQ=
Received: by 10.114.25.3 with SMTP id 3mr2252903way.1178560284445;
        Mon, 07 May 2007 10:51:24 -0700 (PDT)
Received: by 10.115.58.7 with HTTP; Mon, 7 May 2007 10:51:24 -0700 (PDT)
In-Reply-To: <20070507173324.GA3436@steel.home>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/46473>

On 5/7/07, Alex Riesen <raa.lkml@gmail.com> wrote:
> I'm not sure about fsck cleaning up after crashed/killed pack-objects:
> not sure I _can_ detect if the temp files really are just leftovers.

It looks like you create temp file in objects , not objects/pack .

So a rule could be : packs left in the former are crashed/killed,
and packs in the latter are complete?

You should also look at $PACKTMP in git-repack.sh .
In it $GIT_DIR should probably be $GIT_OBJECT_DIRECTORY ?

Junio:
This patch touches the same lines as the --max-pack-size patch.
What do you want to do with the latter?

Thanks,
-- 
Dana L. How  danahow@gmail.com  +1 650 804 5991 cell
