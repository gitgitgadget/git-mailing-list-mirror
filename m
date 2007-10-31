From: Alexander Litvinov <litvinov2004@gmail.com>
Subject: git-svn and auto crlf convertion.
Date: Wed, 31 Oct 2007 10:49:43 +0600
Organization: AcademSoft Ltd.
Message-ID: <200710311049.43861.litvinov2004@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Oct 31 05:50:10 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1In5Wr-000606-Mc
	for gcvg-git-2@gmane.org; Wed, 31 Oct 2007 05:50:10 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752264AbXJaEt4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 31 Oct 2007 00:49:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752373AbXJaEt4
	(ORCPT <rfc822;git-outgoing>); Wed, 31 Oct 2007 00:49:56 -0400
Received: from ug-out-1314.google.com ([66.249.92.169]:42866 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752223AbXJaEtz (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 31 Oct 2007 00:49:55 -0400
Received: by ug-out-1314.google.com with SMTP id z38so246176ugc
        for <git@vger.kernel.org>; Tue, 30 Oct 2007 21:49:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:from:organization:to:subject:date:user-agent:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        bh=eamuWzafrFopUvIiipQwt1uQi2dozR1byFzVGRg/tlU=;
        b=TDiWGiBjv8kHDK7BuZP3XqzojrRQhu19TV6i1xsjH7Di8f5yY9wWLNRy8JpHfjlt80QHR0E1qElxJCrl5d4f7rOp1gMH1muiLBfWEOWSkFmqzDhgiQAr0+Ti2GqBomwagJAlyTSJIKrNPiBdr3A5LAshPoUpPVNzmepPuws6HPI=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:from:organization:to:subject:date:user-agent:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=m+rBR7kdJELcM+DHW9ZlxvrDAiIT0BoZWKVQAxZxMVHugIJ39pNW1ujT2qjpctsKmmcE6J6KGbV456uTDLCheRS/4Hjch+Vpoj+v8ePyFlLptOD5/R2cVaPmroXOf1AtrQ5pIrnPyhltWtcUZA5Q49Wwe1/yOcafHkh3XyZ1JFQ=
Received: by 10.67.195.14 with SMTP id x14mr295100ugp.1193806194178;
        Tue, 30 Oct 2007 21:49:54 -0700 (PDT)
Received: from lan.ac-sw.lcl ( [81.1.223.2])
        by mx.google.com with ESMTPS id l22sm1097257uga.2007.10.30.21.49.52
        (version=TLSv1/SSLv3 cipher=OTHER);
        Tue, 30 Oct 2007 21:49:52 -0700 (PDT)
User-Agent: KMail/1.9.5
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/62791>

Hello.

I have private svn repo with cpp source file in windows encoding (\r\n line 
ending). I am tring to import it into git using git-svn. To make correct crlf 
convertion I have made git svn init first then create 
correct .git/info/attributes file and import repo using git svn fetch 
command. But after import done I have strange situation: after git 
checkout -f master git status show that almost all text files are modified.

As I understand situation git-svn put \r\n encoded files into repo without 
convertng them to \n notation. git-checkout,git-status does the job right and 
found 'modification' as far as they do the needed convertion.

Is there any way to configure git-svn to make proper convertion or it is 
broken and need to be fixed ?
