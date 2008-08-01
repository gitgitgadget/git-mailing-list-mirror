From: Alexander Litvinov <litvinov2004@gmail.com>
Subject: Re: [PATCH] git-svn now work with crlf convertion enabled.
Date: Fri, 1 Aug 2008 18:27:10 +0700
Organization: AcademSoft Ltd.
Message-ID: <200808011827.11043.litvinov2004@gmail.com>
References: <200807231544.23472.litvinov2004@gmail.com> <7v63qluxsb.fsf@gitster.siamese.dyndns.org> <37fcd2780808010044m424f8d8en67a4e50363238e4d@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: "Junio C Hamano" <gitster@pobox.com>, git@vger.kernel.org,
	"Eric Wong" <normalperson@yhbt.net>
To: "Dmitry Potapov" <dpotapov@gmail.com>
X-From: git-owner@vger.kernel.org Fri Aug 01 13:28:33 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KOso1-00066L-8K
	for gcvg-git-2@gmane.org; Fri, 01 Aug 2008 13:28:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753674AbYHAL1U (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 1 Aug 2008 07:27:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752388AbYHAL1U
	(ORCPT <rfc822;git-outgoing>); Fri, 1 Aug 2008 07:27:20 -0400
Received: from ug-out-1314.google.com ([66.249.92.170]:22178 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752186AbYHAL1T (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 1 Aug 2008 07:27:19 -0400
Received: by ug-out-1314.google.com with SMTP id h2so474509ugf.16
        for <git@vger.kernel.org>; Fri, 01 Aug 2008 04:27:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:organization:to:subject
         :date:user-agent:cc:references:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:message-id;
        bh=Fb0J7lDK44xCwA4PGQI0PoKVZvnjaQHQE/g4nMIklYE=;
        b=o4oVhxB1xfgmPHHfO0lWJniYMOpkN6otwMoBpSP81Ol4tuMLU/lIATr6lVIxVeejh/
         BnBLBaP0rwupWXtoa4REXopRCD8TiNbQXGlEmnjSBljqkMFAUupkC5/7SeO6tQWl4NZw
         Czej4m0h54r8/a5Fk/JHx6qbha4LjQ7bccrPA=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:organization:to:subject:date:user-agent:cc:references
         :in-reply-to:mime-version:content-type:content-transfer-encoding
         :content-disposition:message-id;
        b=EqDS2j1Zh6D7LKMv+esyraMEOzaln30eLVZS2QkY4tBiGzQszzh2iQI0CuleYEgh/8
         0EEUADLGrxcOVO0lmOxHXd8coHHYSr+B2vmbxvgoS4VKWMBcfFsLX89YeuG9p5ubxEHC
         zYgSOhS+RxTKXmQWd5G6/QjIF4Tg4NPV26hHU=
Received: by 10.66.249.20 with SMTP id w20mr3617043ugh.22.1217590037703;
        Fri, 01 Aug 2008 04:27:17 -0700 (PDT)
Received: from lan.ac-sw.lcl ( [91.201.74.194])
        by mx.google.com with ESMTPS id l22sm3740743uga.1.2008.08.01.04.27.15
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Fri, 01 Aug 2008 04:27:16 -0700 (PDT)
User-Agent: KMail/1.9.5
In-Reply-To: <37fcd2780808010044m424f8d8en67a4e50363238e4d@mail.gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/91059>

> git-svn uses git hash-object --stdin-paths, which means that it reads
> filenames from the  standard input, so one optional parameter cannot
> help here. 

We could add some parameter ti git-hash-object to tell that we will pass two 
lines per each file: real file name and proposed file name in workdir.

In this case git-hash-object will be able to do proper convertion.

The main proble is the tracking original file from svn. Propably we could use 
some special dir in worktree to store original file. Or we could make special 
branch to track that files and second one to store converted files.
