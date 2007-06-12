From: "Lars Hjemli" <hjemli@gmail.com>
Subject: Re: [PATCH 5/5] Add gitmodules(5)
Date: Tue, 12 Jun 2007 10:27:00 +0200
Message-ID: <8c5c35580706120127p649227d8gc706cb8b364d02b9@mail.gmail.com>
References: <20070611225918.GD4323@planck.djpig.de>
	 <11816319211097-git-send-email-hjemli@gmail.com>
	 <20070612080402.GQ955MdfPADPa@greensroom.kotnet.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Cc: "Frank Lichtenheld" <frank@lichtenheld.de>,
	"Junio C Hamano" <gitster@pobox.com>, git@vger.kernel.org
To: skimo@liacs.nl
X-From: git-owner@vger.kernel.org Tue Jun 12 10:27:14 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Hy1ib-0001lq-Gs
	for gcvg-git@gmane.org; Tue, 12 Jun 2007 10:27:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752681AbXFLI1E (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 12 Jun 2007 04:27:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752760AbXFLI1E
	(ORCPT <rfc822;git-outgoing>); Tue, 12 Jun 2007 04:27:04 -0400
Received: from nz-out-0506.google.com ([64.233.162.235]:43287 "EHLO
	nz-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752681AbXFLI1B (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 12 Jun 2007 04:27:01 -0400
Received: by nz-out-0506.google.com with SMTP id n1so1562312nzf
        for <git@vger.kernel.org>; Tue, 12 Jun 2007 01:27:01 -0700 (PDT)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=p7HrORDHwNw1O+a8WUMc7j+cE6oe8MHWqAKKZAbysBjhjmYq8FwOLwDZqBEIC5Hc7pwkiLbtr5adnAIW/r/nw5v+jjHUeBMl5lsmrtkmEx+RUfpK/tMU3wJOD42RSQ/v4YhGETzkmzQbFwtSpHmf7ugRujo31ll1KxhNKd/3TGI=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=eCHiXkf32xDKXQfdL/46JadazbcICxI9jGBacWZStznLwAXgkgUYZDUPl0yoHB1s2uoE6XZHrC4ER8SWVrdjGo5HBA9F+HPlnTrbruqvAyEdsg3UJ7qZWTQ2eqssffyyRmJSh9XEnDYFuMvSMWxuj9pftD3haMTaDcxAXJGtwYE=
Received: by 10.114.184.16 with SMTP id h16mr2237328waf.1181636820661;
        Tue, 12 Jun 2007 01:27:00 -0700 (PDT)
Received: by 10.115.73.2 with HTTP; Tue, 12 Jun 2007 01:27:00 -0700 (PDT)
In-Reply-To: <20070612080402.GQ955MdfPADPa@greensroom.kotnet.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/49935>

On 6/12/07, Sven Verdoolaege <skimo@kotnet.org> wrote:
> On Tue, Jun 12, 2007 at 09:05:21AM +0200, Lars Hjemli wrote:
> > +The file contains one subsection per submodule, and the subsection value
> > +is the name of the submodule. Each submodule section also contains the
> > +following required keys:
>
> Your only argument for making them required was that Junio thought that
> not having them might be ambiguous, but he doesn't think so anymore.

Well, I actually also had an argument about being strict in the
beginning and possibly loosen the rules later on. Anyways, I can do a
patch on top of this series (if/when it's accepted) and let Junio
decide to apply or drop the 'optional path' stuff.

>
> > +submodule.<name>.path::
> > +     Defines the path, relative to the top-level directory of the git
>
> Your previous patch had "_a_ path" instead of "_the_ path".
> I prefer the former since it allows a module to be checkoud out
> at multiple locations.

This is somewhat intentional. I want to move the submodule repos into
.git/submodules/$name/ (with working dir) and symlink this directory
when 'checking out' the submodule. This would be a simple solution for
the following problems:
  -keeping submodule modifications between checkouts
  -having submodules within submodules

Multiple checkout paths for a single submodule will bring havoc on
this plan, so I need to ask: what is the use-case for multiple
checkout paths?

-- 
larsh
