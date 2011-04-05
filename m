From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH] Documentation: enhance gitignore whitelist example
Date: Tue, 5 Apr 2011 16:41:14 -0500
Message-ID: <20110405214114.GA13729@elie>
References: <1302032214-11438-1-git-send-email-eblake@redhat.com>
 <20110405194005.GA32427@elie>
 <201104052315.54375.j6t@kdbg.org>
 <4D9B8862.1050605@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Johannes Sixt <j6t@kdbg.org>, git@vger.kernel.org
To: Eric Blake <eblake@redhat.com>
X-From: git-owner@vger.kernel.org Tue Apr 05 23:42:17 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Q7E0q-0001On-TV
	for gcvg-git-2@lo.gmane.org; Tue, 05 Apr 2011 23:42:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752037Ab1DEVl0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 5 Apr 2011 17:41:26 -0400
Received: from mail-yi0-f46.google.com ([209.85.218.46]:49682 "EHLO
	mail-yi0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751913Ab1DEVlV (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 5 Apr 2011 17:41:21 -0400
Received: by yia27 with SMTP id 27so339146yia.19
        for <git@vger.kernel.org>; Tue, 05 Apr 2011 14:41:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:date:from:to:cc:subject:message-id:references
         :mime-version:content-type:content-disposition:in-reply-to
         :user-agent;
        bh=H/+mDplT3kn6KhX0MPg/NguI0jDyKJV7AYl1KTEvgCQ=;
        b=A6b/af+FyB+UJWeKwL9dKyyCQmLTp//qdbYBgH2jfh42zjMw7wBlgRH6kAKlruMcLH
         vsCIGVCoxH91lL/f26AKKlpaacOdZuBlr8j5vEUA82k9SUDRkITPOmqu5tOIbbHVpqNH
         AU/c/G/cQXpK84O2MQiRKGPt3vzNbR/3ep/VA=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=VTJ2UCb7L+eExxI9TxS0r/y8IRsc9YQL+2DdvTFGgus/3ZTKIburFwW1muqPRkhTby
         a2Zzs9ya0/Ejg2ZxqTZoBr9jIxlKLhQFRCULivyGxczjkwe9R5QbsMKW/qd2ybMYum7T
         s9PB3kZJ+TfPESPO2g260lGCM4lusLRFekbqY=
Received: by 10.236.32.65 with SMTP id n41mr262801yha.221.1302039681133;
        Tue, 05 Apr 2011 14:41:21 -0700 (PDT)
Received: from elie (adsl-69-209-53-77.dsl.chcgil.ameritech.net [69.209.53.77])
        by mx.google.com with ESMTPS id p51sm3039790yhm.52.2011.04.05.14.41.18
        (version=SSLv3 cipher=OTHER);
        Tue, 05 Apr 2011 14:41:19 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <4D9B8862.1050605@redhat.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/170921>

Eric Blake wrote:

> Yeah, but then you have to 'git add -f path/to/file' them every time you
> change them

No, I don't believe that's true.

 $ git add -f git.o
 $ >git.o
 $ git add git.o

.gitignore only protects against starting to track a file that was
previously untracked.

I do tend to use exceptions in .gitignore anyway, since (1) it allows,
as a sanity check,

 $ git ls-files -i --exclude-standard

and (2) to import from or compare to a tarball, one can do

 $ git rm -rf .
 $ git add .
