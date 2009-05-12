From: Constantine Plotnikov <constantine.plotnikov@gmail.com>
Subject: Re: Git-SVN on Cygwin: svn+ssh good, https awkward
Date: Tue, 12 May 2009 17:47:05 +0400
Message-ID: <85647ef50905120647r564b13e3gf9cac9a5126ff0c1@mail.gmail.com>
References: <20090425120429.GA417@home>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
To: Matthias Andree <matthias.andree@gmx.de>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue May 12 15:47:25 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1M3sKG-0004nK-Sc
	for gcvg-git-2@gmane.org; Tue, 12 May 2009 15:47:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752057AbZELNrL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 12 May 2009 09:47:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751888AbZELNrJ
	(ORCPT <rfc822;git-outgoing>); Tue, 12 May 2009 09:47:09 -0400
Received: from mail-bw0-f222.google.com ([209.85.218.222]:46345 "EHLO
	mail-bw0-f222.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751274AbZELNrH (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 12 May 2009 09:47:07 -0400
Received: by bwz22 with SMTP id 22so3282551bwz.37
        for <git@vger.kernel.org>; Tue, 12 May 2009 06:47:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:content-type
         :content-transfer-encoding;
        bh=nVwa79rmpsiP+NAztzUNRIgunhRLaSaal/6RGJbeI5o=;
        b=psn9GKGPBv+oeaIldMzir3tieHnbUPSqPT8+5XD6iDGeaP82c1L3mSkroR0hlVyo+d
         kgzSUrnuNAykbY/RYuP5zdWgNiJIczmUrdf6jHsP8uwVXY4YHXCLTvAKyNkiV5uQALLC
         gj7u1B6EefS40NssK7X/4eNHNZUWmflDkfiUc=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :content-type:content-transfer-encoding;
        b=mmsbULMkB7yjWtQl/RF0sc8tN93dK5WF4bzhZV1Jt8aN374gfEl6WfLHtAMUqjBdPr
         3BzAfddbUM0/iZJ9MOoMyF9KpPeyYAjYlB3RdXhTjfj8igW5U/8JM6tMrBw49Skz/mHP
         dQjlycUm4Ejq8p0iWkphSVWkxrclyTX8V8alA=
Received: by 10.204.62.82 with SMTP id w18mr8133957bkh.129.1242136025702; Tue, 
	12 May 2009 06:47:05 -0700 (PDT)
In-Reply-To: <20090425120429.GA417@home>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/118894>

On Sat, Apr 25, 2009 at 4:04 PM, Gregory Petrosyan
<gregory.petrosyan@gmail.com> wrote:
>> git-svn on Cygwin works well with svn+ssh://, but needs some fixes
>> around tempfile and/or subprocess handling for https:// - please help.
>
> This problem is triggered by updating Cygwin's SVN to 1.6. Downgrading
> it back to 1.5 make git-svn work for me again.
>
1. The problem is also triggered when svn is accessed using file: protocol.
2. Downgrading does not help completely for file protocol. Instead of
the tempfile.tmp, there is now the same problem with report.tmp.

I tend to agree with Matthias Andree that real bug is using fixed file
names for temporary files. This could also cause interference when
several git-svn instances the same computer for different git
repositories.

Regards,
Constantine
