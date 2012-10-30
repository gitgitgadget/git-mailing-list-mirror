From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: [PATCH v2 4/4] fast-export: make sure refs are updated properly
Date: Tue, 30 Oct 2012 23:56:20 +0100
Message-ID: <CAMP44s2fgB=ruuVBdG6QjF6yviQAxVWFyhN6Vh3DWMGgmOKzyQ@mail.gmail.com>
References: <1351617089-13036-1-git-send-email-felipe.contreras@gmail.com>
	<1351617089-13036-5-git-send-email-felipe.contreras@gmail.com>
	<CAGdFq_j1RROOwxDi1FfJZJ6wiP9y9FWzSpc7MXVSvRmgk0sF9A@mail.gmail.com>
	<CAMP44s3MHrG_XeZEodnxemrW-V18+NHnFvi7koyx9mH8XuHc6w@mail.gmail.com>
	<CAGdFq_jJwZMLq=3co13hs7gas6y9kZRTKwcT+CP=n6-24Uv5Og@mail.gmail.com>
	<CAMP44s2QwdZKqJq0BZ5HOtZYiCMxCxycui9EmxxfL+Sa6M_6+g@mail.gmail.com>
	<CAGdFq_h3L-1rPvb=dSYeXqEea+f+g2kRHp7aAjaU-AxjZHB7dQ@mail.gmail.com>
	<CAMP44s2KNmr7zAvFo2gOR8G=YaoBWiGPCjPY47x00eev6MOAFw@mail.gmail.com>
	<CAGdFq_iiGpYW-txPaa6mZrxg3mYdOX-Ez9uLF-rB5bAjZd5rWg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: ">" <git@vger.kernel.org>, Jeff King <peff@peff.net>,
	Junio C Hamano <gitster@pobox.com>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Johannes Schindelin <johannes.schindelin@gmx.de>,
	Elijah Newren <newren@gmail.com>
To: Sverre Rabbelier <srabbelier@gmail.com>
X-From: git-owner@vger.kernel.org Tue Oct 30 23:56:35 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TTKja-0000QP-7N
	for gcvg-git-2@plane.gmane.org; Tue, 30 Oct 2012 23:56:34 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752500Ab2J3W4V (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 30 Oct 2012 18:56:21 -0400
Received: from mail-ob0-f174.google.com ([209.85.214.174]:63480 "EHLO
	mail-ob0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751068Ab2J3W4U (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 30 Oct 2012 18:56:20 -0400
Received: by mail-ob0-f174.google.com with SMTP id uo13so836752obb.19
        for <git@vger.kernel.org>; Tue, 30 Oct 2012 15:56:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=MrrFR4lGA8TSl65GFMnt+I1bAqiae5teLtgq2rqpMGQ=;
        b=NLwQsIf3PmkdjSA1TjlNwKOEu4M/7Ne68lzPxuPVRm7BR+v1qVm/l1YH/YPAQR2b+F
         91qdyyai/+CksJkK7Oqk4flmlfpmkaDyD49PqCMfQMKbqKKc9y5DNr7A9MXvVHiI1wkX
         9JDVIj/Z29LY4DFdUp1SWnOM7QZICtj6e01dihbVBK0I1DTAhaknDQuJGCwGCB9RfSzt
         2iEID0Li3SKrQSp5xKXnLShgUkPlMPCBr0YUvK21clXoAg80/EilJZlujDnVoDcFugRr
         ySEvfyQdt9Z+kBQd/iSu4464wrXfon7QLbNNxqCAHugMlq3mACgd61rsAnJ29pHKS8uW
         aEBQ==
Received: by 10.60.27.201 with SMTP id v9mr20838971oeg.85.1351637780250; Tue,
 30 Oct 2012 15:56:20 -0700 (PDT)
Received: by 10.60.4.74 with HTTP; Tue, 30 Oct 2012 15:56:20 -0700 (PDT)
In-Reply-To: <CAGdFq_iiGpYW-txPaa6mZrxg3mYdOX-Ez9uLF-rB5bAjZd5rWg@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/208765>

On Tue, Oct 30, 2012 at 11:35 PM, Sverre Rabbelier <srabbelier@gmail.com> wrote:
> On Tue, Oct 30, 2012 at 3:18 PM, Felipe Contreras
> <felipe.contreras@gmail.com> wrote:
>> Which is expected and correct; the branch already points to the right
>> commit, no need for an extra reset.
>
> I think you're correct. Thanks for confirming.

Thanks for reviewing. If you are still not convinced, I could pull the
patches from msysgit and simplify them, I'm sure the end result would
be pretty similar, if not exactly the same as this patch (plus other
orthogonal changes). I saw some patches that were not part of the
patch series you sent before, so maybe that's why you expected certain
behavior that wasn't actually there in that particular patch series.

But hopefully that's not needed.

Cheers.

-- 
Felipe Contreras
