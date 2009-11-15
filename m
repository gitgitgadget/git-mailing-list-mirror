From: Johan 't Hart <johanthart@gmail.com>
Subject: Re: Question about "git pull --rebase"
Date: Sun, 15 Nov 2009 20:47:56 +0100
Message-ID: <4B005AEC.1000002@gmail.com>
References: <38b2ab8a0911141239w2bab7277o66350bc742d985dd@mail.gmail.com>	<4AFF3D4D.7000308@gmail.com> <m2my2noo0g.fsf@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Francis Moreau <francis.moro@gmail.com>
X-From: git-owner@vger.kernel.org Sun Nov 15 20:48:22 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1N9l59-0001Qo-K5
	for gcvg-git-2@lo.gmane.org; Sun, 15 Nov 2009 20:48:19 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753536AbZKOTsF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 15 Nov 2009 14:48:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753404AbZKOTsE
	(ORCPT <rfc822;git-outgoing>); Sun, 15 Nov 2009 14:48:04 -0500
Received: from ey-out-2122.google.com ([74.125.78.26]:20239 "EHLO
	ey-out-2122.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751337AbZKOTsD (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 15 Nov 2009 14:48:03 -0500
Received: by ey-out-2122.google.com with SMTP id 9so1704444eyd.19
        for <git@vger.kernel.org>; Sun, 15 Nov 2009 11:48:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:sender:message-id:date:from
         :user-agent:mime-version:newsgroups:to:cc:subject:references
         :in-reply-to:content-type:content-transfer-encoding;
        bh=dd2ewgTFGeydh6smGp98H8MUUzSsPVHIW5Gq+/crSos=;
        b=l7zOJ16FBOh8tYojocMg5PqMqg0Ye1GhlNMjqsSJDtp7V7issXND7L2iCHWwFfFUPE
         jx78jDbralucRgJqzbQLzuuTVrwi7JPMEZ9Fp9m5nZVAo6CGiParRrn6Rc3q0cvhfxM/
         R3DrT4IpinA7Kbq2aoAA/jn+fuZLsN7oc3apI=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=sender:message-id:date:from:user-agent:mime-version:newsgroups:to
         :cc:subject:references:in-reply-to:content-type
         :content-transfer-encoding;
        b=HI6Dju6vBuJBptt8oLmC/S6b+s9lueTNbDMj2lLtKlbd/jiwrcnQ5yjf35vujzTsq+
         cqTyCBS2DlhFOWIDHWjA2Jl3yiMQZ59lBRyhNK0gZdJCyiatRPiKD6UfqlMVRkHcab+1
         z8iy8akCYatRX7WmCWepjA07YOJRx71BCWo30=
Received: by 10.213.63.14 with SMTP id z14mr1387494ebh.17.1258314488149;
        Sun, 15 Nov 2009 11:48:08 -0800 (PST)
Received: from ?192.168.2.101? (dsl-083-247-086-199.solcon.nl [83.247.86.199])
        by mx.google.com with ESMTPS id 10sm4396084eyz.27.2009.11.15.11.48.06
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sun, 15 Nov 2009 11:48:06 -0800 (PST)
User-Agent: Thunderbird 2.0.0.23 (Windows/20090812)
Newsgroups: gmane.comp.version-control.git
In-Reply-To: <m2my2noo0g.fsf@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/132955>

Francis Moreau schreef:
> Looks like you did :)
> 
> I've been somehow confused by the git-pull man page, which says:
> 
>   A parameter <ref> without a colon is equivalent to <ref>: when
>   pulling/fetching, so it merges <ref> into the current branch without
>   storing the remote branch anywhere locally
> 
> So I thought that both of the commands were equivalent for 'git pull
> --rebase'.
> 
> Thanks for the explanation.

Ah that part.

It means that
$ git pull --rebase origin master

means the same as:
$ git pull --rebase origin master:
(note extra colon at the end)

But not as:
$ git pull --rebase origin master:foo

It means that, when you give a refspec without a colon, it is the same 
as the refspec with the colon and without the right side.
