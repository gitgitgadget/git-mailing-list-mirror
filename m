From: =?ISO-8859-1?Q?Andreas_Gr=FCnbacher?= <agruen@gnu.org>
Subject: GNU patch close to next stable release (2)
Date: Wed, 1 Aug 2012 13:50:14 +0200
Message-ID: <CAHpGcM+DkL_CCisCjF9m0j3NRJUNAdfL05T0cfLjLfVORQHrpw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: git@vger.kernel.org
To: bug-patch@gnu.org
X-From: git-owner@vger.kernel.org Wed Aug 01 13:50:25 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SwXRY-0000lU-Nx
	for gcvg-git-2@plane.gmane.org; Wed, 01 Aug 2012 13:50:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754741Ab2HALuR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 1 Aug 2012 07:50:17 -0400
Received: from mail-lpp01m010-f46.google.com ([209.85.215.46]:38750 "EHLO
	mail-lpp01m010-f46.google.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751910Ab2HALuQ (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 1 Aug 2012 07:50:16 -0400
Received: by lahd3 with SMTP id d3so4605376lah.19
        for <git@vger.kernel.org>; Wed, 01 Aug 2012 04:50:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:date:x-google-sender-auth:message-id:subject
         :from:to:cc:content-type;
        bh=RfjFrKQBlxu/lu8FCtbjUVjaV1SenilFcNntAp5t6pU=;
        b=SYqYxLj4R1B4xnXMAPOjMXryfii/qUxZ67PcHLIVnQO+VAb9kui9Y1CQmbG1/TRV1a
         wu+trbv0jQZ8HYGcny2TCXWOHOB620PxCmjjrAjvdya3PRO5T+R9Lqqv7fXZu/viivFf
         lzbFJrEg117TRr/Q1kEaTrxLLVYna+d7knmGp3020jUrZgB1yBUbttMgSpxOlBMG/A0K
         8B73CB1W3/9SDaiwymUX8ngPNkedzIoPvedRHuCnq2xirfNrjtC9Li0qoIt6UBgTLWR4
         VH2w5ZcTXA7qIE8OyL4kjSxw2A2VhlRZGnaHqbWN7MuSC/tr0Ahp1/nHNUPyDHOSlcnw
         7Dag==
Received: by 10.112.47.231 with SMTP id g7mr8264158lbn.29.1343821814426; Wed,
 01 Aug 2012 04:50:14 -0700 (PDT)
Received: by 10.112.149.38 with HTTP; Wed, 1 Aug 2012 04:50:14 -0700 (PDT)
X-Google-Sender-Auth: 9NLbZwM5NLtj8JwZsDKYBlqO48s
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/202711>

After another improvement in git-style diff support to better handle
concatenated
diffs, here is a last call for testing to ensure that the code works
well enough to
become the next stable release. Please find the latest development snapshots
here:

  ftp://alpha.gnu.org/gnu/patch/

The following significant changes have happened since the last stable release
in December 2009:

* Support for most features of the "diff --git" format, including renames and
  copies, permission changes, and symlink diffs.  Binary diffs are not
  supported yet; patch will complain and skip them.

* Support for double-quoted filenames in the "diff --git" format: when a
  filename starts with a double quote, it is interpreted as a C string
  literal.  The escape sequences \\, \", \a, \b, \f, \n, \r, \t, \v, and \ooo
  (a three-digit octal number between 0 and 255) are recognized.

* Patch now ignores destination file names that are absolute or that contain
  a component of "..".  This addresses CVE-2010-4651.

* Refuse to apply a normal patch to a symlink.  (Previous versions of patch
  were replacing the symlink with a regular file.)

* When trying to modify a read-only file, warn about the potential problem
  by default.  The --read-only command line option allows to change this
  behavior.

* Files that should be deleted are now deleted once the entire patch file has
  been read.  This fixes a bug with numbered backup files.

* When a timestamp specifies a time zone, honor that instead of assuming the
  local time zone (--set-date) or Universal Coordinated Time (--set-utc).

* Support for nanosecond precision timestamps.

* Many portability and bug fixes.

Please report bugs or suggestions on the <bug-patch@gnu.org> mailing list, or
in the project's bug tracker on Savannah:

  http://savannah.gnu.org/projects/patch

Thanks,
Andreas
