From: =?ISO-8859-1?Q?J=E9r=E9mie_NIKAES?= <jeremie.nikaes@gmail.com>
Subject: Git fast-import : Warning duplicated ref: refs/remotes/origin/master
Date: Sun, 29 May 2011 18:09:31 +0200
Message-ID: <BANLkTinTuEppMGO16z2sMkjV8FveCbrwEQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
	Sylvain Boulme <Sylvain.Boulme@imag.fr>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun May 29 18:09:59 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QQiYv-0003oC-5U
	for gcvg-git-2@lo.gmane.org; Sun, 29 May 2011 18:09:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754082Ab1E2QJw convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 29 May 2011 12:09:52 -0400
Received: from mail-pw0-f46.google.com ([209.85.160.46]:64078 "EHLO
	mail-pw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753796Ab1E2QJv convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 29 May 2011 12:09:51 -0400
Received: by pwi15 with SMTP id 15so1355260pwi.19
        for <git@vger.kernel.org>; Sun, 29 May 2011 09:09:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:from:date:message-id:subject:to:cc
         :content-type:content-transfer-encoding;
        bh=QrMzBax+mvmgJKLVI/za2w/XNzBWpzhdl0lHJDPTWac=;
        b=PDl2lwV8e+TnK8ycjyH9FZj35AwuVnwY+FhCJbBrbc8aq5nRcmtlIYJpbvtIpkkO7Q
         E6o5OTqtbPGwYYX+zqAktAOUpXlB4jqKX5cmN3Mh3G5tzKPBEi52IuDOefuO6NdJdcft
         ESOyk3rwExdRlqI4ASznLCZrBLXHB9A2vxQcs=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:from:date:message-id:subject:to:cc:content-type
         :content-transfer-encoding;
        b=KaxbLM0nDN6rOX6X0PcO98YpY0qEy1WDKLGN/TsBBpl942o6DBAbyH27KRflip4xSS
         d06iWZi/r+4gCzidB8Ne7ollBRtGN6QZKkc3IL42+UDBkT9ffLdLsiIv0+xVSspqKmJ5
         9osJb+J4+tbio/UvucLClAZ4jlSAE2+i9+ZPw=
Received: by 10.142.43.15 with SMTP id q15mr564015wfq.348.1306685391313; Sun,
 29 May 2011 09:09:51 -0700 (PDT)
Received: by 10.142.13.11 with HTTP; Sun, 29 May 2011 09:09:31 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/174693>

Hi,
I am currently working on the git-mediawiki gateway project.
This project uses fast-import to get data from mediawiki. For each
revision from mediawiki, we generate a chunk of fast-export stream
looking like this :

commit refs/remotes/origin/master
mark :<int>
commiter <user> <address> <timestamp> +0000
data <sizeofcomment>
<comment>
M 644 inline <title>.wiki
data <sizeoffile>
<content>

At the end of a git clone mediawiki::http://ourwikitest, everything
looks perfectly fine, including the git log, but a "Warning duplicated
ref: refs/remotes/origin/master" is thrown. And indeed, it is
duplicated in .git/packedrefs

A git gc solves everything, but I wondered if there was a way to fix
this or if this was a known bug.

Thank you,
Regards,

--
J=E9r=E9mie Nikaes
