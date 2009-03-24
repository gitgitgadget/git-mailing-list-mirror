From: Erik Faye-Lund <kusmabite@googlemail.com>
Subject: Re: [PATCH 2/9] builtin-apply: use warning() instead of 
	fprintf(stderr, "warning: ")
Date: Tue, 24 Mar 2009 02:25:02 +0100
Message-ID: <40aa078e0903231825w54c9dca2xc68a849d245916a4@mail.gmail.com>
References: <cover.1237856682.git.vmiklos@frugalware.org>
	 <1fcc4848dd7a24f846bb302bbb555bf1bac795a5.1237856682.git.vmiklos@frugalware.org>
	 <9287282d966904f06ae4b3d7cfdf1d79eb645b69.1237856682.git.vmiklos@frugalware.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
	John Tapsell <johnflux@gmail.com>,
	Git Mailing List <git@vger.kernel.org>
To: Miklos Vajna <vmiklos@frugalware.org>
X-From: git-owner@vger.kernel.org Tue Mar 24 02:26:41 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LlvPb-0001rO-Ur
	for gcvg-git-2@gmane.org; Tue, 24 Mar 2009 02:26:40 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753497AbZCXBZK convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 23 Mar 2009 21:25:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752457AbZCXBZJ
	(ORCPT <rfc822;git-outgoing>); Mon, 23 Mar 2009 21:25:09 -0400
Received: from mail-ew0-f165.google.com ([209.85.219.165]:35105 "EHLO
	mail-ew0-f165.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750855AbZCXBZH convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 23 Mar 2009 21:25:07 -0400
Received: by ewy9 with SMTP id 9so1888927ewy.37
        for <git@vger.kernel.org>; Mon, 23 Mar 2009 18:25:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=LqjISTVlYcacK2RxEuwQyQylZMdjI++mGpvzCqWt4JY=;
        b=Ii1u9sFS24v64lpwWMCsUOc3i5D1WVyUgI6W3dTY6AZUEoJ2VDTor/ptYKi8wvH6Wk
         bLIb7feWVuuo54y/YAN8KISUu6nMRXaH449pDWYrMmv0kUaelNxkhYqwSryFw7C+SQ/L
         7dYAlLBJfULcQPlmG1RDsU6QYIHhkrvtgCyrg=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=googlemail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=kXzW9Xnq9xCy0z9sdWnS6E0pzf/1Ckl31edVxkvBVGe0sxV8zERJiS7Sbn+y3umKR8
         VLCvebvrFzkw7ju9C/WPqI4OV8RTkt7xBDIR5r06PjQ4br/QuenVq6zvc3lkmLZ3YsuC
         cwuHAftfhbmDcBIqVNGCrDOSbXc7T3kWrf7fM=
Received: by 10.210.53.5 with SMTP id b5mr2746136eba.90.1237857902761; Mon, 23 
	Mar 2009 18:25:02 -0700 (PDT)
In-Reply-To: <9287282d966904f06ae4b3d7cfdf1d79eb645b69.1237856682.git.vmiklos@frugalware.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/114386>

On Tue, Mar 24, 2009 at 2:09 AM, Miklos Vajna <vmiklos@frugalware.org> =
wrote:
> @@ -2932,8 +2932,7 @@ static int write_out_one_reject(struct patch *p=
atch)
> =A0 =A0 =A0 =A0cnt =3D strlen(patch->new_name);
> =A0 =A0 =A0 =A0if (ARRAY_SIZE(namebuf) <=3D cnt + 5) {
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0cnt =3D ARRAY_SIZE(namebuf) - 5;
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 fprintf(stderr,
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 "warning: truncating .r=
ej filename to %.*s.rej",
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 warning("truncating .rej filename to %.=
*s.rej",

Again, doesn't this change the output?

--=20
Erik "kusma" Faye-Lund
kusmabite@gmail.com
(+47) 986 59 656
