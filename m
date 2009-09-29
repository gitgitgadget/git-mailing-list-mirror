From: Ben Bennett <benbennett@gmail.com>
Subject: Re: clone from url with email address as username?(escaping @ symbol)
Date: Tue, 29 Sep 2009 13:55:57 -0500
Message-ID: <970bc7c80909291155y492b458fg237c2f9d028af718@mail.gmail.com>
References: <970bc7c80909290720i1c5566fer1c1a3db744edc609@mail.gmail.com>
	 <fabb9a1e0909290725w616c3ea9vcb1d2c53950f7788@mail.gmail.com>
	 <vpq1vlp962h.fsf@bauges.imag.fr>
	 <fabb9a1e0909290732h5119170ew133d906b67e49f99@mail.gmail.com>
	 <970bc7c80909290831l59b7fc4at4ec0082f42f3ef87@mail.gmail.com>
	 <vpq63b1u1p6.fsf@bauges.imag.fr>
	 <970bc7c80909291051q5dff9209u650cee4f84d92fae@mail.gmail.com>
	 <vpq1vlpr5le.fsf@bauges.imag.fr> <vpqpr99pqle.fsf@bauges.imag.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Sverre Rabbelier <srabbelier@gmail.com>, git@vger.kernel.org
To: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
X-From: git-owner@vger.kernel.org Tue Sep 29 20:56:12 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Mshro-00057b-2T
	for gcvg-git-2@lo.gmane.org; Tue, 29 Sep 2009 20:56:04 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753861AbZI2Szz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 29 Sep 2009 14:55:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753762AbZI2Szy
	(ORCPT <rfc822;git-outgoing>); Tue, 29 Sep 2009 14:55:54 -0400
Received: from mail-px0-f194.google.com ([209.85.216.194]:58102 "EHLO
	mail-px0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753741AbZI2Szy (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 29 Sep 2009 14:55:54 -0400
Received: by pxi32 with SMTP id 32so4646610pxi.4
        for <git@vger.kernel.org>; Tue, 29 Sep 2009 11:55:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type;
        bh=vji6btGsMZxAz+9mtei+9KxtVX7bQpA+kJ4dkWCx9Ko=;
        b=ETswnpshCQJJgH/UN6W8/rqHhgLdNEdciMljRAra2pxBkg31oyUOxVU85Nv8r0X39M
         7QKIR2343s1/7sG3EeCJsQhbaGzSHaV99COQab2SJFsank+DzKfglhcQUDpOmzx9uYHH
         iZuQ0teoYzhJ90aDPa8IVtmyYHHi+Myug187o=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        b=m9tVhyQ/5ppQvMUmzSobGdk4DG9VnRD4JPRoG6K3kfBosH860Lds9IZZ5Hv2bYVsCa
         532wDzjpsroagJ3nfseG/gvQITeAXxR6OwNcURSq0HxBEVGYt4Gj8QXMS376i/novzW6
         t4b0jPy6AslU7Omt6gv+X/XxVHBOj7IHI/Uyg=
Received: by 10.141.18.6 with SMTP id v6mr288945rvi.148.1254250557369; Tue, 29 
	Sep 2009 11:55:57 -0700 (PDT)
In-Reply-To: <vpqpr99pqle.fsf@bauges.imag.fr>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/129323>

I will look at it tonight. But my fix would be to automatically escape
the @ symbol when  git passes onto curl.
Don't know if this would work easy or not, but it would be something
along the lines of .

https://(USERNAME)@(SERVER_ADDR)

The @ would be  the last index of the @ symbol in the URL.
Then somekind of function that escape_username_for_curl.




On Tue, Sep 29, 2009 at 1:12 PM, Matthieu Moy
<Matthieu.Moy@grenoble-inp.fr> wrote:
> Matthieu Moy <Matthieu.Moy@grenoble-inp.fr> writes:
>
>> OK, so it seems Git should be fixed to unescape this %40 somewhere,
>> most likely in http_auth_init in http.c, in addition to by fix
>> below.
>
> ... err, no not _in addition_ to it, forget this. There's one @ and
> git finds it correctly.
>
> --
> Matthieu Moy
> http://www-verimag.imag.fr/~moy/
>
