From: "Reece Dunn" <msclrhd@googlemail.com>
Subject: git fetch workflow improvements
Date: Sat, 9 Feb 2008 10:57:11 +0000
Message-ID: <3f4fd2640802090257m9ab8e24l2a836abfd2ef6bf@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Feb 09 11:57:50 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JNnP2-0001Fm-8B
	for gcvg-git-2@gmane.org; Sat, 09 Feb 2008 11:57:48 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752724AbYBIK5O (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 9 Feb 2008 05:57:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752699AbYBIK5O
	(ORCPT <rfc822;git-outgoing>); Sat, 9 Feb 2008 05:57:14 -0500
Received: from rv-out-0910.google.com ([209.85.198.186]:5446 "EHLO
	rv-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752638AbYBIK5N (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 9 Feb 2008 05:57:13 -0500
Received: by rv-out-0910.google.com with SMTP id k20so2789478rvb.1
        for <git@vger.kernel.org>; Sat, 09 Feb 2008 02:57:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        bh=8A5FRUtgGxsbzOQjYo33G+gQnxr5tvUnsGr1wFalSO8=;
        b=KmJ4++m0pgQ5VX+CljUq4AXWE0z+fanZcLPWSDfooiQ9OXmDzAbCXAWS//GecSi90uB7KJdpF0F+l6vhfGAohDPo+460CCGMPstNYBpr4kWFlFL5HelV22BgepwPmi6w+LCfYEJRQUjWUlxVDUb+vcWnrePOziNWmgf6VY7tBcA=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=googlemail.com; s=gamma;
        h=message-id:date:from:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=n2VqKx1AenLMMEwJaSgJspcrGTdgZrRXONP/unz5F4fglei9zHLJO9CvdPOAehOGtjkQTquzVLyurm8Lf+RzCKYRuA7MBOUmSfzOt4SDpjv0rsDiUjX4iNLRKMHu4/Ut5dS+xMIvnWFkifaWA/E4nOPFyb7vDMExl15yOuLkO+U=
Received: by 10.141.99.4 with SMTP id b4mr9159107rvm.217.1202554631627;
        Sat, 09 Feb 2008 02:57:11 -0800 (PST)
Received: by 10.141.23.10 with HTTP; Sat, 9 Feb 2008 02:57:11 -0800 (PST)
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/73209>

Hi,

I have some ideas on improvements I would like to make to git fetch. I
am not familiar with the implementation details of builtin-fetch.c and
friends, and having a brief look at the implementation I am unsure how
to proceed.

The ideas for improvements I have are:

    1.  When running `git fetch` on a bare repository that does not
have a remote called 'origin', fetch fails. I would like this to pick
up the first remote entry in the config file.

    2.  When mirroring a repository such as the Linux kernel and its
stable repositories in the same git repository, it would be useful to
be able to fetch the latest data from all the remotes that you are
tracking in the config file. I envision this being done by running
`git fetch -all`.

    3.  When fetching, if everything is up-to-date, display a message saying so.

- Reece
