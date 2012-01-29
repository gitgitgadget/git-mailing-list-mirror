From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: Bug: "git checkout -b" should be allowed in empty repo
Date: Sun, 29 Jan 2012 07:09:11 +0100
Message-ID: <4F24E287.3040302@alum.mit.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Jan 29 07:09:34 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RrNxB-0000Xl-Kn
	for gcvg-git-2@plane.gmane.org; Sun, 29 Jan 2012 07:09:30 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751286Ab2A2GJO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 29 Jan 2012 01:09:14 -0500
Received: from einhorn.in-berlin.de ([192.109.42.8]:49019 "EHLO
	einhorn.in-berlin.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751114Ab2A2GJO (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 29 Jan 2012 01:09:14 -0500
X-Envelope-From: mhagger@alum.mit.edu
Received: from [192.168.69.134] (p54BEDE2E.dip.t-dialin.net [84.190.222.46])
	(authenticated bits=0)
	by einhorn.in-berlin.de (8.13.6/8.13.6/Debian-1) with ESMTP id q0T69BZH011307
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT)
	for <git@vger.kernel.org>; Sun, 29 Jan 2012 07:09:12 +0100
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.9.2.24) Gecko/20111108 Lightning/1.0b2 Thunderbird/3.1.16
X-Scanned-By: MIMEDefang_at_IN-Berlin_e.V. on 192.109.42.8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/189279>

When starting a new repo, git seems to insist that the first commit be
made on a branch named "master":

    $ git --version
    git version 1.7.9
    $ git init git-test
    Initialized empty Git repository in /home/mhagger/tmp/git-test/.git/
    $ cd git-test
    $ git checkout -b foo
    fatal: You are on a branch yet to be born

I would call this a bug; the last command should be allowed.  The
plumbing allows it:

    $ git symbolic-ref HEAD refs/heads/foo

Michael

-- 
Michael Haggerty
mhagger@alum.mit.edu
http://softwareswirl.blogspot.com/
