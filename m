From: Vitor Antunes <vitor.hda@gmail.com>
Subject: Re: [PATCH 2/2] git-p4: Add copy detection support
Date: Sun, 6 Feb 2011 17:25:54 +0000
Message-ID: <AANLkTi=Awi6d77QcbbZ2rDTv6LpP+qjsReJ5=4NyhUBz@mail.gmail.com>
References: <1296429563-18390-1-git-send-email-vitor.hda@gmail.com>
 <1296429563-18390-2-git-send-email-vitor.hda@gmail.com> <20110206002547.GB31245@arf.padd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: git@vger.kernel.org
To: Pete Wyckoff <pw@padd.com>
X-From: git-owner@vger.kernel.org Sun Feb 06 18:26:32 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Pm8Nb-0000JS-9y
	for gcvg-git-2@lo.gmane.org; Sun, 06 Feb 2011 18:26:31 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753333Ab1BFR00 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 6 Feb 2011 12:26:26 -0500
Received: from mail-vw0-f46.google.com ([209.85.212.46]:44332 "EHLO
	mail-vw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752744Ab1BFR0Z (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 6 Feb 2011 12:26:25 -0500
Received: by vws16 with SMTP id 16so2472994vws.19
        for <git@vger.kernel.org>; Sun, 06 Feb 2011 09:26:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-type;
        bh=p2uwHv3QVq+zgkqGel8G6m5xCcZJ/xg49zTPro8v//M=;
        b=LhKi6F8+uBAK59qP0vxNjPm9bM/BFAMIAe5Z+W0Cmu7g7Ya9UlJW1g5gxqHiOQeSG+
         I5binlP/msYS+CApbXlXsZcn0NMVTwR59WCIyOSv91iS2JfHATvVl5BNAnp2mblEn7/t
         XBD04KwYMkTztWHWC/Sa38Wr66FBWiQcsUOno=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        b=Axj+UwCNwZRFSXfOSDDgiWG2tojrwUTbAEQ7/7RIv6YG1UjBHl04JGbZRJGXKGlNPT
         lHq03rU/JcbA1Yx/8D4+vdg/hqyIan6JTLYlRnoPnpPyyVX0F17CeO/o5CAtbT7CZ4rd
         G20ogcHhSUpU9ofpIcvhfDzxyfoDg2JH0Eow0=
Received: by 10.220.198.196 with SMTP id ep4mr3991033vcb.110.1297013184811;
 Sun, 06 Feb 2011 09:26:24 -0800 (PST)
Received: by 10.220.184.75 with HTTP; Sun, 6 Feb 2011 09:25:54 -0800 (PST)
In-Reply-To: <20110206002547.GB31245@arf.padd.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/166156>

Hi Pete,

On Sun, Feb 6, 2011 at 12:25 AM, Pete Wyckoff <pw@padd.com> wrote:
> You can use integrate -t to force the filetype even if the file
> already existed, and skip the whole execbit change.

(Copying help text:
	The -t flag makes the source file's filetype propagate to the target
	file.  Normally, the target file retains its previous filetype.
	Newly branched files always use the source file's filetype.  The
	filetype can still be changed before 'p4 submit' with 'p4 reopen'.
)

Since in git we're only considering newly branched files, I think in
this case "-t" will not add anything. In fact, what is being done here
is detecting exec bit changes from source to target files - we're not
trying to force P4 to use the source's exec bit. Do you agree?

Kind regards,
-- 
Vitor Antunes
