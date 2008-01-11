From: "Morten Welinder" <mwelinder@gmail.com>
Subject: Re: Decompression speed: zip vs lzo
Date: Fri, 11 Jan 2008 09:18:39 -0500
Message-ID: <118833cc0801110618x54d2ca70o4c9de9b885799141@mail.gmail.com>
References: <e5bfff550801091401y753ea883p8d08b01f2b391147@mail.gmail.com>
	 <7v4pdmfw27.fsf@gitster.siamese.dyndns.org>
	 <47855765.9090001@vilain.net>
	 <alpine.LSU.1.00.0801092328580.31053@racer.site>
	 <47856E8D.4010006@vilain.net> <4785A6DB.3080007@vilain.net>
	 <20080110091607.GA17944@artemis.madism.org>
	 <alpine.LFD.1.00.0801101332150.3054@xanadu.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: "Pierre Habouzit" <madcoder@debian.org>,
	"Sam Vilain" <sam@vilain.net>,
	"Git Mailing List" <git@vger.kernel.org>,
	"Johannes Schindelin" <Johannes.Schindelin@gmx.de>,
	"Marco Costalba" <mcostalba@gmail.com>,
	"Junio C Hamano" <gitster@pobox.com>
To: "Nicolas Pitre" <nico@cam.org>
X-From: git-owner@vger.kernel.org Fri Jan 11 15:19:36 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JDKjQ-0000sx-1I
	for gcvg-git-2@gmane.org; Fri, 11 Jan 2008 15:19:36 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759162AbYAKOSo (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 11 Jan 2008 09:18:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758930AbYAKOSo
	(ORCPT <rfc822;git-outgoing>); Fri, 11 Jan 2008 09:18:44 -0500
Received: from fg-out-1718.google.com ([72.14.220.156]:24032 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1761220AbYAKOSn (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 11 Jan 2008 09:18:43 -0500
Received: by fg-out-1718.google.com with SMTP id e21so1144785fga.17
        for <git@vger.kernel.org>; Fri, 11 Jan 2008 06:18:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        bh=3ZAbOh503jUq/zR19dOQtfHrhsbe0QYDwjSq3GisXvo=;
        b=ua2yPVTgauW1pvqHBix0u9B8+iID2ZTb5CyzTuPgSjmqh0kgMArLG1J1quLYRa6DgNTNtO+lJi3HthqQCoqsM16dO+okeVr65rTpSSJIkrdBjxGvxUmIl3fh7ouedtwKTiV9Tqrgy2zPjSz889hcslXMIe4/GR8tp7uMwGHEMKM=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=n4IwH+ukKc9MI4HBidSUcfmhd6Z0Z6AHgVV6fJzTyB7V3PHTsOxjKsKVMzHwGCt1cSfpGNuw3SsDjisNYR+9lKkVagfd3b5UjEBmHqnpyq7YWJXXxhJBTJzgcJpVuz+4Jcjdy2CoWW9nTOpmKbZfnGWWviWktCE6iZs8MRB9x9g=
Received: by 10.86.58.3 with SMTP id g3mr3034383fga.1.1200061119436;
        Fri, 11 Jan 2008 06:18:39 -0800 (PST)
Received: by 10.86.29.17 with HTTP; Fri, 11 Jan 2008 06:18:39 -0800 (PST)
In-Reply-To: <alpine.LFD.1.00.0801101332150.3054@xanadu.home>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/70162>

> This is really the big point here.  Git uses _lots_ of *small* objects,
> usually much smaller than 12KB.  For example, my copy of the gcc
> repository has an average of 270 _bytes_ per compressed object, and
> objects must be individually compressed.
>
> Performance with really small objects should be the basis for any
> Git compression algorithm comparison.

If it so happens that one algorithm does much better on small objects
while another does better on large objects, there really is nothing that
prevents using both in a repository.  It's a bit of code bloat, of course.

Morten
