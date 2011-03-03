From: Piotr Krukowiecki <piotr.krukowiecki@gmail.com>
Subject: Rename/copy detection - options/display improvement proposition
Date: Thu, 3 Mar 2011 16:49:02 +0100
Message-ID: <AANLkTimbvWLCxf6HM-f_z30uUE-Nbpf-tcNzd8GbgK2C@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
To: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Thu Mar 03 16:49:10 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PvAm5-0004Vm-El
	for gcvg-git-2@lo.gmane.org; Thu, 03 Mar 2011 16:49:09 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752258Ab1CCPtE (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 3 Mar 2011 10:49:04 -0500
Received: from mail-vx0-f174.google.com ([209.85.220.174]:46337 "EHLO
	mail-vx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751786Ab1CCPtD (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 3 Mar 2011 10:49:03 -0500
Received: by vxi39 with SMTP id 39so1101525vxi.19
        for <git@vger.kernel.org>; Thu, 03 Mar 2011 07:49:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:date:message-id:subject:from:to
         :content-type;
        bh=0kXHkeDZraGoZuz/smC9Y8+KfdceUG+5O/xQuzV5hAc=;
        b=qh9bcui6pXqVWrl3NeteWimF5o9HSCbi/7rfywYHpwdPD/whY9VU5enIED+VvLW8R4
         wgY0Nbnos+G9e5AWzWz5M2isILMN03Ei2JOzPjLrwOZgmSVX7d5GjPPwHvvN2Etf7XuR
         9jwKLzBSSgQWqNpgA1pOXu+47h8C3GVmdVlOY=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:date:message-id:subject:from:to:content-type;
        b=vUAjV5DPhdpoKj+A1uvkvIpF4kyA0wrGMiYStRyCmy0jk+mCm4udVpQyFNgL5/A4vJ
         TI4Zd8B0WadHG9uQqQ/5isJrR0c7jbs06Nz3TkK+f71vYg7LMGD86EnlT4lAkfTsThKE
         GYMu+qOYIssr9xusyYmzPM1dtT65YfrM/g4Vc=
Received: by 10.220.182.70 with SMTP id cb6mr357948vcb.69.1299167342599; Thu,
 03 Mar 2011 07:49:02 -0800 (PST)
Received: by 10.220.61.140 with HTTP; Thu, 3 Mar 2011 07:49:02 -0800 (PST)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/168398>

Hi,

I think that:

   1. git-status should accept -M<n> -C<n>, same as git-diff
   2. git-diff should have an option to omit diff for deleted files


1. git-status incorrectly recognizes some changes as copied, e.g.:

# Changes to be committed:
#	copied:     SimpleMatcher.h -> BSlashMatcher.h
#	copied:     SimpleMatcher.h -> StringMatcher.h
#	renamed:  SimpleMatcher.h -> TabMatcher.h

(generally SimpleMatcher.h is recognized as being copied into many
different headers)

git-diff shows similarity index 50-60%.
git-diff -M80 -C80 correctly stops recognizing this as copies/renames.

I think git-status also should learn -M and -C, as it works the same
way as git-diff with defaults.


2. git-diff does not show diff for copied files. But when a files is
removed, the diff is shown.

I think seeing what was deleted is sometimes useful, but sometimes it
is not and just clutters the
diff.



-- 
Piotrek
