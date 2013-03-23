From: Ilya Kulakov <kulakov.ilya@gmail.com>
Subject: Bug: =?utf-8?b?YGdpdA==?= =?utf-8?b?c3VibW9kdWxlYA==?= does not list modules with unicode characters
Date: Sat, 23 Mar 2013 16:28:46 +0000 (UTC)
Message-ID: <loom.20130323T171809-46@post.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Mar 23 17:30:14 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UJRKd-0000bX-HZ
	for gcvg-git-2@plane.gmane.org; Sat, 23 Mar 2013 17:30:11 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751504Ab3CWQ3n convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 23 Mar 2013 12:29:43 -0400
Received: from plane.gmane.org ([80.91.229.3]:45130 "EHLO plane.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751346Ab3CWQ3n (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 23 Mar 2013 12:29:43 -0400
Received: from list by plane.gmane.org with local (Exim 4.69)
	(envelope-from <gcvg-git-2@m.gmane.org>)
	id 1UJRKV-0000VM-It
	for git@vger.kernel.org; Sat, 23 Mar 2013 17:30:03 +0100
Received: from 109x194x123x31.dynamic.omsk.ertelecom.ru ([109x194x123x31.dynamic.omsk.ertelecom.ru])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Sat, 23 Mar 2013 17:30:03 +0100
Received: from kulakov.ilya by 109x194x123x31.dynamic.omsk.ertelecom.ru with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Sat, 23 Mar 2013 17:30:03 +0100
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@ger.gmane.org
X-Gmane-NNTP-Posting-Host: sea.gmane.org
User-Agent: Loom/3.14 (http://gmane.org/)
X-Loom-IP: 109.194.123.31 (Mozilla/5.0 (Macintosh; Intel Mac OS X 10_8_3) AppleWebKit/536.28.10 (KHTML, like Gecko) Version/6.0.3 Safari/536.28.10)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/218922>

The `git submodule` commands seem to ignore modules which paths contain
unicode characters.

Consider the following steps to reproduce the problem:

  1. Create a directory with name that contains at least one unicode ch=
aracter
     (e.g. "=C3=BB=C3=B1=C3=AF=C3=A7=C3=B6d=C3=A9-r=C3=A8p=C3=B8")

  2. Initialize git repository within this directory

  3. Add this repository as a submodule to another repository so that
     unicode characters will appear in the path to the module
     (e.g. "../=C3=BB=C3=B1=C3=AF=C3=A7=C3=B6d=C3=A9-r=C3=A8p=C3=B8")

  4. Check that .gitmodules file is updated and contains record
     about just added module

  5. List submodules with using `git submodule` and find out
     that just added module is not listed
