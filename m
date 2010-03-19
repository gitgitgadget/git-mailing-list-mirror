From: Michael Witten <mfwitten@gmail.com>
Subject: Re: What's in a name? Let's use a (uuid,name,email) triplet
Date: Fri, 19 Mar 2010 11:16:15 -0600
Message-ID: <b4087cc51003191016u3d4af923n613f3feca0e6e222@mail.gmail.com>
References: <4ba2293f.c5c2f10a.5e9c.5c4a@mx.google.com> <4BA338C1.7030803@alum.mit.edu> 
	<b4087cc51003190439x3c9ff269g35d11432bd2a3d60@mail.gmail.com> 
	<alpine.DEB.2.00.1003190441530.3821@asgard.lang.hm> <20100319115445.GA12986@glandium.org> 
	<3f4fd2641003190509j6e4908e4kab87b601d2ce9c00@mail.gmail.com> 
	<b4087cc51003190516h42202e34k598a163c246cb9f2@mail.gmail.com> 
	<3f4fd2641003190757y39050691y3dc0ca08bd5196fb@mail.gmail.com> 
	<4BA397B0.2000908@drmicha.warpmail.net> <alpine.DEB.2.00.1003190903540.3821@asgard.lang.hm>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Michael J Gruber <git@drmicha.warpmail.net>, git@vger.kernel.org
To: david@lang.hm
X-From: git-owner@vger.kernel.org Fri Mar 19 18:16:44 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NsfoQ-0002ue-Gr
	for gcvg-git-2@lo.gmane.org; Fri, 19 Mar 2010 18:16:42 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753755Ab0CSRQi (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 19 Mar 2010 13:16:38 -0400
Received: from fg-out-1718.google.com ([72.14.220.155]:52308 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753749Ab0CSRQh (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 19 Mar 2010 13:16:37 -0400
Received: by fg-out-1718.google.com with SMTP id 19so76862fgg.1
        for <git@vger.kernel.org>; Fri, 19 Mar 2010 10:16:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :from:date:message-id:subject:to:cc:content-type;
        bh=CgiWZV16BG0ZlsWTdVkFqhJ6fkLueG6ZzY7nuKJBfdw=;
        b=Vq9zioJ2XfSMJ/lTtt7ktqvh7nlZs9+jJ3CWQRTdAB/ZNkLTM/t1V+r367gByxaovl
         6SOjV5MtFK2R4Eom2z+d54K3SWEQONfBkGaxKK82B1b4GNFwhvKSFTAS9UtQauoIJO7L
         wqcgbzYF/ySCxt2lrnbYyr9WjgCkGDKRHsakY=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        b=Z8wkLIfXxqj5Il0obP8OqxfHzxn/9w62ehHQAn1JfW1PdbS6ijFQIygE9qRZbYVHxb
         U3i1DwxJjAHap0G/UKBbA8+8faNx6XF6nqdITKiX4ogbowu54qaortvD4SHD8H1Slwmf
         M43xwWbZsZNkRFN0tGaZsWgchfxqAQqG26Tx0=
Received: by 10.239.149.196 with SMTP id k4mr265553hbb.138.1269018995208; Fri, 
	19 Mar 2010 10:16:35 -0700 (PDT)
In-Reply-To: <alpine.DEB.2.00.1003190903540.3821@asgard.lang.hm>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/142622>

On Fri, Mar 19, 2010 at 10:05,  <david@lang.hm> wrote:
>
> if you can force people to have a consistant UUID, you can force them to
> have a consistant e-mail address (and submit mapping updates if it changes)
>
> if you can't force people to maintain a consistant e-mail, why do you think
> they would maintain a consistant UUID?

Firstly, please note that a UUID is defined in this context as any
string that the user deems for himself to be uniquely identifying of
himself; a UUID allows a user to determine his canonical
representation from the very start.

There's no forcing; there can't be. This is meant to help users manage
their own identities.

A UUID is basically only subject to change due to:

    * typos when configuring

A name/email pair (as in the user.name and user.email variables) is
subject to change due to:

    * typos when configuring
    * legal name changes
    * email account switching

Naturally, older commits and wrong UUIDs would need mappings, but
that's no different than the current situation except for the fact
that UUIDs would not change as frequently.

That aside, an alternative solution that is not as powerful but that
is less invasive would be to allow users to transmit authorship
information as part of the patch payload separate from the usual email
headers (or something like this). Erik Faye-Lund suggests this is
already easily done, but I'm not so sure.
