From: "Sean Brown" <seanmichaelbrown@gmail.com>
Subject: git repository size vs. subversion repository size
Date: Fri, 4 Apr 2008 18:02:56 -0400
Message-ID: <1086fb5f0804041502s7ab12202y3b0ec3640425eff@mail.gmail.com>
Reply-To: seanmichaelbrown@gmail.com
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Apr 05 00:04:10 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Jhu0e-0003Ej-ID
	for gcvg-git-2@gmane.org; Sat, 05 Apr 2008 00:03:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751791AbYDDWC7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 4 Apr 2008 18:02:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751819AbYDDWC7
	(ORCPT <rfc822;git-outgoing>); Fri, 4 Apr 2008 18:02:59 -0400
Received: from fg-out-1718.google.com ([72.14.220.152]:47632 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751719AbYDDWC6 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 4 Apr 2008 18:02:58 -0400
Received: by fg-out-1718.google.com with SMTP id l27so211825fgb.17
        for <git@vger.kernel.org>; Fri, 04 Apr 2008 15:02:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:reply-to:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        bh=qxVr/07TM/v3ABSF0GJE2Kn1F/h6RWqP9Dve/z9x5NA=;
        b=rqY34ZAXJdP56jKfV+xKTtpPT8HL0DqwBetqouOs99a6XpVwuCsGx+yX2Sq7NJdrSbXoS87Hk+XLykdCNJTg/dVodpf8eeMjB96BUfDvJm9NybKOPGkd6zYAUWTgRozgwnd0wbhcJ+QI9Mx2GLy+wophoXq94/1TeWGHCmrxvGE=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:reply-to:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=hREtt+6+9b1W1n5aJKZsucEkmw2I6Gqc/t7LAFC7vy0qyRyQFPqhLoDA1o41tQqWJxDT/Z1BGrYcl5ElfJaHtK/fhD+qEJPthxkNrDM4wVhrjdF/DWZRDkbHymgN42xIGlHwHD5S7pREjqbxFgZf0UkE9St996xEpiNNMbr/6Fc=
Received: by 10.86.27.9 with SMTP id a9mr1108731fga.62.1207346576394;
        Fri, 04 Apr 2008 15:02:56 -0700 (PDT)
Received: by 10.86.98.11 with HTTP; Fri, 4 Apr 2008 15:02:56 -0700 (PDT)
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/78820>

Last night I decided to see what storage size differences I might see
between an svn repo and a git one.  So I imported a highly used
subversion repository into git and was shocked to see how huge the git
version was.  I used a repo that has a lot of branches and tagged
releases just to make sure importing into git would in fact keep all
of the history.  It did keep the history, but the total disk usage was
very different:

$subversionbox # du -hs ./my_sample_website/
67M	./my_sample_website

$localhost # du -hs ./git-samplesite/
3.6GB ./git-samplesite/

Here are the steps I took (locally):

mkdir git-samplesite-tmp
cd git-samplesite-tmp
git-svn init http://subversion.myco.com/my_sample_website --no-metadata
git config svn.authorsfile ~/Desktop/users.txt   # mapped svn users to git users
git-svn fetch
git clone git-samplesite-tmp git-samplesite

I did this based on reading the documents in the git wiki, so I
assumed they were "best practice."  Did I do something wrong?  If this
is a normal amount of storage need increase, we'd likely not move to
git based on the need for new hardware alone.

Any help would be appreciated.

Sean
