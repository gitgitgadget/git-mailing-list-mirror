From: William Pursell <bill.pursell@gmail.com>
Subject: permissions
Date: Fri, 04 Jun 2010 23:33:50 -1000
Message-ID: <4C0A19FE.1020802@wpursell.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Jun 05 11:34:45 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OKpm8-0007qV-32
	for gcvg-git-2@lo.gmane.org; Sat, 05 Jun 2010 11:34:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932663Ab0FEJd5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 5 Jun 2010 05:33:57 -0400
Received: from mail-pv0-f174.google.com ([74.125.83.174]:35079 "EHLO
	mail-pv0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932651Ab0FEJd4 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 5 Jun 2010 05:33:56 -0400
Received: by pvg16 with SMTP id 16so881624pvg.19
        for <git@vger.kernel.org>; Sat, 05 Jun 2010 02:33:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from
         :user-agent:mime-version:to:subject:content-type
         :content-transfer-encoding;
        bh=hn2ea7fLv8+xoGDLdZSNu0GTqJrJTDBoCXDoRcBXap0=;
        b=vrBf8VQT88849sQ+Z4WmPCz/lD7XLIu0lxCJFTy99pURUl+ikNaZaTi83aqgTZ46JH
         d3jVoh9MowoueVzHA0ulFDRAH2YaDsnIwxbeRjw9x0w2ItX8+UATQF41q0rAsMQDYm2x
         /wQ/1yyxQLZRbS4xlBJ06io9cEo9EidtHP4pU=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:user-agent:mime-version:to:subject
         :content-type:content-transfer-encoding;
        b=BmTjnPiWD2HFG4T9TfaK3Ih/x/20bqiKtE4ekLN2+GD8DULp+SyCZ4j4tL3m6gf4gp
         L3U99klRSi3/UqD0KQN8Mo6g3hVVBeRzL4Z8y2XiKL1gqkzUOIhc+PP5B4hqkX8xe7gN
         QmH2vgXd9GHJ1YT87tgkaE1j0l6yI/lM+gMNY=
Received: by 10.115.114.34 with SMTP id r34mr9556773wam.64.1275730435996;
        Sat, 05 Jun 2010 02:33:55 -0700 (PDT)
Received: from clam.westell.com (udp278831uds.hawaiiantel.net [72.234.51.251])
        by mx.google.com with ESMTPS id f11sm16983597wai.11.2010.06.05.02.33.53
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sat, 05 Jun 2010 02:33:54 -0700 (PDT)
User-Agent: Thunderbird 2.0.0.24 (Macintosh/20100228)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/148464>

If .git is not readable, but ../.git is, .git works with
the database in ../.git.  Is that the desired behavior?
It would seem more appropriate that git fail with a
"permission denied" error.  In particular, if .git
is not readable and there is no database between
$PWD and $GIT_CEILING_DIRECTORIES, the current error is:
fatal: Not a git repository (or any of the parent directories): .git

Wouldn't it be better to have the error message be something like:
.git: permission denied

After all, it is a git repository, so "Not a git repository"
is not accurate.

-- 
William Pursell
