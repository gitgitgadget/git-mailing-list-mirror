From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH] Remove restriction on notes ref base
Date: Wed, 3 Nov 2010 01:41:37 -0500
Message-ID: <20101103064137.GC7606@burratino>
References: <1288657003-17802-1-git-send-email-kroot@google.com>
 <AANLkTinN1UXSmkxOg59pT_xVd2eWS0Ms2sgAweLv7hbg@mail.gmail.com>
 <7vsjzj1v49.fsf@alter.siamese.dyndns.org>
 <201011022358.11340.johan@herland.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	Shawn Pearce <spearce@spearce.org>,
	Kenny Root <kroot@google.com>,
	Thomas Rast <trast@student.ethz.ch>
To: Johan Herland <johan@herland.net>
X-From: git-owner@vger.kernel.org Wed Nov 03 07:42:10 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PDX2v-0006an-Na
	for gcvg-git-2@lo.gmane.org; Wed, 03 Nov 2010 07:42:10 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753092Ab0KCGl6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 3 Nov 2010 02:41:58 -0400
Received: from mail-gw0-f46.google.com ([74.125.83.46]:47823 "EHLO
	mail-gw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753034Ab0KCGl4 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 3 Nov 2010 02:41:56 -0400
Received: by gwj21 with SMTP id 21so221919gwj.19
        for <git@vger.kernel.org>; Tue, 02 Nov 2010 23:41:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :in-reply-to:user-agent;
        bh=EFdpqYFGD8ZinnyJs18J3CaVOXPzXK4lxoGYGcD0kcw=;
        b=El79SKt/HxMnHJHOOaNwrKb0DOEsQvH/faRovvLYTsHmljLOYBlcswTfZRuCeEaX9K
         vG5Wf7GR45dGY2TZvlF0g7URXE4ZRsBse67Q0NK2B4S/dR3OUR6PEyPbTWONNdCTgMjk
         9JjVCQYxWwZc1hDFglwpVx1aSRQGhCUVllhE0=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=L/sKMOTKhCqJHRnY5HKCFIqJmHynaIrT/bLdup9dxpKbMEJhROmvoExnlqe11h3/Mt
         O5qKPeid86FLJpZKoAZqfoKrLucgG7N0+afzlO0JxbzEagMRIKvyptZTqQJm2apLyneJ
         HYAwyUBw5cOB8x2oS+bsSjqIoixJOmkT4ZRCs=
Received: by 10.100.131.10 with SMTP id e10mr1701816and.223.1288766515832;
        Tue, 02 Nov 2010 23:41:55 -0700 (PDT)
Received: from burratino (adsl-68-255-106-176.dsl.chcgil.ameritech.net [68.255.106.176])
        by mx.google.com with ESMTPS id w15sm4980367anw.13.2010.11.02.23.41.53
        (version=SSLv3 cipher=RC4-MD5);
        Tue, 02 Nov 2010 23:41:54 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <201011022358.11340.johan@herland.net>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/160589>

Johan Herland wrote:

> Although I'm starting to wonder whether our remote -> local refspec mappings 
> are getting too varied (i.e. confusing). Currently we have:
> 
>   Remote repo    ->   Local repo
>   ------------------------------------------------
>   refs/heads/*        refs/remotes/$remote/*
>   refs/tags/*         refs/tags/*
> 
> ...and soon we may also have:
>   refs/notes/*        refs/notes/remotes/$remote/*

How about

    refs/notes/*        refs/notes/$remote/*

?

Plus side: shorter magic prefix to remember,
           --notes-ref=charon/full would work with the
           current --notes-ref dwimery.
Downside: potential for name conflicts?
