From: Peter Harris <git@peter.is-a-geek.org>
Subject: Re: sparse support in pu
Date: Mon, 17 Aug 2009 08:52:26 -0400
Message-ID: <eaa105840908170552m3eaf0f92j523ddad98dd67a3@mail.gmail.com>
References: <2729632a0908162309ma6e7d41kc3bafe4575120630@mail.gmail.com>
	 <fcaeb9bf0908170117v67e9f8b1ga56edcda14821e91@mail.gmail.com>
	 <2729632a0908170149o425544dcw52aeb6ac6ee1437d@mail.gmail.com>
	 <fcaeb9bf0908170321o43fa4a6bv95dd78ff7889686f@mail.gmail.com>
	 <4A8932BB.7030002@viscovery.net>
	 <fcaeb9bf0908170441o30005085nb0d4e08f333b6146@mail.gmail.com>
	 <alpine.DEB.1.00.0908171425410.4991@intel-tinevez-2-302>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Nguyen Thai Ngoc Duy <pclouds@gmail.com>,
	Johannes Sixt <j.sixt@viscovery.net>, skillzero@gmail.com,
	git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Mon Aug 17 14:52:38 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Md1hV-00055d-SC
	for gcvg-git-2@lo.gmane.org; Mon, 17 Aug 2009 14:52:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751129AbZHQMw2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 17 Aug 2009 08:52:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750991AbZHQMw1
	(ORCPT <rfc822;git-outgoing>); Mon, 17 Aug 2009 08:52:27 -0400
Received: from mail-ew0-f214.google.com ([209.85.219.214]:49756 "EHLO
	mail-ew0-f214.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750872AbZHQMw1 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 17 Aug 2009 08:52:27 -0400
Received: by ewy10 with SMTP id 10so2912438ewy.37
        for <git@vger.kernel.org>; Mon, 17 Aug 2009 05:52:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:sender:received:in-reply-to
         :references:date:x-google-sender-auth:message-id:subject:from:to:cc
         :content-type:content-transfer-encoding;
        bh=3xVoWtB1Yrzf/mqqHTll/A0+Nv0AD4WTCA3dmHWhJO0=;
        b=daGcdLlremmVlzQZcUFTHr1fJF7Py9LTkP5LtXGY2SEWTaKWmirzzU1/ZesSzru80K
         HVIzxZsQWOskTehMnmk7DTlqpqJu8tBeQ3tr7cs/B4T6oqEEqFvfPuRXsH+dYuzpLjbo
         zLQ5O72rjzEH+lN98M4l3qqo4y+FJIMyew480=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:sender:in-reply-to:references:date
         :x-google-sender-auth:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        b=dU41whkx7Eh0ddMc28fdH/DKN0ogPdDJFIMzcmZLwQF3LXIIeaSWuW3UIXgOhpiFV7
         vyWkdyoV+oGKu5SlTtaKVlRAC1DatFtoQoTHqAArHRyWR+4gCwdA93nQFosXfa9d1e/N
         rMYxaHZni6Yatwk7cBuxkCeWre67IF8gIsYvo=
Received: by 10.210.142.10 with SMTP id p10mr3210456ebd.43.1250513547694; Mon, 
	17 Aug 2009 05:52:27 -0700 (PDT)
In-Reply-To: <alpine.DEB.1.00.0908171425410.4991@intel-tinevez-2-302>
X-Google-Sender-Auth: c6a7b50b8cb709f6
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/126175>

On Mon, Aug 17, 2009 at 8:29 AM, Johannes Schindelin wrote:
> If I want to have a sparse checkout, I know which files I _want_.

That's funny. I have a git tree that would benefit from sparse
checkout. I know which path I _don't_ want. Specifying all the paths I
want would be a rather longer (and more error-prone) list. I suspect
it would be best to support both.

Does sparse use the same parser as .gitignore? (I guess not, if it
handles trailing slashes differently?) If so, it would be trivial to
turn "exclude path" into "exclude all but path" (or vice-versa) with:

*
!path

Peter Harris
