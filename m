From: Jonathan Nieder <jrnieder@gmail.com>
Subject: [PATCH gitk 0/2] stop clobbering "Remember This View" setting
Date: Sat, 6 Mar 2010 16:46:05 -0600
Message-ID: <20100306224605.GA7064@progeny.tock>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Steve Cotton <steve0001@s.cotton.clara.co.uk>,
	Alexander Gavrilov <angavrilov@gmail.com>, git@vger.kernel.org
To: Paul Mackerras <paulus@samba.org>
X-From: git-owner@vger.kernel.org Sat Mar 06 23:46:32 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1No2l7-0000dD-0M
	for gcvg-git-2@lo.gmane.org; Sat, 06 Mar 2010 23:46:09 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752929Ab0CFWqA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 6 Mar 2010 17:46:00 -0500
Received: from mail-gy0-f174.google.com ([209.85.160.174]:50954 "EHLO
	mail-gy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751632Ab0CFWp7 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 6 Mar 2010 17:45:59 -0500
Received: by gyh3 with SMTP id 3so256927gyh.19
        for <git@vger.kernel.org>; Sat, 06 Mar 2010 14:45:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:mime-version:content-type:content-disposition:user-agent;
        bh=nOcKoVozJXrwAkBNAd4vyPvYdwxFhhF4OoVLxeftkH8=;
        b=ItnScVhPVRhg9wQau/uN9vP4jwUGAtyuslTM0OVROgNUP8Yf5Iz1ReIftuC98OjPhK
         7FA/C3/vNWaFom24llxkROMyXUzNCmhiDJaU2UaNG7upggyzVVUKwYGU11G6G3EZuZZo
         Km4wdoXJk5GMD+Pcfz/O2j77bKjkjbwGhJauk=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:mime-version:content-type
         :content-disposition:user-agent;
        b=gcCtvmjCSQtPaoUkJpjSHnTka/yWMiij1VFRto1BRCrk+spjhAjRSkXv4/2iWOYFpv
         X9KBQtpEqC2Bz3/m9YMY1a+81P2DUl56rjQOZPUrfV2+nDY8RR4UgTdz3mfcOqUqxQp7
         0R+d13fALQLnvQ9C1BcGHW5FvthgSxiLW0528=
Received: by 10.101.28.7 with SMTP id f7mr5654050anj.243.1267915558848;
        Sat, 06 Mar 2010 14:45:58 -0800 (PST)
Received: from progeny.tock (c-98-212-3-231.hsd1.il.comcast.net [98.212.3.231])
        by mx.google.com with ESMTPS id 21sm2870403iwn.3.2010.03.06.14.45.57
        (version=SSLv3 cipher=RC4-MD5);
        Sat, 06 Mar 2010 14:45:58 -0800 (PST)
Content-Disposition: inline
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/141624>

Hi Paul,

As Steve Cotton reported [1], the Edit View... dialog in gitk
always defaults to not remembering the view, which makes it
easy to lose settings if one is not careful.

These patches fix it.  The first one adds two one-line comments
from my investigation into the issue.  The second one fixes the
obvious bug.

I am cc-ing others in case I have missed anything obvious or
people have comments on style.

I hope you enjoy the patches.

Kind regards,
Jonathan Nieder (2):
  gitk: Add comments to explain encode_view_opts and decode_view_opts
  gitk: Edit View unsets Remember this view

 gitk |    6 ++++--
 1 files changed, 4 insertions(+), 2 deletions(-)

[1] http://bugs.debian.org/522520
