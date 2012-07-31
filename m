From: "Manuela Hutter" <manuelah@opera.com>
Subject: Return code in cmd (git describe)
Date: Tue, 31 Jul 2012 14:02:50 +0200
Organization: Opera Software ASA
Message-ID: <op.wia7q0jqt21y7h@id-c1003.oslo.osa>
Reply-To: manuelah@opera.com
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
	format=flowed	delsp=yes
Content-Transfer-Encoding: 7BIT
To: "git@vger.kernel.org" <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Tue Jul 31 14:16:22 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SwBN8-0002iP-CL
	for gcvg-git-2@plane.gmane.org; Tue, 31 Jul 2012 14:16:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756099Ab2GaMQQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 31 Jul 2012 08:16:16 -0400
Received: from smtp.opera.com ([213.236.208.81]:34086 "EHLO smtp.opera.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756026Ab2GaMQP (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 31 Jul 2012 08:16:15 -0400
X-Greylist: delayed 808 seconds by postgrey-1.27 at vger.kernel.org; Tue, 31 Jul 2012 08:16:15 EDT
Received: from id-c1003.oslo.osa (oslo.jvpn.opera.com [213.236.208.46])
	(authenticated bits=0)
	by smtp.opera.com (8.14.3/8.14.3/Debian-5+lenny1) with ESMTP id q6VC2iI2013105
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT)
	for <git@vger.kernel.org>; Tue, 31 Jul 2012 12:02:45 GMT
User-Agent: Opera Mail/12.00 (Win32)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/202648>

Hi,

we have some python scripts that are run from Visual Studio, and one of  
them fails because of a wrong git return code when calling 'git describe  
--dirty'

Here's the issue:

=============
import subprocess

GIT_EXE = "<path to git exe>"
GIT_SRC = "<path to git repo>"


# call 'git describe --dirty':
run_git = subprocess.Popen([GIT_EXE, "describe", "--dirty"],
                            cwd=GIT_SRC,
                            stdout=subprocess.PIPE,
                            stderr=subprocess.PIPE)
(output, output_err) = run_git.communicate()
print "Returncode: %s" % run_git.returncode
print "Output:     %s" % output.strip()
=============

Run from wingw, the return code is 0.
Run from cmd, the return code is 1.

Why?

Thanks,
Manuela
