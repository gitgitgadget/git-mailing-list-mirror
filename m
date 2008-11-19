From: "Alex Riesen" <raa.lkml@gmail.com>
Subject: Re: [PATCH] Fix handle leak in builtin-pack-objects
Date: Wed, 19 Nov 2008 14:34:30 +0100
Message-ID: <81b0412b0811190534r4f71f981s53de415f79e56e25@mail.gmail.com>
References: <81b0412b0811190313p643c0cb4vad620ea942aeea93@mail.gmail.com>
	 <4923FE58.3090503@viscovery.net>
	 <alpine.LFD.2.00.0811190753420.27509@xanadu.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: "Johannes Sixt" <j.sixt@viscovery.net>,
	"Junio C Hamano" <gitster@pobox.com>,
	"Git Mailing List" <git@vger.kernel.org>
To: "Nicolas Pitre" <nico@cam.org>
X-From: git-owner@vger.kernel.org Wed Nov 19 14:35:48 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1L2nDe-0007VU-MX
	for gcvg-git-2@gmane.org; Wed, 19 Nov 2008 14:35:47 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753039AbYKSNec (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 19 Nov 2008 08:34:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753004AbYKSNec
	(ORCPT <rfc822;git-outgoing>); Wed, 19 Nov 2008 08:34:32 -0500
Received: from wa-out-1112.google.com ([209.85.146.180]:20805 "EHLO
	wa-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752838AbYKSNeb (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 19 Nov 2008 08:34:31 -0500
Received: by wa-out-1112.google.com with SMTP id v27so1729774wah.21
        for <git@vger.kernel.org>; Wed, 19 Nov 2008 05:34:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to
         :subject:cc:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:references;
        bh=+jk0T87QxoYyhnotGefjzG4l6BG2CrQez9QTlBp1lwQ=;
        b=xArIzfsWElBnyMEVOFtKNxhiD47rceGWzDjBQzdW9W7IlE3H1Ekqaap56I+LjRv+zz
         rHfXHtQnqcn+XqwuZu0nIQR7m+6gqWpAOVvjO71YgtqnjR4PHJePY+UtNmPWfG2dIyNn
         BD5IGp8hpPKCJyEVeFa+UL87hBG4xvNaDSlAs=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version
         :content-type:content-transfer-encoding:content-disposition
         :references;
        b=acZ4md6K6d9VbPUN2rg6Rfh7g78JsjW8Q9LW/gYtFbzSzfuVs8wHmYncDWK9jLssqo
         FD441MMFsjBEoJEPHOpnOuYQBM07/sdmSDeYw/+nX/P9i2r4WMcWvZ6hSCS2GTwjFqGf
         k+xLz7+WmhNIWz7OZLP8aFBu7Ue4UY2xLW20I=
Received: by 10.114.80.1 with SMTP id d1mr655155wab.168.1227101670407;
        Wed, 19 Nov 2008 05:34:30 -0800 (PST)
Received: by 10.114.157.9 with HTTP; Wed, 19 Nov 2008 05:34:30 -0800 (PST)
In-Reply-To: <alpine.LFD.2.00.0811190753420.27509@xanadu.home>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/101343>

2008/11/19 Nicolas Pitre <nico@cam.org>:
> On Wed, 19 Nov 2008, Johannes Sixt wrote:
>> The work-around is to write the repacked objects to a file of a different
>> name, and replace the original after git-pack-objects has terminated.
>>
>> Signed-off-by: Johannes Sixt <j6t@kdbg.org>
>
> Acked-by: Nicolas Pitre <nico@cam.org>
>

Are you sure? Will it work in a real repository? Were noone does
rename the previous pack files into packtmp-something?
