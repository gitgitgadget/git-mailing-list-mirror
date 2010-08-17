From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: Re: [WIP/PATCH] Teach fast-import to print the id of each imported
 commit
Date: Tue, 17 Aug 2010 22:32:20 +0530
Message-ID: <20100817170216.GA14491@kytes>
References: <20100701031819.GA12524@burratino>
 <20100701054849.GA14972@burratino>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, "Shawn O. Pearce" <spearce@spearce.org>,
	Sverre Rabbelier <srabbelier@gmail.com>,
	David Barr <david.barr@cordelta.com>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Tue Aug 17 19:04:23 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OlPaH-0008BI-Lr
	for gcvg-git-2@lo.gmane.org; Tue, 17 Aug 2010 19:04:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757832Ab0HQRER (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 17 Aug 2010 13:04:17 -0400
Received: from mail-yw0-f46.google.com ([209.85.213.46]:35045 "EHLO
	mail-yw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757742Ab0HQREP (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 17 Aug 2010 13:04:15 -0400
Received: by ywh1 with SMTP id 1so2587506ywh.19
        for <git@vger.kernel.org>; Tue, 17 Aug 2010 10:04:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :in-reply-to:user-agent;
        bh=3283bS2RtJlZ3RymuGSOICnrxNvSB7DvPvdSmnXPSPM=;
        b=bmdTbRg8drJSaJC0/rf46Q/6Nhtn4fa002FSxVW7hUi/VtQcv/hqfsiFpk/AOK1mGA
         oJX0TgzFbJ/+UgkAqCpzHVC5qMBolGdrvWv3kwdXo4BgwBuzAhe3FBwPQAwgqeMSaw9u
         GE3lqsTPfRB2WBM2MydBuAbje4+sL8W3Bt00Y=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=KiGCpxDKJddUEuJV8W1LQETWUyKGvpFBNWX4tkT1RhXcg4bCvjqRoPPoxdQuRDYalR
         jiUm1JjIJowvnHSuiFIDNnlaKzSLEUY312EhOzmPooLaeyOyPbCDjefz+Tau83Iuedg2
         KZZB0YtkiBBtbzBUXcEc7VPyt2GADMrcyrGw4=
Received: by 10.151.92.3 with SMTP id u3mr7334592ybl.209.1282064654634;
        Tue, 17 Aug 2010 10:04:14 -0700 (PDT)
Received: from kytes ([203.110.240.41])
        by mx.google.com with ESMTPS id g31sm6294858ibh.16.2010.08.17.10.04.10
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Tue, 17 Aug 2010 10:04:13 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20100701054849.GA14972@burratino>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/153763>

Hi,

Jonathan Nieder writes:
> For the svn importer, it would be useful to have a map from
> subversion revision numbers to git commits.  This is particularly
> relevant because the subversion api sometimes represents as "copy
> this directory from this revision", and the importer needs to be
> able to access the corresponding trees.  So (optionally) print
> each commit id when the corresponding object is written.
> 
> Unfortunately when each commit object is written, it is not yet
> accessible to the caller.  The corresponding pack index
> and header are not written until the next checkpoint finishes.
> 
> Should fast-import accept lines of the form
> 
>  M 100644 <commit id>:<path> <path>
> 
> and
> 
>  M 040000 <commit id>:<path> <path>
> 
> to allow the caller to use commits before they are accessible
> through the git object database?
> 
> Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
> but definitely not ready for inclusion

I'm resurrecting this thread. We need to finish this feature before we
can finish the dumpfilev3 support in svn-dump-fast-export.

-- Ram
