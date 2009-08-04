From: Martinolich Paul <goldenautumnday@gmail.com>
Subject: non-recursive path limits
Date: Tue, 4 Aug 2009 08:10:52 -0400
Message-ID: <3E7A2158-B7F8-4A75-902E-25A21E4D87D6@gmail.com>
Mime-Version: 1.0 (Apple Message framework v935.3)
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Aug 04 14:11:13 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MYIrI-0006cE-EO
	for gcvg-git-2@gmane.org; Tue, 04 Aug 2009 14:11:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754914AbZHDMLC (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 4 Aug 2009 08:11:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754820AbZHDMLB
	(ORCPT <rfc822;git-outgoing>); Tue, 4 Aug 2009 08:11:01 -0400
Received: from mail-yw0-f177.google.com ([209.85.211.177]:52561 "EHLO
	mail-yw0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754540AbZHDMLA (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 4 Aug 2009 08:11:00 -0400
Received: by ywh7 with SMTP id 7so5008607ywh.21
        for <git@vger.kernel.org>; Tue, 04 Aug 2009 05:11:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:from:to
         :content-type:content-transfer-encoding:mime-version:subject:date
         :x-mailer;
        bh=AqEJiCY15P0/yRyse5QDoAYqOzHkzMoxiM3cFP3h5E0=;
        b=GIhKfxtNW++KpwzFegXNO495noVBPoOiu3npWS8QoPAO/fgOYhKnVnmRnTjXt30rd1
         ZlP2nG3sSbrNMCGX9fyzghumTgoczJbwhLC5f5W+5CnARuRh6U3a/6mpJxLGrS258SNt
         TVexR3yrZ+5mbfi0VdZQ1Wpo7A6LAG+Wx6rKw=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:from:to:content-type:content-transfer-encoding
         :mime-version:subject:date:x-mailer;
        b=AUuHyMd5vOSIG9i3bLNpypL1zdwe1WMd4f6YDJbM4qRHQ0JuXq1JmqJcqbnuZGF0VY
         S6Rbe5ozg1sM4KoEriXfcmYviHsKoLqAGFX/8ICMqD2YgoTG4LET5oa7oQVANQWG8gUN
         r7nzPOndW6FMumK1WpclkWOe+DFsIx/xH7xrk=
Received: by 10.100.154.9 with SMTP id b9mr8634297ane.11.1249387860807;
        Tue, 04 Aug 2009 05:11:00 -0700 (PDT)
Received: from ?192.168.1.66? (pool-71-98-165-52.tampfl.dsl-w.verizon.net [71.98.165.52])
        by mx.google.com with ESMTPS id b29sm2761588ana.11.2009.08.04.05.10.58
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Tue, 04 Aug 2009 05:11:00 -0700 (PDT)
X-Mailer: Apple Mail (2.935.3)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/124779>

Is there a way to perform non-recursive path limiting on functions  
like 'git log', 'git format-patch', etc.

Each of these functions can limit to a path using the '-- <path>'  
notation.  By default, it recursively
goes down the directory tree.  I would like to limit the tree descent  
to one level.  For example,

repos/a-dir/a1.c
repos/a-dir/a2.c
repos/a-dir/a-lib/alib1.c
repos/a-dir/a-lib/alib2.c

If we are in repos, then 'git log -- a-dir' will show all four files.   
However, I only wish to see the
output for all files that are the 'a-dir' level.  For the above, that  
would consist of a1.c and a2.c.
However, I also wish to see any files that might have existed in the  
history at this level.  I know
I can do 'git log -- a-dir/a1.c' to search all history for the a1.c  
file, but I want the history of the
a-dir directory (only).

Is there a way to accomplish this?

Thanks,

Paul
