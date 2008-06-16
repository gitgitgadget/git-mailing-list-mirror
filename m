From: Lea Wiemann <lewiemann@gmail.com>
Subject: Re: [PATCH] gitweb: return correct HTTP status codes
Date: Mon, 16 Jun 2008 23:49:28 +0200
Message-ID: <4856DFE8.9010809@gmail.com>
References: <1213564515-14356-1-git-send-email-LeWiemann@gmail.com> <m37icqpb5f.fsf@localhost.localdomain> <48568D5C.5090909@gmail.com> <200806161843.09372.jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, Kay Sievers <kay.sievers@suse.de>
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Tue Jun 17 00:15:31 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K8Myy-00078E-04
	for gcvg-git-2@gmane.org; Tue, 17 Jun 2008 00:15:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756957AbYFPWO3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 16 Jun 2008 18:14:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756826AbYFPWO2
	(ORCPT <rfc822;git-outgoing>); Mon, 16 Jun 2008 18:14:28 -0400
Received: from fg-out-1718.google.com ([72.14.220.156]:37235 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754851AbYFPWO2 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 16 Jun 2008 18:14:28 -0400
Received: by fg-out-1718.google.com with SMTP id 19so3391822fgg.17
        for <git@vger.kernel.org>; Mon, 16 Jun 2008 15:14:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:user-agent
         :mime-version:to:cc:subject:references:in-reply-to:content-type
         :content-transfer-encoding:from;
        bh=6dObxW2D3/B+B0B6mQgJxRG6svS4gWRb4GSSIWVZ6pk=;
        b=PYlQh/F8MG6LHrXZEl8RnxFZ5VlMliDet7sPYuO4VYZsii9nzMFQNPomCVz6Zl2ns2
         3oof8x+hPGJu2oUxIDG1avKCUIu2x46IA+bTbABjcU59z2lIW3gLl1A0NQ0o2vghimWa
         s6U3JJs2M/g/0Hz/O0pCAmHsqbnCnTCh23+RE=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:user-agent:mime-version:to:cc:subject:references
         :in-reply-to:content-type:content-transfer-encoding:from;
        b=HIQVOnaUOHfU6vsWcoYPZ/zAiaTzPqe+CRuwC0mrnFIxM7JbvqbV42YAa4JrlshVda
         Q4uUawlHJKIS7LddaWaDnmnJ1J9ZXoHt878xEox1q5NOGLqXwEmnSPzuhdJmKniDEI0e
         uw/kf7Av0pzXTkpD73Lb0XKMycrgo/rZxIkzc=
Received: by 10.86.31.18 with SMTP id e18mr8282513fge.6.1213654466226;
        Mon, 16 Jun 2008 15:14:26 -0700 (PDT)
Received: from ?172.16.30.128? ( [80.187.209.58])
        by mx.google.com with ESMTPS id e20sm12221004fga.1.2008.06.16.15.14.24
        (version=SSLv3 cipher=RC4-MD5);
        Mon, 16 Jun 2008 15:14:25 -0700 (PDT)
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.8.1.14) Gecko/20080421 Thunderbird/2.0.0.14 Mnenhy/0.7.5.666
In-Reply-To: <200806161843.09372.jnareb@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/85241>

Jakub Narebski wrote:
> Well, we could, perhaps, examine stderr (or redirect it to stdout and
> examine upon error) to check what was the error.

We don't have to -- gitweb's current (suboptimal) error checking is 
because it doesn't interface with git very well.  The API I'm writing 
will fix this (i.e. provide proper feedback in all cases) so we'll have 
more specific status codes.  IOW, we'll be able to differentiate between 
500 and 404.  Trust me on this one. ;-)

> But I think in all, or almost all cases, the source is wrong parameters
> in URL.  Now, returning 5xx _server_ error would make me want to email
> webmaster about error on his/her server, while 4xx _user_ error would
> make me examine my input

Since the status codes will get better (more accurate) anyway, I care 
more about correctness than practicalities right now (and I'm convinced 
that only 500 is correct in the cases we're talking about).  That said, 
if you really want 404s in there, go ahead and send a follow-up patch, I 
won't object.

> BTW. I got three copies of this email: was it you fighting VGER
> anti-spam filter?

Yup.  Apparently it simply greps for Content-TypXe: text/hXtml.  *shakes 
head* :-)

-- Lea
