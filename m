From: "Paolo Teti" <paolo.teti@gmail.com>
Subject: Re: git-rebase (1.5.0.6) errors
Date: Fri, 18 May 2007 16:39:46 +0200
Message-ID: <34a7ae040705180739i38d4853ci95717407e81add7b@mail.gmail.com>
References: <Pine.LNX.4.64.0705181130570.28356@kivilampi-30.cs.helsinki.fi>
	 <34a7ae040705180331x1a86782fh3b2c6a87db32030e@mail.gmail.com>
	 <Pine.LNX.4.64.0705181640270.14736@kivilampi-30.cs.helsinki.fi>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: "David Kastrup" <dak@gnu.org>, git@vger.kernel.org
To: "=?ISO-8859-1?Q?Ilpo_J=E4rvinen?=" <ilpo.jarvinen@helsinki.fi>
X-From: git-owner@vger.kernel.org Fri May 18 16:40:00 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Hp3cd-0005n0-6R
	for gcvg-git@gmane.org; Fri, 18 May 2007 16:39:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754315AbXEROjv convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git@m.gmane.org>); Fri, 18 May 2007 10:39:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754974AbXEROjv
	(ORCPT <rfc822;git-outgoing>); Fri, 18 May 2007 10:39:51 -0400
Received: from nz-out-0506.google.com ([64.233.162.230]:59581 "EHLO
	nz-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754315AbXEROju convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 18 May 2007 10:39:50 -0400
Received: by nz-out-0506.google.com with SMTP id r28so1356661nza
        for <git@vger.kernel.org>; Fri, 18 May 2007 07:39:50 -0700 (PDT)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=JEmRGhGQn5UfYrPvexhQFVefXtQrTq500vs08jAQtF6wJTfDousdB//Fp7Fl6kkyuwWugwtdNBXPKuY/9oi+QAWqdhafiGqWfwjXTWjBX1R7Nng8Fp17pPJ0Fjmv088upxFUA3zvqLWxEgkvNYMQXcFIDX4lsuOwqIA42IyC+bE=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=ABZKiZIOyLVlLB4Hw4S2daIcGn7FKNFr6fcmUEHxHbVS09Gj6uLypMse9Fk7tEkGxPbs7GQL8DkrPsXR7HmSi9ebkP082HUe9fClNc8XZ0tkvZUzqTzBmmeaDPJXcxFDz7M6gHu7fNF+DdlWtQlVLARLOXso1o0QOJF3/Jiooh0=
Received: by 10.114.154.1 with SMTP id b1mr897385wae.1179499186702;
        Fri, 18 May 2007 07:39:46 -0700 (PDT)
Received: by 10.115.58.17 with HTTP; Fri, 18 May 2007 07:39:46 -0700 (PDT)
In-Reply-To: <Pine.LNX.4.64.0705181640270.14736@kivilampi-30.cs.helsinki.fi>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/47612>

2007/5/18, Ilpo J=E4rvinen <ilpo.jarvinen@helsinki.fi>:

> ...sizeof(size_t) =3D=3D sizeof(int) should hold...

what I have reported is not necessarily the cause of your error. Yes

BUT size_t is UNSIGNED and ssize_t is SIGNED.

The problem is that We store a signed return value into a unsigned vari=
able.
So the check against -1 has no sense.

and please note that also sizeof(int) =3D=3D sizeof(unsigned int), but =
-1
is a signed int !!

I repeat: this is not necessarily the cause of your error.
