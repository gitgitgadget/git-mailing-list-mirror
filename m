From: Tor Arntsen <tor@spacetec.no>
Subject: Re: Minimum Perl version?
Date: Fri, 24 Sep 2010 12:27:36 +0200
Message-ID: <AANLkTi=3xNSV0y-i=0KUSDRBJ8HmfSfGO7TBHTPiv_KM@mail.gmail.com>
References: <20100924100019.GT23563@ece.pdx.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: git@vger.kernel.org
To: Tait <git.git@t41t.com>
X-From: git-owner@vger.kernel.org Fri Sep 24 12:27:41 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Oz5VF-0005Ln-05
	for gcvg-git-2@lo.gmane.org; Fri, 24 Sep 2010 12:27:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752230Ab0IXK1i (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 24 Sep 2010 06:27:38 -0400
Received: from mail-qy0-f181.google.com ([209.85.216.181]:41910 "EHLO
	mail-qy0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751139Ab0IXK1h (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 24 Sep 2010 06:27:37 -0400
Received: by qyk33 with SMTP id 33so3767424qyk.19
        for <git@vger.kernel.org>; Fri, 24 Sep 2010 03:27:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:sender:received
         :in-reply-to:references:date:x-google-sender-auth:message-id:subject
         :from:to:cc:content-type;
        bh=pdNOsln2/DKT2toIbjPtH9E848DnF9gxrj6aW7cAVbc=;
        b=M/q7wZvqBv5PUAHiLoP9i2YxyxQrQL5EkydOghXnE0XQ8VC3mgcPG7LFcuxOTrARFB
         OT3b22v6tmDkfRYqGVlbxiyJm3DwIsnvfPDtB18J+O0aKWb0wy0z0jpbNan1JXOm57NV
         yO7cZnhpl5Yn8cHWReKJV2ESMX1cz+YlePypI=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:sender:in-reply-to:references:date
         :x-google-sender-auth:message-id:subject:from:to:cc:content-type;
        b=fnb9hpIq0hV5+lQ0i/get/Y8d9ondYFYriEkcTJKAQ84AunuU4DXi7WtiGfkZGs+00
         AYl7a5dGXiVsvYUoe/2yE1XiqslwGXJcs8T0X4fR857TvpCP7Jxuk5BsIgxeScmr3tBo
         fgF+fGFh5s1cdRPubhsKH77q45qf4gfL0rQ3A=
Received: by 10.229.246.83 with SMTP id lx19mr2355022qcb.127.1285324056743;
 Fri, 24 Sep 2010 03:27:36 -0700 (PDT)
Received: by 10.229.62.98 with HTTP; Fri, 24 Sep 2010 03:27:36 -0700 (PDT)
In-Reply-To: <20100924100019.GT23563@ece.pdx.edu>
X-Google-Sender-Auth: lWjcfaOXh9ZYWmghwYI1i8CvL_Y
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/156969>

On Fri, Sep 24, 2010 at 12:00, Tait <git.git@t41t.com> wrote:
>
> What is the minimum Perl version git expects to support?
>
> I ask, because f922df8... seems to have introduced a open() syntax that
> is not compatible with some older Perl versions.

I've found that for add -p you'll need 5.8.x or newer, due to stuff like

                my $fh = undef;
                open($fh, '-|', @_) or die;

which fails in e.g. perl 5.6.
There could be some other stuff (in addition to add -p) that also does
this kind of thing.

-Tor
