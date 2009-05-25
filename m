From: Asger Ottar Alstrup <asger@area9.dk>
Subject: git subtree as a solution to partial cloning?
Date: Mon, 25 May 2009 09:35:38 +0200
Message-ID: <8873ae500905250035h74fc366ct907998c62e518fcf@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Avery Pennarun <apenwarr@gmail.com>,
	Alexander Gavrilov <angavrilov@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon May 25 09:40:00 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1M8Ulq-00066u-8V
	for gcvg-git-2@gmane.org; Mon, 25 May 2009 09:38:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758670AbZEYHfo (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 25 May 2009 03:35:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758742AbZEYHfn
	(ORCPT <rfc822;git-outgoing>); Mon, 25 May 2009 03:35:43 -0400
Received: from mail-ew0-f176.google.com ([209.85.219.176]:54231 "EHLO
	mail-ew0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758652AbZEYHfj (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 25 May 2009 03:35:39 -0400
Received: by ewy24 with SMTP id 24so2906349ewy.37
        for <git@vger.kernel.org>; Mon, 25 May 2009 00:35:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:sender:received:date
         :x-google-sender-auth:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=kVZutAPzMH2bLJB/9JlPkSJPo5WHYS/6U72XuHp9Fus=;
        b=dvPrAV2qXyVZLN5NWyJtVisqsyVXoZl9rLIs0yIeBjwyZvvRATNg8an3W1ro71vwNY
         WsNAob9D4n8DpS+EB6H8XcNw75lhUIqN/0q48XBFMHCOVEzpbDlsbryzjEf5VWbzu47Y
         E/UfPhA8WM4T4IXwKdSkC8YZPMZADJQLtARLM=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:sender:date:x-google-sender-auth:message-id:subject
         :from:to:cc:content-type:content-transfer-encoding;
        b=wAN/XzE7mkaVuFVTSzHHeBp+f2soywaB2IRmFl374tTYqapr6UN/rO66dH9LG5Tm+y
         tOhnk4qZSJCanFbfc1EKgXwdmXtqYhUHP/xdyC9awM8LiaxwWDiBN1mVpnd1JjHOLn65
         49m13Rq/NJiO85wkv/A28YXQ1V8jlHoHprF88=
Received: by 10.216.21.205 with SMTP id r55mr1395864wer.175.1243236938998; 
	Mon, 25 May 2009 00:35:38 -0700 (PDT)
X-Google-Sender-Auth: 31c3f68a8126bdaa
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/119894>

I am considering different ways to get git to handle repositories with
very big files in a setup where partial clone is required, and it
seems git subtree might be a part of the solution.

Does git subtree support splitting at the file level, or only at
directory level? Also, how are conflicts handled when you subtree
merge changes back to the master? For this to work in practice, I
suppose the users of the split repositories should see the conflicts
and fix them themselves. Can the reduced split repositories reuse pack
files from the original repository? Can you think of any other
limitations to git subtree that would prevent it from working with big
files to support a partial cloning setup?

The alternative seems to be git sparse checkout extended with
non-existing narrow clone, but it seems that a git subtree based
approach might be simpler.

Regards,
Asger Ottar Alstrup
