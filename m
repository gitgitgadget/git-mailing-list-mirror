From: "David Tweed" <david.tweed@gmail.com>
Subject: Re: How to ignore deleted files
Date: Tue, 11 Mar 2008 15:43:47 +0000
Message-ID: <e1dab3980803110843u3fdf2189xf5931f1cb5526ff9@mail.gmail.com>
References: <47D68203.10905@bioinf.uni-sb.de>
	 <m3y78pxsf5.fsf@localhost.localdomain>
	 <47D69CE0.3030505@bioinf.uni-sb.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: "Jakub Narebski" <jnareb@gmail.com>, git@vger.kernel.org
To: "Andreas Hildebrandt" <anhi@bioinf.uni-sb.de>
X-From: git-owner@vger.kernel.org Tue Mar 11 16:44:59 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JZ6ec-0007uG-D0
	for gcvg-git-2@gmane.org; Tue, 11 Mar 2008 16:44:38 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752716AbYCKPoA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 11 Mar 2008 11:44:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751998AbYCKPn7
	(ORCPT <rfc822;git-outgoing>); Tue, 11 Mar 2008 11:43:59 -0400
Received: from ti-out-0910.google.com ([209.85.142.191]:50091 "EHLO
	ti-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751028AbYCKPn7 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 11 Mar 2008 11:43:59 -0400
Received: by ti-out-0910.google.com with SMTP id 28so986318tif.23
        for <git@vger.kernel.org>; Tue, 11 Mar 2008 08:43:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        bh=oQGp1lulq5mkWXTBC/kpu3KDBPMU/67au54aORXN0yI=;
        b=lXBoxzkVnh5SeNlZSGFHby6urGIrZwJn5WdywMK28jsag5K+7yWOf+A1peaguJ9Vm+nFXwSwVgrCzgSIpe/nMncdLVUV+JjYICRKDJpmuoLqbLDh0qyw0BUZpR63jCKoQ/OCh0+25FRinS7ZRhTyNpQ1kx5hlJN/qaOIGZ4EC74=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=PmDo8aLj8WbKXgf/0vzpMS+Dsk/AqyuGoTsJU5iAJofDKLOpSN11f55iVEY0RI7kWhRLcEXFSS7ONapBFDlPlS0fbgvZrEVBc4t+2DBfECiK1qp+yi+K0X3lzjFa5OO9Wh3YIM4FPs4sr//9X45u4fIPP4B9e+bYcjaSr2acI9Q=
Received: by 10.151.144.4 with SMTP id w4mr3722442ybn.199.1205250228510;
        Tue, 11 Mar 2008 08:43:48 -0700 (PDT)
Received: by 10.150.149.2 with HTTP; Tue, 11 Mar 2008 08:43:47 -0700 (PDT)
In-Reply-To: <47D69CE0.3030505@bioinf.uni-sb.de>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/76871>

On Tue, Mar 11, 2008 at 2:53 PM, Andreas Hildebrandt
<anhi@bioinf.uni-sb.de> wrote:
>  I absolutetly agree that it's strange. The main reason for this is that
>  we have some collections of data files (some of them pretty large) that
>  can be compressed pretty effectively. At compilation time, it is decided
>  if the files are needed or not. If so, they are extracted. In the end,
>  the .tar.gz files are deleted since they are no longer needed. In

This is probably a silly questions: why are you actually deleting the
tar.gz files? If they compress the data files well, then any storage
requirement for keeping them is dwarfed by the size of the unpacked
data files (presumably). If a minor tweak to your build process avoids
more complicated git scripting, that sounds a reasonable trade-off.

-- 
cheers, dave tweed__________________________
david.tweed@gmail.com
Rm 124, School of Systems Engineering, University of Reading.
"while having code so boring anyone can maintain it, use Python." --
attempted insult seen on slashdot
