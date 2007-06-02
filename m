From: "Lars Hjemli" <hjemli@gmail.com>
Subject: Re: [PATCH] Let .git/config specify the url for submodules
Date: Sat, 2 Jun 2007 11:53:19 +0200
Message-ID: <8c5c35580706020253j4e24785cyce712460d8d1a1b8@mail.gmail.com>
References: <8c5c35580705301717h4e9b127fr21ee19764f8ec288@mail.gmail.com>
	 <8c5c35580706010745l76fc5410l21f2e3f385693ad9@mail.gmail.com>
	 <20070601145104.GY955MdfPADPa@greensroom.kotnet.org>
	 <8c5c35580706010856s390b1157p3ea0d28cb2074cae@mail.gmail.com>
	 <alpine.LFD.0.98.0706010919360.3957@woody.linux-foundation.org>
	 <7vfy5bzby1.fsf@assigned-by-dhcp.cox.net>
	 <8c5c35580706020013g2a4039fcsdf8974da8cd4c2c2@mail.gmail.com>
	 <20070602074410.GA955MdfPADPa@greensroom.kotnet.org>
	 <8c5c35580706020139k3beae8bbj3f51eee0ff5fd30c@mail.gmail.com>
	 <7vejkuyaxq.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Cc: skimo@liacs.nl, "Linus Torvalds" <torvalds@linux-foundation.org>,
	git@vger.kernel.org
To: "Junio C Hamano" <junkio@cox.net>
X-From: git-owner@vger.kernel.org Sat Jun 02 11:53:29 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HuQIa-0000HE-TR
	for gcvg-git@gmane.org; Sat, 02 Jun 2007 11:53:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754568AbXFBJxV (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 2 Jun 2007 05:53:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754710AbXFBJxV
	(ORCPT <rfc822;git-outgoing>); Sat, 2 Jun 2007 05:53:21 -0400
Received: from wa-out-1112.google.com ([209.85.146.181]:49160 "EHLO
	wa-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754987AbXFBJxU (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 2 Jun 2007 05:53:20 -0400
Received: by wa-out-1112.google.com with SMTP id j4so841479wah
        for <git@vger.kernel.org>; Sat, 02 Jun 2007 02:53:20 -0700 (PDT)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=gfnqKDK3Rgjx/O//CtKbVX3EAjJTCKfotb0fXgRh/C9x6b2x9K/oM3IVW7hDC/baLVpfB5dQUPieZK68klrxtQRdcRbL2PWwSpwO2VK+5N/Of5PoV8yRvXxhLAstmXgo2VJdA28od5tXHC9kNh7tmlpBJfA0QJSUADtdQomaJBU=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=XZyMcuj2d9Mp7EbOickSG5AGJYCqtm8CNjmt6IARVJk9gQWJmEbOyryAqf/BsjxhRh/4oe6cU1qDQDeh22CpzFYIOIneTmR5qWf5ET+0Z8y2EZwXP8llVsBR+NJqj5KjwdWaZ/AH1pURpb02/gAoXw3o3uwVo1pBxnqvUgBZjJE=
Received: by 10.114.174.2 with SMTP id w2mr2732553wae.1180777999625;
        Sat, 02 Jun 2007 02:53:19 -0700 (PDT)
Received: by 10.114.235.4 with HTTP; Sat, 2 Jun 2007 02:53:19 -0700 (PDT)
In-Reply-To: <7vejkuyaxq.fsf@assigned-by-dhcp.cox.net>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/48919>

On 6/2/07, Junio C Hamano <junkio@cox.net> wrote:
> "Lars Hjemli" <hjemli@gmail.com> writes:
>
> > But why would we want to design .gitmodules in a way that makes it
> > hard to do the mapping from path to url?
>
> Perhaps because "path" is not the "identity" of the subproject, but
> the (logical) subproject name is?
>
>

Ok.

So I'll make 'git-submodule' expect the .gitmodules layout to be like this:

[submodule 'xyz']
  url=git://example.com/xyz.git
  path=xyz1
  path=xyz2

And submodule.$name.path should be optional: if no submodule.*.path
entry exists for a given $path, submodule $name == $path.

Ok?

--
larsh
